{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressFlowChart                                            }
{                                                                   }
{       Copyright (c) 1998-2009 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSFLOWCHART AND ALL ACCOMPANYING}
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxFcEdit;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxflchrt, ExtCtrls, StdCtrls, Menus, Buttons,ImgList,
  ShellAPI, Registry;

type

  TChart = class(TdxFlowChart) end;
  TConnection = class(TdxFcConnection) end;

  TItemType = (iObject, iConnection);

  TBuferItem = class
    FObject : TObject;
    FObjectType : TItemType;
    procedure SetObject(Value : TObject);
    procedure SetObjectType(Value : TItemType);
  public
    property Obj : TObject read FObject write SetObject;
    property ObjType : TItemType read FObjectType write SetObjectType;
  end;

  TUndoManager = class
    FStream : TMemoryStream;
    FChart  : TdxFlowChart;
    FUndoSteps : Integer;
    FCanUndo : Boolean;
    FStep : Integer;
    FLength : array [1..200] of integer;
    procedure SetChart(Value : TdxFlowChart);
    procedure SetUndoSteps(Value : integer);
  public
    constructor Create;
    destructor Destroy; override;
    property UndoSteps : Integer read FUndoSteps write SetUndoSteps;
    property Chart : TdxFlowChart read FChart write SetChart;
    property CanUndo : Boolean read FCanUndo;
    procedure Store;
    procedure Undo;
  end;

  TFChartEditor = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MainMenu: TMainMenu;
    miFile: TMenuItem;
    Bevel: TBevel;
    Bevel1: TBevel;
    ShapePopupMenu: TPopupMenu;
    iRectangle: TMenuItem;
    iEllipse: TMenuItem;
    iRoundRect: TMenuItem;
    iDiamond: TMenuItem;
    iNorthTriangle: TMenuItem;
    itSouthTriangle: TMenuItem;
    itEastTriangle: TMenuItem;
    itWestTriangle: TMenuItem;
    itHexagon: TMenuItem;
    LargeImages: TImageList;
    LinePopupMenu: TPopupMenu;
    i1p: TMenuItem;
    i2p: TMenuItem;
    i3p: TMenuItem;
    i4p: TMenuItem;
    i5p: TMenuItem;
    i6p: TMenuItem;
    i7p: TMenuItem;
    i8p: TMenuItem;
    i9p: TMenuItem;
    i10p: TMenuItem;
    Panel4: TPanel;
    btnCreateConnect: TSpeedButton;
    btnCreateObject: TSpeedButton;
    Label1: TLabel;
    pObject: TPanel;
    Label2: TLabel;
    sbShape: TSpeedButton;
    sbLine: TSpeedButton;
    Bevel2: TBevel;
    pConnect: TPanel;
    Label5: TLabel;
    sbStyle: TSpeedButton;
    StylePopupMenu: TPopupMenu;
    iStraight: TMenuItem;
    iCurved: TMenuItem;
    iRectHorizontal: TMenuItem;
    iRectVertical: TMenuItem;
    sbSourceArrow: TSpeedButton;
    sbDestArrow: TSpeedButton;
    SourceArrowPopupMenu: TPopupMenu;
    iSNone: TMenuItem;
    iSArrow: TMenuItem;
    iSOvalArrow: TMenuItem;
    iSRectArrow: TMenuItem;
    DestArrowPopupMenu: TPopupMenu;
    iDNone: TMenuItem;
    iDArrow: TMenuItem;
    iDOvalArrow: TMenuItem;
    iDRectArrow: TMenuItem;
    pColor: TPanel;
    pBkColor: TPanel;
    pBlack: TPanel;
    Bevel3: TBevel;
    pWhite: TPanel;
    pGray: TPanel;
    Panel5: TPanel;
    pMarron: TPanel;
    pRed: TPanel;
    pOlive: TPanel;
    pYellow: TPanel;
    pGreen: TPanel;
    pLime: TPanel;
    pTeal: TPanel;
    pAqua: TPanel;
    pNavy: TPanel;
    pBlue: TPanel;
    pPurple: TPanel;
    pFuchsia: TPanel;
    ColorDialog: TColorDialog;
    sbSArrowSize: TSpeedButton;
    sbDArrowSize: TSpeedButton;
    SArrowSizePopupMenu: TPopupMenu;
    iS10: TMenuItem;
    iS20: TMenuItem;
    iS30: TMenuItem;
    iS40: TMenuItem;
    iS50: TMenuItem;
    DArrowSizePopupMenu: TPopupMenu;
    iD10: TMenuItem;
    iD20: TMenuItem;
    iD30: TMenuItem;
    iD40: TMenuItem;
    iD50: TMenuItem;
    SPointPopupMenu: TPopupMenu;
    iSP1: TMenuItem;
    iSP2: TMenuItem;
    iSP3: TMenuItem;
    iSP4: TMenuItem;
    iSP5: TMenuItem;
    iSP6: TMenuItem;
    sbSPoint: TSpeedButton;
    sbDPoint: TSpeedButton;
    iSP7: TMenuItem;
    iSP8: TMenuItem;
    iSP9: TMenuItem;
    iSP10: TMenuItem;
    iSP11: TMenuItem;
    iSP12: TMenuItem;
    iSP13: TMenuItem;
    iSP14: TMenuItem;
    iSP15: TMenuItem;
    iSP16: TMenuItem;
    DPointPopupMenu: TPopupMenu;
    iDP1: TMenuItem;
    iDP2: TMenuItem;
    iDP3: TMenuItem;
    iDP4: TMenuItem;
    iDP5: TMenuItem;
    iDP6: TMenuItem;
    iDP7: TMenuItem;
    iDP8: TMenuItem;
    iDP9: TMenuItem;
    iDP10: TMenuItem;
    iDP11: TMenuItem;
    iDP12: TMenuItem;
    iDP13: TMenuItem;
    iDP14: TMenuItem;
    iDP15: TMenuItem;
    iDP16: TMenuItem;
    sbTextPosition: TSpeedButton;
    TextPositionPopupMenu: TPopupMenu;
    iTextTopLeft: TMenuItem;
    iTextTop: TMenuItem;
    iTextTopRight: TMenuItem;
    iTextLeft: TMenuItem;
    iTextCenter: TMenuItem;
    iTextRight: TMenuItem;
    iTextBottomLeft: TMenuItem;
    iTextBottom: TMenuItem;
    iTextBottomRight: TMenuItem;
    Bevel4: TBevel;
    Panel6: TPanel;
    sbZoom: TSpeedButton;
    miOpen: TMenuItem;
    miSaveAs: TMenuItem;
    miEdit: TMenuItem;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miDelete: TMenuItem;
    miSelectAll: TMenuItem;
    sbFit: TSpeedButton;
    sbObjectFont: TSpeedButton;
    FontDialog: TFontDialog;
    sbConnectFont: TSpeedButton;
    sbImagePosition: TSpeedButton;
    ImagePositionPopupMenu: TPopupMenu;
    iImageTopLeft: TMenuItem;
    iImageTop: TMenuItem;
    iImageTopRight: TMenuItem;
    iImageLeft: TMenuItem;
    iImageCenter: TMenuItem;
    iImageRight: TMenuItem;
    iImageBottomLeft: TMenuItem;
    iImageBottom: TMenuItem;
    iImageBottomRight: TMenuItem;
    ChartPopupMenu: TPopupMenu;
    N6: TMenuItem;
    miClearSelection: TMenuItem;
    N7: TMenuItem;
    miBringToFront: TMenuItem;
    miSendToBack: TMenuItem;
    iCut: TMenuItem;
    iCopy: TMenuItem;
    iPaste: TMenuItem;
    iDelete: TMenuItem;
    N8: TMenuItem;
    iSelectAll: TMenuItem;
    iClearSelection: TMenuItem;
    N9: TMenuItem;
    iBringToFront: TMenuItem;
    iSendToBack: TMenuItem;
    N10: TMenuItem;
    iEdit: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    iRemovePoint: TMenuItem;
    iNone: TMenuItem;
    miUndo: TMenuItem;
    N11: TMenuItem;
    miHelp: TMenuItem;
    miUnions: TMenuItem;
    miNewUnion: TMenuItem;
    miAddToUnion: TMenuItem;
    miRemoveFromUnion: TMenuItem;
    miClearUnion: TMenuItem;
    miClearAllUnions: TMenuItem;
    N12: TMenuItem;
    iNewUnion: TMenuItem;
    iAddToUnion: TMenuItem;
    iRemoveFromUnion: TMenuItem;
    iClearUnion: TMenuItem;
    iClearAllUnions: TMenuItem;
    View1: TMenuItem;
    miZoomIn: TMenuItem;
    miZoomOut: TMenuItem;
    N1: TMenuItem;
    miFit: TMenuItem;
    miActualSize: TMenuItem;
    SmallImages: TImageList;
    Chart: TdxFlowChart;
    Contens1: TMenuItem;
    btnOK: TButton;
    btnCancel: TButton;
    procedure ChartMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChartMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChartMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure sbShapeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure iRectangleClick(Sender: TObject);
    procedure btnCreateConnectClick(Sender: TObject);
    procedure pBlackMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pColorClick(Sender: TObject);
    procedure pColorDblClick(Sender: TObject);
    procedure ChartSelected(Sender: TdxCustomFlowChart; Item: TdxFcItem);
    procedure ChartSelection(Sender: TdxCustomFlowChart; Item: TdxFcItem;
      var Allow: Boolean);
    procedure sbZoomClick(Sender: TObject);
    procedure sbFitClick(Sender: TObject);
    procedure sbObjectFontClick(Sender: TObject);
    procedure sbConnectFontClick(Sender: TObject);
    procedure ChartDblClick(Sender: TObject);
    procedure iClearSelectionClick(Sender: TObject);
    procedure iSelectAllClick(Sender: TObject);
    procedure iBringToFrontClick(Sender: TObject);
    procedure iSendToBackClick(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure iDeleteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure iCopyClick(Sender: TObject);
    procedure iPasteClick(Sender: TObject);
    procedure iCutClick(Sender: TObject);
    procedure iEditClick(Sender: TObject);
    procedure ChartChange(Sender: TdxCustomFlowChart; Item: TdxFcItem);
    procedure FormShow(Sender: TObject);
    procedure iRemovePointClick(Sender: TObject);
    procedure ChartPopupMenuPopup(Sender: TObject);
    procedure ChartKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChartKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miUndoClick(Sender: TObject);
    procedure iClearAllUnionsClick(Sender: TObject);
    procedure iClearUnionClick(Sender: TObject);
    procedure iNewUnionClick(Sender: TObject);
    procedure iAddToUnionClick(Sender: TObject);
    procedure iRemoveFromUnionClick(Sender: TObject);
    procedure miZoomInClick(Sender: TObject);
    procedure miZoomOutClick(Sender: TObject);
    procedure miFitClick(Sender: TObject);
    procedure miActualSizeClick(Sender: TObject);
    procedure btnCreateObjectClick(Sender: TObject);
    procedure Contens1Click(Sender: TObject);
  private
    { Private declarations }
    DownPoint : TPoint;
    OldPoint : TPoint;
    FNewObject : Boolean;
    FChange : Boolean;
    Buf : TList;
    BufChart : TdxFlowChart;
    FUndo : TUndoManager;
    FStore : Boolean;
    LastObj : TdxFcObject;
    FSelect : Boolean;
    FPE : Boolean;  // Fix: by Kirill
    procedure ChangeObjects(Mode : Integer);
    procedure ChangeConnections(Mode : Integer);
    procedure SelectLastObject;
    procedure SelectLastConnect;
    procedure SetGlyph(SB : TSpeedButton; PM : TPopupMenu);
    procedure ClearBuf;
    procedure CopyToBuf;
    procedure PasteFromBuf;
    procedure ObjAssign(Source, Dest : TdxFcObject);
    procedure ConAssign(Source, Dest : TdxFcConnection);
    procedure DrawDrag(P1, P2 : TPoint; Mode : Integer);
    function GetImageIndexByMenuItem(Item : TmenuItem) : Integer;
    procedure MultiSelect(ResetOldSelected : Boolean; SelectRect : TRect);
  public
    { Public declarations }
    function IsMainItemInUnion(Obj : TdxFcObject) : Boolean;
    function IsChildItemInUnion(AChart : TdxFlowChart; Obj : TdxFcObject) : Boolean;
    function GetMainItemInUnion(AChart : TdxFlowChart; Obj : TdxFcObject) : TdxFcObject;
    function GetNumberByUnion(AChart : TdxFlowChart; Obj : TdxFcObject) : Integer;
    function GetUnionByNumber(AChart : TdxFlowChart; Number : Integer) : TdxFcObject;
    function ChartHasUnions(AChart : TdxFlowChart) : Boolean;
    function FindAllUnions(AChart : TdxFlowChart; FromUnion : TdxFcObject) : TdxFcObject;
    function FindUnions(AChart : TdxFlowChart; FromUnion, Obj : TdxFcObject) : TdxFcObject;
    function CanKeyEnter(Edit : TEdit; Key : Char; MinValue, MaxValue : Integer) : Boolean;
    function IntegerToStr(S : String) : Integer;
  end;

function ShowFlowChartEditor(AChart: TdxFlowChart; EditorCaption : String): Boolean;

var
  FChartEditor: TFChartEditor;
  OldHintHidePause : Integer;

const
  crFlChartZoomIn = 2001;
  crFlChartZoomOut = 2002;

implementation

{$R *.res}

uses dxEditObj, dxEditCon, dxSelUnion;

{$R *.DFM}

{TBuferItem}

procedure TBuferItem.SetObject(Value : TObject);
begin
  FObject := Value;
end;

procedure TBuferItem.SetObjectType(Value : TItemType);
begin
  FObjectType := Value;
end;

{TUndoManager}

constructor TUndoManager.Create;
begin
  FStream := TMemoryStream.Create;
  FStep := 0;
  FUndoSteps := 10;
  FCanUndo := False;
end;

destructor TUndoManager.Destroy;
begin
  FStream.Free;
  inherited;
end;

procedure TUndoManager.SetChart(Value : TdxFlowChart);
begin
  FChart := Value;
end;

procedure TUndoManager.SetUndoSteps(Value : integer);
begin
  FUndoSteps := Value;
  if FUndoSteps > 200 then FUndoSteps := 200;
end;

procedure TUndoManager.Store;
var Stream1, Stream2 : TMemoryStream;
    i, StartPos : Integer;
    F : Boolean;
begin
  Stream1 := TMemoryStream.Create;
  Stream2 := TMemoryStream.Create;
  FChart.SaveToStream(Stream1);
  if FStep > 0 then begin
    StartPos := 0;
    for i := 1 to FStep - 1 do StartPos := StartPos + FLength[i];
    FStream.Position := StartPos;
    Stream2.Position := 0;
    Stream2.CopyFrom(FStream, FLength[FStep]);
  end;
  if Stream2.Size <> 0 then
    F := CompareMem(Stream1.Memory, Stream2.Memory, Stream1.Size)
  else F := False;
  if not ( F and (Stream1.Size = Stream2.Size)) then begin
    if FStep >= FUndoSteps then begin
      Stream2.Clear;
      FStream.Position := FLength[1];
      Stream2.Position := 0;
      Stream2.CopyFrom(FStream, FStream.Size - FLength[1]);
      FStream.Clear;
      Stream2.Position := 0;
      FStream.Position := 0;
      FStream.CopyFrom(Stream2, 0);
      dec(FStep);
      for i := 1 to FStep do FLength[i] := FLength[i+1];
    end;
    StartPos := 0;
    for i := 1 to FStep do StartPos := StartPos + FLength[i];
    FStream.Position := StartPos;
    FStream.CopyFrom(Stream1, 0);
    inc(FStep);
    FLength[FStep] := Stream1.Size;
  end;
  Stream1.Free;
  Stream2.Free;
  FCanUndo := FStep > 1;
end;

procedure TUndoManager.Undo;
var Stream : TMemoryStream;
    StartPos, i : Integer;
begin
  if not FCanUndo then exit;
  Stream := TMemoryStream.Create;
  StartPos := 0;
  for i := 1 to FStep - 2 do StartPos := StartPos + FLength[i];
  FStream.Position := StartPos;
  Stream.CopyFrom(FStream, FLength[FStep - 1]);
  Stream.Position := 0;
  FChart.LoadFromStream(Stream);
  dec(FStep);
  if FStep <= 1 then FCanUndo := False;
  StartPos := 0;
  for i := 1 to FStep do StartPos := StartPos + FLength[i];
  FStream.Size := StartPos;
  Stream.Free;
end;

{dxFlowChartEditor}

function ShowFlowChartEditor(AChart: TdxFlowChart; EditorCaption : String): Boolean;
var
  AForm: TFChartEditor;
  S: TMemoryStream;
  SavH : TdxFcEvent;              // Fix: by SNG & Kirill
  P : TPoint;         // Fix: by Kirill
begin
  SavH:= AChart.OnDeletion;       // Fix: by SNG & Kirill
  AChart.OnDeletion := nil;       // Fix: by SNG & Kirill
  Result := False;
  AForm := TFChartEditor.Create(nil);
  S := TMemoryStream.Create;
  try
    AChart.SaveToStream(S);
    S.Position := 0;
    with AForm.Chart do begin
      Images := AChart.Images;
      Color := AChart.Color;
      Font := AChart.Font;
      Zoom := 100;
      LoadFromStream(S);
    end;
    if EditorCaption = '' then AForm.Caption := 'ExpressFlowChart Editor'
    else AForm.Caption := EditorCaption;
    AForm.ShowModal;
    if AForm.ModalResult=mrOK then
    begin
      S.Position := 0;
      AForm.Chart.SaveToStream(S);
      S.Position := 0;
      AChart.LoadFromStream(S);
      AChart.Color := AForm.Chart.Color;
      Result := True;
    end;
  finally
    S.Free;
    AForm.Free;
  end;
  AChart.OnDeletion := SavH;      // Fix: by SNG & Kirill
  GetCursorPos(P);                                                   // Fix: by Kirill
  PostMessage(AChart.Handle, WM_LBUTTONUP, 0, MakeLParam(P.x, P.y)); // Fix: by Kirill
end;

procedure TFChartEditor.ChartMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var hTest : TdxFcHitTest;
    R : TRect;
begin
  if Button = mbLeft then begin
    DownPoint := Point(X, Y);
    OldPoint := DownPoint;
  end;

  if sbZoom.Down then begin
    if ssAlt in Shift then begin
      if Chart.Zoom > 20 then Chart.Zoom := Chart.Zoom - 10
    end else begin
      if Chart.Zoom < 490 then Chart.Zoom := Chart.Zoom + 10;
    end;
    miActualSize.Enabled := (Chart.Zoom <> 100) and (not sbFit.Down);
    exit;
  end;

  hTest := Chart.GetHitTestAt(X,Y);
  if (hTest = [htNowhere]) and (Button = mbLeft) and (not (ssShift in Shift)) then
    Chart.ClearSelection;
  if (btnCreateObject.Down or btnCreateConnect.Down) and (Button = mbLeft) then begin
    FNewObject := True;
    R := Chart.ClientRect;
    R.TopLeft := Chart.ClientToScreen(R.TopLeft);
    R.BottomRight := Chart.ClientToScreen(R.BottomRight);
    ClipCursor(@R);
    Chart.ClearSelection;
  end;
  if ((hTest - [htNowhere, htByObject]) = []) and (Button = mbLeft) and (not btnCreateObject.Down) and (not btnCreateConnect.Down)
     and (not FPE) then begin  // Fix: by Kirill "and (not FPE)"
    FSelect := True;
    R := Chart.ClientRect;
    R.TopLeft := Chart.ClientToScreen(R.TopLeft);
    R.BottomRight := Chart.ClientToScreen(R.BottomRight);
    ClipCursor(@R);
    if not ((ssShift in Shift)) then Chart.ClearSelection;
  end;
  if FPE then FPE := False; // Fix: by Kirill
end;

procedure TFChartEditor.ChartMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var ALeft, ATop, SPoint, DPoint, Temp : integer; // Fix: by Kirill "Temp"
    P1, P2 : TPoint;
    SObj, DObj, Obj: TdxFcObject;
    Con : TdxFcConnection;
begin

  if sbZoom.Down then exit;

  if btnCreateObject.Down then begin
    btnCreateObject.Down := False;
    DrawDrag(DownPoint, OldPoint, 1);
    if (Button = mbLeft) and (Abs(DownPoint.X - X) > 5) and (Abs(DownPoint.Y - Y) > 5) then begin
      FChange := False;
      P1 := Chart.ChartPoint(DownPoint.X, DownPoint.Y);
      P2 := Chart.ChartPoint(X, Y);
      if P1.X < P2.X then ALeft := P1.X else ALeft := P2.X;
      if P1.Y < P2.Y then ATop := P1.Y else ATop := P2.Y;
      FStore := False;
      Chart.CreateObject(ALeft , ATop, Abs(P1.X - P2.X), Abs(P1.Y - P2.Y), TdxFcShapeType(sbShape.Tag));
      SelectLastObject;
      ChangeObjects(0);
      FChange := True;
      Obj := Chart.Objects[Chart.ObjectCount-1];
      if Obj.Text = '' then Obj.Text := 'Object ' + IntToStr(Chart.ObjectCount);
      FStore := True;
      ChartChange(Chart, nil);
    end;
  end;
  if btnCreateConnect.Down then begin
    btnCreateConnect.Down := False;
    DrawDrag(DownPoint, OldPoint, 2);
    if (Button = mbLeft) and ((Abs(DownPoint.X - X) > 5) or (Abs(DownPoint.Y - Y) > 5)) then begin
      FChange := False;
      FStore := False;
      SObj := Chart.GetObjectAt(DownPoint.X, DownPoint.Y);
      DObj := Chart.GetObjectAt(X, Y);
      if SObj <> nil then SPoint := SObj.GetLinkedPoint(DownPoint.X, DownPoint.Y) else SPoint := sbSPoint.Tag;
      if DObj <> nil then DPoint := DObj.GetLinkedPoint(X, Y) else DPoint := sbDPoint.Tag;
      Chart.CreateConnection(SObj, DObj , SPoint, DPoint);
      Con := Chart.Connections[Chart.ConnectionCount-1];
      if Chart.GetObjectAt(DownPoint.X, DownPoint.Y) = nil then Con.AddPoint(Chart.ChartPoint(DownPoint.X, DownPoint.Y));
      if Chart.GetObjectAt(X, Y) = nil then Con.AddPoint(Chart.ChartPoint(X, Y));
      SelectLastConnect;
      sbSPoint.Tag := SPoint;
      sbDPoint.Tag := DPoint;
      ChangeConnections(0);
      FChange := True;
      SelectLastConnect;
      FStore := True;
      ChartChange(Chart, nil);
    end;
  end;
  FNewObject := False;
  ClipCursor(nil);
  if FSelect then begin
    P1 := DownPoint;
    P2 := Point(X, Y);
   DrawDrag(DownPoint, OldPoint, 3);
     if Button = mbLeft then begin
       if P1.x > P2.x then begin Temp:=P1.x; P1.x:=P2.x; P2.x:=Temp; end; // Fix: by Kirill
       if P1.y > P2.y then begin Temp:=P1.y; P1.y:=P2.y; P2.y:=Temp; end; // Fix: by Kirill
       MultiSelect(not(ssShift in Shift), Rect(P1.X, P1.Y, P2.X, P2.Y));
     end;
  end;
  FSelect := False;

  if Button = mbRight then begin
    if Chart.SelCount = 0 then
      if Chart.GetConnectionAt(X, Y) <> nil then
        Chart.GetConnectionAt(X, Y).Selected := True;

    if Chart.SelCount = 0 then
      if Chart.GetObjectAt(X, Y) <> nil then
        Chart.GetObjectAt(X, Y).Selected := True;
  end;

  if Button = mbRight then begin
    P1 := Chart.ClientToScreen(Point(X, Y));
    DownPoint := Point(X, Y);
    ChartPopupMenu.Popup(P1.X, P1.Y);
  end;
end;

procedure TFChartEditor.ChartMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var UpPoint: TPoint;
    Obj : TdxFcObject;
    AText, CountText : String;
    FirstObj : TdxFcObject;
    Count : integer;
begin

  if sbZoom.Down then exit;

  UpPoint := Point(X, Y);
  if btnCreateObject.Down and FNewObject then begin
    DrawDrag(DownPoint, OldPoint, 1);
    DrawDrag(DownPoint, UpPoint, 1);
    OldPoint := UpPoint;
  end;
  if btnCreateConnect.Down and FNewObject and  ((Abs(UpPoint.Y - DownPoint.Y) > 5) or (Abs(UpPoint.X - DownPoint.X) > 5)) then begin
    DrawDrag(DownPoint, OldPoint, 2);
    DrawDrag(DownPoint, UpPoint, 2);
    OldPoint := UpPoint;
  end;

  if FSelect then begin
    DrawDrag(DownPoint, OldPoint, 3);
    DrawDrag(DownPoint, UpPoint, 3);
    OldPoint := UpPoint;
  end;

  if not (btnCreateConnect.Down or btnCreateObject.Down) then begin
    Obj := Chart.GetObjectAt(X, Y);
    AText := '';
    if Obj <> nil then begin
      if IsMainItemInUnion(Obj) then AText := 'Main Item of the Union '+IntToStr(GetNumberByUnion(Chart, Obj));
      if IsChildItemInUnion(Chart, Obj) then begin
        FirstObj := nil;
        Count := 0;
        CountText := '';
        repeat
          FirstObj := FindUnions(Chart, FirstObj, Obj);
          if FirstObj <> nil then begin
            if Count = 0 then CountText := CountText + IntToStr(GetNumberByUnion(Chart, FirstObj))
            else CountText := CountText + ', '+IntToStr(GetNumberByUnion(Chart, FirstObj));
            inc(Count);
          end;
        until FirstObj = nil;
        if Count > 0 then begin
          if AText = '' then AText := 'Child Item of the '
          else AText := AText + ' and Child Item of the ';
          if Count > 1 then AText := AText + 'Unions '
          else AText := AText +'Union ';
          AText := AText + CountText;
        end;
      end;
    end;
    if AText = '' then Obj := nil;
    if (Obj <> nil) and (Obj <> LastObj) then begin
      Application.HintHidePause := 5000;
      Chart.Hint := AText;
      Chart.ShowHint := True;
      LastObj := Obj;
    end else if Obj <> LastObj then begin
               Chart.ShowHint := False;
               LastObj := nil;
               Application.HintHidePause := OldHintHidePause;
             end;
  end;
end;

procedure TFChartEditor.sbShapeClick(Sender: TObject);
var P : TPoint;
    APanel : TPanel;
    APopupMenu : TPopupMenu;
begin
  APanel := nil;
  APopupMenu := nil;
  if TSpeedButton(Sender) = sbShape then begin
    APanel := pObject;
    APopupMenu := ShapePopupMenu;
  end;
  if TSpeedButton(Sender) = sbLine then begin
    APanel := pObject;
    APopupMenu := LinePopupMenu;
  end;
  if TSpeedButton(Sender) = sbTextPosition then begin
    APanel := pObject;
    APopupMenu := TextPositionPopupMenu;
  end;
  if TSpeedButton(Sender) = sbImagePosition then begin
    APanel := pObject;
    APopupMenu := ImagePositionPopupMenu;
  end;
  if TSpeedButton(Sender) = sbStyle then begin
    APanel := pConnect;
    APopupMenu := StylePopupMenu;
  end;
  if TSpeedButton(Sender) = sbSourceArrow then begin
    APanel := pConnect;
    APopupMenu := SourceArrowPopupMenu;
  end;
  if TSpeedButton(Sender) = sbDestArrow then begin
    APanel := pConnect;
    APopupMenu := DestArrowPopupMenu;
  end;
  if TSpeedButton(Sender) = sbSArrowSize then begin
    APanel := pConnect;
    APopupMenu := SArrowSizePopupMenu;
  end;
  if TSpeedButton(Sender) = sbDArrowSize then begin
    APanel := pConnect;
    APopupMenu := DArrowSizePopupMenu;
  end;
  if TSpeedButton(Sender) = sbSPoint then begin
    APanel := pConnect;
    APopupMenu := SPointPopupMenu;
  end;
  if TSpeedButton(Sender) = sbDPoint then begin
    APanel := pConnect;
    APopupMenu := DPointPopupMenu;
  end;

  if APanel = nil then Exit;

  with TSpeedButton(Sender) do
    P := APanel.ClientToScreen(Point(Left, Top + Height + 2));
  APopupMenu.Popup(P.X, P.Y);
end;

procedure TFChartEditor.FormCreate(Sender: TObject);

{$IFDEF DELPHI7}
  procedure ExcludeParentBackground(APanel: TPanel);
  begin
    APanel.ControlStyle := APanel.ControlStyle - [csParentBackground];
  end;
{$ENDIF}

var
  i: Integer;
begin
  sbObjectFont.Font.Assign(Chart.Font);
  sbConnectFont.Font.Assign(Chart.Font);
  FChange := True;
  Buf := TList.Create;
  BufChart := TdxFlowChart.Create(Self);
  FUndo := TUndoManager.Create;
  FUndo.Chart := Chart;
  FUndo.UndoSteps := 30;
  FStore := True;
  LastObj := nil;
  FSelect := False;
  OldHintHidePause := Application.HintHidePause;
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TMenuItem then
      TMenuItem(Components[i]).ImageIndex := GetImageIndexByMenuItem(TMenuItem(Components[i]));

{$IFDEF DELPHI7}
  for I := 0 to Panel2.ControlCount - 1 do
    if Panel2.Controls[I] is TPanel then
      ExcludeParentBackground(TPanel(Panel2.Controls[I]));
{$ENDIF}

  with Constraints do
  begin
    MinHeight := MulDiv(MinHeight, PixelsPerInch, 96);
    MinWidth := MulDiv(MinWidth, PixelsPerInch, 96);
  end;
end;

procedure TFChartEditor.ChangeObjects(Mode : Integer);
var i, Position : integer;
    AStore, AChange : Boolean;
begin
  if not FStore then AStore := False else AStore := True;
  if AStore then FStore := False;
  AChange := False;
  for i := 0 to Chart.SelectedObjectCount-1 do begin
    with Chart.SelectedObjects[i] do begin
      if Mode in [0,1] then ShapeType := TdxFcShapeType(sbShape.Tag);
      if Mode in [0,2] then ShapeWidth := sbLine.Tag;
      if Mode in [0,3] then ShapeColor := pColor.Color;
      if Mode in [0,4] then BkColor := pBkColor.Color;
      if Mode in [0,5] then begin
        Position := sbTextPosition.Tag;
        HorzTextPos := TdxFcHorzPos(Position mod 3);
        VertTextPos := TdxFcVertPos(Position div 3);
      end;
      if Mode in [0,6] then begin
        Position := sbImagePosition.Tag;
        HorzImagePos := TdxFcHorzPos(Position mod 3);
        VertImagePos := TdxFcVertPos(Position div 3);
      end;
      if Mode in [0,7] then Font.Assign(sbObjectFont.Font);
      AChange := True;
    end;
  end;
  if AStore then begin
    FStore := True;
    if AChange then ChartChange(Chart, nil);
  end;
end;

procedure TFChartEditor.ChangeConnections(Mode : Integer);
var i : integer;
    AStore, AChange : Boolean;
begin
  if not FStore then AStore := False else AStore := True;
  if AStore then FStore := False;
  AChange := False;
  for i := 0 to Chart.SelectedConnectionCount-1 do begin
    with Chart.SelectedConnections[i] do begin
      if Mode in [0,1] then Style := TdxFclStyle(sbStyle.Tag - 1);
      if Mode in [0,2] then Color := pColor.Color;
      if Mode in [0,3] then ArrowSource.ArrowType := TdxFcaType(sbSourceArrow.Tag);
      if Mode in [0,4] then ArrowDest.ArrowType := TdxFcaType(sbDestArrow.Tag);
      if Mode in [0,5] then ArrowSource.Width := sbSArrowSize.Tag * 5 + 5;
      if Mode in [0,5] then ArrowSource.Height := sbSArrowSize.Tag * 5 + 5;
      if Mode in [0,6] then ArrowDest.Width := sbDArrowSize.Tag * 5 + 5;
      if Mode in [0,6] then ArrowDest.Height := sbDArrowSize.Tag * 5 + 5;
      if Mode in [0,7] then SetObjectSource(ObjectSource,sbSPoint.Tag);
      if Mode in [0,8] then SetObjectDest(ObjectDest, sbDPoint.Tag);
      if Mode in [0,9] then Font.Assign(sbConnectFont.Font);
      if Mode in [0,10] then ArrowSource.Color := pBkColor.Color;
      if Mode in [0,10] then ArrowDest.Color := pBkColor.Color;
      AChange := True;
    end;
  end;
  if AStore then begin
    FStore := True;
    if AChange then ChartChange(Chart, nil);
  end;
end;

procedure TFChartEditor.iRectangleClick(Sender: TObject);
var B : TBitmap;
    APopupMenu : TPopupMenu;
    ASB : TSpeedButton;

    function GetPopupMenuByItem(AItem : TMenuItem) : TPopupMenu;
    var i, j : Integer;
    begin
      for i := 0 to ComponentCount - 1 do
        if Components[i] is TPopupMenu then
          for j := 0 to TPopupMenu(Components[i]).Items.Count - 1 do
            if TPopupMenu(Components[i]).Items[j] = AItem then begin
              Result := TPopupMenu(Components[i]);
              exit;
            end;
      Result := nil;
    end;

begin
  APopupMenu := GetPopupMenuByItem(TMenuItem(Sender));
  if APopupMenu = nil then exit;
  ASB := nil;
  if APopupMenu = ShapePopupMenu then ASB := sbShape;
  if APopupMenu = LinePopupMenu then ASB := sbLine;
  if APopupMenu = StylePopupMenu then ASB := sbStyle;
  if APopupMenu = SourceArrowPopupMenu then ASB := sbSourceArrow;
  if APopupMenu = DestArrowPopupMenu then ASB := sbDestArrow;
  if APopupMenu = SArrowSizePopupMenu then ASB := sbSArrowSize;
  if APopupMenu = DArrowSizePopupMenu then ASB := sbDArrowSize;
  if APopupMenu = SPointPopupMenu then ASB := sbSPoint;
  if APopupMenu = DPointPopupMenu then ASB := sbDPoint;
  if APopupMenu = TextPositionPopupMenu then ASB := sbTextPosition;
  if APopupMenu = ImagePositionPopupMenu then ASB := sbImagePosition;

  B := TBitmap.Create;
  B.Width := SmallImages.Width;
  B.Height := SmallImages.Height;
  ASB.Tag := TMenuItem(Sender).Tag;
  with B, Canvas do begin
    Brush.Color := clBtnFace;
    FillRect(Rect(0, 0, Width, Height));
  end;
  SmallImages.Draw(B.Canvas, 0, 0, TMenuItem(Sender).ImageIndex, True);
  ASB.Glyph.Assign(B);
  B.Free;
  FStore := False;
  if ASB = sbShape then ChangeObjects(1);
  if ASB = sbLine then ChangeObjects(2);
  if ASB = sbTextPosition then ChangeObjects(5);
  if ASB = sbImagePosition then ChangeObjects(6);
  if ASB = sbStyle then ChangeConnections(1);
  if ASB = sbSourceArrow then ChangeConnections(3);
  if ASB = sbDestArrow then ChangeConnections(4);
  if ASB = sbSArrowSize then ChangeConnections(5);
  if ASB = sbDArrowSize then ChangeConnections(6);
  if ASB = sbSPoint then ChangeConnections(7);
  if ASB = sbDPoint then ChangeConnections(8);
  FStore := True;
  ChartChange(Chart, nil);
end;

procedure TFChartEditor.btnCreateConnectClick(Sender: TObject);
begin
  if (Chart.SelectedObjectCount=2) and (Chart.SelectedConnectionCount=0) then begin
    with Chart do begin
      FStore := False;
      CreateConnection(SelectedObjects[0],SelectedObjects[1], 0, 0);
      Connections[ConnectionCount - 1].Style := TdxFclStyle(sbStyle.Tag - 1);
      SelectLastConnect;
      ChangeConnections(0);
      FStore := True;
      ChartChange(Chart, nil);
    end;
    btnCreateConnect.Down := False;
  end else
    if TSpeedButton(Sender).Down then Chart.ClearSelection;
end;

procedure TFChartEditor.SelectLastObject;
begin
  with Chart do begin
    ClearSelection;
    if ObjectCount > 0 then Objects[ObjectCount - 1].Selected := True;
  end;
end;

procedure TFChartEditor.SelectLastConnect;
begin
  with Chart do begin
    ClearSelection;
    if ConnectionCount > 0 then Connections[ConnectionCount - 1].Selected := True;
  end;
end;

procedure TFChartEditor.pBlackMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FStore := False;
  FChange := False;
  if Button = mbLeft then begin
    pColor.Color := TPanel(Sender).Color; ChangeObjects(3);   ChangeConnections(2);
  end;
  if Button = mbRight then begin
    pBkColor.Color := TPanel(Sender).Color; ChangeObjects(4); ChangeConnections(10);
  end;
  if (Chart.SelCount = 0) and (Button = mbRight) then begin
    if Chart.Color <> pBkColor.Color then
      Chart.Color := pBkColor.Color;
  end;
  FStore := True;
  FChange := True;
  ChartChange(Chart, nil);
end;

procedure TFChartEditor.pColorClick(Sender: TObject);
begin
  FChange := False;
  FStore := False;
  if TPanel(Sender) = pColor then begin ChangeObjects(3); ChangeConnections(2); end;
  if TPanel(Sender) = pBkColor then begin ChangeObjects(4); ChangeConnections(10); end;
  FStore := True;
  FChange := True;
  ChartChange(Chart, nil);
end;

procedure TFChartEditor.pColorDblClick(Sender: TObject);
begin
  if ColorDialog.Execute then begin
    FStore := False;
    FChange := False;
    if TPanel(Sender).Tag = 1 then begin pColor.Color := ColorDialog.Color; ChangeObjects(3); ChangeConnections(2); end;
    if TPanel(Sender).Tag = 2 then begin pBkColor.Color := ColorDialog.Color; ChangeObjects(4); ChangeConnections(10); end;
    if (Chart.SelCount = 0) and (TPanel(Sender).Tag = 2) then begin
      if Chart.Color <> pBkColor.Color then
        Chart.Color := pBkColor.Color;
    end;
    FStore := True;
    FChange := True;
    ChartChange(Chart, nil);
  end;
end;

procedure TFChartEditor.ChartSelected(Sender: TdxCustomFlowChart;
  Item: TdxFcItem);
var En : Boolean;
    i : Integer;
begin
  if not FChange then Exit;
  FChange := False;

  if (Chart.SelCount = 0) and (not btnCreateObject.Down) then pBkColor.Color := Chart.Color;

  if Chart.SelectedObjectCount > 0 then with Chart.SelectedObjects[0] do begin
    if sbShape.Tag <> Integer(ShapeType) then begin
      sbShape.Tag := Integer(ShapeType);
      SetGlyph(sbShape, ShapePopupMenu);
    end;
    if sbLine.Tag <> ShapeWidth then begin
      sbLine.Tag := ShapeWidth;
      SetGlyph(sbLine, LinePopupMenu);
    end;
    pColor.Color := ShapeColor;
    pBkColor.Color := BkColor;
    if sbTextPosition.Tag <> (Integer(VertTextPos) * 3 + Integer(HorzTextPos)) then begin
      sbTextPosition.Tag := (Integer(VertTextPos) * 3 + Integer(HorzTextPos));
    SetGlyph(sbTextPosition, TextPositionPopupMenu);
    end;
    if sbImagePosition.Tag <> (Integer(VertImagePos) * 3 + Integer(HorzImagePos)) then begin
      sbImagePosition.Tag := (Integer(VertImagePos) * 3 + Integer(HorzImagePos));
      SetGlyph(sbImagePosition, ImagePositionPopupMenu);
    end;
    sbObjectFont.Font.Assign(Font);
  end;

  if Chart.SelectedConnectionCount > 0 then with Chart.SelectedConnections[0] do begin
    if sbStyle.Tag <> (Integer(Style) + 1) then begin
      sbStyle.Tag:= (Integer(Style) + 1);
      SetGlyph(sbStyle, StylePopupMenu);
    end;
    pColor.Color := Color;
    pBkColor.Color := ArrowSource.Color;
    if sbSourceArrow.Tag <> Integer(ArrowSource.ArrowType) then begin
      sbSourceArrow.Tag := Integer(ArrowSource.ArrowType);
      SetGlyph(sbSourceArrow, SourceArrowPopupMenu);
    end;
    if sbDestArrow.Tag <> Integer(ArrowDest.ArrowType) then begin
      sbDestArrow.Tag := Integer(ArrowDest.ArrowType);
      SetGlyph(sbDestArrow, DestArrowPopupMenu);
    end;
    sbSArrowSize.Tag := (ArrowSource.Width - 5) div 5;
    sbDArrowSize.Tag := (ArrowDest.Width - 5) div 5;
    if sbSArrowSize.Tag < 1 then sbSArrowSize.Tag := 1;
    if sbDArrowSize.Tag < 1 then sbDArrowSize.Tag := 1;
    SetGlyph(sbSArrowSize, SArrowSizePopupMenu);
    SetGlyph(sbDArrowSize, DArrowSizePopupMenu);
    sbSPoint.Tag := PointSource;
    SetGlyph(sbSPoint, SPointPopupMenu);
    sbDPoint.Tag := PointDest;
    SetGlyph(sbDPoint, DPointPopupMenu);
    sbConnectFont.Font.Assign(Font);
  end;

  if Self.HandleAllocated then begin
    En := Chart.SelCount > 0;
    iCut.Enabled := En;
    miCut.Enabled := En;
    iCopy.Enabled := En;
    miCopy.Enabled := En;
    iClearSelection.Enabled := En;
    miClearSelection.Enabled := En;
    iDelete.Enabled := En;
    miDelete.Enabled := En;
    iEdit.Enabled := En;
    iPaste.Enabled := Buf.Count > 0;
    miPaste.Enabled := Buf.Count > 0;

    En := Chart.SelectedObjectCount > 0;
    iBringToFront.Enabled := En;
    miBringToFront.Enabled := En;
    iSendToBack.Enabled := En;
    miSendToBack.Enabled := En;

    En := Chart.SelectedObjectCount > 1 ;
    iNewUnion.Enabled := En;
    miNewUnion.Enabled := En;

    En := ChartHasUnions(Chart) and (Chart.SelectedObjectCount > 0);
    iAddToUnion.Enabled := En;
    miAddToUnion.Enabled := En;

    En := False;
    for i := 0 to Chart.SelectedObjectCount - 1 do
      if IsChildItemInUnion(Chart, Chart.SelectedObjects[i]) then begin
        En := True;
        break;
      end;
    iRemoveFromUnion.Enabled := En;
    miRemoveFromUnion.Enabled := En;

    En := False;
    for i := 0 to Chart.SelectedObjectCount - 1 do
     if IsMainItemInUnion(Chart.SelectedObjects[i]) then begin
       En := True;;
     end;
    iClearUnion.Enabled := En;
    miClearUnion.Enabled := En;

    En := ChartHasUnions(Chart);
    iClearAllUnions.Enabled := En;
    miClearAllUnions.Enabled := En;

  end;
  FChange := True;
end;

procedure TFChartEditor.ChartSelection(Sender: TdxCustomFlowChart;
  Item: TdxFcItem; var Allow: Boolean);
begin
  Allow := not ( sbZoom.Down or btnCreateObject.Down or btnCreateConnect.Down);
end;

procedure TFChartEditor.sbZoomClick(Sender: TObject);
begin
  if TSpeedButton(Sender).Down then begin
    Chart.ClearSelection;
    Chart.Cursor := crFlChartZoomIn;
  end else Chart.Cursor := crDefault;
end;

procedure TFChartEditor.sbFitClick(Sender: TObject);
begin
  if TSpeedButton(Sender).Down then begin
    sbZoom.Enabled := False;
    sbZoom.Down := False;
    Chart.Zoom := 0;
    miZoomIn.Enabled := False;
    miZoomOut.Enabled := False;
    miActualSize.Enabled := False;
  end else begin
    sbZoom.Enabled := True;
    Chart.Zoom := 100;
    miZoomIn.Enabled := True;
    miZoomOut.Enabled := True;
    miActualSize.Enabled := True;
  end;
  miActualSize.Enabled := (Chart.Zoom <> 100) and (not sbFit.Down);
  Chart.Cursor := crDefault;
end;

procedure TFChartEditor.sbObjectFontClick(Sender: TObject);
begin
  with TSpeedButton(Sender) do begin
    if Chart.SelectedObjectCount > 0 then Font := Chart.SelectedObjects[0].Font;
    FontDialog.Font.Assign(Font);
    if FontDialog.Execute then begin
      Font.Assign(FontDialog.Font);
      ChangeObjects(7);
    end;
  end;
end;

procedure TFChartEditor.sbConnectFontClick(Sender: TObject);
begin
  with TSpeedButton(Sender) do begin
    if Chart.SelectedConnectionCount > 0 then Font := Chart.SelectedConnections[0].Font;
    FontDialog.Font.Assign(Font);
    if FontDialog.Execute then begin
      Font.Assign(FontDialog.Font);
      ChangeConnections(9);
    end;
  end;
end;

procedure TFChartEditor.SetGlyph(SB : TSpeedButton; PM : TPopupMenu);
var B : TBitmap;
    i : Integer;
begin
  B := TBitmap.Create;
  B.Width := SmallImages.Width;
  B.Height := SmallImages.Height;
  for i := 0 to PM.Items.Count - 1 do
    if SB.Tag = PM.Items[i].Tag then begin
      with B, Canvas do begin
       Brush.Color := clBtnFace;
       FillRect(Rect(0, 0, Width, Height));
      end;
      SmallImages.Draw(B.Canvas, 0, 0, PM.Items[i].ImageIndex, True);
      SB.Glyph.Assign(B);
    end;
  B.Free;
end;

procedure TFChartEditor.ChartDblClick(Sender: TObject);
var hTest : TdxFcHitTest;
    Res : Boolean;
begin
  hTest := Chart.GetHitTestAt(DownPoint.X, DownPoint.Y);
  if (hTest * [htByObject,htOnObject]) <> [] then
    if Chart.SelectedObjectCount > 0 then begin
      FStore := False;
      Res := ObjectEditor(Chart, Chart.SelectedObjects[0]);
      FStore := True;
      FSelect := False;
      FPE := True; // Fix: by Kirill
      if Res then ChartChange(Chart, nil);
      ChartSelected(Chart, nil);
    end;
  if (hTest * [htOnConnection, htOnConLabel,htOnArrowSrc,htOnArrowDst]) <> [] then
    if Chart.SelectedConnectionCount > 0 then begin
      FStore := False;
      Res := ConnectEditor(Chart, Chart.SelectedConnections[0]); // PropertForm 
      FStore := True;
      FSelect := False;
      if Res then ChartChange(Chart, nil);
      ChartSelected(Chart, nil);
    end;
end;

procedure TFChartEditor.iClearSelectionClick(Sender: TObject);
begin
   Chart.ClearSelection;
end;

procedure TFChartEditor.iSelectAllClick(Sender: TObject);
begin
  Chart.SelectAll;
end;

procedure TFChartEditor.iBringToFrontClick(Sender: TObject);
var i : integer;
begin
  for i := 0 to Chart.SelectedObjectCount - 1 do
    Chart.SelectedObjects[i].BringToFront;
end;

procedure TFChartEditor.iSendToBackClick(Sender: TObject);
var i : integer;
begin
  for i := 0 to Chart.SelectedObjectCount - 1 do
    Chart.SelectedObjects[i].SendToBack;
end;

procedure TFChartEditor.miOpenClick(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    Chart.LoadFromFile(OpenDialog.FileName);
    ChartChange(Chart, nil);
  end;
end;

procedure TFChartEditor.miSaveAsClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    Chart.SaveToFile(SaveDialog.FileName);
end;

procedure TFChartEditor.iDeleteClick(Sender: TObject);
begin
  Chart.DeleteSelection;
end;

procedure TFChartEditor.FormDestroy(Sender: TObject);
begin
  ClearBuf;
  Buf.Free;
  BufChart.Free;
  FUndo.Free;
  Application.HintHidePause := OldHintHidePause;
end;

procedure TFChartEditor.ClearBuf;
var i : Integer;
begin
  for i := 0 to Buf.Count - 1 do
    if TBuferItem(Buf.Items[i]).ObjType = iConnection then
      TdxFcConnection(TBuferItem(Buf.Items[i]).Obj).Free;
  for i := 0 to Buf.Count - 1 do
    if TBuferItem(Buf.Items[i]).ObjType = iObject then
      TdxFcObject(TBuferItem(Buf.Items[i]).Obj).Free;
  while Buf.Count > 0 do begin
    TBuferItem(Buf.Items[0]).Free;
    Buf.Delete(0);
  end;
end;

procedure TFChartEditor.ObjAssign(Source, Dest : TdxFcObject);
begin
  Dest.Font.Assign(Source.Font);
  Dest.ParentFont := Source.ParentFont;
  Dest.Text := Source.Text;
  Dest.BkColor := Source.BkColor;
  Dest.BorderStyle := Source.BorderStyle;
  Dest.CustomData := Source.CustomData;
  Dest.Data := Source.Data;
  Dest.EdgeStyle := Source.EdgeStyle;
  Dest.Height := Source.Height;
  Dest.HorzImagePos := Source.HorzImagePos;
  Dest.HorzTextPos := Source.HorzTextPos;
  Dest.ImageIndex := Source.ImageIndex;
  Dest.Left := Source.Left;
  Dest.ShapeColor := Source.ShapeColor;
  Dest.ShapeStyle := Source.ShapeStyle;
  Dest.ShapeType := Source.ShapeType;
  Dest.ShapeWidth := Source.ShapeWidth;
  Dest.Tag := Source.Tag;
  Dest.Top := Source.Top;
  Dest.Transparent := Source.Transparent;
  Dest.VertImagePos := Source.VertImagePos;
  Dest.VertTextPos := Source.VertTextPos;
  Dest.Visible := Source.Visible;
  Dest.Width := Source.Width;
  Dest.ZOrder := Source.ZOrder;
end;

procedure TFChartEditor.ConAssign(Source, Dest : TdxFcConnection);
var i : Integer;
begin
  Dest.Font.Assign(Source.Font);
  Dest.ParentFont := Source.ParentFont;
  Dest.Text := Source.Text;
  Dest.ArrowSource.ArrowType := Source.ArrowSource.ArrowType;
  Dest.ArrowSource.Height := Source.ArrowSource.Height;
  Dest.ArrowSource.Width := Source.ArrowSource.Width;
  Dest.ArrowSource.Color := Source.ArrowSource.Color;
  Dest.ArrowDest.ArrowType := Source.ArrowDest.ArrowType;
  Dest.ArrowDest.Height := Source.ArrowDest.Height;
  Dest.ArrowDest.Width := Source.ArrowDest.Width;
  Dest.ArrowDest.Color := Source.ArrowDest.Color;
  Dest.Color := Source.Color;
  Dest.PenStyle := Source.PenStyle;
  for i := 0 to Source.PointCount - 1 do
    Dest.AddPoint(Source.Points[i]);
  Dest.Style := Source.Style;
  Dest.Transparent := Source.Transparent;
end;

procedure TFChartEditor.CopyToBuf;
var i, j : integer;
    ABufItem : TBuferItem;
    SObj, DObj, AObj : TdxFcObject;
    ACon : TdxFcConnection;
    List : TList;
begin
  List := TList.Create;
  ClearBuf;
  for i := 0 to Chart.SelectedObjectCount - 1 do begin
    ABufItem := TBuferItem.Create;
    AObj := TdxFcObject.Create(BufChart);
    ObjAssign(Chart.SelectedObjects[i], AObj);
    ABufItem.Obj := AObj;
    ABufItem.ObjType := iObject;
    Buf.Add(ABufItem);
    List.Add(AObj);
  end;

  for i := 0 to Chart.SelectedConnectionCount - 1 do begin
    ABufItem := TBuferItem.Create;
    ACon := TdxFcConnection.Create(BufChart);
    ConAssign(Chart.SelectedConnections[i], ACon);
    SObj := nil;
    DObj := nil;
    for j := 0 to Chart.SelectedObjectCount - 1 do begin
      if Chart.SelectedConnections[i].ObjectSource = Chart.SelectedObjects[j] then
        SObj := TdxFcObject(List.Items[j]);
      if Chart.SelectedConnections[i].ObjectDest = Chart.SelectedObjects[j] then
        DObj := TdxFcObject(List.Items[j]);
    end;
    ACon.SetObjectSource(SObj, Chart.SelectedConnections[i].PointSource);
    ACon.SetObjectDest(DObj, Chart.SelectedConnections[i].PointDest);
    ABufItem.Obj := ACon;
    ABufItem.ObjType := iConnection;
    Buf.Add(ABufItem);
  end;
  List.Free;
end;

procedure TFChartEditor.PasteFromBuf;
const d = 5;
var i, j, Index : integer;
    SObj, DObj, AObj : TdxFcObject;
    List : TList;
    ACon : TdxFcConnection;
    P : TPoint;
begin

  FChange := False;

  List := TList.Create;
  Chart.ClearSelection;
  for i := 0 to Buf.Count - 1 do
    if TBuferItem(Buf.Items[i]).ObjType = iObject then begin
      AObj := TdxFcObject.Create(Chart);
      ObjAssign(TdxFcObject(TBuferItem(Buf.Items[i]).Obj), AObj);
      AObj.Left := AObj.Left + d;
      AObj.Top := AObj.Top + d;
      AObj.BringToFront;
      AObj.Selected := True;
      List.Add(AObj);
    end;
  for i := 0 to Buf.Count - 1 do
    if TBuferItem(Buf.Items[i]).ObjType = iConnection then begin
      ACon := TdxFcConnection.Create(Chart);
      ConAssign(TdxFcConnection(TBuferItem(Buf.Items[i]).Obj), ACon);
      for j := 0 to ACon.PointCount - 1 do begin
        P := ACon.Points[j];
        P.X := P.X + d;
        P.Y := P.Y + d;
        ACon.Points[j] := P;
      end;
      SObj := nil;
      DObj := nil;
      Index := -1;
      for j := 0 to Buf.Count - 1 do
        if TBuferItem(Buf.Items[j]).ObjType = iObject then begin
          inc(Index);
          if TdxFcObject(TBuferItem(Buf.Items[j]).Obj) = TdxFcConnection(TBuferItem(Buf.Items[i]).Obj).ObjectSource then
            SObj := TdxFcObject(List.Items[Index]);
          if TdxFcObject(TBuferItem(Buf.Items[j]).Obj) = TdxFcConnection(TBuferItem(Buf.Items[i]).Obj).ObjectDest then
            DObj := TdxFcObject(List.Items[Index]);
        end;
      ACon.SetObjectSource(SObj, TdxFcConnection(TBuferItem(Buf.Items[i]).Obj).PointSource);
      ACon.SetObjectDest(DObj, TdxFcConnection(TBuferItem(Buf.Items[i]).Obj).PointDest);
      ACon.Selected := True;
    end;
  List.Free;
  FChange := True;
end;

procedure TFChartEditor.iCopyClick(Sender: TObject);
begin
  CopyToBuf;
  ChartSelected(Chart, nil);
end;

procedure TFChartEditor.iPasteClick(Sender: TObject);
begin
  FStore := False;
  PasteFromBuf;
  FStore := True;
  ChartChange(Chart, nil);
end;

procedure TFChartEditor.iCutClick(Sender: TObject);
begin
  FStore := False;
  CopyToBuf;
  Chart.DeleteSelection;
  FStore := True;
  ChartChange(Chart, nil);
end;

procedure TFChartEditor.iEditClick(Sender: TObject);
begin
  ChartDblClick(Chart);
end;

procedure TFChartEditor.ChartChange(Sender: TdxCustomFlowChart;
  Item: TdxFcItem);
begin
  if Self.HandleAllocated then begin
    ChartSelected(Chart, nil);
    if FStore then begin
      FUndo.Store;
      miUndo.Enabled := FUndo.CanUndo;
    end;
  end;
end;

procedure TFChartEditor.FormShow(Sender: TObject);
begin
  ChartChange(Chart, nil);
end;

procedure TFChartEditor.DrawDrag(P1, P2 : TPoint; Mode : Integer);
var AMode : TPenMode;
    AColor : TColor;
    ABkColor : TColor;
    AStyle : TPenStyle;
    PP1 , PP2 : TPoint;
begin
  if P1.X < P2.X then begin
    PP1.X := P1.X; PP2.X := P2.X;
  end else begin
    PP1.X := P2.X; PP2.X := P1.X;
  end;
  if P1.Y < P2.Y then begin
    PP1.Y := P1.Y; PP2.Y := P2.Y;
  end else begin
    PP1.Y := P2.Y; PP2.Y := P1.Y;
  end;
  with TChart(Chart).Canvas do begin
    AMode := Pen.Mode;
    AColor := Pen.Color;
    AStyle := Pen.Style;
    ABkColor := Brush.Color;
    Pen.Mode := pmNotXor;
    Pen.Color := clBlack;
    if Mode = 3 then Pen.Style := psDot;
    Brush.Style := bsClear;
    if Mode = 1 then case sbShape.Tag of
      0, 1 : Rectangle(PP1.X, PP1.Y, PP2.X, PP2.Y);
         2 : Ellipse(PP1.X, PP1.Y, PP2.X, PP2.Y);
         3 : RoundRect(PP1.X, PP1.Y, PP2.X, PP2.Y, (PP2.X - PP1.X) shr 1, (PP2.Y - PP1.Y) shr 1);
         4 : PolyLine([Point(PP1.X + (PP2.X - PP1.X) shr 1, PP1.Y),
                       Point(PP2.X, PP1.Y + (PP2.Y - PP1.Y) shr 1),
                       Point(PP1.X + (PP2.X - PP1.X) shr 1, PP2.Y),
                       Point(PP1.X, PP1.Y + (PP2.Y - PP1.Y) shr 1),
                       Point(PP1.X + (PP2.X - PP1.X) shr 1, PP1.Y)]);
         5 : PolyLine([Point(PP1.X + (PP2.X - PP1.X) shr 1, PP1.Y),
                       Point(PP2.X, PP2.Y),
                       Point(PP1.X, PP2.Y),
                       Point(PP1.X + (PP2.X - PP1.X) shr 1, PP1.Y)]);
         6 : PolyLine([Point(PP1.X, PP1.Y),
                       Point(PP2.X, PP1.Y),
                       Point(PP1.X + (PP2.X - PP1.X) shr 1, PP2.Y),
                       Point(PP1.X, PP1.Y)]);
         7 : PolyLine([Point(PP1.X, PP1.Y),
                       Point(PP2.X,  PP1.Y + (PP2.Y - PP1.Y) shr 1),
                       Point(PP1.X, PP2.Y),
                       Point(PP1.X, PP1.Y)]);
         8 : PolyLine([Point(PP1.X, PP1.Y + (PP2.Y - PP1.Y) shr 1),
                       Point(PP2.X, PP1.Y),
                       Point(PP2.X, PP2.Y),
                       Point(PP1.X, PP1.Y + (PP2.Y - PP1.Y) shr 1)]);
         9 : PolyLine([Point(PP1.X + (PP2.X - PP1.X) shr 2, PP1.Y),
                       Point(PP2.X - (PP2.X - PP1.X) shr 2, PP1.Y),
                       Point(PP2.X, PP1.Y + (PP2.Y - PP1.Y) shr 1),
                       Point(PP2.X - (PP2.X - PP1.X) shr 2, PP2.Y),
                       Point(PP1.X + (PP2.X - PP1.X) shr 2, PP2.Y),
                       Point(PP1.X, PP1.Y + (PP2.Y - PP1.Y) shr 1),
                       Point(PP1.X + (PP2.X - PP1.X) shr 2, PP1.Y)]);
    end;
    if Mode = 2 then begin
      MoveTo(P1.X, P1.Y);
      LineTo(P2.X, P2.Y);
    end;
    if Mode = 3 then Rectangle(P1.X, P1.Y, P2.X, P2.Y);
    Pen.Mode := AMode;
    Pen.Color := AColor;
    Pen.Style := AStyle;
    Brush.Color := ABkColor;
  end;
end;

procedure TFChartEditor.iRemovePointClick(Sender: TObject);
var i, j, b, k : integer;
    P1 : TPoint;
begin
  P1 := DownPoint;
  with Chart do
    for i := 0 to SelectedConnectionCount - 1 do with SelectedConnections[i] do begin
      j := GetNearestPoint(P1.X, P1.Y);
      b := 1;
      k := PointCount - 2;
      if ObjectSource <> nil then dec(b);
      if ObjectDest <> nil then inc(K);
      if (j >= b) and (j <= k) then
         RemovePoint(j);
    end;
end;

procedure TFChartEditor.ChartPopupMenuPopup(Sender: TObject);
var i, j, b, k : integer;
    P1 : TPoint;
begin
  with Chart do begin
    if SelectedConnectionCount > 0 then begin
    P1 := DownPoint;
    iRemovePoint.Enabled := False;
    if (GetHitTestAt(P1.X, P1.Y) * [htOnSelPoint]) <> [] then
      with Chart do
        for i := 0 to SelectedConnectionCount - 1 do with SelectedConnections[i] do begin
          j := GetNearestPoint(P1.X, P1.Y);
          b := 1;
          k := PointCount - 2;
          if ObjectSource <> nil then dec(b);
          if ObjectDest <> nil then inc(K);
          if (j >= b) and (j <= k) then begin
            iRemovePoint.Enabled := True;
            break;
          end;
        end;
    end else iRemovePoint.Enabled := False;
  end;
end;

procedure TFChartEditor.ChartKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var P : TPoint;
begin

  if (Key = VK_MENU) and sbZoom.Down then Chart.Cursor := crFlChartZoomOut;
  if Key = VK_APPS then begin
    GetCursorPos(P);
    P := Chart.ScreenToClient(P);
    DownPoint := Point(P.X, P.Y);
    GetCursorPos(P);
    ChartPopupMenu.Popup(P.X, P.Y);
  end;
  if (Key = VK_INSERT) and (ssCtrl in Shift) and iCopy.Enabled then iCopyClick(iCopy);
  if (Key = VK_INSERT) and (ssShift in Shift) and iPaste.Enabled then iPasteClick(iPaste);
  if (Key = VK_DELETE) and (ssShift in Shift) and iCut.Enabled then iCutClick(iCut);

  if FSelect and (Key <> VK_SHIFT) then
    if Key <> VK_ESCAPE then begin
      GetCursorPos(P);
      P := Chart.ScreenToClient(P);
      ChartMouseUp(Chart, mbLeft, [], P.X, P.Y);
    end else begin
      ClipCursor(nil);
      DrawDrag(DownPoint, OldPoint, 3);
      FSelect := False;
    end;

  if FNewObject then begin
    if btnCreateObject.Down then begin
      GetCursorPos(P);
      P := Chart.ScreenToClient(P);
      if (Abs(DownPoint.X - P.X) > 5) and (Abs(DownPoint.Y - P.Y) > 5) and (Key <> VK_ESCAPE)then
        ChartMouseUp(Chart, mbLeft, [], P.X, P.Y)
      else begin
        btnCreateObject.Down := False;
        DrawDrag(DownPoint, OldPoint, 1);
        FNewObject := False;
        ClipCursor(nil);
      end;
    end;
    if btnCreateConnect.Down then begin
      GetCursorPos(P);
      P := Chart.ScreenToClient(P);
      if ((Abs(DownPoint.X - P.X) > 5) or (Abs(DownPoint.Y - P.Y) > 5)) and (Key <> VK_ESCAPE) then
        ChartMouseUp(Chart, mbLeft, [], P.X, P.Y)
      else begin
        btnCreateConnect.Down := False;
        DrawDrag(DownPoint, OldPoint, 2);
        FNewObject := False;
        ClipCursor(nil);
      end;
    end;
  end;

end;

procedure TFChartEditor.ChartKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_MENU then begin
    if sbZoom.Down then Chart.Cursor := crFlChartZoomIn
    else Chart.Cursor := crDefault;
  end;
  if Key = VK_DELETE then ChartChange(Chart, nil);
end;

procedure TFChartEditor.miUndoClick(Sender: TObject);
begin
  FStore := False;
  FUndo.Undo;
  miUndo.Enabled := FUndo.CanUndo;
  FStore := True;
end;

function TFChartEditor.IsMainItemInUnion(Obj : TdxFcObject) : Boolean;
begin
  Result := Obj.IsUnion;
end;

function TFChartEditor.IsChildItemInUnion(AChart : TdxFlowChart; Obj : TdxFcObject) : Boolean;
var i : integer;
begin
  Result := False;
  for i := 0 to AChart.ObjectCount - 1 do
    if AChart.Objects[i].IsUnion then
      if AChart.Objects[i].HasInUnion(Obj) then begin
        Result := True;
        break;
      end;
end;

function TFChartEditor.GetMainItemInUnion(AChart : TdxFlowChart; Obj : TdxFcObject) : TdxFcObject;
var i : integer;
begin
  Result := nil;
  for i := 0 to AChart.ObjectCount - 1 do
    if AChart.Objects[i].IsUnion then
      if AChart.Objects[i].HasInUnion(Obj) then begin
        Result := AChart.Objects[i];
        break;
      end;
end;

function TFChartEditor.GetNumberByUnion(AChart : TdxFlowChart; Obj : TdxFcObject) : Integer;
var i : integer;
begin
  Result := 0;
  for i := 0 to AChart.ObjectCount - 1 do
    if AChart.Objects[i].IsUnion then begin
      Result := Result + 1;
      if AChart.Objects[i] = Obj then break;
    end;
end;

function TFChartEditor.GetUnionByNumber(AChart : TdxFlowChart; Number : Integer) : TdxFcObject;
var i, Count : integer;
begin
  Result := nil;
  Count := 0;
  for i := 0 to AChart.ObjectCount - 1 do
    if AChart.Objects[i].IsUnion then begin
      inc(Count);
      if Count = Number then begin
        Result := AChart.Objects[i];
        break;
      end;
    end;
end;

function TFChartEditor.ChartHasUnions(AChart : TdxFlowChart) : Boolean;
var i : integer;
begin
  Result := False;
  for i := 0 to AChart.ObjectCount - 1 do
    if AChart.Objects[i].IsUnion then begin
      Result := True;
      break;
    end;
end;

function TFChartEditor.FindAllUnions(AChart : TdxFlowChart; FromUnion : TdxFcObject) : TdxFcObject;
var i : integer;
    FFind : Boolean;
begin
  Result := nil;
  FFind := FromUnion = nil;
  for i := 0 to AChart.ObjectCount - 1 do
    if AChart.Objects[i].IsUnion then begin
      if FFind then begin
        Result := AChart.Objects[i];
        break;
      end;
      FFind := FromUnion = AChart.Objects[i];
    end;
end;

function TFChartEditor.FindUnions(AChart : TdxFlowChart; FromUnion, Obj : TdxFcObject) : TdxFcObject;
var i : integer;
    FFind : Boolean;
begin
  Result := nil;
  FFind := FromUnion = nil;
  for i := 0 to AChart.ObjectCount - 1 do
    if AChart.Objects[i].IsUnion and (Obj <> AChart.Objects[i]) then
      if AChart.Objects[i].HasInUnion(Obj) then begin
        if FFind then begin
          Result := AChart.Objects[i];
          break;
        end;
        FFind := AChart.Objects[i] = FromUnion;
      end;
end;

procedure TFChartEditor.iClearAllUnionsClick(Sender: TObject);
var i : integer;
    FChange : Boolean;
begin
  FChange := False;
  for i := 0 to Chart.ObjectCount - 1 do
    if Chart.Objects[i].IsUnion then begin
      Chart.Objects[i].ClearUnion;
      FChange := True;
    end;
  if FChange then FUndo.Store;
end;

procedure TFChartEditor.iClearUnionClick(Sender: TObject);
var i : integer;
    FChange : Boolean;
begin
  FChange := False;
  for i := 0 to Chart.SelectedObjectCount - 1 do
    if Chart.SelectedObjects[i].IsUnion then begin
      Chart.SelectedObjects[i].ClearUnion;
      FChange := True;
    end;
  if FChange then FUndo.Store;
end;

procedure TFChartEditor.iNewUnionClick(Sender: TObject);
var i : integer;
    MainObj, FirstObj : TdxFcObject;
    FFind, FChange : Boolean;
begin
  MainObj := nil;
  FChange := False;
  if Chart.SelectedObjectCount > 0 then MainObj := Chart.SelectedObjects[0];
  for i := 0 to Chart.SelectedObjectCount - 1 do
    if MainObj <> nil then begin
      FFind := False;
      FirstObj := nil;
      repeat
        FirstObj := FindUnions(Chart, FirstObj, MainObj);
        if FirstObj = Chart.SelectedObjects[i] then begin
          FFind := True;
          break;
        end;
      until FirstObj = nil;
      if not FFind then begin
        MainObj.AddToUnion(Chart.SelectedObjects[i]);
        FChange := True;
      end;
    end;
  if FChange then FUndo.Store;
end;

procedure TFChartEditor.iAddToUnionClick(Sender: TObject);
var Obj, FirstObj : TdxFcObject;
    i : Integer;
    FFind, FChange : Boolean;
begin
  FChange := False;
  if ChartHasUnions(Chart) then begin
    Obj := SelectUnion(Chart, nil);
    if Obj <> nil then
      for i := 0 to Chart.SelectedObjectCount - 1 do begin
        FirstObj := nil;
        FFind := False;
        repeat
          FirstObj := FindUnions(Chart, FirstObj, Obj);
          if FirstObj = Chart.SelectedObjects[i] then begin
            FFind := True;
            break;
          end;
        until FirstObj = nil;
        if not FFind then begin
          Obj.AddToUnion(Chart.SelectedObjects[i]);
          FChange := True;
        end;
      end;
  end;
  if FChange then FUndo.Store;
end;

procedure TFChartEditor.iRemoveFromUnionClick(Sender: TObject);
var FFind, FChange : Boolean;
    i : integer;
    Obj : TdxFcObject;
begin
  FFind := False;
  FChange := False;
  for i := 0 to Chart.SelectedObjectCount - 1 do
    if IsChildItemInUnion(Chart, Chart.SelectedObjects[i]) then begin
      FFind := True;
    end;
  if FFind then begin
    Obj := SelectUnion(Chart, Chart.SelectedObjects[0]);
    if Obj <> nil then begin
      for i := 0 to Chart.SelectedObjectCount - 1 do
        Obj.RemoveFromUnion(Chart.SelectedObjects[i]);
      FChange := True;
    end;
  end;
  if FChange then FUndo.Store;
end;

function TFChartEditor.GetImageIndexByMenuItem(Item : TmenuItem) : Integer;
begin
  Result := - 1;
  if Item = miOpen then begin Result := 0; Exit; end;
  if Item = miSaveAs then begin Result := 1; Exit; end;
  if Item = miUndo then begin Result := 2; Exit; end;
  if Item = miCut then begin Result := 3; Exit; end;
  if Item = miCopy then begin Result := 4;  Exit; end;
  if Item = miPaste then begin Result := 5; Exit; end;
  if Item = miDelete then begin Result := 6; Exit; end;
  if Item = miSelectAll then begin Result := 7; Exit; end;
  if Item = miBringToFront then begin Result := 8; Exit; end;
  if Item = miSendToBack then begin Result := 9; Exit; end;
  if Item = miNewUnion then begin Result := 10; Exit; end;
  if Item = miAddToUnion then begin Result := 11; Exit; end;
  if Item = miRemoveFromUnion then begin Result := 12; Exit; end;
  if Item = iNone then begin Result := 75; Exit; end;
  if Item = iRectangle then begin Result := 0; Exit; end;
  if Item = iEllipse then begin Result := 1; Exit; end;
  if Item = iRoundRect then begin Result := 2; Exit; end;
  if Item = iDiamond then begin Result := 3; Exit; end;
  if Item = iNorthTriangle then begin Result := 4; Exit; end;
  if Item = itSouthTriangle then begin Result := 5; Exit; end;
  if Item = itEastTriangle then begin Result := 6; Exit; end;
  if Item = itWestTriangle then begin Result := 7; Exit; end;
  if Item = itHexagon then begin Result := 8; Exit; end;
  if Item = i1p then begin Result := 9; Exit; end;
  if Item = i2p then begin Result := 10; Exit; end;
  if Item = i3p then begin Result := 11; Exit; end;
  if Item = i4p then begin Result := 12; Exit; end;
  if Item = i5p then begin Result := 13; Exit; end;
  if Item = i6p then begin Result := 14; Exit; end;
  if Item = i7p then begin Result := 15; Exit; end;
  if Item = i8p then begin Result := 16; Exit; end;
  if Item = i9p then begin Result := 17; Exit; end;
  if Item = i10p then begin Result := 18; Exit; end;
  if Item = iStraight then begin Result := 19; Exit; end;
  if Item = iCurved then begin Result := 20; Exit; end;
  if Item = iRectHorizontal then begin Result := 21; Exit; end;
  if Item = iRectVertical then begin Result := 22; Exit; end;
  if Item = iSNone then begin Result := 23; Exit; end;
  if Item = iSArrow then begin Result := 24; Exit; end;
  if Item = iSOvalArrow then begin Result := 25; Exit; end;
  if Item = iSRectArrow then begin Result := 26; Exit; end;
  if Item = iDNone then begin Result := 27; Exit; end;
  if Item = iDArrow then begin Result := 28; Exit; end;
  if Item = iDOvalArrow then begin Result := 29; Exit; end;
  if Item = iDRectArrow then begin Result := 30; Exit; end;
  if Item = iS10 then begin Result := 31; Exit; end;
  if Item = iS20 then begin Result := 32; Exit; end;
  if Item = iS30 then begin Result := 33; Exit; end;
  if Item = iS40 then begin Result := 34; Exit; end;
  if Item = iS50 then begin Result := 35; Exit; end;
  if Item = iD10 then begin Result := 36; Exit; end;
  if Item = iD20 then begin Result := 37; Exit; end;
  if Item = iD30 then begin Result := 38; Exit; end;
  if Item = iD40 then begin Result := 39; Exit; end;
  if Item = iD50 then begin Result := 40; Exit; end;
  if Item = iSP1 then begin Result := 41; Exit; end;
  if Item = iSP2 then begin Result := 42; Exit; end;
  if Item = iSP3 then begin Result := 43; Exit; end;
  if Item = iSP4 then begin Result := 44; Exit; end;
  if Item = iSP5 then begin Result := 45; Exit; end;
  if Item = iSP6 then begin Result := 46; Exit; end;
  if Item = iSP7 then begin Result := 47; Exit; end;
  if Item = iSP8 then begin Result := 48; Exit; end;
  if Item = iSP9 then begin Result := 49; Exit; end;
  if Item = iSP10 then begin Result := 50; Exit; end;
  if Item = iSP11 then begin Result := 51; Exit; end;
  if Item = iSP12 then begin Result := 52; Exit; end;
  if Item = iSP13 then begin Result := 53; Exit; end;
  if Item = iSP14 then begin Result := 54; Exit; end;
  if Item = iSP15 then begin Result := 55; Exit; end;
  if Item = iSP16 then begin Result := 56; Exit; end;
  if Item = iDP1 then begin Result := 41; Exit; end;
  if Item = iDP2 then begin Result := 42; Exit; end;
  if Item = iDP3 then begin Result := 43; Exit; end;
  if Item = iDP4 then begin Result := 44; Exit; end;
  if Item = iDP5 then begin Result := 45; Exit; end;
  if Item = iDP6 then begin Result := 46; Exit; end;
  if Item = iDP7 then begin Result := 47; Exit; end;
  if Item = iDP8 then begin Result := 48; Exit; end;
  if Item = iDP9 then begin Result := 49; Exit; end;
  if Item = iDP10 then begin Result := 50; Exit; end;
  if Item = iDP11 then begin Result := 51; Exit; end;
  if Item = iDP12 then begin Result := 52; Exit; end;
  if Item = iDP13 then begin Result := 53; Exit; end;
  if Item = iDP14 then begin Result := 54; Exit; end;
  if Item = iDP15 then begin Result := 55; Exit; end;
  if Item = iDP16 then begin Result := 56; Exit; end;
  if Item = iTextTopLeft then begin Result := 57; Exit; end;
  if Item = iTextTop then begin Result := 58; Exit; end;
  if Item = iTextTopRight then begin Result := 59; Exit; end;
  if Item = iTextLeft then begin Result := 60; Exit; end;
  if Item = iTextCenter then begin Result := 61; Exit; end;
  if Item = iTextRight then begin Result := 62; Exit; end;
  if Item = iTextBottomLeft then begin Result := 63; Exit; end;
  if Item = iTextBottom then begin Result := 64; Exit; end;
  if Item = iTextBottomRight then begin Result := 65; Exit; end;
  if Item = iImageTopLeft then begin Result := 66; Exit; end;
  if Item = iImageTop then begin Result := 67; Exit; end;
  if Item = iImageTopRight then begin Result := 68; Exit; end;
  if Item = iImageLeft then begin Result := 69; Exit; end;
  if Item = iImageCenter then begin Result := 70; Exit; end;
  if Item = iImageRight then begin Result := 71; Exit; end;
  if Item = iImageBottomLeft then begin Result := 72; Exit; end;
  if Item = iImageBottom then begin Result := 73; Exit; end;
  if Item = iImageBottomRight then begin Result := 74; Exit; end;
  if Item = iCut then begin Result := 3; Exit; end;
  if Item = iCopy then begin Result := 4; Exit; end;
  if Item = iPaste then begin Result := 5; Exit; end;
  if Item = iDelete then begin Result := 6; Exit; end;
  if Item = iSelectAll then begin Result := 7; Exit; end;
  if Item = iBringToFront then begin Result := 8; Exit; end;
  if Item = iSendToBack then begin Result := 9; Exit; end;
  if Item = iNewUnion then begin Result := 10; Exit; end;
  if Item = iAddToUnion then begin Result := 11; Exit; end;
  if Item = iRemoveFromUnion then begin Result := 12; Exit; end;
  if Item = miZoomIn then begin Result := 13; Exit; end;
  if Item = miZoomOut then begin Result := 14; Exit; end;
  if Item = miFit then begin Result := 15; Exit; end;
end;

procedure TFChartEditor.miZoomInClick(Sender: TObject);
begin
  if Chart.Zoom < 490 then Chart.Zoom := Chart.Zoom + 10 else miZoomIn.Enabled := False;
  miZoomOut.Enabled := True;
  miActualSize.Enabled := (Chart.Zoom <> 100) and (not sbFit.Down);
end;

procedure TFChartEditor.miZoomOutClick(Sender: TObject);
begin
  if Chart.Zoom > 20 then Chart.Zoom := Chart.Zoom - 10 else miZoomOut.Enabled := False;
  miZoomIn.Enabled := True;
  miActualSize.Enabled := (Chart.Zoom <> 100) and (not sbFit.Down);
end;

procedure TFChartEditor.miFitClick(Sender: TObject);
begin
  miFit.Checked := not miFit.Checked;
  if miFit.Checked then begin
    miZoomIn.Enabled := False;
    miZoomOut.Enabled := False;
    Chart.Zoom := 0;
    sbZoom.Enabled := False;
    sbFit.Down := True;
    Chart.Cursor := crDefault;
  end else begin
    miZoomIn.Enabled := True;
    miZoomOut.Enabled := True;
    Chart.Zoom := 100;
    sbZoom.Enabled := True;
    sbFit.Down := False;
  end;
  miActualSize.Enabled := (Chart.Zoom <> 100) and (not sbFit.Down);
end;

procedure TFChartEditor.miActualSizeClick(Sender: TObject);
begin
   Chart.Zoom := 100;
end;

function TFChartEditor.CanKeyEnter(Edit : TEdit; Key : Char; MinValue, MaxValue : Integer) : Boolean;
var Text : String;
    Value : Integer;
begin
  if Key >= #32 then begin
    if Edit.SelLength = 0 then Text := Edit.Text + Key
    else Text := Copy(Edit.Text, 1, Edit.SelStart - 1) + Key + Copy(Edit.Text, Edit.SelStart+Edit.SelLength, Length(Edit.Text) - Edit.SelStart - Edit.SelLength + 1);
  end else Text := Edit.Text;    
  try
    if Text = '' then Value := 1
    else Value := StrToInt(Text);
    if (Value >= MinValue) and (Value <= MaxValue) then Result := True else Result := False;
  except
    Result := False;
  end;
end;

function TFChartEditor.IntegerToStr(S : String) : Integer;
begin
  try
    if S = '' then Result := 1 else Result := StrToInt(S);
  except
    Result := 1;
  end;
end;

procedure TFChartEditor.Multiselect(ResetOldSelected : Boolean; SelectRect : TRect);
var i : Integer;
begin
  if ResetOldSelected then Chart.ClearSelection;
  for i := 0 to Chart.ObjectCount - 1 do
    if Chart.Objects[i].InRect(SelectRect) then Chart.Objects[i].Selected := not Chart.Objects[i].Selected;
  for i := 0 to Chart.ConnectionCount - 1 do
    if Chart.Connections[i].InRect(SelectRect) then Chart.Connections[i].Selected := not Chart.Connections[i].Selected;
end;

procedure TFChartEditor.btnCreateObjectClick(Sender: TObject);
begin
  if TSpeedButton(Sender).Down then    Chart.ClearSelection;
end;

procedure TFChartEditor.Contens1Click(Sender: TObject);
var FileName, PathInRegistry : String;
    Registry : TRegistry;
begin
  FileName := 'FCEditor.hlp';
  if FileExists(FileName) then begin
    ShellExecute(Handle, PChar('OPEN'), PChar(FileName), nil, nil, SW_SHOWMAXIMIZED);
    exit;
  end;
  if Application <> nil then begin
    FileName := ExtractFilePath(Application.HelpFile) + 'FCEditor.hlp';
    if FileExists(FileName) then begin
      ShellExecute(Handle, PChar('OPEN'), PChar(FileName), nil, nil, SW_SHOWMAXIMIZED);
      exit;
    end;
  end;

  Registry := TRegistry.Create;
  Registry.RootKey := HKEY_LOCAL_MACHINE;
  PathInRegistry := '';
  {$IFDEF DELPHI4} PathInRegistry := 'SOFTWARE\Borland\Delphi\4.0'; {$ENDIF}
  {$IFDEF CBUILDER4} PathInRegistry := 'SOFTWARE\Borland\C++Builder\4.0'; {$ENDIF}
  if PathInRegistry <> '' then
    if Registry.OpenKey(PathInRegistry, False) then begin
      FileName := Registry.ReadString('RootDir')+'\Help\FCEditor.hlp';
      if FileExists(FileName) then
        ShellExecute(Handle, PChar('OPEN'), PChar(FileName), nil, nil, SW_SHOWMAXIMIZED);
      Registry.CloseKey;
    end;
  Registry.Free;
end;

initialization
   Screen.Cursors[crFlChartZoomIn] := LoadCursor(HInstance, 'ZOOMIN');
   Screen.Cursors[crFlChartZoomOut] := LoadCursor(HInstance, 'ZOOMOUT');
   
end.
