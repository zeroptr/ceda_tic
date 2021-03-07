{*******************************************************}
{                                                       }
{       TiPlotLayoutViewer Component                    }
{                                                       }
{       Copyright (c) 1997,2008 Iocomp Software         }
{                                                       }
{*******************************************************}
{$I iInclude.inc}

{$ifdef iVCL}unit  iPlotLayoutViewer;{$endif}
{$ifdef iCLX}unit QiPlotLayoutViewer;{$endif}

interface

uses
  {$I iIncludeUses.inc}
  {$IFDEF iVCL} Menus,  iTypes,  iGPFunctions,  iPlotObjects,  iPlotLayoutManager,   iPlotMasterManager, iPlotTranslation,  iCustomComponent;{$ENDIF}
  {$IFDEF iCLX}QMenus, QiTypes, QiGPFunctions, QiPlotObjects, QiPlotLayoutManager, QiPlotMasterManager, QiPlotTranslation, QiCustomComponent;{$ENDIF}


type
  TiLayoutEditMode   = (ilemNone, ilemDrag, ilemSize);
  TiLayoutSizingSide = (ilssStart, ilssStop);

  TBlockObject = class(TObject)
  public
    ARect      : TRect;
    ZOrder     : Integer;
    Horizontal : Boolean;
    DataView   : Boolean;
    ToolBar    : Boolean;
  end;


  TiPlotLayoutViewer = class(TiCustomComponent)
  private
    FBlockList             : TStringList;

    FCellWidth             : Integer;

    FMouseDown             : Boolean;
    FMouseDownX            : Integer;
    FMouseDownY            : Integer;

    FMouseDownStartPercent : Double;
    FMouseDownStopPercent  : Double;

    FViewRect              : TRect;
    FDataViewRect          : TRect;

    FDataViewHeight        : Integer;
    FDataViewWidth         : Integer;

    FEditMode              : TiLayoutEditMode;
    FSizingSide            : TiLayoutSizingSide;

    FSelectedBlock         : TiPlotLayoutObject;
    FResizeBlock           : TiPlotLayoutObject;
    FOverLayoutObject      : TiPlotLayoutObject;

    FDragOverRefBlock2     : TBlockObject;

    FInsertDirection       : TiInsertDirection;

    FLayoutManager         : TiPlotLayoutManager;
    FMaster                : TiPlotMasterManager;
    FFont                  : TFont;
    FOnChange              : TNotifyEvent;
    FTranslationManager    : TiPlotTranslationManager;
  protected
    procedure CalcRects;

    procedure iPaintTo       (Canvas: TCanvas); override;
    procedure DrawOuterBorder(Canvas : TCanvas);
    procedure Draw           (Canvas : TCanvas);

    procedure iMouseUp  (Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure iMouseMove(                      Shift: TShiftState; X, Y: Integer); override;

    procedure Flip;
    procedure MoveZ;
    procedure MoveHorzToVert;
    procedure MoveVertToHorz;

    procedure TriggerChange;

    function GetDropRefObject(Source: TiPlotLayoutObject; Horizontal: Boolean; ZOrder: Integer): TiPlotLayoutObject;
  public
    function  GetMouseOverBlock (X, Y: Integer): TiPlotLayoutObject;
    function  GetMouseOverBlock2(X, Y: Integer): TBlockObject;

    constructor Create(AOwner : TComponent); override;
    destructor  Destroy; override;

    property LayoutManager      : TiPlotLayoutManager      read FLayoutManager      write FLayoutManager;
    property Master             : TiPlotMasterManager      read FMaster             write FMaster;
    property TranslationManager : TiPlotTranslationManager read FTranslationManager write FTranslationManager;

    property SelectedObject     : TiPlotLayoutObject       read FSelectedBlock;
  published
    property OnChange : TNotifyEvent                       read FOnChange           write FOnChange;
  end;

implementation

uses
{$ifdef iVCL} iPlotToolBar,  iPlotLegend,  iPlotAxis,  iPlotLabel,  iPlotTable,  iPlotChannel,  iPlotDataView;{$endif}
{$ifdef iCLX}QiPlotToolBar, QiPlotLegend, QiPlotAxis, QiPlotLabel, QiPlotTable, QiPlotChannel, QiPlotDataView;{$endif}

type
  TiPlotLayoutAccess = class(TiPlotLayoutObject ) end;
//****************************************************************************************************************************************************
constructor TiPlotLayoutViewer.Create(AOwner : TComponent);
begin
  inherited;
  FFont      := TFont.Create;
  FFont.Name := 'Arial';
  FFont.Size := 10;

  FBlockList := TStringList.Create;
end;
//****************************************************************************************************************************************************
destructor TiPlotLayoutViewer.Destroy;
begin
  FFont.Free;

  while FBlockList.Count <> 0 do
    begin
      FBlockList.Objects[0].Free;
      FBlockList.Delete(0);
    end;
  FBlockList.Free;

  inherited;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.iPaintTo(Canvas: TCanvas);
begin
  CalcRects;
  DrawOuterBorder(Canvas);
  if Assigned(FLayoutManager) then Draw(Canvas);
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.DrawOuterBorder(Canvas: TCanvas);
begin
  with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clBlue;
      Pen.Color   := clBlue;
      FillRect(ClipRect);

      Brush.Color := clWhite;
      Pen.Color   := clWhite;
      FillRect(FViewRect);
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.Draw(Canvas: TCanvas);
var
  x               : Integer;
  iBlockObject    : TiPlotLayoutObject;
  ATextString     : String;
  DrawRect        : TRect;
  ARect           : TRect;
  AWidth          : Integer;
  AHeight         : Integer;
begin
  with Canvas do
    begin
      Pen.Color   := clBlack;
      Pen.Style   := psClear;
      Font.Assign(FFont);

      for x := 0 to FLayoutManager.Count - 1 do
        begin
          iBlockObject := FLayoutManager.Items[x];

          if iBlockObject is TiPlotDataViewVert then Continue;
          if iBlockObject is TiPlotDataView     then Continue;

          if iBlockObject = FSelectedBlock then Brush.Color := clYellow
            else                                Brush.Color := clSilver;

          DrawRect := iBlockObject.LayoutRect;

          if iBlockObject.Visible then
            Brush.Style := bsSolid
          else Brush.Style := bsDiagCross;

          {$ifdef iVCL}Rectangle(DrawRect.Left, DrawRect.Top, DrawRect.Right,   DrawRect.Bottom);  {$endif}
          {$ifdef iCLX}Rectangle(DrawRect.Left, DrawRect.Top, DrawRect.Right-1, DrawRect.Bottom-1);{$endif}
          Brush.Style := bsClear;

          if Assigned(TranslationManager) then ATextString := TranslationManager.FindReplacement(iBlockObject.Name)
            else ATextString := iBlockObject.Name;

          //ATextString := ATextString + '-' + IntToStr(iBlockObject.ZOrder);

          if iBlockObject.Horizontal then
            iDrawRotatedText(Canvas, ATextString, DrawRect, ira000, iahCenter, True, BackGroundColor)
            //iDrawText(Canvas, ATextString, DrawRect,  [itfVCenter, itfHCenter, itfNoClip, itfSingleLine])
          else iDrawRotatedText(Canvas, ATextString, DrawRect, ira090, iahCenter, True, BackGroundColor);
        end;


    Brush.Style := bsSolid;
    Brush.Color := clYellow;
    Pen.Style   := psSolid;
    Pen.Width   := 1;
    Pen.Color   := clBlack;

    AWidth  := Round(FCellWidth);
    AHeight  := Round(FCellWidth);
    if Assigned(FOverLayoutObject) then
      begin
        Brush.Style := bsClear;
        Pen.Style   := psSolid;
        Pen.Width   := 2;
        Rectangle(FOverLayoutObject.LayoutRect.Left, FOverLayoutObject.LayoutRect.Top, FOverLayoutObject.LayoutRect.Right, FOverLayoutObject.LayoutRect.Bottom);
      end
    else if Assigned(FDragOverRefBlock2) then
      begin
        ARect := FDragOverRefBlock2.ARect;
        if FDragOverRefBlock2.Horizontal then
          case FInsertDirection of
            iidMerge : OffsetRect(ARect, 0,  0                );
            iidBelow : OffsetRect(ARect, 0,  AHeight div 2    );
            iidAbove : OffsetRect(ARect, 0, -AHeight div 2 + 1);
          end
        else
          case FInsertDirection of
            iidMerge : OffsetRect(ARect,  0               , 0);
            iidBelow : OffsetRect(ARect, -AWidth div 2    , 0);
            iidAbove : OffsetRect(ARect,  AWidth div 2 + 1, 0);
          end;

        if FDragOverRefBlock2.DataView then
          begin
            if FDragOverRefBlock2.Horizontal then
              begin
                case FInsertDirection of
                  iidBelow : ARect.Top    := ARect.Bottom - Round(FCellWidth);
                  iidAbove : ARect.Bottom := ARect.Top    + Round(FCellWidth);
                end;
                ARect.Left  := FViewRect.Left;
                ARect.Right := FViewRect.Right;
              end
            else
              case FInsertDirection of
                iidBelow : ARect.Right := ARect.Left  + Round(FCellWidth);
                iidAbove : ARect.Left  := ARect.Right - Round(FCellWidth);
              end;

          end;
        Brush.Style := bsClear;
        Pen.Style   := psSolid;
        Pen.Width   := 2;
        Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      end;
  end;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutViewer.GetDropRefObject(Source: TiPlotLayoutObject; Horizontal: Boolean; ZOrder: Integer): TiPlotLayoutObject;
var
  i            : Integer;
  iBlockObject : TiPlotLayoutObject;
begin
  Result := nil;
  for i := 0 to FLayoutManager.Count - 1 do
    begin
      iBlockObject := FLayoutManager.Items[i];
      if iBlockObject = Source                 then Continue;
      if iBlockObject is TiPlotDataView        then Continue;
      if iBlockObject.ZOrder     <> ZOrder     then Continue;
      if iBlockObject.Horizontal <> Horizontal then Continue;

      if Horizontal then
        begin
          if iBlockObject is TiPlotDataViewVert then Continue
        end
      else
        begin
          if iBlockObject is TiPlotDataViewHorz then Continue;
        end;

      Result := iBlockObject;
      Break;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutViewer.GetMouseOverBlock(X, Y: Integer): TiPlotLayoutObject;
var
  i            : Integer;
  iBlockObject : TiPlotLayoutObject;
begin
  Result := nil;
  for i := 0 to FLayoutManager.Count - 1 do
    begin
      iBlockObject := FLayoutManager.Items[i];
      if iBlockObject is TiPlotDataViewLayout then Continue;
      if PtInRect(iBlockObject.LayoutRect, Point(X,Y)) then
        begin
          Result := iBlockObject;
          Exit;
        end;
    end;
end;
//****************************************************************************************************************************************************
function TiPlotLayoutViewer.GetMouseOverBlock2(X, Y: Integer): TBlockObject;
var
  i           : Integer;
  BlockObject : TBlockObject;
  Rect1       : TRect;
  Rect2       : TRect;
begin
  Result := nil;
  for i := 0 to FBlockList.Count - 1 do
    begin
      BlockObject := FBlockList.Objects[i] as TBlockObject;

      if BlockObject.ToolBar then
        begin
          if Y < (BlockObject.ARect.Top + BlockObject.ARect.Bottom) div 2 then Continue;
        end
      else  if BlockObject.DataView then
        begin
          if BlockObject.Horizontal then
            begin
              Rect1 := Rect(BlockObject.ARect.Left, BlockObject.ARect.Bottom - FCellWidth, BlockObject.ARect.Right, BlockObject.ARect.Bottom          );
              Rect2 := Rect(BlockObject.ARect.Left, BlockObject.ARect.Top,                 BlockObject.ARect.Right, BlockObject.ARect.Top + FCellWidth);
              if not (PtInRect(Rect1, Point(X, Y)) or PtInRect(Rect2, Point(X, Y))) then Continue;
            end
          else
            begin
              Rect1 := Rect(BlockObject.ARect.Left,               BlockObject.ARect.Top, BlockObject.ARect.Left + FCellWidth, BlockObject.ARect.Bottom);
              Rect2 := Rect(BlockObject.ARect.Right - FCellWidth, BlockObject.ARect.Top, BlockObject.ARect.Right,             BlockObject.ARect.Bottom);
              if not (PtInRect(Rect1, Point(X, Y)) or PtInRect(Rect2, Point(X, Y))) then Continue;
            end;
        end;

      if PtInRect(BlockObject.ARect, Point(X,Y)) then
        begin
          Result := BlockObject;
          Break;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.iMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  iBlockObject : TiPlotLayoutObject;
begin
  iBlockObject := GetMouseOverBlock(X,Y);
  if Assigned(iBlockObject) then
    begin
      if iBlockObject is TiPlotDataView then Exit;
      if iBlockObject is TiPlotToolBar  then Exit;

      FSelectedBlock  := iBlockObject;
      FMouseDown      := True;
      FMouseDownX     := X;
      FMouseDowny     := Y;

      if not (ssLeft in Shift) then FInsertDirection := iidMerge;

      if Assigned(FResizeBlock) then
        begin
          FEditMode              := ilemSize;
          FMouseDownStartPercent := iBlockObject.StartPercent;
          FMouseDownStopPercent  := iBlockObject.StopPercent;
        end
      else
        begin
          FEditMode := ilemDrag;
        end;

      InvalidateChange;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.iMouseMove(Shift: TShiftState; X, Y: Integer);
var
  LayoutObject : TiPlotLayoutObject;
  RefObject    : TiPlotLayoutObject;
  BlockObject  : TBlockObject;
  DiffPercent  : Double;
  CanDropOnTo  : Boolean;
  BlockWidth   : Integer;
  BlockHeight  : Integer;
  CanMerge     : Boolean;
begin
  Cursor := crDefault;

  if not (ssLeft in Shift) and (FEditMode = ilemDrag) then Exit;

  FOverLayoutObject  := nil;
  FDragOverRefBlock2 := nil;

  LayoutObject := GetMouseOverBlock (X,Y);
  BlockObject  := GetMouseOverBlock2(X,Y);
                             
  case FEditMode of
    ilemNone : begin
                 if Assigned(LayoutObject) then
                   begin
                     if (LayoutObject is TiPlotAxis) or (LayoutObject is TiPlotLabel) or (LayoutObject is TiPlotTable) or (LayoutObject is TiPlotLegend) then
                       begin
                         if LayoutObject.IsHorz then
                           begin
                             if (Abs(LayoutObject.LayoutRect.Left - X) < 7) then
                               begin
                                 FSizingSide  := ilssStart;
                                 Cursor       := crSizeWE;
                                 FResizeBlock := LayoutObject;
                               end
                             else if (Abs(LayoutObject.LayoutRect.Right - X) < 7) then
                               begin
                                 FSizingSide  := ilssStop;
                                 Cursor       := crSizeWE;
                                 FResizeBlock := LayoutObject;
                               end
                             else
                               begin
                                 Cursor  := crDefault;
                                 FResizeBlock := nil;
                               end;
                           end
                         else
                           begin
                             if (Abs(LayoutObject.LayoutRect.Bottom - Y) < 7) then
                               begin
                                 FSizingSide  := ilssStart;
                                 Cursor       := crSizeNS;
                                 FResizeBlock := LayoutObject;
                               end
                             else if (Abs(LayoutObject.LayoutRect.Top - Y) < 7) then
                               begin
                                 FSizingSide  := ilssStop;
                                 Cursor       := crSizeNS;
                                 FResizeBlock := LayoutObject;
                               end
                             else
                               begin
                                 Cursor  := crDefault;
                                 FResizeBlock := nil;
                               end;
                           end;
                       end;
                     end
                 else
                   begin
                     Cursor       := crDefault;
                     FResizeBlock := nil;
                   end;
               end;
    ilemDrag :begin
                if not FMouseDown         then Exit;
                if Assigned(LayoutObject) then
                  begin
                                                                                                                      CanDropOnTo := True;
                    if LayoutObject is TiPlotDataView                                                            then CanDropOnTo := False;
                    if FSelectedBlock.Horizontal <> LayoutObject.Horizontal                                      then CanDropOnTo := False;
                    if FSelectedBlock.ZOrder     <> LayoutObject.Zorder                                          then CanDropOnTo := False;

                    if CanDropOnTo and (FSelectedBlock <> LayoutObject) then
                      begin
                        FOverLayoutObject := LayoutObject;
                      end
                    else FOverLayoutObject := nil;
                end;

              if Assigned(BlockObject) then
                begin
                  RefObject := GetDropRefObject(FSelectedBlock, BlockObject.Horizontal, BlockObject.ZOrder);
                                                                                                                      CanDropOnTo := True;
                  if FSelectedBlock is TiPlotAxis    then if FSelectedBlock.Horizontal <> BlockObject.Horizontal then CanDropOnTo := False;

                  if CanDropOnTo then
                     begin
                       BlockWidth  := BlockObject.ARect.Right  - BlockObject.ARect.Left;
                       BlockHeight := BlockObject.ARect.Bottom - BlockObject.ARect.Top;

                       FDragOverRefBlock2 := BlockObject;

                       if not Assigned(RefObject) then Exit;

                       CanMerge := False;
                       if (FSelectedBlock is TiPlotAxis)   and (RefObject is TiPlotAxis)   then CanMerge := True;
                       if (FSelectedBlock is TiPlotLabel)  and (RefObject is TiPlotLabel)  then CanMerge := True;
                       if (FSelectedBlock is TiPlotLabel)  and (RefObject is TiPlotLegend) then CanMerge := True;
                       if (FSelectedBlock is TiPlotLegend) and (RefObject is TiPlotLabel)  then CanMerge := True;


                       if not CanMerge then
                         begin
                           if not BlockObject.Horizontal then
                             begin
                               if X < (BlockObject.ARect.Left + BlockWidth  div 2) then FInsertDirection := iidBelow
                                else                                                    FInsertDirection := iidAbove;
                             end
                           else
                             begin
                               if Y > (BlockObject.ARect.Top  + BlockHeight div 2) then FInsertDirection := iidBelow
                                 else                                                   FInsertDirection := iidAbove;
                             end;
                         end
                       else if BlockObject.ToolBar then
                         begin
                           if  Y > (BlockObject.ARect.Top + BlockHeight*2 div 3) then FInsertDirection := iidBelow
                             else FDragOverRefBlock2 := nil;
                         end
                       else
                         begin
                           if not BlockObject.Horizontal then
                             begin
                               if       X < (BlockObject.ARect.Left + BlockWidth   div 3) then FInsertDirection := iidBelow
                                else if X < (BlockObject.ARect.Left + BlockWidth*2 div 3) then FInsertDirection := iidMerge
                                  else                                                         FInsertDirection := iidAbove;
                             end
                           else
                             begin
                               if       Y > (BlockObject.ARect.Top + BlockHeight*2 div 3)  then FInsertDirection := iidBelow
                                else if Y > (BlockObject.ARect.Top + BlockHeight   div 3)  then FInsertDirection := iidMerge
                                  else                                                          FInsertDirection := iidAbove;
                             end;
                         end;
                     end
                   else FDragOverRefBlock2 := nil;
                end;
              end;
    ilemSize :begin
                if not FMouseDown then exit;
                if FResizeBlock.IsVert then DiffPercent := (FMouseDownY - Y)/FDataViewHeight*100
                  else                      DiffPercent := (X - FMouseDownX)/FDataViewWidth *100;

                DiffPercent := (Round(DiffPercent/1.25))*1.25;

                case FSizingSide of
                  ilssStart : FResizeBlock.StartPercent := FMouseDownStartPercent + DiffPercent;
                  ilssStop  : FResizeBlock.StopPercent  := FMouseDownStopPercent  + DiffPercent;
                end
              end;
  end;
  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.iMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i               : Integer;
  MergeList       : TStringList;
  LayoutObject    : TiPlotLayoutObject;
  RefObject       : TiPlotLayoutObject;
  StepPerecent    : Double;
begin
  FMouseDown := False;

  case FEditMode of
    ilemNone : ;
    ilemDrag : if Assigned(FDragOverRefBlock2) and Assigned(FOverLayoutObject) then
                 begin
                   Flip;
                 end
               else
                 begin
                   if Assigned(FDragOverRefBlock2) then
                     begin
                       if FSelectedBlock.Horizontal <> FDragOverRefBlock2.Horizontal then
                         begin
                           if FSelectedBlock.Horizontal then MoveHorzToVert else MoveVertToHorz;
                         end
                       else
                         case FInsertDirection of
                           iidBelow : begin
                                        RefObject := GetDropRefObject(FSelectedBlock, FDragOverRefBlock2.Horizontal, FDragOverRefBlock2.ZOrder);
                                        if Assigned(RefObject) then
                                          begin
                                            FLayoutManager.RemoveZOrder(FSelectedBlock);
                                            FLayoutManager.InsertZOrder(FSelectedBlock, RefObject.ZOrder, iidBelow);
                                          end;

                                        FSelectedBlock.StartPercent := 0;
                                        FSelectedBlock.StopPercent  := 100;
                                      end;
                           iidMerge : begin
                                        MergeList := TStringList.Create;
                                        try
                                          for i := 0 to FLayoutManager.Count - 1 do
                                            begin
                                              LayoutObject := FLayoutManager.Items[i];
                                              if LayoutObject is TiPlotDataView then Continue;
                                              if LayoutObject = FSelectedBlock then Continue;
                                              if (LayoutObject.Horizontal = FDragOverRefBlock2.Horizontal) and (LayoutObject.ZOrder = FDragOverRefBlock2.ZOrder) then
                                                MergeList.AddObject('', FLayoutManager.Items[I]);
                                            end;

                                          RefObject := GetDropRefObject(FSelectedBlock, FDragOverRefBlock2.Horizontal, FDragOverRefBlock2.ZOrder);
                                          MergeList.AddObject('', FSelectedBlock);
                                          StepPerecent := 100/MergeList.Count;
                                          for i := 0 to MergeList.Count-1 do
                                            begin
                                              LayoutObject := MergeList.Objects[i] as TiPlotLayoutObject;
                                              LayoutObject.StopPercent  := i * StepPerecent + StepPerecent;
                                              LayoutObject.StartPercent := i * StepPerecent;
                                            end;
                                          if Assigned(RefObject) then
                                            begin
                                              FLayoutManager.RemoveZOrder(FSelectedBlock);
                                              FLayoutManager.InsertZOrder(FSelectedBlock, RefObject.ZOrder, iidMerge)
                                            end;
                                        finally
                                          MergeList.Free;
                                        end;
                                        TriggerChange;
                                      end;
                           iidAbove : begin
                                        RefObject := GetDropRefObject(FSelectedBlock, FDragOverRefBlock2.Horizontal, FDragOverRefBlock2.ZOrder);
                                        if Assigned(RefObject) then
                                          begin
                                            FLayoutManager.RemoveZOrder(FSelectedBlock);
                                            FLayoutManager.InsertZOrder(FSelectedBlock, RefObject.ZOrder, iidAbove);
                                          end;

                                        FSelectedBlock.StartPercent := 0;
                                        FSelectedBlock.StopPercent  := 100;
                                      end;
                         end;
                 end;
               end;
    ilemSize : if Assigned(FResizeBlock) then TriggerChange;
  end;

  FEditMode := ilemNone;
  Cursor := crDefault;

  FOverLayoutObject  := nil;
  FDragOverRefBlock2 := nil;
  FSelectedBlock     := nil;
  FResizeBlock       := nil;

  InvalidateChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.Flip;
var
  OldStart  : Double;
  OldStop   : Double;
begin
  OldStart := FOverLayoutObject.StartPercent;
  OldStop  := FOverLayoutObject.StopPercent;

  TiPlotLayoutAccess(FOverLayoutObject).SetStartStopPercent(FSelectedBlock.StartPercent, FSelectedBlock.StopPercent);
  TiPlotLayoutAccess(FSelectedBlock ).SetStartStopPercent (OldStart, OldStop);
  TriggerChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.MoveZ;
var
  ShouldMove : Boolean;
  x          : Integer;
begin
  if FSelectedBlock.ZOrder = FOverLayoutObject.ZOrder then
    begin
      ShouldMove := False;
      for x := 0 to FLayoutManager.Count-1 do
        if (FLayoutManager.Items[x].Horizontal =  FSelectedBlock.Horizontal) and
           (FLayoutManager.Items[x]            <> FSelectedBlock           ) and
           (FLayoutManager.Items[x].ZOrder     =  FSelectedBlock.ZOrder    ) then ShouldMove := True;
      if not ShouldMove then exit;
    end;
  FLayoutManager.RemoveZOrder(FSelectedBlock);
  FLayoutManager.InsertZOrder(FSelectedBlock, FOverLayoutObject.ZOrder, FInsertDirection);
  TriggerChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.MoveHorzToVert;
var
  RefObject : TiPlotLayoutObject;
begin
  RefObject := GetDropRefObject(FSelectedBlock, FDragOverRefBlock2.Horizontal, FDragOverRefBlock2.ZOrder);
  FLayoutManager.RemoveZOrder(FSelectedBlock);
  FSelectedBlock.Horizontal := False;
  FLayoutManager.InsertZOrder(FSelectedBlock, RefObject.ZOrder, FInsertDirection);
  TriggerChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.MoveVertToHorz;
var
  RefObject : TiPlotLayoutObject;
begin
  RefObject := GetDropRefObject(FSelectedBlock, FDragOverRefBlock2.Horizontal, FDragOverRefBlock2.ZOrder);
  FLayoutManager.RemoveZOrder(FSelectedBlock);
  FSelectedBlock.Horizontal := True;
  FLayoutManager.InsertZOrder(FSelectedBlock, RefObject.ZOrder, FInsertDirection);
  TriggerChange;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.CalcRects;
var
  x            : Integer;
  iBlockObject : TiPlotLayoutObject;
  BlockStart   : Integer;
  BlockStop    : Integer;
  BlockTop     : Integer;
  BlockBottom  : Integer;
  BlockLeft    : Integer;
  BlockRight   : Integer;
  BlockObject  : TBlockObject;
  CurrentZ     : Integer;
begin
  CurrentZ         := 0;
  FViewRect.Left   := 5;
  FViewRect.Top    := 5;
  FViewRect.Right  := Width  - 5;
  FViewRect.Bottom := Height - 5;

  if not Assigned(FLayoutManager) then Exit;

  Canvas.Font.Assign(FFont);
  FCellWidth           := Round(1.10*Canvas.TextHeight('ABC'));
  FDataViewRect.Left   := FViewRect.Left   + Round(FLayoutManager.LeftUniqueCount   * FCellWidth);
  FDataViewRect.Right  := FViewRect.Right  - Round(FLayoutManager.RightUniqueCount  * FCellWidth);
  FDataViewRect.Top    := FViewRect.Top    + Round(FLayoutManager.TopUniqueCount    * FCellWidth);
  FDataViewRect.Bottom := FViewRect.Bottom - Round(FLayoutManager.BottomUniqueCount * FCellWidth);

  FDataViewWidth  := FDataViewRect.Right  - FDataViewRect.Left;
  FDataViewHeight := FDataViewRect.Bottom - FDataViewRect.Top;
  //---------------------------------------------------------------------------------------------------------
  if not Assigned(FDragOverRefBlock2) then
    begin
      while FBlockList.Count <> 0 do
        begin
          FBlockList.Objects[0].Free;
          FBlockList.Delete(0);
        end;

      for x := 0 to FLayoutManager.LeftUniqueCount - 1 do
        begin
          BlockObject            := TBlockObject.Create;
          BlockObject.ZOrder     := CurrentZ;
          BlockObject.Horizontal := False;

          BlockObject.ARect := iRect(FViewRect.Left + Round( x   *FCellWidth), FDataViewRect.Top,
                                     FViewRect.Left + Round((x+1)*FCellWidth), FDataViewRect.Bottom);
          FBlockList.AddObject('', BlockObject);
          Inc(CurrentZ);
        end;

      BlockObject            := TBlockObject.Create;
      BlockObject.DataView   := True;
      BlockObject.ZOrder     := CurrentZ;
      BlockObject.Horizontal := False;
      BlockObject.ARect      := FDataViewRect;
      FBlockList.AddObject('', BlockObject);
      Inc(CurrentZ);

      for x := 0 to FLayoutManager.RightUniqueCount - 1 do
        begin
          BlockObject            := TBlockObject.Create;
          BlockObject.ZOrder     := CurrentZ;
          BlockObject.Horizontal := False;

          BlockObject.ARect := iRect(FDataViewRect.Right + Round( x   *FCellWidth), FDataViewRect.Top,
                                     FDataViewRect.Right + Round((x+1)*FCellWidth), FDataViewRect.Bottom);
          FBlockList.AddObject('', BlockObject);
          Inc(CurrentZ);
        end;
      //---------------------------------------------------------------------------------------------------------
      CurrentZ := FLayoutManager.TopUniqueCount + FLayoutManager.BottomUniqueCount;

      for x := 0 to FLayoutManager.TopUniqueCount - 1 do
        begin
          BlockObject            := TBlockObject.Create;
          if x = 0 then BlockObject.ToolBar := True;
          BlockObject.ZOrder     := CurrentZ;
          BlockObject.Horizontal := True;
          BlockObject.ARect := iRect(FViewRect.Left,  FViewRect.Top + Round( x   *FCellWidth),
                                     FViewRect.Right, FViewRect.Top + Round((x+1)*FCellWidth));
          FBlockList.AddObject('', BlockObject);
          Dec(CurrentZ);
        end;

      BlockObject            := TBlockObject.Create;
      BlockObject.DataView   := True;
      BlockObject.ZOrder     := CurrentZ;
      BlockObject.Horizontal := True;
      BlockObject.ARect      := FDataViewRect;
      FBlockList.AddObject('', BlockObject);  
      Dec(CurrentZ);

      for x := 0 to FLayoutManager.BottomUniqueCount - 1 do
        begin
          BlockObject            := TBlockObject.Create;
          BlockObject.ZOrder     := CurrentZ;
          BlockObject.Horizontal := True;
          BlockObject.ARect := iRect(FViewRect.Left,  FDataViewRect.Bottom + Round( x   *FCellWidth),
                                     FViewRect.Right, FDataViewRect.Bottom + Round((x+1)*FCellWidth));
          FBlockList.AddObject('', BlockObject);
          Dec(CurrentZ);
        end;
    end;
  //---------------------------------------------------------------------------------------------------------
  for x := 0 to FLayoutManager.Count-1 do
    begin
      iBlockObject := FLayoutManager.Items[x];

      if (iBlockObject is TiPlotDataViewLayout) or (iBlockObject is TiPlotDataView) then
        begin
          TiPlotLayoutAccess(iBlockObject).SetLayoutRect(Rect(FDataViewRect.Left, FDataViewRect.Top, FDataViewRect.Right, FDataViewRect.Bottom));
        end
      else
        begin
          if iBlockObject.IsHorz then
            begin
              if iBlockObject.ZOrder > FLayoutManager.DataViewHorz.ZOrder then
                begin
                  BlockStart := FDataViewRect.Top - Round((iBlockObject.ZOrder - FLayoutManager.DataViewHorz.ZOrder  ) * FCellWidth);
                  BlockStop  := FDataViewRect.Top - Round((iBlockObject.ZOrder - FLayoutManager.DataViewHorz.ZOrder-1) * FCellWidth);
                end
              else
                begin
                  BlockStart := FDataViewRect.Bottom + Round((FLayoutManager.DataViewHorz.ZOrder - iBlockObject.ZOrder-1) * FCellWidth);
                  BlockStop  := FDataViewRect.Bottom + Round((FLayoutManager.DataViewHorz.ZOrder - iBlockObject.ZOrder  ) * FCellWidth);
                end;

              if (iBlockObject is TiPlotAxis) then
                begin
                  BlockLeft  := Round(FDataViewRect.Left + iBlockObject.StartPercent * (FDataViewWidth)/100);
                  BlockRight := Round(FDataViewRect.Left + iBlockObject.StopPercent  * (FDataViewWidth)/100);
                end
              else
                begin
                  BlockLeft  := FViewRect.Left + Round(iBlockObject.StartPercent * (FViewRect.Right - FViewRect.Left)/100);
                  BlockRight := FViewRect.Left + Round(iBlockObject.StopPercent  * (FViewRect.Right - FViewRect.Left)/100);
                end;

              TiPlotLayoutAccess(iBlockObject).SetLayoutRect(Rect(BlockLeft, BlockStart, BlockRight, BlockStop));
            end
          else
            begin
              if iBlockObject.ZOrder > FLayoutManager.DataViewVert.ZOrder then
                begin
                  BlockStart := FDataViewRect.Right + Round((iBlockObject.ZOrder - FLayoutManager.DataViewVert.ZOrder-1) * FCellWidth);
                  BlockStop  := FDataViewRect.Right + Round((iBlockObject.ZOrder - FLayoutManager.DataViewVert.ZOrder  ) * FCellWidth);
                end
              else
                begin
                  BlockStart := FDataViewRect.Left - Round((FLayoutManager.DataViewVert.ZOrder - iBlockObject.ZOrder  ) * FCellWidth);
                  BlockStop  := FDataViewRect.Left - Round((FLayoutManager.DataViewVert.ZOrder - iBlockObject.ZOrder-1) * FCellWidth);
                end;

              BlockTop    := FDataViewRect.Bottom - Round(iBlockObject.StopPercent  * (FDataViewHeight)/100);
              BlockBottom := FDataViewRect.Bottom - Round(iBlockObject.StartPercent * (FDataViewHeight)/100);

              TiPlotLayoutAccess(iBlockObject).SetLayoutRect(Rect(BlockStart, BlockTop, BlockStop, BlockBottom));
            end;
        end;
    end;
end;
//****************************************************************************************************************************************************
procedure TiPlotLayoutViewer.TriggerChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;
//****************************************************************************************************************************************************
end.
