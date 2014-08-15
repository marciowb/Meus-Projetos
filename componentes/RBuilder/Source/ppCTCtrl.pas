{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppCTCtrl;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TypInfo, ppComm, ppRelatv, ppDB, ppTypes, ppUtils, ExtCtrls, StdCtrls,
  ppCTMain, ppCTCell;


type

  TppCrossTabSelection = class;
  
  TppGetFieldEvent = procedure (Sender: TObject; var aField: TppField) of object;

  TppCrossTabMoveModeType = (mmColumn, mmRow, mmValue);

  {@TppCrossTabControl }
  TppCrossTabControl = class(TComponent)
    private
      FAddToSelection: Boolean;
      FCrossTabImage: TBitmap;
      FCrossTabImage2: TBitmap;
      FCrossTab: TppCrossTab;
      FElements: TList;
      FElementSelected: Boolean;
      FFieldSource: TWinControl;
      FGridColor: TColor;
      FHighlighting: Boolean;
      FNeedToUpdateScrollBars: Boolean;
      FNewColumn: TppElement;
      FNewRow: TppElement;
      FNewValue: TppElement;
      FMoveDimension: Boolean;
      FMoveMode: TppCrossTabMoveModeType;
      FMovePosition: TRect;
      FOnGetField: TppGetFieldEvent;
      FOnSelectionChange: TNotifyEvent;
      FOnStatusChange: TNotifyEvent;
      FOldSize: TRect;
      FPaintBox: TPaintBox;
      FPoint: TPoint;
      FScrollBox: TScrollBox;
      FSelection: TppCrossTabSelection;
      FStatus: String;
      FUpdating: Boolean;
      FVisible: Boolean;

      {draw variables}
      FAnchorHeight: Integer;
      FAnchorWidth: Integer;
      FMainColumnWidth: Integer;
      FMainRowHeight: Integer;
      FTotalHeight: Integer;
      FTotalWidth: Integer;
      FHorizontalMargin: Integer;
      FVerticalMargin: Integer;

      {double-click vars}
      FClickTimeOne: TDateTime;
      FClickTimeTwo: TDateTime;
      FClickPointOne: TPoint;
      FClickPointTwo: TPoint;
      FClickCount: Integer;

      function  AlignmentToX(aAlignment: TAlignment; aWidth, aTextWidth: Integer): Integer;
      function  CalcMaxHeightOfElements(aList: TList): Integer;
      function  CalcMaxWidthOfElements(aList: TList): Integer;
      function  Canvas: TCanvas;
      procedure ClearMoveIndicators;
      procedure DimensionChangeEvent(Sender: TObject);
      function  DoubleClickEnd: Boolean;
      procedure DoubleClickStart;
      procedure DrawCrossTab;
      procedure DrawElement(aElement: TppElement; aCanvas: TCanvas);
      procedure DrawMoveIndicators;
      procedure ElementChangeEvent(Sender: TObject);
      function  OkayToPaint: Boolean;
      function  PointToElement(aPoint: TPoint): TppElement;
      function  PointToNewElement(aPoint: TPoint): TppElement;
      procedure SelectionChangeEvent(Sender: TObject);
      procedure SetFieldSource(aFieldSource: TWinControl);
      procedure SetVisible(aValue: Boolean);
      procedure SetVisibleProperty;
      procedure SetVisiblePropertyOfTotal(aTotal: TppTotal);
      procedure SetHeightOfElements(aList: TList; aHeight: Integer);
      procedure SetWidthOfElements(aList: TList; aWidth: Integer);
      procedure UpdateScrollBars;
      procedure UpdateStatus(const aStatus: String);
      function  ValidMoveStartDrag(aElement: TppElement): Boolean;
      function  ValidMoveDragOver(aTargetElement, aSourceElement: TppElement): Boolean;
      function  ValidMoveDragDrop(aTargetElement, aSourceElement: TppElement; aAvailableIndex: Integer): Boolean;

      {draw routines}
      procedure CalcTextDimensions(aCanvas: TCanvas);
      procedure CalcColumnTopAndHeight;
      procedure CalcColumnSubTotalTopAndHeight;
      procedure CalcColumnGrandTotalTopAndHeight;
      procedure CalcNewColumnTopAndHeight;
      procedure CalcRowLeftAndWidth;
      procedure CalcRowSubTotalLeftAndWidth;
      procedure CalcRowGrandTotalLeftAndWidth;
      procedure CalcNewRowLeftAndWidth;
      procedure CalcValueHeightAndWidth;
      procedure CalcNewValueHeightAndWidth;
      procedure CalcColumnLeftAndWidth;
      procedure CalcRowTopAndHeight;
      procedure CalcValueLeftTopAndWidth;
      procedure CalcColumnSubTotalLeftAndWidth;
      procedure CalcColumnGrandTotalLeftAndWidth;
      procedure CalcRowSubTotalTopAndHeight;
      procedure CalcRowGrandTotalTopAndHeight;
      procedure DrawAnchorCells(aCanvas: TCanvas);
      procedure DrawColumnSubTotals(aCanvas: TCanvas);
      procedure DrawColumnGrandTotal(aCanvas: TCanvas);
      procedure DrawRowSubTotals(aCanvas: TCanvas);
      procedure DrawRowGrandTotals(aCanvas: TCanvas);
      procedure DrawSelection;

      {event handlers}
      procedure PaintBoxStartDragEvent(Sender: TObject; var DragObject: TDragObject);
      procedure PaintBoxEndDragEvent(Sender, Target: TObject; X, Y: Integer);
      procedure PaintBoxDragDropEvent(Sender, Source: TObject; X, Y: Integer);
      procedure PaintBoxDragOverEvent(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
      procedure PaintBoxMouseMoveEvent(Sender: TObject; Shift: TShiftState; X, Y: Integer);
      procedure PaintBoxPaintEvent(Sender: TObject);

    public
      constructor CreateControl(aCrossTab: TppCrossTab; aParentControl: TWinControl);
      destructor Destroy; override;

      procedure BeginUpdate;
      procedure EndUpdate;
      procedure Refresh;

      property FieldSource: TWinControl read FFieldSource write SetFieldSource;
      property OnGetField: TppGetFieldEvent read FOnGetField write FOnGetField;
      property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
      property OnStatusChange: TNotifyEvent read FOnStatusChange write FOnStatusChange;
      property Selection: TppCrossTabSelection read FSelection;
      property Status: String read FStatus;
      property Visible: Boolean read FVisible write SetVisible;

  end; {class, TppCrossTabControl}

  {@TppCrossTabSelection }
  TppCrossTabSelection = class(TppCommunicator)
    private
      FContainsDimensions: Boolean;
      FContainsTotals: Boolean;
      FControl: TppCrossTabControl;
      FImage: TCanvas;
      FLiveImage: TCanvas;
      FSelectionImage: TCanvas;
      FElements: TList;
      FOnElementChange: TNotifyEvent;
      FOnSelectionChange: TNotifyEvent;

      procedure DrawElement(aElement: TppElement);
      procedure Erase;
      procedure EraseElement(aElement: TppElement);
      procedure ElementChangeEvent(Sender: TObject);
      function  GetElementCount: Integer;
      function  GetElementForIndex(aIndex: Integer): TppElement;
      procedure UpdateContainsProps;

    protected
      procedure DoOnSelectionChange;

    public
      constructor CreateSelection(aControl: TppCrossTabControl);
      destructor Destroy; override;

      procedure Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType); override;

      procedure GetPropertyValue(const aPropName: String; var aPropValue);
      function  HasProperty(const aPropName: String): Boolean;
      procedure SetPropertyValue(const aPropName: String; var aPropValue);

      function  AddElement(aElement: TppElement): Integer;
      procedure Clear;
      procedure Draw;
      function  IndexOfElement(aElement: TppElement): Integer;
      function  RemoveElement(aElement: TppElement): Integer;
      procedure SelectElement(aElement: TppElement);

      property ContainsDimensions: Boolean read FContainsDimensions;
      property ContainsTotals: Boolean read FContainsTotals;
      property Image: TCanvas read FImage write FImage;
      property ElementCount: Integer read GetElementCount;
      property Elements[Index: Integer]: TppElement read GetElementForIndex;
      property LiveImage: TCanvas read FLiveImage write FLiveImage;
      property OnElementChange: TNotifyEvent read FOnElementChange write FOnElementChange;
      property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
      property SelectionImage: TCanvas read FSelectionImage write FSelectionImage;

  end; {class, TppCrossTabSelection}


implementation

{------------------------------------------------------------------------------}
{ raPointInRect }

function raPointInRect(aPoint: TPoint; aRect: TRect): Boolean;
begin

  Result := (aPoint.X >= aRect.Left) and (aPoint.X <= aRect.Right) and
            (aPoint.Y >= aRect.Top) and (aPoint.Y <= aRect.Bottom);

end; {function, raPointInRect}

{******************************************************************************
 *
 ** C R O S S T A B   C O N T R O L
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CreateControl }

constructor TppCrossTabControl.CreateControl(aCrossTab: TppCrossTab; aParentControl: TWinControl);
begin

  inherited Create(nil);

  aCrossTab.OnDimensionChange := DimensionChangeEvent;

  FClickCount := 0;
  FCrossTab := aCrossTab;
  FCrossTabImage := nil;
  FCrossTabImage2 := nil;
  FElements := TList.Create;
  FElementSelected := False;
  FFieldSource := nil;
  FHighlighting := False;
  FMoveDimension := False;
  FMoveMode := mmColumn;
  FMovePosition := Rect(-1, -1, -1, -1);
  FNeedToUpdateScrollBars := True;
  FOnGetField := nil;
  FOnSelectionChange := nil;
  FOnStatusChange := nil;
  FOldSize := Rect(0,0,0,0);
  FPoint := Point(-1, -1);
  FSelection := TppCrossTabSelection.CreateSelection(Self);
  FSelection.OnElementChange := ElementChangeEvent;
  FSelection.OnSelectionChange := SelectionChangeEvent;
  FStatus := '';
  FUpdating := False;

  FNewColumn := TppElement.CreateWithName(Self, ppLoadStr(659)); {'new column'}
  FNewColumn.Color := clBtnFace;

  FNewRow := TppElement.CreateWithName(Self, ppLoadStr(660)); {'new row'}
  FNewRow.Color := clBtnFace;

  FNewValue := TppElement.CreateWithName(Self, ppLoadStr(661)); {'new value'}
  FNewValue.Color := clBtnFace;

  FScrollBox := TScrollBox.Create(Self);
  FScrollBox.Parent := aParentControl;
  FScrollBox.Color := clWhite;
  FScrollBox.Align := alClient;
  FScrollBox.Visible := True;

  FPaintBox := TPaintBox.Create(Self);
  FPaintBox.Parent := FScrollBox;
  FPaintBox.Color := clWhite;
  FPaintBox.Align := alClient;
  FPaintBox.DragMode := dmAutomatic;
  FPaintBox.DragCursor := crDefault;

  {assign paint routine to paint boxes}
  FPaintBox.OnStartDrag := PaintBoxStartDragEvent;
  FPaintBox.OnDragOver  := PaintBoxDragOverEvent;
  FPaintBox.OnDragDrop  := PaintBoxDragDropEvent;
  FPaintBox.OnMouseMove := PaintBoxMouseMoveEvent;
  FPaintBox.OnPaint     := PaintBoxPaintEvent;
  FPaintBox.OnEndDrag   := PaintBoxEndDragEvent;

end; {constructor, CreateControl}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.Destroy }

destructor TppCrossTabControl.Destroy;
begin

  FCrossTab.OnDimensionChange := nil;
  
  FCrossTabImage.Free;
  FCrossTabImage2.Free;
  FElements.Free;
  FNewColumn.Free;
  FNewRow.Free;
  FNewValue.Free;
  FPaintBox.Free;
  FScrollBox.Free;
  FSelection.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.SetVisibleProperty }

procedure TppCrossTabControl.SetVisibleProperty;
var
  lTotals: TList;
  liIndex: Integer;
  lTotal: TppTotal;
begin

  lTotals := TList.Create;

  for liIndex := 0 to FSelection.ElementCount - 1 do
    begin
      if (FSelection.Elements[liIndex].Parent is TppTotal) then
        begin
          lTotal := TppTotal(FSelection.Elements[liIndex].Parent);

          if (lTotal.Parent is TppColumnDef) then
            lTotal := TppColumnDef(lTotal.Parent).SubTotals[0]

          else if (lTotal.Parent is TppGrandTotal) and (FCrossTab.IndexOfColumnGrandTotal(TppGrandTotal(lTotal)) <> -1) then
            lTotal := FCrossTab.ColumnGrandTotals[0];

          if (lTotals.IndexOf(lTotal) = -1) then
            lTotals.Add(lTotal);
        end;
    end;

  for liIndex := 0 to lTotals.Count - 1 do
    SetVisiblePropertyOfTotal(TppTotal(lTotals[liIndex]));

  lTotals.Free;

end; {procedure, SetVisibleProperty}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.SetVisiblePropertyOfTotal }

procedure TppCrossTabControl.SetVisiblePropertyOfTotal(aTotal: TppTotal);
var
  lbVisible: Boolean;
begin

  lbVisible := not(aTotal.Visible);

  if (aTotal.Parent is TppRowDef) then
    aTotal.Visible := lbVisible

  else if (aTotal.Parent is TppColumnDef) then
    TppColumnDef(aTotal.Parent).ShowSubTotals(lbVisible)

  else if (aTotal.Parent is TppCrossTab) and (FCrossTab.IndexOfRowGrandTotal(TppGrandTotal(aTotal)) <> -1) then
    aTotal.Visible := lbVisible

  else if (aTotal.Parent is TppCrossTab) and (FCrossTab.IndexOfColumnGrandTotal(TppGrandTotal(aTotal)) <> -1) then
    TppCrossTab(aTotal.Parent).ShowGrandTotals(ctttColumn, lbVisible);

end; {procedure, SetVisiblePropertyOfTotal}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.BeginUpdate }

procedure TppCrossTabControl.BeginUpdate;
begin
  FUpdating := True;
end; {procedure, BeginUpdate}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.EndUpdate }

procedure TppCrossTabControl.EndUpdate;
begin
  FUpdating := False;

  Refresh;
end; {procedure, EndUpdate}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.Refresh }

procedure TppCrossTabControl.Refresh;
begin

  DrawCrossTab;

  PaintBoxPaintEvent(Self);

end; {procedure, Refresh}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DimensionChangeEvent }

procedure TppCrossTabControl.DimensionChangeEvent(Sender: TObject);
begin
  Refresh;
end; {procedure, DimensionChangeEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.ElementChangeEvent }

procedure TppCrossTabControl.ElementChangeEvent(Sender: TObject);
begin
  Refresh;
end; {procedure, ElementChangeEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.SetFieldSource }

procedure TppCrossTabControl.SetFieldSource(aFieldSource: TWinControl);
begin
  FFieldSource := aFieldSource;
end; {procedure, SetFieldSource}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.SetVisible }

procedure TppCrossTabControl.SetVisible(aValue: Boolean);
begin
  FVisible := aValue;

  if (aValue) then
    DrawCrossTab;

  FScrollBox.Visible := aValue;
  FPaintBox.Visible := aValue;

end; {procedure, SetVisible}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.SelectionChangeEvent }

procedure TppCrossTabControl.SelectionChangeEvent(Sender: TObject);
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Sender);
end; {procedure, SelectionChangeEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.OkayToPaint }

function TppCrossTabControl.OkayToPaint: Boolean;
begin
  if FHighlighting then
    Result := False
  else
    Result := True;
end; {procedure, OkayToPaint}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PaintBoxPaintEvent }

procedure TppCrossTabControl.PaintBoxPaintEvent(Sender: TObject);
begin

  if not(OkayToPaint) then Exit;

  UpdateScrollBars;

  {copy crosstab image to paint box}
  Canvas.CopyRect(Canvas.ClipRect, FCrossTabImage2.Canvas, Canvas.ClipRect);

end; {procedure, PaintBoxPaintEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PaintBoxMouseMoveEvent }

procedure TppCrossTabControl.PaintBoxMouseMoveEvent(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  lElement: TppElement;
  lsStatus: String;
begin

  FAddToSelection := (ssCtrl in Shift);

  lElement := PointToElement(Point(X, Y));

  if (lElement <> nil) then
    lsStatus := lElement.GetName
  else
    lsStatus := '';

  UpdateStatus(lsStatus);

end; {procedure, PaintBoxMouseMoveEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PaintBoxStartDragEvent }

procedure TppCrossTabControl.PaintBoxStartDragEvent(Sender: TObject; var DragObject: TDragObject);
var
  lElement: TppElement;
begin

  GetCursorPos(FPoint);

  FPoint := FPaintBox.ScreenToClient(FPoint);

  DoubleClickStart;

  if (PointToNewElement(FPoint) = nil) then
    lElement := PointToElement(FPoint)
  else
    lElement := nil;

  if (lElement <> nil) and (FSelection.IndexOfElement(lElement) = -1) then
    begin
      if FAddToSelection then
        FSelection.AddElement(lElement)
      else
        FSelection.SelectElement(lElement);

      FElementSelected := True;
    end
  else
    FElementSelected := False;

  FMoveDimension := ValidMoveStartDrag(lElement);
   
end; {procedure, PaintBoxStartDragEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PaintBoxEndDragEvent }

procedure TppCrossTabControl.PaintBoxEndDragEvent(Sender, Target: TObject; X, Y: Integer);
begin

  FElementSelected := False;
  FMoveDimension := False;

  {clear move indicators}
  if (FMovePosition.Left <> -1) then
    begin
      ClearMoveIndicators;

      FMovePosition := Rect(-1, -1, -1, -1);
    end;

end; {procedure, PaintBoxEndDragEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PaintBoxDragOverEvent }

procedure TppCrossTabControl.PaintBoxDragOverEvent(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  lElement: TppElement;
  lPoint: TPoint;
begin

  if (FMoveDimension) or (Source = FFieldSource) then
    begin
      GetCursorPos(lPoint);

      lPoint := FPaintBox.ScreenToClient(lPoint);

      lElement := PointToElement(lPoint);

      if (Source = FFieldSource) then
        begin
          FMoveDimension := False;

          ValidMoveDragOver(lElement, nil);
        end
      else
        ValidMoveDragOver(lElement, FSelection.Elements[0]);
    end;

end; {procedure, PaintBoxDragOverEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PaintBoxDragDropEvent }

procedure TppCrossTabControl.PaintBoxDragDropEvent(Sender, Source: TObject; X, Y: Integer);
var
  lElement: TppElement;
  lSourceElement: TppElement;
  lTotal: TppTotal;
  liAvailableIndex: Integer;
  lField: TppField;
begin

  if DoubleClickEnd then
    begin
      lElement := PointToElement(Point(X, Y));

      if (lElement <> nil) and (lElement.Parent is TppTotal) then
        begin
          BeginUpdate;

          lTotal := TppTotal(lElement.Parent);

          SetVisiblePropertyOfTotal(lTotal);

          EndUpdate;
        end;
    end;

  if (FPoint.X = X) and (FPoint.Y = Y) then
    begin
      lElement := PointToElement(Point(X, Y));

      if (lElement = nil) then
        FSelection.Clear

      else if (FSelection.IndexOfElement(lElement) <> -1) and not(FElementSelected) then
        FSelection.RemoveElement(lElement);
    end

  else if (FMoveDimension) or (Source = FFieldSource) then
    begin
      lElement := PointToElement(Point(X, Y));

      if (FMoveDimension) then
        begin
          lSourceElement := FSelection.Elements[0];

          liAvailableIndex := -1;
        end
      else
        begin
          lSourceElement := nil;

          lField := nil;

          if Assigned(FOnGetField) then FOnGetField(Self, lField);

          if (lField = nil) then Exit;

          liAvailableIndex := FCrossTab.IndexOfAvailableDimension(lField.FieldAlias);

          if (liAvailableIndex = -1) then Exit;
        end;

      ValidMoveDragDrop(lElement, lSourceElement, liAvailableIndex);
    end;

end; {procedure, PaintBoxDragDropEvent}


{------------------------------------------------------------------------------}
{ TppCrossTabControl.DoubleClickStart }

procedure TppCrossTabControl.DoubleClickStart;
begin

  if (FClickCount = 0) then
    begin
      FClickTimeOne := Now;
      FClickPointOne := FPoint;
    end
  else
    begin
      FClickTimeTwo := Now;
      FClickPointTwo := FPoint;
    end;

end; {procedure, DoubleClickStart}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DoubleClickEnd }

function TppCrossTabControl.DoubleClickEnd: Boolean;
var
  ldDifference: TDateTime;
  lwHour: Word;
  lwMin: Word;
  lwSec: Word;
  lwMSec: Word;
  lbCountClick: Boolean;
begin

  if (FClickCount = 0) then
    begin
      ldDifference := Now - FClickTimeOne;

      DecodeTime(ldDifference, lwHour, lwMin, lwSec, lwMSec);

      lbCountClick := ((lwSec = 0) and (lwMSec < 750))
    end

  else
    begin
      ldDifference := FClickTimeTwo - FClickTimeOne;

      DecodeTime(ldDifference, lwHour, lwMin, lwSec, lwMSec);

      lbCountClick := (Abs(FClickPointOne.X - FClickPointTwo.X) < 2) and
                      (Abs(FClickPointOne.Y - FClickPointTwo.Y) < 2) and
                      (lwSec = 0) and (lwMSec < 750);

      if not(lbCountClick) then
        begin
          FClickCount := 1;

          FClickPointOne := FClickPointTwo;
          FClickTimeOne := FClickTimeTwo;
        end;
    end;

  if (lbCountClick) then
    Inc(FClickCount);

  Result := (FClickCount = 2);

  if (FClickCount = 2) then
    FClickCount := 0;

end; {function, DoubleClickEnd}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.ValidMoveStartDrag }

function TppCrossTabControl.ValidMoveStartDrag(aElement: TppElement): Boolean;
var
  lSelectedElement: TppElement;
begin

  Result := False;

  if (aElement = nil) then Exit;

  if (FSelection.ElementCount > 1) then Exit;

  lSelectedElement := FSelection.Elements[0];

  if (lSelectedElement is TppValueCaptionDef) then
    lSelectedElement := TppValueDef(lSelectedElement.Parent);

  if (aElement is TppValueCaptionDef) then
    aElement := TppValueDef(aElement.Parent);

  if not(lSelectedElement is TppDimension) then Exit;

  if (lSelectedElement <> aElement) then Exit;

  if (lSelectedElement is TppColumnDef) and (FCrossTab.ColumnDefCount > 1) then
    FMoveMode := mmColumn

  else if (lSelectedElement is TppRowDef) and (FCrossTab.RowDefCount > 1) then
    FMoveMode := mmRow

  else if (lSelectedElement is TppValueDef) and (FCrossTab.ValueDefCount > 1) then
    FMoveMode := mmValue;

  Result := True;

end; {procedure, ValidMoveStartDrag}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.ValidMoveDragOver }

function TppCrossTabControl.ValidMoveDragOver(aTargetElement, aSourceElement: TppElement): Boolean;
var
  lRect: TRect;
  liSourceIndex: Integer;
  liTargetIndex: Integer;
begin

  Result := False;

  ClearMoveIndicators;

  if (aTargetElement = nil) then Exit;

  FStatus := aTargetElement.GetName;

  FOnStatusChange(Self);


  if (aSourceElement is TppValueCaptionDef) then
    aSourceElement := TppValueDef(aSourceElement.Parent);

  if (aTargetElement is TppValueCaptionDef) then
    aTargetElement := TppValueDef(aTargetElement.Parent);


  if (aTargetElement = aSourceElement) then Exit;

  if (aSourceElement is TppValueDef) and not(aTargetElement is TppValueDef) then Exit;

  if (aSourceElement <> nil) and (aTargetElement <> nil) and (aSourceElement.ClassType = aTargetElement.ClassType) then
    begin
      liTargetIndex := FCrossTab.IndexOfChild(aTargetElement);
      liSourceIndex := FCrossTab.IndexOfChild(aSourceElement);
    end
  else
    begin
      liTargetIndex := -1;
      liSourceIndex := -1;
    end;

  {if this is already the innermost dimension, we can't drag into the new cell}
  if ((aSourceElement <> nil) and (aSourceElement is TppValueDef) and (aTargetElement = FNewValue) and (FCrossTab.IndexOfChild(aSourceElement) = FCrossTab.ValueDefCount - 1))  then
    Exit

  else if ((aSourceElement <> nil) and (aSourceElement is TppRowDef) and (aTargetElement = FNewRow) and (FCrossTab.IndexOfChild(aSourceElement) = FCrossTab.RowDefCount - 1))  then
    Exit

  else if ((aSourceElement <> nil) and (aSourceElement is TppColumnDef) and (aTargetElement = FNewColumn) and (FCrossTab.IndexOfChild(aSourceElement) = FCrossTab.ColumnDefCount - 1)) then
    Exit;


  {set move mode}
  if ((aTargetElement is TppValueDef) or (aTargetElement = FNewValue))  then
    FMoveMode := mmValue

  else if ((aTargetElement is TppRowDef) or (aTargetElement = FNewRow))  then
    FMoveMode := mmRow

  else if ((aTargetElement is TppColumnDef) or (aTargetElement = FNewColumn)) then
    FMoveMode := mmColumn

  else
    Exit;


  lRect := aTargetElement.DrawRect;

  if (aTargetElement is TppValueDef) then
    lRect.Top := lRect.Top - TppValueDef(aTargetElement).CaptionDef.Height;

  case FMoveMode of
    mmColumn, mmValue:
      begin
        if (liTargetIndex < liSourceIndex) or (liSourceIndex = -1) then
          FMovePosition := Rect(lRect.Left, lRect.Top, lRect.Right, lRect.Top)
        else
          FMovePosition := Rect(lRect.Left, lRect.Bottom, lRect.Right, lRect.Bottom);
      end;

    mmRow:
      begin
        if (liTargetIndex < liSourceIndex) or (liSourceIndex = -1) then
          FMovePosition := Rect(lRect.Left, lRect.Top, lRect.Left, lRect.Bottom)
        else
          FMovePosition := Rect(lRect.Right, lRect.Top, lRect.Right, lRect.Bottom);
      end;
  end;

  DrawMoveIndicators;

  Result := True;

end; {procedure, ValidMoveDragOver}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.ClearMoveIndicators }

procedure  TppCrossTabControl.ClearMoveIndicators;
var
  lRect1: TRect;
  lRect2: TRect;
  lRect: TRect;
begin

  if (FMovePosition.Left = -1) then Exit;

  lRect := FMovePosition;

  case FMoveMode of
    mmColumn, mmValue:
      begin
        lRect1 := Rect(lRect.Left - 4, lRect.Top - 4, lRect.Left, lRect.Top + 4);
        lRect2 := Rect(lRect.Right + 1, lRect.Top - 4, lRect.Right + 5, lRect.Top + 4);
      end;

    mmRow:
      begin
        lRect1 := Rect(lRect.Left - 4, lRect.Top - 4, lRect.Left + 4, lRect.Top);
        lRect2 := Rect(lRect.Left - 4, lRect.Bottom + 1, lRect.Left + 4, lRect.Bottom + 5);
      end;
  end;

  FCrossTabImage2.Canvas.CopyRect(lRect1, FCrossTabImage.Canvas, lRect1);
  FCrossTabImage2.Canvas.CopyRect(lRect2, FCrossTabImage.Canvas, lRect2);

  lRect := Rect(lRect1.Left, lRect1.Top, lRect2.Right, lRect2.Bottom);

  Canvas.CopyRect(lRect, FCrossTabImage2.Canvas, lRect);

  FMovePosition := Rect(-1, -1, -1, -1);

end; {procedure, ClearMoveIndicators}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawMoveIndicators }

procedure  TppCrossTabControl.DrawMoveIndicators;
var
  lRect: TRect;

  procedure DrawIndicator(aX, aY, aDirection: Integer);
    begin
      case aDirection of
         1: FCrossTabImage2.Canvas.Polygon([Point(aX, aY), Point(aX + 3, aY + 3), Point(aX, aY + 6), Point(aX, aY)]);
        -1: FCrossTabImage2.Canvas.Polygon([Point(aX + 3, aY), Point(aX, aY + 3), Point(aX + 3, aY + 6), Point(aX + 3, aY)]);
         2: FCrossTabImage2.Canvas.Polygon([Point(aX, aY), Point(aX + 3, aY + 3), Point(aX + 6, aY), Point(aX, aY)]);
        -2: FCrossTabImage2.Canvas.Polygon([Point(aX, aY + 3), Point(aX + 3, aY), Point(aX + 6, aY + 3), Point(aX, aY + 3)]);
      end;
    end;

begin

  lRect := FMovePosition;

  FCrossTabImage2.Canvas.Brush.Color := clBlack;
  FCrossTabImage2.Canvas.Pen.Color := clBlack;

  case FMoveMode of

    mmColumn, mmValue:
      begin
        DrawIndicator(lRect.Left - 4, lRect.Top - 3, 1);
        DrawIndicator(lRect.Right + 1, lRect.Top - 3, -1);

        lRect := Rect(lRect.Left - 4, lRect.Top - 4, lRect.Right + 5, lRect.Top + 4);
      end;

    mmRow:
      begin
        DrawIndicator(lRect.Left - 3, lRect.Top - 4, 2);
        DrawIndicator(lRect.Left - 3, lRect.Bottom, -2);

        lRect := Rect(lRect.Left - 4, lRect.Top - 4, lRect.Left + 4, lRect.Bottom + 5);
      end;

  end;

  Canvas.CopyRect(lRect, FCrossTabImage2.Canvas, lRect);

end; {procedure, DrawMoveIndicators}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.ValidMoveDragDrop }

function TppCrossTabControl.ValidMoveDragDrop(aTargetElement, aSourceElement: TppElement; aAvailableIndex: Integer): Boolean;
var
  liSourceIndex: Integer;
  liTargetIndex: Integer;
  lCopyElement: TppElement;
begin

  if (aSourceElement is TppValueCaptionDef) then
    aSourceElement := TppValueDef(aSourceElement.Parent);

  if (aTargetElement is TppValueCaptionDef) then
    aTargetElement := TppValueDef(aTargetElement.Parent);

  if ValidMoveDragOver(aTargetElement, aSourceElement) then
    begin
      BeginUpdate;

      liTargetIndex := FCrossTab.IndexOfChild(aTargetElement);

      if (aSourceElement <> nil) and (aSourceElement.ClassType = aTargetElement.ClassType) then
        FCrossTab.MoveChild(aSourceElement, liTargetIndex)
      else
        begin

          lCopyElement := nil;

          if (aSourceElement <> nil) then
            begin
              liSourceIndex := FCrossTab.IndexOfChild(aSourceElement);

              if (liSourceIndex <> -1) then
                begin
                  lCopyElement := TppElement.Create(Self);
                  lCopyElement.Assign(aSourceElement);
                end;

              {deselect source, frees source element}
              if (aSourceElement is TppColumnDef) then
                aAvailableIndex := FCrossTab.DeselectColumnDef(liSourceIndex)

              else if (aSourceElement is TppRowDef) then
                aAvailableIndex := FCrossTab.DeselectRowDef(liSourceIndex)

              else if (aSourceElement is TppValueDef) then
                aAvailableIndex := FCrossTab.DeselectValueDef(liSourceIndex);
            end;

          {select target, creates new element}
          if (aTargetElement = FNewColumn) then
            aSourceElement := FCrossTab.SelectColumnDef(aAvailableIndex)

          else if (aTargetElement = FNewRow) then
            aSourceElement := FCrossTab.SelectRowDef(aAvailableIndex)

          else if (aTargetElement = FNewValue) then
            aSourceElement := FCrossTab.SelectValueDef(aAvailableIndex)

          else if (aTargetElement is TppColumnDef) then
            begin
              aSourceElement := FCrossTab.SelectColumnDef(aAvailableIndex);
              FCrossTab.MoveChild(aSourceElement, liTargetIndex)
            end

          else if (aTargetElement is TppRowDef) then
            begin
              aSourceElement := FCrossTab.SelectRowDef(aAvailableIndex);
              FCrossTab.MoveChild(aSourceElement, liTargetIndex)
            end

          else if (aTargetElement is TppValueDef) then
            begin
              aSourceElement := FCrossTab.SelectValueDef(aAvailableIndex);
              FCrossTab.MoveChild(aSourceElement, liTargetIndex)
            end;

          {assign old element style to new element}
          if (lCopyElement <> nil) and (aSourceElement is TppDimension) then
            aSourceElement.Assign(lCopyElement);

          lCopyElement.Free;
        end;

      {crosstab will be redrawn, so no need to clear indicators}
      FMovePosition := Rect(-1, -1, -1, -1);

      EndUpdate;
    end;

  FMoveDimension := False;

  Result := True;

end; {procedure, ValidMoveDragDrop}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.UpdateStatus }

procedure TppCrossTabControl.UpdateStatus(const aStatus: String);
begin
  FStatus := aStatus;

  if Assigned(FOnStatusChange) then FOnStatusChange(Self);

end; {procedure, UpdateStatus}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.UpdateScrollBars }

procedure TppCrossTabControl.UpdateScrollBars;
begin

  if not OkayToPaint then Exit;

  {set horizontal scroll bar}
  if FCrossTabImage.Width > FScrollBox.Width then
    begin
      FScrollBox.HorzScrollBar.Range := FCrossTabImage.Width;
      FScrollBox.HorzScrollBar.Visible := True;
    end
  else
   begin
      FScrollBox.HorzScrollBar.Range := FScrollBox.ClientWidth;
      FScrollBox.HorzScrollBar.Visible := False;
   end;

  {set vertical scroll bar}
  if FCrossTabImage.Height > FScrollBox.Height then
    begin
      FScrollBox.VertScrollBar.Range := FCrossTabImage.Height;
      FScrollBox.VertScrollBar.Visible := True;
    end
  else
   begin
      FScrollBox.VertScrollBar.Range := FScrollBox.ClientHeight;
      FScrollBox.VertScrollBar.Visible := False;
   end;

  {reposition thumbs}
  if FNeedToUpdateScrollBars then
    begin
      FScrollBox.HorzScrollBar.Position := 0;
      FScrollBox.VertScrollBar.Position := 0;

      FNeedToUpdateScrollBars := False;
    end;

end; {procedure, UpdateScrollBars}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PointToNewElement }

function TppCrossTabControl.PointToNewElement(aPoint: TPoint): TppElement;
begin

  if raPointInRect(aPoint, FNewColumn.DrawRect) then
    Result := FNewColumn

  else if raPointInRect(aPoint, FNewRow.DrawRect) then
    Result := FNewRow

  else if raPointInRect(aPoint, FNewValue.DrawRect) then
    Result := FNewValue

  else
    Result := nil;

end; {procedure, PointToNewElement}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.PointToElement }

function TppCrossTabControl.PointToElement(aPoint: TPoint): TppElement;
var
  liIndex: Integer;
  lElement: TppElement;
begin
  Result := nil;

  {loop thru elements, try to find draw rect in which point falls}
  liIndex := 0;

  while (liIndex < FElements.Count) and (Result = nil) do
    begin
      lElement := TppElement(FElements[liIndex]);

      if raPointInRect(aPoint, lElement.DrawRect) then
        Result := lElement;

      Inc(liIndex);
    end;

end; {procedure, PointToElement}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawSelection }

procedure TppCrossTabControl.DrawSelection;
var
  lRect: TRect;
begin

  FCrossTabImage2.Free;
  FCrossTabImage2 := TBitmap.Create;

  FCrossTabImage2.Height := FCrossTabImage.Height;
  FCrossTabImage2.Width := FCrossTabImage.Width;

  lRect := Rect(0, 0, FCrossTabImage.Width, FCrossTabImage.Height);

  FCrossTabImage2.Canvas.CopyRect(lRect, FCrossTabImage.Canvas, lRect);

  FSelection.Image := FCrossTabImage.Canvas;
  FSelection.SelectionImage := FCrossTabImage2.Canvas;
  FSelection.LiveImage := Canvas;

  FSelection.Draw;

end; {procedure, DrawSelection}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.Canvas }

function TppCrossTabControl.Canvas: TCanvas;
begin
  Result := FPaintBox.Canvas;
end; {function, Canvas}

{******************************************************************************
 *
 ** D R A W   R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawCrossTab }

procedure TppCrossTabControl.DrawCrossTab;
var
  lCanvas: TCanvas;
  liIndex: Integer;
begin

  if (FUpdating) then Exit;

  if (FCrossTabImage <> nil) then
    FOldSize := Rect(0,0,FCrossTabImage.Width, FCrossTabImage.Height);

  {init draw variables}
  FAnchorHeight := 0;
  FAnchorWidth := 0;
  FElements.Clear;
  FMainRowHeight := 0;
  FMainColumnWidth := 0;
  FVerticalMargin := 10;
  FHorizontalMargin := 16;
  FTotalHeight := 0;
  FTotalWidth := 0;

  if FCrossTab.GridLines then
    FGridColor := clBlack
  else
    FGridColor := clBtnFace;

  {reset image}
  FCrossTabImage.Free;
  FCrossTabImage := TBitmap.Create;
  lCanvas := FCrossTabImage.Canvas;

  {calc text height and text width of all elements}
  CalcTextDimensions(lCanvas);

  {columns: calc top & height, calc main column width, calc anchor height}
  CalcColumnTopAndHeight;

  {column subtotals: calc top & height, update anchor height}
  CalcColumnSubTotalTopAndHeight;

  {column grand total: calc top, height & width, update anchor height}
  CalcColumnGrandTotalTopAndHeight;

  {new column: calc top, height, update main column width, update anchor height}
  CalcNewColumnTopAndHeight;

  {rows: calc left & width, calc main row height, calc anchor width}
  CalcRowLeftAndWidth;

  {row subtotals: calc left & width, update anchor width}
  CalcRowSubTotalLeftAndWidth;

  {row grand totals: calc left & width, update anchor width}
  CalcRowGrandTotalLeftAndWidth;

  {calc new row at end of existing rows}
  CalcNewRowLeftAndWidth;

  {values: update main column width, update main row height}
  CalcValueHeightAndWidth;

  {new value: update main column width, update main row height}
  CalcNewValueHeightAndWidth;

  {columns: set left and width }
  CalcColumnLeftAndWidth;

  {rows: set top and height}
  CalcRowTopAndHeight;

  {values: calc left, top, and width, calc total height and total width}
  CalcValueLeftTopAndWidth;

  {column subtotals: set left, update total width}
  CalcColumnSubTotalLeftAndWidth;

  {column grand total: set left, update total width}
  CalcColumnGrandTotalLeftAndWidth;

  {row subtotal: calc top and height, update total height}
  CalcRowSubTotalTopAndHeight;

  {row grand total: calc top and height, update total height}
  CalcRowGrandTotalTopAndHeight;

  {set size}
  FTotalHeight := FTotalHeight + FVerticalMargin;
  FTotalWidth := FTotalWidth + FHorizontalMargin;

  FCrossTabImage.Height := FTotalHeight;
  FCrossTabImage.Width := FTotalWidth;

  {draw anchor cells}
  lCanvas.Pen.Color := FGridColor;
  lCanvas.Brush.Color := clWhite;

  DrawAnchorCells(lCanvas);

  {draw columns}
  for liIndex := 0 to FCrossTab.ColumnDefCount - 1 do
    DrawElement(FCrossTab.ColumnDefs[liIndex], lCanvas);

  {draw new column}
  DrawElement(FNewColumn, lCanvas);

  {draw columnar subtotals}
  DrawColumnSubTotals(lCanvas);

  {draw column grand total}
  DrawColumnGrandTotal(lCanvas);

  {draw rows}
  for liIndex := 0 to FCrossTab.RowDefCount - 1 do
    DrawElement(FCrossTab.RowDefs[liIndex], lCanvas);

  {draw new row}
  DrawElement(FNewRow, lCanvas);

  {draw row subtotals}
  DrawRowSubTotals(lCanvas);

  {draw row grand totals}
  DrawRowGrandTotals(lCanvas);

  {draw values}
  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      DrawElement(FCrossTab.ValueDefs[liIndex].CaptionDef, lCanvas);

      DrawElement(FCrossTab.ValueDefs[liIndex], lCanvas);
    end;

  {draw new value}
  DrawElement(FNewValue, lCanvas);

  {draw selection}
  DrawSelection;

  {erase previous image}
  if (FOldSize.Right > FCrossTabImage.Width) or
     (FOldSize.Bottom > FCrossTabImage.Height) then
    begin
      Canvas.Pen.Color := clWhite;
      Canvas.Brush.Color := clWhite;

      Canvas.Rectangle(FOldSize.Left, FOldSize.Top, FOldSize.Right, FOldSize.Bottom);
    end;

  {copy crosstab image to paint box}
  PaintBoxPaintEvent(Self);

end; {procedure, DrawCrossTab}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawElement }

procedure TppCrossTabControl.DrawElement(aElement: TppElement; aCanvas: TCanvas);
var
  liX: Integer;
  liY: Integer;
  lSaveColor: TColor;
  lRect: TRect;
  lsLine: String;
  lsName: String;
  liPos: Integer;
begin

  if (aElement.Visible) then
    begin
      aCanvas.Brush.Color := aElement.Color;
      aCanvas.Pen.Color := FGridColor;
      aCanvas.Font := aElement.Font;
    end
  else
    begin
      aCanvas.Brush.Color := clWhite;
      aCanvas.Pen.Color := FGridColor;
      aCanvas.Font.Color := clBtnFace;
    end;

  lRect := aElement.DrawRect;
  Inc(lRect.Right);
  Inc(lRect.Bottom);

  aCanvas.Rectangle(lRect.Left,
                    lRect.Top,
                    lRect.Right,
                    lRect.Bottom);

  {erase line between value def and its caption}
  if (aElement is TppValueDef) then
    begin
      lSaveColor := aCanvas.Pen.Color;

      aCanvas.Pen.Color := aCanvas.Brush.Color;

      aCanvas.MoveTo(lRect.Left + 1, lRect.Top);
      aCanvas.LineTo(lRect.Right - 1, lRect.Top);

      aCanvas.Pen.Color := lSaveColor
    end

  else if (aElement is TppValueCaptionDef) then
    begin
      lSaveColor := aCanvas.Pen.Color;

      aCanvas.Pen.Color := aCanvas.Brush.Color;

      aCanvas.MoveTo(lRect.Left + 1, lRect.Bottom);
      aCanvas.LineTo(lRect.Right - 1, lRect.Bottom);

      aCanvas.Pen.Color := lSaveColor
    end;

  if (aElement = FNewColumn) or (aElement = FNewRow) or (aElement = FNewValue) then
    begin
      lSaveColor := aCanvas.Pen.Color;

      aCanvas.Pen.Color := clBtnShadow;
      aCanvas.Pen.Width := 3;

      aCanvas.Rectangle(aElement.DrawRect.Left + 3,
                        aElement.DrawRect.Top + 3,
                        aElement.DrawRect.Right - 2,
                        aElement.DrawRect.Bottom - 2);

      aCanvas.Pen.Width := 1;
      aCanvas.Pen.Color := lSaveColor;
    end;

  lsName := aElement.GetDesignName;
  liPos := Pos('<newline>', lsName);

  if (liPos <> 0) then
    begin
      lsLine := Copy(lsName, 1, liPos - 1);

      liX := aElement.DrawRect.Left + AlignmentToX(aElement.Alignment, aElement.Width, aCanvas.TextWidth(lsLine));
      liY := aElement.DrawRect.Top + (aElement.Height - aElement.TextHeight) div 2;

      aCanvas.TextOut(liX, liY, lsLine);

      lsLine := Copy(lsName, liPos + 9, Length(lsName));

      liX := aElement.DrawRect.Left + AlignmentToX(aElement.Alignment, aElement.Width, aCanvas.TextWidth(lsLine));
      liY := liY + aCanvas.TextHeight('0');

      aCanvas.TextOut(liX, liY, lsLine);

    end
  else
    begin
      lsLine := lsName;

      liX := aElement.DrawRect.Left + AlignmentToX(aElement.Alignment, aElement.Width, aCanvas.TextWidth(lsLine));
      liY := aElement.DrawRect.Top + (aElement.Height - aElement.TextHeight) div 2;

      aCanvas.TextOut(liX, liY, lsName);
    end;

  {if (aElement <> FNewColumn) and (aElement <> FNewRow) and (aElement <> FNewValue) then}
    FElements.Add(aElement);

end; {procedure, DrawElement}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.AlignmentToX }

function TppCrossTabControl.AlignmentToX(aAlignment: TAlignment; aWidth, aTextWidth: Integer): Integer;
begin

  case aAlignment of
    taCenter:       Result := (aWidth - aTextWidth) div 2;
    taLeftJustify:  Result := FHorizontalMargin div 2;
    taRightJustify: Result := (aWidth - aTextWidth) - (FHorizontalMargin div 2);
    else            Result := 0;
  end;

end; {procedure, AlignmentToX}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcTextDimensions }

procedure TppCrossTabControl.CalcTextDimensions(aCanvas: TCanvas);
var
  liIndex: Integer;
  liIndex2: Integer;
  lDimension: TppDimension;
  lValueDef: TppValueDef;
  lCaptionDef: TppValueCaptionDef;

  procedure ElementToTextDimensions(aElement: TppElement);
  var
    lsDesignName: String;
    liPos: Integer;
    liLines: Integer;
    lsLine1: String;
    lsLine2: String;
    liWidth: Integer;
  begin
      aCanvas.Font := aElement.Font;

      lsDesignName := aElement.GetDesignName;

      liPos := Pos('<newline>', lsDesignName);

      if (liPos <> 0) then
        begin
          liLines := 2;
          lsLine1 := Copy(lsDesignName, 1, liPos - 1);
          lsLine2 := Copy(lsDesignName, liPos + 9, Length(lsDesignName));
        end
      else
        begin
          liLines := 1;
          lsLine1 := lsDesignName;
          lsLine2 := '';
        end;

      aElement.TextHeight := aCanvas.TextHeight('0') * liLines;
      aElement.TextWidth := aCanvas.TextWidth(lsLine1);

      liWidth := aCanvas.TextWidth(lsLine2);
      
      if (liWidth > aElement.TextWidth) then
        aElement.TextWidth := liWidth;

      aElement.Height := aElement.TextHeight + FVerticalMargin;
      aElement.Width := aElement.TextWidth + FHorizontalMargin;
  end;

begin

  for liIndex := 0 to FCrossTab.ColumnDefCount - 1 do
    begin
      ElementToTextDimensions(FCrossTab.ColumnDefs[liIndex]);

      lDimension := FCrossTab.ColumnDefs[liIndex];

      for liIndex2 := 0 to lDimension.SubTotalCount - 1 do
        begin
          ElementToTextDimensions(lDimension.SubTotals[liIndex2].CaptionDef);

          ElementToTextDimensions(lDimension.SubTotals[liIndex2].TotalDef);
        end;
    end;

  for liIndex := 0 to FCrossTab.RowDefCount - 1 do
    begin
      ElementToTextDimensions(FCrossTab.RowDefs[liIndex]);

      lDimension := FCrossTab.RowDefs[liIndex];

      for liIndex2 := 0 to lDimension.SubTotalCount - 1 do
        begin
          ElementToTextDimensions(lDimension.SubTotals[liIndex2].CaptionDef);

          ElementToTextDimensions(lDimension.SubTotals[liIndex2].TotalDef);
        end;
    end;

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lValueDef := FCrossTab.ValueDefs[liIndex];
      lCaptionDef := lValueDef.CaptionDef;

      ElementToTextDimensions(lCaptionDef);
      ElementToTextDimensions(lValueDef);
    end;


  for liIndex := 0 to FCrossTab.RowGrandTotalCount - 1 do
    begin
      ElementToTextDimensions(FCrossTab.RowGrandTotals[liIndex].CaptionDef);

      ElementToTextDimensions(FCrossTab.RowGrandTotals[liIndex].TotalDef);
    end;

  for liIndex := 0 to FCrossTab.ColumnGrandTotalCount - 1 do
    begin
      ElementToTextDimensions(FCrossTab.ColumnGrandTotals[liIndex].CaptionDef);

      ElementToTextDimensions(FCrossTab.ColumnGrandTotals[liIndex].TotalDef);
    end;

  ElementToTextDimensions(FNewColumn);
  ElementToTextDimensions(FNewRow);
  ElementToTextDimensions(FNewValue);

end; {procedure, CalcTextDimensions}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcColumnTopAndHeight }

procedure TppCrossTabControl.CalcColumnTopAndHeight;
var
  liIndex: Integer;
  lElement: TppElement;
begin

  for liIndex := 0 to FCrossTab.ColumnDefCount - 1 do
    begin
      lElement := FCrossTab.ColumnDefs[liIndex];

      lElement.Top := FAnchorHeight + FVerticalMargin;

      FAnchorHeight := FAnchorHeight + lElement.Height;

      if (lElement.Width > FMainColumnWidth) then
        FMainColumnWidth := lElement.Width;
    end;

end; {procedure, CalcColumnTopAndHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcColumnSubTotalTopAndHeight }

procedure TppCrossTabControl.CalcColumnSubTotalTopAndHeight;
var
  liIndex: Integer;
  liIndex2: Integer;
  lColumn: TppColumnDef;
  lAdjacentColumn: TppColumnDef;
  lElement: TppElement;
  liDifference: Integer;
begin

  if (FCrossTab.ColumnDefCount < 2) or (FCrossTab.ValueDefCount = 0) then Exit;

  for liIndex := 0 to FCrossTab.ColumnDefCount - 2 do
    begin
      lColumn := FCrossTab.ColumnDefs[liIndex];
      lAdjacentColumn := FCrossTab.ColumnDefs[liIndex + 1];

      lElement := lColumn.SubTotals[0].CaptionDef;

      lElement.Top := lAdjacentColumn.Top;
      lElement.Height := lAdjacentColumn.Height;

      if (lElement.Height > lAdjacentColumn.Height) then
        begin
          liDifference := lElement.Height - lAdjacentColumn.Height;

          FAnchorHeight := FAnchorHeight + liDifference;

          for liIndex2 := liIndex + 1 to FCrossTab.ColumnDefCount - 1 do
            FCrossTab.ColumnDefs[liIndex2].Top := FCrossTab.ColumnDefs[liIndex2].Top + liDifference;

          lAdjacentColumn.Height := lElement.Height
        end;
        
      {add on height for outer columns}
      for liIndex2 := liIndex + 1 to FCrossTab.ColumnDefCount - 2 do
        lElement.Height := lElement.Height + FCrossTab.ColumnDefs[liIndex2].Height;

    end;

end; {procedure, CalcColumnSubTotalTopAndHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcColumnGrandTotalTopAndHeight }

procedure TppCrossTabControl.CalcColumnGrandTotalTopAndHeight;
var
  liIndex: Integer;
  lElement: TppElement;
  liNewAnchorHeight: Integer;
  liDifference: Integer;
  liIncrement: Integer;
begin

  if (FCrossTab.ColumnDefCount = 0) or (FCrossTab.ValueDefCount = 0) then Exit;

  lElement := FCrossTab.ColumnGrandTotals[0].CaptionDef;

  lElement.Top := FVerticalMargin;

  if (lElement.Height > FAnchorHeight) then
    begin
      liNewAnchorHeight := lElement.Height;

      liDifference := liNewAnchorHeight - FAnchorHeight;

      liIncrement := (liDifference div FCrossTab.ColumnDefCount);

      if ((liDifference mod FCrossTab.ColumnDefCount) <> 0) then
        Inc(liIncrement);

      for liIndex := 0 to FCrossTab.ColumnDefCount - 1 do
        begin
          lElement := FCrossTab.ColumnDefs[liIndex];

          lElement.Height := lElement.Height + liIncrement;
       end;

      FAnchorHeight := liNewAnchorHeight;
    end;

  lElement.Height := FAnchorHeight;

end; {procedure, CalcColumnGrandTotalTopAndHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcNewColumnTopAndHeight }

procedure TppCrossTabControl.CalcNewColumnTopAndHeight;
var
  lElement: TppElement;
begin

  lElement := FNewColumn;

  lElement.Top := FAnchorHeight + FVerticalMargin;

  FAnchorHeight := FAnchorHeight + lElement.Height;

  if (lElement.Width > FMainColumnWidth) then
    FMainColumnWidth := lElement.Width;

end; {procedure, CalcNewColumnTopAndHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcRowLeftAndWidth }

procedure TppCrossTabControl.CalcRowLeftAndWidth;
var
  liIndex: Integer;
  lElement: TppElement;
begin

  for liIndex := 0 to FCrossTab.RowDefCount - 1 do
    begin
      lElement := FCrossTab.RowDefs[liIndex];

      lElement.Left := FAnchorWidth + FHorizontalMargin;

      FAnchorWidth := FAnchorWidth + lElement.Width;

      if (lElement.Height > FMainRowHeight) then
        FMainRowHeight := lElement.Height;
    end;

end; {procedure, CalcRowLeftAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcRowSubTotalLeftAndWidth }

procedure TppCrossTabControl.CalcRowSubTotalLeftAndWidth;
var
  liIndex: Integer;
  liIndex2: Integer;
  lRowDef: TppRowDef;
  liRowsRemaining: Integer;
  liLeft: Integer;
  liWidth: Integer;
  liAvailableWidth: Integer;
  liDifference: Integer;
  liIncrement: Integer;
  lElements: TList;
  lElement: TppElement;
begin

  if (FCrossTab.RowDefCount < 2) or (FCrossTab.ValueDefCount = 0) then Exit;

  lElements := TList.Create;

  liAvailableWidth := FAnchorWidth;

  for liIndex := 0 to FCrossTab.RowDefCount - 2 do
    begin
      lRowDef := FCrossTab.RowDefs[liIndex];

      liLeft := FCrossTab.RowDefs[liIndex + 1].Left;
      liAvailableWidth := liAvailableWidth - lRowDef.Width;

      lElements.Clear;

      lElements.Add(FCrossTab.RowDefs[liIndex + 1]);

      for liIndex2 := 0 to lRowDef.SubTotalCount - 1 do
        lElements.Add(lRowDef.SubTotals[liIndex2].CaptionDef);

      liWidth := CalcMaxWidthOfElements(lElements);

      if (liWidth > liAvailableWidth) then
        begin
          liDifference := liWidth - liAvailableWidth;

          {allocate additional width to remaining rows}
          liRowsRemaining := (FCrossTab.RowDefCount - 1) - liIndex;

          liIncrement := (liDifference div liRowsRemaining);

          if ((liDifference mod liRowsRemaining) <> 0) then
            begin
              Inc(liIncrement);

              liDifference := liIncrement * liRowsRemaining;
            end;

          {add increment to widths of remaining rows}
          for liIndex2 := liIndex + 1 to FCrossTab.RowDefCount - 1 do
            FCrossTab.RowDefs[liIndex2].Width := FCrossTab.RowDefs[liIndex2].Width + liIncrement;

          {true up remaining rows for new widths}
          for liIndex2 := 1 to FCrossTab.RowDefCount - 1 do
            FCrossTab.RowDefs[liIndex2].Left := FCrossTab.RowDefs[liIndex2 - 1].Left + FCrossTab.RowDefs[liIndex2 - 1].Width;

          {get new left of adjacent row}
          liLeft := FCrossTab.RowDefs[liIndex + 1].Left;

          {increase available and anchor width}
          liAvailableWidth := liAvailableWidth + liDifference;

          FAnchorWidth := FAnchorWidth + liDifference;
        end;

      {set left of subtotals}
      lElements.Delete(0);

      for liIndex2 := 0 to lElements.Count - 1 do
        begin
          lElement := TppElement(lElements[liIndex2]);

          lElement.Left := liLeft;
        end;

    end;

  lElements.Free;

  {set subtotal caption widths}
  for liIndex := 0 to FCrossTab.RowDefCount - 2 do
    begin
      lRowDef := FCrossTab.RowDefs[liIndex];

      for liIndex2 := 0 to lRowDef.SubTotalCount - 1 do
        begin
          lElement := lRowDef.SubTotals[liIndex2].CaptionDef;
          
          lElement.Width := (FAnchorWidth + FHorizontalMargin) - lElement.Left;
        end;

    end;

end; {procedure, CalcRowSubTotalLeftAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcRowGrandTotalLeftAndWidth }

procedure TppCrossTabControl.CalcRowGrandTotalLeftAndWidth;
var
  liIndex: Integer;
  lElement: TppElement;
  liNewAnchorWidth: Integer;
  liDifference: Integer;
  liIncrement: Integer;
begin

  if (FCrossTab.RowDefCount = 0) then Exit;

  liNewAnchorWidth := FAnchorWidth;

  for liIndex := 0 to FCrossTab.RowGrandTotalCount - 1 do
    begin
      lElement := FCrossTab.RowGrandTotals[liIndex].CaptionDef;

      lElement.Left := FHorizontalMargin;

      if (lElement.Width > liNewAnchorWidth) then
        liNewAnchorWidth := lElement.Width;
    end;

  liDifference := liNewAnchorWidth - FAnchorWidth;

  if (liDifference = 0) then Exit;
  
  liIncrement := (liDifference div FCrossTab.RowDefCount);

  if ((liDifference mod FCrossTab.RowDefCount) <> 0) then
    Inc(liIncrement);

  for liIndex := 0 to FCrossTab.RowDefCount - 1 do
    begin
      lElement := FCrossTab.RowDefs[liIndex];

      lElement.Width := lElement.Width + liIncrement;

      {move adjacent rows to the left}
      if (liIndex > 0) then
        lElement.Left := lElement.Left + (liIncrement * liIndex);
    end;

  FAnchorWidth := FAnchorWidth + (FCrossTab.RowDefCount * liIncrement);

end; {procedure, CalcRowGrandTotalLeftAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcNewRowLeftAndWidth }

procedure TppCrossTabControl.CalcNewRowLeftAndWidth;
var
  lElement: TppElement;
begin

  lElement := FNewRow;

  lElement.Left := FAnchorWidth + FHorizontalMargin;

  FAnchorWidth := FAnchorWidth + lElement.Width;

  if (lElement.Height > FMainRowHeight) then
    FMainRowHeight := lElement.Height;

end; {procedure, CalcNewRowLeftAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcValueHeightAndWidth }

procedure TppCrossTabControl.CalcValueHeightAndWidth;
var
  liIndex: Integer;
  liIndex2: Integer;
  lElements: TList;
  liHeight: Integer;
  liWidth: Integer;
  lValueDef: TppValueDef;
  lCaptionDef: TppValueCaptionDef;
  liSaveHeight: Integer;
  liDifference: Integer;
begin

  lElements := TList.Create;

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lElements.Clear;

      lValueDef := FCrossTab.ValueDefs[liIndex];
      lCaptionDef := lValueDef.CaptionDef;

      liSaveHeight := lValueDef.Height;
      lValueDef.Height := lValueDef.Height + lCaptionDef.Height;

      lElements.Add(FCrossTab.ValueDefs[liIndex]);
      lElements.Add(FCrossTab.ColumnGrandTotals[liIndex].TotalDef);

      for liIndex2 := 0 to FCrossTab.ColumnDefCount - 2 do
        lElements.Add(FCrossTab.ColumnDefs[liIndex2].SubTotals[liIndex].TotalDef);

      liHeight := CalcMaxHeightOfElements(lElements);

      lElements.Remove(lValueDef);

      SetHeightOfElements(lElements, liHeight);

      if (liHeight > lValueDef.Height) then
        begin
          liDifference := liHeight - lValueDef.Height;

          lValueDef.Height := liSaveHeight + (liDifference div 2);
          lCaptionDef.Height := lCaptionDef.Height + (liDifference - (liDifference div 2))
        end
      else
        lValueDef.Height := liSaveHeight;

      if (liIndex = 0) and (liHeight > FMainRowHeight) then
        FMainRowHeight := liHeight;
    end;

  lElements.Clear;

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lElements.Add(FCrossTab.ValueDefs[liIndex].CaptionDef);
      lElements.Add(FCrossTab.ValueDefs[liIndex]);
    end;

  for liIndex := 0 to FCrossTab.RowDefCount - 2 do
    for liIndex2 := 0 to FCrossTab.ValueDefCount - 1 do
      lElements.Add(FCrossTab.RowDefs[liIndex].SubTotals[liIndex2].TotalDef);

  for liIndex := 0 to FCrossTab.RowGrandTotalCount - 1 do
    lElements.Add(FCrossTab.RowGrandTotals[liIndex].TotalDef);

  lElements.Add(FNewColumn);
  lElements.Add(FNewValue);

  liWidth := CalcMaxWidthOfElements(lElements);

  SetWidthOfElements(lElements, liWidth);

  if (liWidth > FMainColumnWidth) then
    FMainColumnWidth := liWidth;

  lElements.Free;

end; {procedure, CalcValueHeightAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcMaxHeightOfElements }

function TppCrossTabControl.CalcMaxHeightOfElements(aList: TList): Integer;
var
  liIndex: Integer;
  lElement: TppElement;
begin

  Result := 0;

  for liIndex := 0 to aList.Count - 1 do
    begin
      lElement := TppElement(aList[liIndex]);

      if (lElement.Height > Result) then
        Result := lElement.Height;
    end;

end; {function, CalcMaxHeightOfElements}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.SetHeightOfElements }

procedure TppCrossTabControl.SetHeightOfElements(aList: TList; aHeight: Integer);
var
  liIndex: Integer;
  lElement: TppElement;
begin

  for liIndex := 0 to aList.Count - 1 do
    begin
      lElement := TppElement(aList[liIndex]);

      lElement.Height := aHeight;
    end;

end; {function, SetHeightOfElements}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcMaxWidthOfElements }

function TppCrossTabControl.CalcMaxWidthOfElements(aList: TList): Integer;
var
  liIndex: Integer;
  lElement: TppElement;
begin

  Result := 0;

  for liIndex := 0 to aList.Count - 1 do
    begin
      lElement := TppElement(aList[liIndex]);

      if (lElement.Width > Result) then
        Result := lElement.Width;
    end;

end; {function, CalcMaxWidthOfElements}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.SetWidthOfElements }

procedure TppCrossTabControl.SetWidthOfElements(aList: TList; aWidth: Integer);
var
  liIndex: Integer;
  lElement: TppElement;
begin

  for liIndex := 0 to aList.Count - 1 do
    begin
      lElement := TppElement(aList[liIndex]);

      lElement.Width := aWidth;
    end;

end; {procedure, SetWidthOfElements}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcNewValueHeightAndWidth }

procedure TppCrossTabControl.CalcNewValueHeightAndWidth;
var
  lElement: TppElement;
begin

  lElement := FNewValue;

  if (FCrossTab.ValueDefCount = 0) then
    begin
      if (lElement.Height > FMainRowHeight) then
        FMainRowHeight := lElement.Height
      else
        lElement.Height := FMainRowHeight;
    end;

  if (lElement.Width > FMainColumnWidth) then
    FMainColumnWidth := lElement.Width;

end; {procedure, CalcNewValueHeightAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcColumnLeftAndWidth }

procedure TppCrossTabControl.CalcColumnLeftAndWidth;
var
  liIndex: Integer;
  lElement: TppElement;
begin

  for liIndex := 0 to FCrossTab.ColumnDefCount - 1 do
    begin
      lElement := FCrossTab.ColumnDefs[liIndex];

      lElement.Width := FMainColumnWidth;
      lElement.Left := FAnchorWidth + FHorizontalMargin;
    end;

  lElement := FNewColumn;
  lElement.Width := FMainColumnWidth;
  lElement.Left := FAnchorWidth + FHorizontalMargin;

end; {procedure, CalcColumnLeftAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcRowTopAndHeight }

procedure TppCrossTabControl.CalcRowTopAndHeight;
var
  liIndex: Integer;
  lElement: TppElement;
begin

  for liIndex := 0 to FCrossTab.RowDefCount - 1 do
    begin
      lElement := FCrossTab.RowDefs[liIndex];

      lElement.Top := FAnchorHeight + FVerticalMargin;
      lElement.Height := FMainRowHeight;
    end;

  lElement := FNewRow;
  lElement.Top := FAnchorHeight + FVerticalMargin;
  lElement.Height := FMainRowHeight;

end; {procedure, CalcRowTopAndHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcValueLeftTopAndWidth }

procedure TppCrossTabControl.CalcValueLeftTopAndWidth;
var
  liIndex: Integer;
  liIndex2: Integer;
  lElement: TppElement;
  liLeft: Integer;
begin

  FTotalHeight := FAnchorHeight + FVerticalMargin;
  FTotalWidth := FAnchorWidth + FMainColumnWidth + FHorizontalMargin;

  liLeft := FAnchorWidth + FHorizontalMargin;

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lElement := FCrossTab.ValueDefs[liIndex].CaptionDef;

      lElement.Left := liLeft;
      lElement.Top := FTotalHeight;
      lElement.Width := FMainColumnWidth;

      FTotalHeight := FTotalHeight + lElement.Height;


      lElement := FCrossTab.ValueDefs[liIndex];

      lElement.Left := liLeft;
      lElement.Top := FTotalHeight;
      lElement.Width := FMainColumnWidth;

      FTotalHeight := FTotalHeight + lElement.Height;

      for liIndex2 := 0 to FCrossTab.RowDefCount - 2 do
        FCrossTab.RowDefs[liIndex2].SubTotals[liIndex].TotalDef.Left := liLeft;
    end;

  lElement := FNewValue;
  lElement.Left := liLeft;
  lElement.Top := FTotalHeight;
  lElement.Width := FMainColumnWidth;

  FTotalHeight := FTotalHeight + lElement.Height;

end; {procedure, CalcValueLeftTopAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcColumnSubTotalLeftAndWidth }

procedure TppCrossTabControl.CalcColumnSubTotalLeftAndWidth;
var
  liIndex: Integer;
  liIndex2: Integer;
  lColumn: TppColumnDef;
  lCaption: TppElement;
  liWidth: Integer;
  lElements: TList;
  lSubTotal: TppSubTotal;
begin

  if (FCrossTab.ColumnDefCount < 2) or (FCrossTab.ValueDefCount = 0) then Exit;

  lElements := TList.Create;

  for liIndex := FCrossTab.ColumnDefCount - 2 downto 0 do
    begin
      lColumn := FCrossTab.ColumnDefs[liIndex];

      lElements.Clear;

      for liIndex2 := 0 to lColumn.SubTotalCount - 1 do
        begin
          lSubTotal := lColumn.SubTotals[liIndex2];

          if (liIndex2 = 0) then
            lElements.Add(lSubTotal.CaptionDef);

          lElements.Add(lSubTotal.TotalDef);
        end;

      liWidth := CalcMaxWidthOfElements(lElements);

      SetWidthOfElements(lElements, liWidth);

      for liIndex2 := 0 to lColumn.SubTotalCount - 1 do
        begin
          lSubTotal := lColumn.SubTotals[liIndex2];

          if (liIndex2 = 0) then
            lSubTotal.CaptionDef.Left := FTotalWidth;

          lSubTotal.TotalDef.Left := FTotalWidth;

          lSubTotal.TotalDef.Top := lSubTotal.GetValueDef.CaptionDef.Top;
        end;

      FTotalWidth := FTotalWidth + liWidth;

      {adjust column width to overlap column subtotal}
      lCaption := lColumn.SubTotals[0].CaptionDef;

      if (liIndex <> FCrossTab.ColumnDefCount - 1) then
        lColumn.Width := (lCaption.Left + lCaption.Width) - (FAnchorWidth + FHorizontalMargin);
    end;

  lElements.Free;
  
end; {procedure, CalcColumnSubTotalLeftAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcColumnGrandTotalLeftAndWidth }

procedure TppCrossTabControl.CalcColumnGrandTotalLeftAndWidth;
var
  lElement: TppElement;
  liWidth: Integer;
  lValueDef: TppValueDef;
  liIndex: Integer;
begin

  if (FCrossTab.ColumnDefCount = 0) or (FCrossTab.ValueDefCount = 0) then Exit;

  {calc max width}
  liWidth := FCrossTab.ColumnGrandTotals[0].CaptionDef.Width;

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lValueDef := FCrossTab.ValueDefs[liIndex];

      lElement := FCrossTab.ColumnGrandTotals[liIndex].TotalDef;

      lElement.Top := lValueDef.CaptionDef.Top;

      if (lElement.Width > liWidth) then
        liWidth := lElement.Width;
    end;

  {set left & width}
  lElement := FCrossTab.ColumnGrandTotals[0].CaptionDef;
  lElement.Left := FTotalWidth;
  lElement.Width := liWidth;

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lElement := FCrossTab.ColumnGrandTotals[liIndex].TotalDef;
      
      lElement.Left := FTotalWidth;
      lElement.Width := liWidth;
    end;

  FTotalWidth := FTotalWidth + liWidth;

end; {procedure, CalcColumnGrandTotalLeftAndWidth}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcRowSubTotalTopAndHeight }

procedure TppCrossTabControl.CalcRowSubTotalTopAndHeight;
var
  liIndex: Integer;
  liIndex2: Integer;
  lRowDef: TppRowDef;
  lCaption: TppElement;
  lTotal: TppElement;
  liTop: Integer;
  liHeight: Integer;
  liAdjustHeight: Integer;
begin

  if (FCrossTab.RowDefCount < 2) or (FCrossTab.ValueDefCount = 0) then Exit;

  lRowDef := FCrossTab.RowDefs[FCrossTab.RowDefCount - 1];
  liHeight := (FNewValue.Top + FNewValue.Height) - FNewRow.Top;
  liAdjustHeight := liHeight - lRowDef.Height;
  lRowDef.Height := liHeight;

  for liIndex := FCrossTab.RowDefCount - 2 downto 0 do
    begin
      lRowDef := FCrossTab.RowDefs[liIndex];

      liTop := FTotalHeight;

      for liIndex2 := 0 to lRowDef.SubTotalCount - 1 do
        begin
          lCaption := lRowDef.SubTotals[liIndex2].CaptionDef;
          lTotal := lRowDef.SubTotals[liIndex2].TotalDef;

          lCaption.Top := liTop;
          lTotal.Top := liTop;

          if (lCaption.Height > lTotal.Height) then
            liHeight := lCaption.Height
          else
            liHeight := lTotal.Height;

          lCaption.Height := liHeight;
          lTotal.Height := liHeight;

          liAdjustHeight := liAdjustHeight + liHeight;

          FTotalHeight := FTotalHeight + liHeight;

          liTop := liTop + liHeight;
        end;

        lRowDef.Height := lRowDef.Height + liAdjustHeight;

    end;

end; {procedure, CalcRowSubTotalTopAndHeight}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.CalcRowGrandTotalTopAndHeight }

procedure TppCrossTabControl.CalcRowGrandTotalTopAndHeight;
var
  liIndex: Integer;
  lCaption: TppElement;
  lTotal: TppElement;
  liHeight: Integer;
begin

  if (FCrossTab.RowDefCount = 0) then Exit;

  for liIndex := 0 to FCrossTab.RowGrandTotalCount - 1 do
    begin
      lCaption := FCrossTab.RowGrandTotals[liIndex].CaptionDef;
      lTotal := FCrossTab.RowGrandTotals[liIndex].TotalDef;

      lCaption.Top := FTotalHeight;
      lTotal.Top := FTotalHeight;

      lCaption.Width := FAnchorWidth - FNewRow.Width;
      lTotal.Width := FMainColumnWidth;

      if (lCaption.Height > lTotal.Height) then
        liHeight := lCaption.Height
      else
        liHeight := lTotal.Height;

      lCaption.Height := liHeight;
      lTotal.Height := liHeight;

      FTotalHeight := FTotalHeight + liHeight;

      lTotal.Left := FCrossTab.ValueDefs[liIndex].Left;
    end;

end; {procedure, CalcRowGrandTotalTopAndHeight}

{******************************************************************************
 *
 ** D R A W   R O U T I N E S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawAnchorCells }

procedure TppCrossTabControl.DrawAnchorCells(aCanvas: TCanvas);
var
  liIndex: Integer;
  liIndex2: Integer;
  lElement: TppElement;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
begin

  for liIndex := 0 to FCrossTab.RowDefCount do
    begin
      if (liIndex = FCrossTab.RowDefCount) then
        lElement := FNewRow
      else
        lElement := FCrossTab.RowDefs[liIndex];

      liLeft := lElement.Left;
      liTop := FVerticalMargin;
      liHeight := FAnchorHeight;
      liWidth := lElement.Width;

      aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);
    end;

  for liIndex := 1 to FCrossTab.ValueDefCount do
    begin
      if (liIndex = FCrossTab.ValueDefCount) then
        lElement := FNewValue
      else
        lElement := FCrossTab.ValueDefs[liIndex].CaptionDef;

      liHeight := lElement.Height;
      liTop := lElement.Top;

      if (lElement is TppValueCaptionDef) then
        liHeight := liHeight + FCrossTab.ValueDefs[liIndex].Height;

      for liIndex2 := 0 to FCrossTab.RowDefCount do
        begin
          if (liIndex2 = FCrossTab.RowDefCount) then
            lElement := FNewRow
          else
            lElement := FCrossTab.RowDefs[liIndex2];

          liLeft := lElement.Left;
          liWidth := lElement.Width;

          aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);
        end;
    end;

end; {procedure, DrawAnchorCells}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawColumnSubTotals }

procedure TppCrossTabControl.DrawColumnSubTotals(aCanvas: TCanvas);
var
  liIndex: Integer;
  liIndex2: Integer;
  lElement: TppElement;
  lColumn: TppColumnDef;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
begin

  if (FCrossTab.ColumnDefCount < 2) or (FCrossTab.ValueDefCount = 0) then Exit;

  for liIndex := 0 to FCrossTab.ColumnDefCount - 2 do
    begin
      lColumn := FCrossTab.ColumnDefs[liIndex];

      if (lColumn.SubTotalCount > 0) then
        begin
          lElement := lColumn.SubTotals[0].CaptionDef;

          {draw total caption}
          DrawElement(lElement, aCanvas);

          {draw total values}
          for liIndex2 := 0 to FCrossTab.ValueDefCount - 1 do
            DrawElement(lColumn.SubTotals[liIndex2].TotalDef, aCanvas);

          {create empty cell to right of new column}
          aCanvas.Pen.Color := FGridColor;
          aCanvas.Brush.Color := clWhite;

          liLeft := lElement.Left;
          liTop := FNewColumn.Top;
          liHeight := FNewColumn.Height;
          liWidth := lElement.Width;

          aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);

          {create empty cell to right of new value}
          liTop := FNewValue.Top;
          liHeight := FNewValue.Height;

          aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);

          {create empty cells to right of row grand totals}
          if (FCrossTab.RowDefCount > 0) then
            begin
              for liIndex2 := 0 to FCrossTab.RowGrandTotalCount - 1 do
                begin
                  lElement := FCrossTab.RowGrandTotals[liIndex2].CaptionDef;

                  liTop := lElement.Top;
                  liHeight := lElement.Height;

                  aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);
                end;
            end;

        end;

    end;

end; {procedure, DrawColumnSubTotals}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawColumnGrandTotal }

procedure TppCrossTabControl.DrawColumnGrandTotal(aCanvas: TCanvas);
var
  liIndex: Integer;
  lElement: TppElement;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
begin

  if (FCrossTab.ColumnDefCount = 0) or (FCrossTab.ValueDefCount = 0) then Exit;

  lElement := FCrossTab.ColumnGrandTotals[0].CaptionDef;

  DrawElement(lElement, aCanvas);

  for liIndex := 0 to FCrossTab.ValueDefCount - 1 do
    begin
      lElement := FCrossTab.ColumnGrandTotals[liIndex].TotalDef;

      DrawElement(lElement, aCanvas);
    end;

  {create empty cells below}
  lElement := FCrossTab.ColumnGrandTotals[0].CaptionDef;

  aCanvas.Brush.Color := clWhite;
  
  liLeft := lElement.Left;
  liTop := FNewColumn.Top;
  liHeight := FNewColumn.Height;
  liWidth := lElement.Width;

  aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);

  liTop := FNewValue.Top;
  liHeight := FNewValue.Height;

  aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);

  if (FCrossTab.RowDefCount > 0) then
    begin
      for liIndex := 0 to FCrossTab.RowGrandTotalCount - 1 do
        begin
          lElement := FCrossTab.RowGrandTotals[liIndex].CaptionDef;

          liLeft := (FTotalWidth - FHorizontalMargin) - liWidth;
          liTop := lElement.Top;
          liHeight := lElement.Height;

          aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);
        end;
    end;

end; {procedure, DrawColumnGrandTotal}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawRowSubTotals }

procedure TppCrossTabControl.DrawRowSubTotals(aCanvas: TCanvas);
var
  liIndex: Integer;
  liIndex2: Integer;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
  lRowDef: TppRowDef;
  lSubTotal: TppSubTotal;
  liIndex3: Integer;
begin

  if (FCrossTab.RowDefCount < 2) or (FCrossTab.ValueDefCount = 0) then Exit;

  for liIndex := 0 to FCrossTab.RowDefCount - 2 do
    begin
      lRowDef := FCrossTab.RowDefs[liIndex];

        for liIndex2 := 0 to lRowDef.SubTotalCount - 1 do
          begin
            lSubTotal := lRowDef.SubTotals[liIndex2];

            DrawElement(lSubTotal.CaptionDef, aCanvas);

            {draw empty cell below new row}
            liLeft := FNewRow.Left;
            liTop := lSubTotal.CaptionDef.Top;
            liHeight := lSubTotal.CaptionDef.Height;
            liWidth := FNewRow.Width;

            aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);

            DrawElement(lSubTotal.TotalDef, aCanvas);

            {draw empty cell below column grand total}
            if (FCrossTab.ColumnDefCount > 0) then
              begin
                liLeft := FCrossTab.ColumnGrandTotals[0].CaptionDef.Left;
                liWidth := FCrossTab.ColumnGrandTotals[0].CaptionDef.Width;

                aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);

               {draw empty cells below column subtotals}
               for liIndex3 := 0 to FCrossTab.ColumnDefCount - 2 do
                 begin
                   lSubTotal := FCrossTab.ColumnDefs[liIndex3].SubTotals[0];

                   liLeft := lSubTotal.CaptionDef.Left;
                   liWidth := lSubTotal.CaptionDef.Width;

                   aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);
                 end;
              end;

          end;

    end;

end; {procedure, DrawRowSubTotals}

{------------------------------------------------------------------------------}
{ TppCrossTabControl.DrawRowGrandTotals }

procedure TppCrossTabControl.DrawRowGrandTotals(aCanvas: TCanvas);
var
  liIndex: Integer;
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
begin

  if (FCrossTab.RowDefCount = 0) or (FCrossTab.ValueDefCount = 0) then Exit;

  for liIndex := 0 to FCrossTab.RowGrandTotalCount - 1 do
    begin
      DrawElement(FCrossTab.RowGrandTotals[liIndex].CaptionDef, aCanvas);

      {draw empty cell}
      liLeft := FNewRow.Left;
      liTop := FCrossTab.RowGrandTotals[liIndex].CaptionDef.Top;
      liHeight := FCrossTab.RowGrandTotals[liIndex].CaptionDef.Height;
      liWidth := FNewRow.Width;

      aCanvas.Rectangle(liLeft, liTop, liLeft + liWidth + 1, liTop + liHeight + 1);

      DrawElement(FCrossTab.RowGrandTotals[liIndex].TotalDef, aCanvas);
    end;

end; {procedure, DrawRowGrandTotals}


{******************************************************************************
 *
 ** C R O S S T A B   S E L E C T I O N
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.CreateSelection }

constructor TppCrossTabSelection.CreateSelection(aControl: TppCrossTabControl);
begin

  inherited Create(aControl);

  FContainsDimensions := False;
  FContainsTotals := False;
  FControl := aControl;
  FElements := TList.Create;
  FOnElementChange := nil;
  FOnSelectionChange := nil;

end; {constructor, CreateSelection}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.Destroy }

destructor TppCrossTabSelection.Destroy;
begin

  FElements.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.Notify }

procedure TppCrossTabSelection.Notify(aCommunicator: TppCommunicator; aOperation: TppOperationType);
begin

  if (aOperation <> ppopRemove) then Exit;

  if (aCommunicator is TppElement) then
    RemoveElement(TppElement(aCommunicator));

end; {destructor, Notify}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.ElementChangeEvent }

procedure TppCrossTabSelection.ElementChangeEvent(Sender: TObject);
begin
  if Assigned(FOnElementChange) then FOnElementChange(Sender);
end; {function, ElementChangeEvent}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.DoOnSelectionChange }

procedure TppCrossTabSelection.DoOnSelectionChange;
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end; {function, DoOnSelectionChange}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.GetElementCount }

function TppCrossTabSelection.GetElementCount: Integer;
begin
  Result := FElements.Count;
end; {function, GetElementCount}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.GetElementForIndex }

function TppCrossTabSelection.GetElementForIndex(aIndex: Integer): TppElement;
begin
  Result := TppElement(FElements[aIndex]);
end; {function, GetElementForIndex}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.IndexOfElement }

function TppCrossTabSelection.IndexOfElement(aElement: TppElement): Integer;
begin
  Result := FElements.IndexOf(aElement);
end; {function, IndexOfElement}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.SelectElement }

procedure TppCrossTabSelection.SelectElement(aElement: TppElement);
begin

  if (ElementCount > 0) and (Elements[0] = aElement) then Exit;

  Clear;
  
  AddElement(aElement);

end; {procedure, SelectElement}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.Clear }

procedure TppCrossTabSelection.Clear;
var
  liIndex: Integer;
begin

  Erase;

  for liIndex := 0 to FElements.Count - 1 do
    begin
      Elements[liIndex].OnChange := nil;

      Elements[liIndex].RemoveNotify(Self);
    end;

  FElements.Clear;

  FContainsDimensions := False;
  FContainsTotals := False;

  DoOnSelectionChange;

end; {procedure, Clear}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.AddElement }

function TppCrossTabSelection.AddElement(aElement: TppElement): Integer;
begin

  Result := -1;

  if (ElementCount > 0) and (Elements[0] = aElement) then Exit;

  DrawElement(aElement);

  if (aElement is TppDimension) or (aElement is TppValueCaptionDef) then
    FContainsDimensions := True;

  if (aElement.Parent is TppTotal) then
    FContainsTotals := True;

  aElement.OnChange := ElementChangeEvent;

  aElement.AddNotify(Self);

  Result := FElements.Add(aElement);

  DoOnSelectionChange;

end; {function, AddElement}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.RemoveElement }

function TppCrossTabSelection.RemoveElement(aElement: TppElement): Integer;
begin

  EraseElement(aElement);

  aElement.OnChange := nil;

  aElement.RemoveNotify(Self);

  Result := FElements.Remove(aElement);

  UpdateContainsProps;

  DoOnSelectionChange;

end; {function, RemoveElement}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.UpdateContainsProps }

procedure TppCrossTabSelection.UpdateContainsProps;
var
  liIndex: Integer;
  lElement: TppElement;
begin

  FContainsDimensions := False;
  FContainsTotals := False;

  liIndex := 0;

  while (liIndex < FElements.Count) and not(FContainsDimensions) do
    begin
      lElement := TppElement(FElements[liIndex]);

      if (lElement is TppDimension) or (lElement is TppValueCaptionDef) then
        FContainsDimensions := True;

      if (lElement.Parent is TppTotal) then
        FContainsTotals := True;

      Inc(liIndex);
    end;

end; {function, UpdateContainsProps}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.HasProperty }

function TppCrossTabSelection.HasProperty(const aPropName: String): Boolean;
var
  liIndex: Integer;
begin

  Result := False;

  if (ElementCount = 0) then Exit;

  Result := True;
  liIndex := 0;

  while Result and (liIndex < ElementCount) do
    begin
      Result := (GetPropInfo(Elements[liIndex].ClassInfo, aPropName) <> nil);

      Inc(liIndex);
    end;

end; {function, HasProperty}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.GetPropertyValue }

procedure TppCrossTabSelection.GetPropertyValue(const aPropName: String; var aPropValue);
var
  lElement: TppElement;
begin

  if (ElementCount = 0) then Exit;

  if (aPropName = 'Alignment') then
    TAlignment(aPropValue) := Elements[0].Alignment

  else if (aPropName = 'Font') then
    TFont(aPropValue) := Elements[0].Font

  else if (aPropName = 'Color') then
    TColor(aPropValue) := Elements[0].Color

  else if (aPropName = 'DisplayFormat') then
    String(aPropValue) := Elements[0].DisplayFormat

  else if (aPropName = 'DataType') then
    TppDataType(aPropValue) := Elements[0].GetDataType

  else if (aPropName = 'CalcType') then
    TppDBCalcType(aPropValue) := TppValueCaptionDef(Elements[0]).CalcType

  else if (aPropName = 'SortType') then
    TppSortOrderType(aPropValue) := TppDimension(Elements[0]).SortType

  else if (aPropName = 'SkipNulls') then
    begin
      lElement := Elements[0];

      if (lElement is TppDimension) then
        Boolean(aPropValue) := TppDimension(lElement).SkipNulls

      else if (lElement is TppValueCaptionDef) then
        Boolean(aPropValue) := TppValueCaptionDef(lElement).SkipNulls;
    end

  else if (aPropName = 'NullOrder') then
    TppNullOrderType(aPropValue) := TppDimension(Elements[0]).NullOrder

  else if (aPropName = 'Visible') then
    begin
      if (Elements[0].Parent is TppTotal) then
        Boolean(aPropValue) := TppTotal(Elements[0].Parent).Visible;
    end;

end; {procedure, GetPropertyValue}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.SetPropertyValue }

procedure TppCrossTabSelection.SetPropertyValue(const aPropName: String; var aPropValue);
var
  liIndex: Integer;
  lElement: TppElement;
begin

  if (ElementCount = 0) then Exit;

  FControl.BeginUpdate;

  if (aPropName = 'Alignment') then
    for liIndex := 0 to ElementCount - 1 do
      Elements[liIndex].Alignment := TAlignment(aPropValue)

  else if (aPropName = 'Font') then
    for liIndex := 0 to ElementCount - 1 do
      Elements[liIndex].Font := TFont(aPropValue)

  else if (aPropName = 'Color') then
    for liIndex := 0 to ElementCount - 1 do
      Elements[liIndex].Color := TColor(aPropValue)

  else if (aPropName = 'DisplayFormat') then
    for liIndex := 0 to ElementCount - 1 do
      Elements[liIndex].DisplayFormat := String(aPropValue)

  else if (aPropName = 'CalcType') then
    for liIndex := 0 to ElementCount - 1 do
      TppValueCaptionDef(Elements[liIndex]).CalcType := TppDBCalcType(aPropValue)

  else if (aPropName = 'SortType') then
    for liIndex := 0 to ElementCount - 1 do
      TppDimension(Elements[liIndex]).SortType := TppSortOrderType(aPropValue)

  else if (aPropName = 'SkipNulls') then
    for liIndex := 0 to ElementCount - 1 do
      begin
        lElement := Elements[liIndex];

        if (lElement is TppDimension) then
          TppDimension(lElement).SkipNulls := Boolean(aPropValue)
        else if (lElement is TppValueCaptionDef) then
          TppValueCaptionDef(lElement).SkipNulls := Boolean(aPropValue);
      end

  else if (aPropName = 'NullOrder') then
    for liIndex := 0 to ElementCount - 1 do
      TppDimension(Elements[liIndex]).NullOrder := TppNullOrderType(aPropValue)

  else if (aPropName = 'Visible') then
    FControl.SetVisibleProperty;

  FControl.EndUpdate;

end; {procedure, SetPropertyValue}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.Erase }

procedure TppCrossTabSelection.Erase;
var
  liIndex: Integer;
begin

  for liIndex := 0 to ElementCount - 1 do
    EraseElement(Elements[liIndex]);

end; {procedure, Erase}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.EraseElement }

procedure TppCrossTabSelection.EraseElement(aElement: TppElement);
var
  lRect: TRect;
begin

  if (ElementCount = 0) or (aElement = nil) then Exit;

  if (FControl.FUpdating) then Exit;

  lRect := aElement.DrawRect;

  Inc(lRect.Left, 2);
  Inc(lRect.Top, 2);
  Dec(lRect.Right, 1);
  Dec(lRect.Bottom, 1);

  FSelectionImage.CopyRect(lRect, FImage, lRect);

  FLiveImage.CopyRect(lRect, FSelectionImage, lRect);

end; {procedure, EraseElement}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.DrawElement }

procedure TppCrossTabSelection.DrawElement(aElement: TppElement);
var
  lRect: TRect;
begin

  if (aElement = nil) then Exit;

  if (FControl.FUpdating) then Exit;

  {clip element from crosstab image and paste into bitmap}
  lRect := aElement.DrawRect;
  Inc(lRect.Left, 2);
  Inc(lRect.Top, 2);
  Dec(lRect.Right, 1);
  Dec(lRect.Bottom, 1);

  FSelectionImage.CopyMode := cmDstInvert;
  FSelectionImage.CopyRect(lRect, FImage, lRect);
  FSelectionImage.CopyMode := cmSrcCopy;

  {draw selection}
  lRect := aElement.DrawRect;
  Inc(lRect.Left, 2);
  Inc(lRect.Top, 2);
  Dec(lRect.Right, 1);
  Dec(lRect.Bottom, 1);

  FLiveImage.CopyRect(lRect, FSelectionImage, lRect);

end; {procedure, DrawElement}

{------------------------------------------------------------------------------}
{ TppCrossTabSelection.Draw }

procedure TppCrossTabSelection.Draw;
var
  liIndex: Integer;
begin

  if (FControl.FUpdating) then Exit;

  for liIndex := 0 to ElementCount - 1 do
    DrawElement(Elements[liIndex]);

end; {procedure, Draw}


end.
