{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit cxSSViewInfo;

{$I cxVer.inc}

interface

uses
  Classes, Math, SysUtils,
  Windows, Graphics, cxGraphics, cxExcelConst, cxSSTypes, cxSSStyles,
  cxSSData, cxSSHeaders, cxSSFormulas, cxSSUtils, cxSSPainterWrapper;

type
  TcxSSheetViewInfoClass = class of TcxSSheetViewInfo;

  TcxSSNavigatorBtnStates = set of TcxSSNavigatorBtn;

  TcxSSCaptionHitTest = (htNone, htCaption, htButton);

  TcxSSCaptionStates = set of (csCurrent, csHidden);

  TcxSSCaptionInfoBrick = record
    State: TcxSSCaptionStates;
    DisplayText: TcxString;
    BoundsRect: TRect;
  end;

  TcxSSBookCaptionViewInfo = record
    Bounds: TRect;
    FillColor: TColor;
    Font: TFont;
    PageCount: Byte;
    IsButtonDown: Boolean;
    BtnDown: ShortInt;
    Enabled: TcxSSNavigatorBtnStates;
    FirstVisibleCaption: Integer;
    BtnBricks: array[TcxSSNavigatorBtn] of TRect;
    Bricks: array of TcxSSCaptionInfoBrick;
  end;

  PcxEdgeVertex = ^TcxEdgeVertex;
  TcxEdgeVertex = packed array[0..2] of TRect;

  PcxSSInfoBrick = ^TcxSSInfoBrick;
  TcxSSInfoBrick = packed record
    Col, Row     : Integer;
    DisplayRect  : TRect;
    TextRect     : TRect;
    BrushStyle   : TcxSSFillStyle;
    BrushBkColor : Word;
    BrushFGColor : Word;
    Edges: TcxSSBordersStyle;
    TopEdgeVertex: TcxEdgeVertex;
    LeftEdgeVertex: TcxEdgeVertex;
    TextSettings : TcxTextParameters;
    IsSelected: Boolean;
    case IsMerge: Boolean of
      True: (UnionIndex: Integer);
      False: ();
  end;

  TcxSSUnionInfoBrick = packed record
    UnionRange: TRect;
    BrushStyle   : TcxSSFillStyle;
    BrushBkColor : Word;
    BrushFGColor : Word;
    TextRect     : TRect;
    DisplayRect  : TRect;
    IsSelected   : Boolean;
    TextSettings : TcxTextParameters;
  end;

  TcxSSViewInfoData = packed record
    DisplayRect: TRect;
    Bounds     : TRect;
    DrawHeaders: Boolean;
    Selection  : TRect;
    SelectedBricks: TRect;
    HeaderColor: Integer;
    HeaderFontColor: Integer;
    IsSelectionVisible: Boolean; 
    UnionBricks: array of TcxSSUnionInfoBrick;
    Bricks     : array of array of TcxSSInfoBrick;
  end;

  TcxSSHitTestState = (htCell, htRowHeader, htColHeader, htResize, htUpperLeft);
  TcxSSHitTestStates = set of TcxSSHitTestState;

  TcxSSheetViewInfo  = class
  private
    FDrawGrid: Boolean;
    FInfoData: TcxSSViewInfoData;
    FInfoChanged: Boolean;
    FOwner: TObject;
    FShowFormulas: Boolean;
    function GetBottomRow: Integer;
    function GetBottomRight: TPoint;
    function GetCanvas: TcxCanvasWrapper;
    function GetClientRect: TRect;
    function GetColHeaderHeight: Integer;
    function GetDataStorage: TcxSSDataStorage;
    function GetFloatDigits: Byte;
    function GetFormulasCache: TcxSSFormulasCache;
    function GetHeader(AType: TcxSSHeaderType): TcxSSHeader;
    function GetLeftCol: Integer;
    function GetMergeCellBorders(ACol, ARow: Integer): TcxSSEdgeBorders;
    function GetRowHeaderWidth: Integer;
    function GetRightCol: Integer;
    function GetTopLeft: TPoint;
    function GetTopRow: Integer;
    procedure SetBottomRight(const Value: TPoint);
    procedure SetBottomRow(const Value: Integer);
    procedure SetInfoChanged(const Value: Boolean);
    procedure SetLeftCol(const Value: Integer);
    procedure SetRightCol(const Value: Integer);
    procedure SetTopLeft(Value: TPoint);
    procedure SetTopRow(const Value: Integer);
  protected
    function AddUnionBrick(ACol, ARow: Integer): Integer; virtual;
    procedure CalculateViewInfo; virtual;
    procedure CheckSelectionVisibility;
    function ConvertCellRecToDisplayText(const ACellRec: TcxSSCellRec;
      var AColor: Word): TcxString;
    procedure InvalidateRect(ARect: TRect); virtual;
    function GetCellIndexes(ACol, ARow: Integer; var AColPos, ARowPos: Integer): Boolean;
    function GetCellsRectIndexes(const ASelRect: TRect): TRect;
    function GetCellTextAlignment(const ACell: TcxSSCellRec): TcxHorzTextAlign;
    procedure InvalidateBrick(AColPos, ARowPos: Integer); virtual;
    procedure InvalidateCells; virtual;
    procedure SetBrickInfo(AColPos, ARowPos: Integer); virtual;
    property Canvas: TcxCanvasWrapper read GetCanvas;
    property ClipRect: TRect read GetClientRect;
    property DataStorage: TcxSSDataStorage read GetDataStorage;
    property Headers[AType: TcxSSHeaderType]: TcxSSHeader read GetHeader;
    property FormulasCache: TcxSSFormulasCache read GetFormulasCache;
    property FloatDigits: Byte read GetFloatDigits;
  public
    constructor Create(AOwner: TObject); virtual;
    procedure ClearBrickText(ACol, ARow: Integer);
    function HitTest(X, Y: Integer; var ACol, ARow: Integer): TcxSSHitTestStates;
    procedure UpdateCellInfo(const ACol, ARow: Integer);
    procedure UpdateCellsInfo(const ACellRect: TRect);
    procedure UpdateOnChangeSelection;
    procedure UpdateOnCancelMode;
    procedure UpdateOnResize;
    procedure UpdateOnResizeColumn(const ACol: Integer);
    procedure UpdateOnResizeRow(const ARow: Integer);
    procedure UpdateViewInfo;
    property BottomRight: TPoint read GetBottomRight write SetBottomRight;
    property BottomRow: Integer read GetBottomRow write SetBottomRow;
    property ColHeaderHeight: Integer read GetColHeaderHeight;
    property InfoData: TcxSSViewInfoData read FInfoData;
    property InfoChanged: Boolean read FInfoChanged write SetInfoChanged;
    property LeftCol: Integer read GetLeftCol write SetLeftCol;
    property Owner: TObject read FOwner;
    property RightCol: Integer read GetRightCol write SetRightCol;
    property RowHeaderWidth: Integer read GetRowHeaderWidth;
    property TopLeft: TPoint read GetTopLeft write SetTopLeft;
    property TopRow: Integer read GetTopRow write SetTopRow;
  end;

implementation
uses
  cxSSheet;

type
  TcxDataStorageAccess = class(TcxSSDataStorage);
  TcxHeaderAccess = class(TcxSSHeader);
  TcxBookAccess = class(TcxCustomSpreadSheetBook);
  TcxBookSubControlAccess = class(TcxWorkBookSubControl);
  TcxSheetAccess = class(TcxSSBookSheet);
  TcxListenerAccess = class(TcxSSListener);

{ TcxSSViewInfo }
constructor TcxSSheetViewInfo.Create(AOwner: TObject);
begin
  FOwner := AOwner;
end;

procedure TcxSSheetViewInfo.ClearBrickText(ACol, ARow: Integer);
begin
  with FInfoData do
  begin
    if not Bricks[ACol, ARow].IsMerge then
      SetLength(Bricks[ACol, ARow].TextSettings.TextBricks, 0)
    else
      SetLength(UnionBricks[Bricks[ACol, ARow].UnionIndex].TextSettings.TextBricks, 0);
  end;
  InvalidateBrick(ACol, ARow)
end;

function TcxSSheetViewInfo.HitTest(X, Y: Integer; var ACol, ARow: Integer): TcxSSHitTestStates;
var
  I, J: Integer;
begin
  Result := [];
  with FInfoData do
  begin
    X := TcxSSUtils.CheckValue(X, 0, ClipRect.Right);
    Y := TcxSSUtils.CheckValue(Y, 0, ClipRect.Bottom);
    for I := Length(Bricks) - 1 downto 0 do
      if (X >= Bricks[I, 0].DisplayRect.Left) and (X < Bricks[I, 0].DisplayRect.Right) then
      begin
        for J := Length(Bricks[0]) - 1 downto 0 do
          if (Y >= FInfoData.Bricks[0, J].DisplayRect.Top) and
            (Y < FInfoData.Bricks[0, J].DisplayRect.Bottom) then
          begin
             ACol := I - 1;
             ARow := J -  1;;
             if (ACol >= 0) and (ARow >= 0)then
             begin
               ACol := FInfoData.Bricks[I, J].Col;
               ARow := FInfoData.Bricks[I, J].Row;
               Include(Result, htCell)
             end
             else
             begin
               if (ACol < 0) and (ARow < 0) then
                 Include(Result, htUpperLeft)
               else
                 if ACol < 0 then
                 begin
                   Include(Result, htRowHeader);
                   ARow := Bricks[0, J].Row;
                   if  (ARow > 0) and (((Y + 4) >= Bricks[0, J].DisplayRect.Top) and
                       ((Y - 4) <= Bricks[0, J].DisplayRect.Top)) then
                   begin
                     Include(Result, htResize);
                     if ARow > 0 then Dec(ARow);
                   end;
                    while (ARow > 0) and not Headers[htRow].Visible[ARow] do Dec(ARow);
                 end
                 else
                   if ARow < 0 then
                   begin
                     Include(Result, htColHeader);
                     ACol := Bricks[I, 0].Col;
                     if (ACol > 0) and ((X + 4) > Bricks[I, 0].DisplayRect.Left) and
                        ((X - 4) < Bricks[I, 0].DisplayRect.Left) then
                     begin
                       Include(Result, htResize);
                       Dec(ACol);
                     end;
                     while (ACol > 0) and not Headers[htCol].Visible[ACol] do Dec(ACol);
                   end;
             end;
             Break;
          end;
          if Result <> [] then Break;
      end;
  end;
end;

procedure TcxSSheetViewInfo.UpdateCellInfo(const ACol, ARow: Integer);
begin
  CalculateViewInfo;
  with FInfoData.DisplayRect do
    InvalidateRect(Rect(RowHeaderWidth, ColHeaderHeight, Right, Bottom));
end;

procedure TcxSSheetViewInfo.UpdateCellsInfo(const ACellRect: TRect);
begin
  UpdateViewInfo;
  Exit;
end;

procedure TcxSSheetViewInfo.UpdateOnResize;
var
  AOldRect, ARect: TRect;
begin
  AOldRect := FInfoData.DisplayRect;
  try
    CalculateViewInfo;
  finally
    ARect := FInfoData.DisplayRect;
    if not EqualRect(AOldRect, ARect) then
    begin
      if AOldRect.Right < ARect.Right then
      begin
        ARect.TopLeft := Point(AOldRect.Right, 0);
        InflateRect(ARect, 2, 2);
        InvalidateRect(ARect);
      end;
    end;
  end;
end;

procedure TcxSSheetViewInfo.UpdateOnCancelMode;
var
  I, J: Integer;
begin
  for I := 0 to Length(FInfoData.Bricks) - 1 do
    for J := 0 to Length(FInfoData.Bricks[0]) - 1 do
      with FInfoData.Bricks[I, J] do
      if IsSelected then
        InvalidateRect(DisplayRect);
  for I := 0 to Length(FInfoData.UnionBricks) - 1 do
    with FInfoData.UnionBricks[I] do
      if IsSelected then
        InvalidateRect(DisplayRect);
  with FInfoData.SelectedBricks do
    if (Left >= 1) and (Left < Length(FInfoData.Bricks)) and
      (Top >= 1) and (Top < Length(FInfoData.Bricks[0])) then
    if FInfoData.Bricks[Left, Top].IsMerge then
      InvalidateRect(FInfoData.UnionBricks[FInfoData.Bricks[Left, Top].UnionIndex].DisplayRect)
    else
      InvalidateRect(FInfoData.Bricks[Left, Top].DisplayRect);
  CheckSelectionVisibility;
end;

procedure TcxSSheetViewInfo.UpdateOnResizeColumn(const ACol: Integer);
var
  I, J, K: Integer;
  R, ARect: TRect;

begin
  K := 0;
  if (Length(FInfoData.Bricks) = 0) or (Length(FInfoData.Bricks[0]) = 0) then Exit;
  while (K < Length(FInfoData.Bricks)) and (FInfoData.Bricks[K, 0].Col < ACol) do Inc(K);
  if K >= Length(FInfoData.Bricks) then Exit;
  for I := 0 to Length(FInfoData.Bricks[K]) - 1 do
     InvalidateBrick(K, I);
  CalculateViewInfo;
  K := 0;
  while FInfoData.Bricks[K, 0].Col < ACol do Inc(K);
  ARect.TopLeft := Point(FInfoData.Bricks[K, 0].DisplayRect.Left, 0);
  ARect.BottomRight := FInfoData.DisplayRect.BottomRight;
  for I := 0 to Length(FInfoData.Bricks[K]) - 1  do
    InvalidateBrick(K, I);
  InvalidateRect(ARect);
  for I := 0 to K do
    for J := 0 to Length(FInfoData.Bricks[I]) - 1 do
     if IntersectRect(R, ARect, FInfoData.Bricks[I, J].TextRect) then
       InvalidateBrick(I, J);
  for I := 0 to Length(FInfoData.UnionBricks) - 1 do
    if IntersectRect(R, FInfoData.UnionBricks[I].TextRect, ARect) then
      InvalidateRect(FInfoData.UnionBricks[I].TextRect);
end;

procedure TcxSSheetViewInfo.UpdateOnResizeRow(const ARow: Integer);
var
  K: Integer;
  R, ARect: TRect;
begin
  with FInfoData do
    if (Length(Bricks) = 0) or (Length(Bricks[0]) = 0) then Exit;
  CalculateViewInfo;
  K := 0;
  while (K < Length(FInfoData.Bricks[0])) and (FInfoData.Bricks[0, K].Row < ARow) do Inc(K);
  if K >= Length(FInfoData.Bricks[0]) then Exit;
  ARect.TopLeft := Point(0, FInfoData.Bricks[0, K].DisplayRect.Top);
  ARect.BottomRight := FInfoData.DisplayRect.BottomRight;
  InvalidateRect(ARect);
  for K := 0 to Length(FInfoData.UnionBricks) - 1 do
    if IntersectRect(R, FInfoData.UnionBricks[K].TextRect, ARect) then
      InvalidateRect(FInfoData.UnionBricks[K].TextRect);
end;

procedure TcxSSheetViewInfo.UpdateViewInfo;
begin
  try
    CalculateViewInfo;
    CheckSelectionVisibility;
  finally
    (FOwner as TcxSSBookSheet).Invalidate;
  end;
end;

procedure TcxSSheetViewInfo.UpdateOnChangeSelection;

  procedure UpdateBrickSelection(ABrickCol, ABrickRow: Integer; AIsSelected: Boolean);
  var
    K, L: Integer;
    ARange: TRect;
  begin
    with FInfoData do
    begin
      if Bricks[ABrickCol, ABrickRow].IsMerge then
      begin
        with UnionBricks[Bricks[ABrickCol, ABrickRow].UnionIndex] do
        begin
          ARange := GetCellsRectIndexes(UnionRange);
          for K := ARange.Left to ARange.Right do
            for L := ARange.Top to ARange.Bottom do
            if ((K > 0) and (K < Length(Bricks))) and
              ((L > 0) and (L < Length(Bricks[0]))) then
            begin
              FInfoData.Bricks[K, L].IsSelected := AIsSelected;
              InvalidateRect(FInfoData.Bricks[K, L].DisplayRect);
            end;
          IsSelected := AIsSelected;
        end;
      end
      else
      begin
        Bricks[ABrickCol, ABrickRow].IsSelected := AIsSelected;
        InvalidateRect(Bricks[ABrickCol, ABrickRow].DisplayRect);
      end;
    end;
  end;

var
  AOldRect, ANewRect: TRect;
  I, J: Integer;
  ACol, ARow: Integer;
  IsCurrent, IsColSelected, IsRowSelected: Boolean;
  ASelected: Boolean;

begin
  InfoChanged := True;
  ANewRect := DataStorage.Selection;
  AOldRect := FInfoData.Selection;
  if EqualRect(AOldRect, ANewRect) then Exit;
  FInfoData.Selection := ANewRect;
  for I := 1 to Length(FInfoData.Bricks) - 1 do
  begin
    ACol := FInfoData.Bricks[I, 0].Col;
    IsColSelected := (ACol >= ANewRect.Left) and (ACol <= ANewRect.Right);
    if FInfoData.Bricks[I, 0].IsSelected <> IsColSelected then
    begin
      FInfoData.Bricks[I, 0].IsSelected := IsColSelected;
      InvalidateRect(FInfoData.Bricks[I, 0].DisplayRect);
    end;
    for J := 1 to Length(FInfoData.Bricks[0]) - 1 do
    begin
      ARow := FInfoData.Bricks[0, J].Row;
      IsRowSelected := (ARow >= ANewRect.Top) and (ARow <= ANewRect.Bottom);
      if FInfoData.Bricks[0, J].IsSelected <> IsRowSelected then
      begin
        FInfoData.Bricks[0, J].IsSelected := IsRowSelected;
        InvalidateRect(FInfoData.Bricks[0, J].DisplayRect);
      end;
      with FInfoData.Bricks[I, J] do
      begin
        IsCurrent := (ACol = ANewRect.Left) and (ARow = ANewRect.Top);
        ASelected := IsColSelected and IsRowSelected and not IsCurrent;
        with FInfoData.SelectedBricks do
        if IsCurrent and ((I <> Left) or (J <> Top)) then
          begin
            UpdateBrickSelection(I, J, not IsCurrent);
            if (Left >= 0) and (Left <= Length(FInfoData.Bricks)) and
              (Top >= 0) and (Top <= Length(FinfoData.Bricks[0])) then
                UpdateBrickSelection(Left, Top, FinfoData.Bricks[Left, Top].IsSelected);
          end;
        if (ASelected <> IsSelected) then
        begin
          if not FInfoData.Bricks[I, J].IsMerge then
            UpdateBrickSelection(I, J, ASelected)
          else
            with FInfoData.UnionBricks[FInfoData.Bricks[I, J].UnionIndex] do
              if (UnionRange.Top <> ANewRect.Top) or (UnionRange.Left <> ANewRect.Left) then
                UpdateBrickSelection(I, J, ASelected);
        end;
      end;
    end;
  end;
  FInfoData.SelectedBricks := GetCellsRectIndexes(FInfoData.Selection);
  CheckSelectionVisibility;
end;

function TcxSSheetViewInfo.AddUnionBrick(ACol, ARow: Integer): Integer;

  function IndexOfRect(const ARect: TRect): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    with FInfoData do
    begin
      for I := 0 to Length(UnionBricks) - 1 do
        if EqualRect(UnionBricks[I].UnionRange, ARect) then
        begin
          Result := I;
          Break;
        end;
    end;
  end;

var
  ARect: TRect;
  ACellRec: TcxSSCellRec;
  AHorzAlign: TcxHorzTextAlign;
  AText: TcxString;
  AColor: Word;
begin
  Result := -1;
  if not DataStorage.CheckInMergeRange(Point(ACol, ARow), ARect) then Exit;
  Result := IndexOfRect(ARect);
  begin
    if Result = -1 then
    begin
      Result := Length(FInfoData.UnionBricks);
      SetLength(FInfoData.UnionBricks,  Result + 1);
      with FInfoData.UnionBricks[Result] do
      begin
        ACellRec := DataStorage[ARect.Left, ARect.Top];
        AColor := 0;
        AText := ConvertCellRecToDisplayText(ACellRec, AColor);
        IsSelected := (Int64(ARect.TopLeft) <> Int64(FInfoData.Selection.TopLeft)) and
           (TcxSSUtils.PointInRect(FInfoData.Selection, ARect.TopLeft) and
            TcxSSUtils.PointInRect(FInfoData.Selection, ARect.BottomRight));
        DisplayRect := DataStorage.CellRect(FInfoData.Bricks[1, 0].Col,
          FInfoData.Bricks[0, 1].Row, ACol, ARow, True);
        UnionRange := ARect;
        BrushStyle := ACellRec.StylePtr^.BrushStyle;
        BrushBkColor := ACellRec.StylePtr^.BrushBkColor;
        BrushFgColor := ACellRec.StylePtr^.BrushFgColor;
        OffsetRect(DisplayRect, RowHeaderWidth, ColHeaderHeight);
        TextRect := DisplayRect;
        InflateRect(TextRect, -1, 0);
        OffsetRect(TextRect, 0, 2);
        Dec(TextRect.Right, 2);
        Dec(TextRect.Bottom, 2);
        AHorzALign := GetCellTextAlignment(ACellRec);
        with ACellRec.StylePtr^ do
        begin
          if AColor = 0 then
            TextSettings.FontColor := FontPtr^.FontColor
          else
            TextSettings.FontColor := AColor;
          if (ACellRec.StylePtr^.FormatIndex <> $31) and cxTryStrToFloat(AText) then
            AText := TcxSSUtils.FormatText(StrToFloat(AText),
              ACellRec.StylePtr^.FormatIndex, FloatDigits, TextSettings.FontColor);
          Canvas.SelectFont(FontPtr^.FontHandle);
          Canvas.CalculateTextExtents(AText, TextRect, AHorzAlign, VertAlign,
            WordBreak, TextSettings);
        end;
        if DisplayRect.Top < ColHeaderHeight then
        begin
          DisplayRect.Top := ColHeaderHeight;
          TextRect.Top := ColHeaderHeight;
        end;
        if DisplayRect.Left < RowHeaderWidth then
        begin
          DisplayRect.Left := RowHeaderWidth;
          TextRect.Left := RowHeaderWidth;
        end;
        Inc(TextRect.Right);
      end;
    end;
  end;
end;

procedure TcxSSheetViewInfo.CalculateViewInfo;

  procedure GetHeaderBrickInfo(var ABrick: TcxSSInfoBrick; ACol, ARow: Integer;
    const ADisplayRect: TRect; const ADisplayText: TcxString; IsColHeader: Boolean = True);
  begin
    with ABrick do
    begin
      Col := ACol;
      Row := ARow;
      DisplayRect := ADisplayRect;
      Canvas.SetSingleText(ADisplayText, ADisplayRect, TextSettings, IsColHeader);
      Inc(TextSettings.TextBricks[0].YPos, 2);
      TextSettings.FontColor := $FFFF; 
      with FInfoData.Selection do
        if IsColHeader then
          IsSelected := (ACol >= Left) and (ACol <= Right)
        else
          IsSelected := (ARow >= Top) and (ARow <= Bottom);
    end;
  end;

  function GetItemsCount(AFrom, ASize: Integer; AType: TcxSSHeaderType): Integer;
  var
    AItem, AItemsSize, AItemSize: Integer;
    AHeader: TcxSSHeader;
  begin
    AHeader := Headers[AType];
    Result := 0;
    AItem := AFrom;
    AItemsSize := 0;
    while ASize > AItemsSize do
    begin
      AItemSize := AHeader[AItem];
      if AItemSize > 0 then Inc(Result);
      Inc(AItemsSize, AItemSize);
      Inc(AItem);
    end;
  end;

  procedure CheckTextExtentAndCorrectBorders(ARow: Integer);

    procedure ClearBorder(J: Integer);
    begin
      FInfoData.Bricks[J, ARow].Edges[eLeft].Style := lsNone;
      if (J - 1) > 0 then
        FInfoData.Bricks[J - 1, ARow].Edges[eRight].Style := lsNone;
    end;

    function BrickIsEmpty(J: Integer): Boolean;
    begin
      with FInfoData.Bricks[J, ARow] do
        Result := (Length(TextSettings.TextBricks) = 0) and (not IsMerge);
    end;

  var
    I, J: Integer;
  begin
    for I := Length(FInfoData.Bricks) - 1 downto 1 do
    with FInfoData.Bricks[I, ARow] do
    if not IsMerge and not BrickIsEmpty(I) and not TextSettings.WordBreak then
    begin
      if TextRect.Left < DisplayRect.Left then
        for J := I - 1 downto 1 do
        if BrickIsEmpty(J) then
        begin
          ClearBorder(J + 1);
          if TextRect.Left > FInfoData.Bricks[J, ARow].DisplayRect.Left then
            Break;
        end
        else
        begin
          TextRect.Left := FInfoData.Bricks[J, ARow].DisplayRect.Right + 2;
          Break;
        end;
      if TextRect.Left < FInfoData.Bricks[0, ARow].DisplayRect.Right then
        TextRect.Left := FInfoData.Bricks[0, ARow].DisplayRect.Right;

      if TextRect.Right > DisplayRect.Right then  
        for J := I + 1 to Length(FInfoData.Bricks) - 1 do
        if BrickIsEmpty(J) then
        begin
          ClearBorder(J);
          if TextRect.Right < FInfoData.Bricks[J, ARow].DisplayRect.Right then
            Break;
        end
        else
        begin
          TextRect.Right :=  FInfoData.Bricks[J, ARow].DisplayRect.Left - 2;
          Break;
        end;
    end;
  end;

  procedure CorrectBordersAndDisplayRect(AColPos, ARowPos: Integer);
  var
    ATopLeft, ALeftTop: PcxEdgeVertex;
    ASide: TcxSSEdgeBorder;
  const
    cxHalfWidth: array[TcxSSEdgeLineStyle] of Byte =
      (1, 1, 2, 1, 1, 2, 2, 1, 2, 1, 2, 1, 2, 2, 0);
    DxDy: array[Boolean] of Byte = (1, 2);

   begin
     with FInfoData.Bricks[AColPos, ARowPos] do
     begin
       if (ARowPos > 1) and
         (FInfoData.Bricks[AColPos, ARowPos - 1].Edges[eLeft].Style = lsDouble) then
         ATopLeft := @FInfoData.Bricks[AColPos, ARowPos - 1].LeftEdgeVertex
       else
         ATopLeft := nil;
       if (AColPos > 1) and
         (FInfoData.Bricks[AColPos - 1, ARowPos].Edges[eTop].Style = lsDouble) then
         ALeftTop := @FInfoData.Bricks[AColPos - 1, ARowPos].TopEdgeVertex
       else
         ALeftTop := nil;
       for ASide := eLeft to eBottom do
         if Edges[ASide].Style <> lsNone then
         begin
          if ASide in [eLeft, eTop] then
            Inc(PIntArray(@DisplayRect)^[Byte(ASide)],
              cxHalfWidth[Edges[ASide].Style])
          else
            Dec(PIntArray(@DisplayRect)^[Byte(ASide)],
              DxDy[cxLineWidth[Edges[ASide].Style] = 3]);
         end;
       if Edges[eTop].Style = lsDouble then
       begin
         if Edges[eLeft].Style = lsDouble then
         begin
           Inc(TopEdgeVertex[2].Left);
           Inc(LeftEdgeVertex[2].Top);
           if ATopLeft = ALeftTop then
           begin
             Dec(TopEdgeVertex[0].Left);
             Dec(LeftEdgeVertex[0].Top);
           end
           else
             if ATopLeft <> nil then
             begin
               Inc(TopEdgeVertex[0].Left);
               Dec(ATopLeft^[2].Bottom);
             end
         end
         else
         begin
           if ATopLeft <> ALeftTop then
           begin
             Inc(TopEdgeVertex[0].Left);
             if ATopLeft <> nil then
             begin
               Dec(TopEdgeVertex[2].Left);
               Inc(ATopLeft[0].Bottom);
             end;
           end;
         end;
       end;
       if Edges[eLeft].Style = lsDouble then
       begin
         if ALeftTop <> nil then
         begin
           Inc(LeftEdgeVertex[0].Top);
           if (Edges[eTop].Style <> lsDouble) and (ATopLeft = nil) then
           begin
             Inc(ALeftTop^[0].Right);
             Dec(LeftEdgeVertex[2].Top);
           end;
         end
       end
       else
         if (ALeftTop <> nil) and (ATopLeft <> nil) and
           (Edges[eTop].Style <> lsDouble) then
         begin
           Inc(ALeftTop^[2].Right);
           Inc(ATopLeft^[2].Bottom, 2);
         end;
       if Edges[eTop].Style = lsThick then
       begin
         Dec(TopEdgeVertex[0].Left);
         Inc(TopEdgeVertex[0].Right, 2);
       end;
       if Edges[eLeft].Style = lsThick then
       begin
         Dec(LeftEdgeVertex[0].Top);
         Inc(LeftEdgeVertex[0].Bottom, 2);
       end
     end;
   end;

var
  I, J, K: Integer;
  ASize: TcxSSSize;
  ATop, ALeft: Integer;
  ARowCount, AColCount: Integer;
  AColHeaderHeight: Integer;
  ARowHeaderWidth: Integer;
  ARange: TRect;

begin
  InfoChanged := True;
  if not TcxSheetAccess(Owner).Owner.HandleAllocated then Exit;
  CheckSelectionVisibility;
  Canvas.BeginPaint(TcxSheetAccess(Owner).ControlCanvas);
  FShowFormulas := TcxSheetAccess(Owner).ShowFormulas;
  FInfoData.DisplayRect := ClipRect;
  AColHeaderHeight := ColHeaderHeight;
  ARowHeaderWidth := RowHeaderWidth;
  FDrawGrid := TcxSheetAccess(Owner).ShowGrid;
  AColCount := GetItemsCount(FInfoData.Bounds.Left,
                             ClipRect.Right - ARowHeaderWidth, htCol) + 2;
  ARowCount := GetItemsCount(FInfoData.Bounds.Top,
                             ClipRect.Bottom - AColHeaderHeight, htRow) + 2;
  SetLength(FInfoData.UnionBricks, 0);
  SetLength(FInfoData.Bricks, AColCount, ARowCount);
  FInfoData.Selection := DataStorage.Selection;
  FInfoData.DrawHeaders := TcxSheetAccess(Owner).ShowHeaders;
  I := 1;
  J := FInfoData.Bounds.Top;
  ATop := AColHeaderHeight;
  with TcxBookAccess(TcxBookSubControlAccess(Owner).Owner) do
  begin
    FInfoData.HeaderColor := Canvas.GetNativeColor(HeaderColor);
    FInfoData.HeaderFontColor := Canvas.GetNativeColor(HeaderFont.Color);
    Canvas.SelectFont(HeaderFont);
  end;
  while I < ARowCount do
  begin
    ASize := Headers[htRow][J];
    Inc(J);
    if ASize > 0 then
    begin
      GetHeaderBrickInfo(FInfoData.Bricks[0, I], 0, J - 1,
        Rect(0, ATop, ARowHeaderWidth, ATop + ASize), IntToStr(J), False);
      Inc(ATop, ASize);
      Inc(I);
    end;
  end;
  I := 1;
  J := FInfoData.Bounds.Left;
  ALeft := ARowHeaderWidth;
  while I < AColCount do
  begin
    ASize := Headers[htCol][J];
    Inc(J);
    if ASize > 0 then
    begin
      GetHeaderBrickInfo(FInfoData.Bricks[I, 0], J - 1, 0,
        Rect(ALeft, 0, ALeft + ASize, AColHeaderHeight),
         TcxSSUtils.ColumnNameByIndex(J - 1,
           TcxSheetAccess(Owner).Owner.R1C1ReferenceStyle));
      Inc(ALeft, ASize);
      Inc(I);
    end;
  end;
  FInfoData.Bounds.BottomRight := Point(AColCount, ARowCount);
  GetHeaderBrickInfo(FInfoData.Bricks[0, 0], -1, -1,
    Rect(0, 0, ARowHeaderWidth, AColHeaderHeight), '');
  for I := 1 to ARowCount - 1 do
  begin
    for J := 1 to AColCount - 1 do SetBrickInfo(J, I);
    CheckTextExtentAndCorrectBorders(I);
  end;
  for I := 0 to Length(FInfoData.UnionBricks) - 1 do
  begin
    with FInfoData.UnionBricks[I] do
    begin
      ARange := GetCellsRectIndexes(UnionRange);
      for J := ARange.Left to ARange.Right do
        for K := ARange.Top to ARange.Bottom do
        if ((J >= 1) and (J < Length(FInfoData.Bricks))) and
          ((K >= 1) and (K < Length(FInfoData.Bricks[0]))) then
             with FInfoData.Bricks[J, K] do
             begin
               if J > ARange.Left then Edges[eLeft].Style := lsNone;
               if J < ARange.Right then Edges[eRight].Style := lsNone;
               if K > ARange.Top then Edges[eTop].Style := lsNone;
               if K < ARange.Bottom then Edges[eBottom].Style := lsNone;
             end;
    end;
  end;
  for I := 1 to AColCount - 1 do
    for J := 1 to ARowCount - 1 do CorrectBordersAndDisplayRect(I, J);
  FInfoData.SelectedBricks := GetCellsRectIndexes(FInfoData.Selection);
  TcxSheetAccess(Owner).InitScrollBars;
  CheckSelectionVisibility;
end;

procedure TcxSSheetViewInfo.CheckSelectionVisibility;
var
  R: TRect;
begin
  with FInfoData do
  begin
    R := DataStorage.Selection;
    IsSelectionVisible := (R.Left <= (RightCol + 1)) and (R.Right >= LeftCol) and
      (R.Top <= (BottomRow + 1)) and (R.Bottom >= TopRow);
  end;
end;

function TcxSSheetViewInfo.ConvertCellRecToDisplayText(
  const ACellRec: TcxSSCellRec; var AColor: Word): TcxString;
var
  AValue: Double;
begin
  AValue := 0;
  case ACellRec.DataType of
    dtFunction:
        Result := FormulasCache.FuncRecToDisplayText(ACellRec.FuncRecPtr, AColor);
    dtDateTime:
      Result := TcxSSUtils.FormatText(ACellRec.DateTime,
        ACellRec.StylePtr^.FormatIndex, FloatDigits, AColor);
  else
    if (ACellRec.StylePtr^.FormatIndex <> $31) and cxTryStrToFloat(ACellRec.Text, AValue) then
      Result := TcxSSUtils.FormatText(AValue, ACellRec.StylePtr^.FormatIndex,
        FloatDigits, AColor)
    else
      Result := ACellRec.Text;
  end;
end;

function TcxSSheetViewInfo.GetCellIndexes(ACol, ARow: Integer;
  var AColPos, ARowPos: Integer): Boolean;
var
  I: Integer;
begin
  I := 1;
  while (I < Length(FInfoData.Bricks)) and (FInfoData.Bricks[I, 0].Col < ACol) do Inc(I);
  Result :=  (I < Length(FInfoData.Bricks)) and (FInfoData.Bricks[I, 0].Col >= ACol);
  if Result then
    AColPos := I
  else
    AColPos := -1;
  I := 1;
  while (I < Length(FInfoData.Bricks[0])) and (FInfoData.Bricks[0, I].Row < ARow) do Inc(I);
  if (I < Length(FInfoData.Bricks[0])) and (FInfoData.Bricks[0, I].Row >= ARow) then
    ARowPos := I
  else
    ARowPos := -1;
  Result := Result or (ARowPos <> -1);
end;

procedure TcxSSheetViewInfo.InvalidateRect(ARect: TRect);
begin
  InflateRect(ARect, 5, 5);
  TcxBookSubControlAccess(FOwner).InvalidateRect(ARect);
end;

function TcxSSheetViewInfo.GetCellsRectIndexes(const ASelRect: TRect): TRect;
var
  I: Integer;
  ARect: TRect;
begin
  Result := Rect(-1, -1, -1, -1);
  if Length(FInfoData.Bricks) = 0 then Exit; 
  with FInfoData do
    ARect := Rect(Bricks[1, 1].Col, Bricks[1, 1].Row,
                  Bricks[Length(Bricks) - 1, 1].Col, Bricks[1, Length(Bricks[0]) - 1].Row);

  if (ASelRect.Left >= ARect.Left) and (ASelRect.Left <= ARect.Right) then
    for I := 1 to Length(FInfoData.Bricks) - 1 do
      if FInfoData.Bricks[I, 0].Col > ASelRect.Left then
      begin
        if (Result.Left >=0) and (FInfoData.Bricks[Result.Left, 0].Col <> ASelRect.Left) then
          Result.Left := I;
        Break;
      end
      else
        Result.Left := I;

  if (ASelRect.Right >= ARect.Left) and (ASelRect.Right <= ARect.Right) then
    for I := 1 to Length(FInfoData.Bricks) - 1 do
      if FInfoData.Bricks[I, 0].Col > ASelRect.Right then
        Break
      else
        Result.Right := I;

  if (ASelRect.Top >= ARect.Top) and (ASelRect.Top <= ARect.Bottom) then
    for I := 1 to Length(FInfoData.Bricks[0]) - 1 do
      if FInfoData.Bricks[0, I].Row > ASelRect.Top then
      begin
        if FInfoData.Bricks[0, Result.Top].Row <> ASelRect.Top then
          Result.Top := I;
        Break;
      end
      else
        Result.Top := I;

  if (ASelRect.Bottom >= ARect.Top) and (ASelRect.Bottom <= ARect.Bottom) then
    for I := 1 to Length(FInfoData.Bricks[0]) - 1 do
      if FInfoData.Bricks[0, I].Row > ASelRect.Bottom then
        Break
      else
        Result.Bottom := I;

  if (Result.Left >= 0) and (Result.Right < 0) then
    Result.Right := Length(FInfoData.Bricks) - 1;

  if (Result.Top >= 0) and (Result.Bottom < 0) then
    Result.Bottom := Length(FInfoData.Bricks[0]) - 1;
end;

function TcxSSheetViewInfo.GetCellTextAlignment(
  const ACell: TcxSSCellRec): TcxHorzTextAlign;
var
  S: string;
  C: Word;
begin
  with ACell do
  begin
    Result := ACell.StylePtr^.HorzAlign;
    if Result = haGeneral then
    begin
      if DataType = dtFunction then
        S := FormulasCache.FuncRecToDisplayText(ACell.FuncRecPtr, C, False)
      else
        S := Text;
      Result := haLeft;
      if StylePtr^.FormatIndex <> $31 then
      begin
        if cxTryStrToFloat(S) then
          Result := haRight
        else
          if cxTryStrToBool(S) then
            Result := haCenter
      end;
    end;
  end;
end;

procedure TcxSSheetViewInfo.InvalidateBrick(AColPos, ARowPos: Integer);
var
  ARect, ARect1: TRect;
begin
  if (AColPos < 0) or (ARowPos < 0) then Exit;
  ARect := FInfoData.Bricks[AColPos, ARowPos].DisplayRect;
  ARect1 := FInfoData.Bricks[AColPos, ARowPos].TextRect;
  UnionRect(ARect, ARect1, ARect);
  InflateRect(ARect, 3, 3);
  InvalidateRect(ARect);
end;

procedure TcxSSheetViewInfo.InvalidateCells;
var
  ARect: TRect;
begin
  ARect.TopLeft := FInfoData.Bricks[0, 0].DisplayRect.BottomRight;
  ARect.BottomRight := ClipRect.BottomRight;
  InflateRect(ARect, 3, 3);
  InvalidateRect(ARect);
end;

procedure TcxSSheetViewInfo.SetBrickInfo(AColPos, ARowPos: Integer);
var
  AColor: Word;
  ACell: TcxSSCellRec;
  AStyle: PcxSSCellStyleRec;
  ABorderState: TcxSSEdgeBorders;
  AHorzAlign: TcxHorzTextAlign;
  AText: TcxString;
  AWidth: Integer;
  ASide: TcxSSEdgeBorder;

  procedure SetEdgeVertex(const ARect: TRect; var AStyle: TcxSSEdgeLineStyle;
    var AVertex: TcxEdgeVertex; AOrient: TcxOrientation);
  var
    I: Byte;
  const
    AOfs: array[TcxOrientation, 0..1] of Byte = ((0, 1), (1, 0));
  begin
    if (AStyle = lsDefault) and not FDrawGrid then
      AStyle := lsNone;
    if AStyle = lsNone then Exit;
    with ARect do
      if AOrient = oHorz then
        AVertex[0] := Rect(Left, Top, Right - 1, Top)
      else
        AVertex[0] := Rect(Left, Top, Left, Bottom - 1);
    if cxLineWidth[AStyle] = 3 then
      OffsetRect(AVertex[0], -AOfs[AOrient, 0], -AOfs[AOrient, 1]);
    if AStyle = lsDouble then
      for I := 1 to 2 do
      begin
        AVertex[I] := AVertex[0];
        OffsetRect(AVertex[I], AOfs[AOrient, 0] * I, AOfs[AOrient, 1] * I);
      end
    else
    begin
      if AOrient = oHorz then
        Inc(AVertex[0].Bottom, cxLineWidth[AStyle] - 1)
      else
        Inc(AVertex[0].Right, cxLineWidth[AStyle] - 1);
    end;
  end;

  function GetActualStyle(AStyle1, AStyle2: TcxSSEdgeLineStyle): TcxSSEdgeLineStyle;
  begin
    Result := AStyle1;
    if Result = lsDefault then
      Result := AStyle2;
  end;

begin
  with FInfoData.Bricks[AColPos, ARowPos] do
  begin
    Col := FInfoData.Bricks[AColPos, 0].Col;
    Row := FInfoData.Bricks[0, ARowPos].Row;
    ACell := DataStorage[Col, Row];
    AStyle := ACell.StylePtr;
    with FInfoData.Bricks[AColPos, 0].DisplayRect do
    begin
      DisplayRect.Left := Left;
      DisplayRect.Right := Right;
    end;
    with FInfoData.Bricks[0, ARowPos].DisplayRect do
    begin
      DisplayRect.Top := Top;
      DisplayRect.Bottom := Bottom;
    end;
    BrushStyle := AStyle^.BrushStyle;
    BrushBkColor := AStyle^.BrushBkColor;
    BrushFgColor := AStyle^.BrushFgColor;
    if Col > 0 then
      Edges[eLeft].Style := GetActualStyle(AStyle^.Borders[eLeft].Style,
        DataStorage[Col - 1, Row].StylePtr^.Borders[eRight].Style)
    else
      Edges[eLeft].Style := AStyle^.Borders[eLeft].Style;
    Edges[eRight].Style := GetActualStyle(AStyle^.Borders[eRight].Style,
      DataStorage[Col + 1, Row].StylePtr^.Borders[eLeft].Style);
    Edges[eBottom].Style := GetActualStyle(AStyle^.Borders[eBottom].Style,
      DataStorage[Col, Row + 1].StylePtr^.Borders[eTop].Style);
    if Row > 0 then
      Edges[eTop].Style := GetActualStyle(AStyle^.Borders[eTop].Style,
        DataStorage[Col, Row - 1].StylePtr^.Borders[eBottom].Style)
    else
      Edges[eTop].Style := AStyle^.Borders[eTop].Style;
    for ASide := eLeft to eBottom do
    begin
      if (Edges[ASide].Style = lsDefault) and (not FDrawGrid) then
        Edges[ASide].Style := lsNone;
      Edges[ASide].Color := AStyle^.Borders[ASide].Color;
    end;
    IsMerge := cMerge in AStyle^.CellState;
    if not IsMerge then
    begin
      with FInfoData.Selection do
        IsSelected := (not ((Col = Left) and (Row = Top))) and (Col >= Left) and
          (Col <= Right) and (Row >= Top) and (Row <= Bottom);
      AColor := 0;
      AText := ConvertCellRecToDisplayText(ACell, AColor);
      TextRect := DisplayRect;
      InflateRect(TextRect, -2, 0);
      OffsetRect(TextRect, 0, 2);
      Dec(TextRect.Bottom, 2);
      if AText <> '' then
      begin
        Canvas.SelectFont(AStyle^.FontPtr^.FontHandle);
        if AColor = 0 then
          TextSettings.FontColor := AStyle^.FontPtr^.FontColor
        else
          TextSettings.FontColor := AColor;
        AHorzAlign := GetCellTextAlignment(ACell);
        if not AStyle^.WordBreak then
        begin
          AWidth := Canvas.TextWidth(AText) - (TextRect.Right - TextRect.Left) + 4;
          if AWidth > 0 then
          begin
            case AHorzAlign of
              haLeft:
                Inc(TextRect.Right, AWidth);
              haRight:
                Dec(TextRect.Left, AWidth);
              haCenter:
              begin
                Dec(TextRect.Left, AWidth shr 1);
                Inc(TextRect.Right, AWidth shr 1);
              end;
            end;
          end;
        end;
        Canvas.CalculateTextExtents(AText, TextRect, AHorzAlign,
           AStyle.VertAlign, AStyle.WordBreak, TextSettings);
      end
      else
        SetLength(TextSettings.TextBricks, 0);
    end;
    if IsMerge then
    begin
      ABorderState := GetMergeCellBorders(Col, Row);
      UnionIndex := AddUnionBrick(Col, Row);
      if UnionIndex >= 0 then
      begin
        BrushStyle := FInfoData.UnionBricks[UnionIndex].BrushStyle;
        BrushBkColor := FInfoData.UnionBricks[UnionIndex].BrushBkColor;
        BrushFgColor := FInfoData.UnionBricks[UnionIndex].BrushFgColor;
        IsSelected := FInfoData.UnionBricks[UnionIndex].IsSelected;
      end;
    end
    else
      ABorderState := [eLeft, eTop];
    SetEdgeVertex(DisplayRect, Edges[eTop].Style, TopEdgeVertex, oHorz);
    SetEdgeVertex(DisplayRect, Edges[eLeft].Style, LeftEdgeVertex, oVert);
  end;
end;

function TcxSSheetViewInfo.GetBottomRow: Integer;
begin
  Result := GetBottomRight.Y;
end;

function TcxSSheetViewInfo.GetBottomRight: TPoint;

  procedure GetLastVisible(AHeader: TcxSSHeader; ALen: Integer; var AIndex: Integer);
  var
    ACalcLen:  Integer;
  begin
    ACalcLen := 0;
    while ACalcLen < ALen do
    begin
      ACalcLen := ACalcLen + AHeader.Size[AIndex];
      if ACalcLen <= ALen then
        Inc(AIndex);
    end;
    Dec(AIndex);
    while not AHeader.Visible[AIndex] do Dec(AIndex);
  end;

var
  ARect: TRect;
  ASize: Integer;
begin
  ARect := ClipRect;
  Result := FInfoData.Bounds.TopLeft;
  ASize := ARect.Right - ARect.Left - RowHeaderWidth;
  GetLastVisible(Headers[htCol], ASize, Result.X);
  ASize := ARect.Bottom - ARect.Top - ColHeaderHeight;
  GetLastVisible(Headers[htRow], ASize, Result.Y);
end;

function TcxSSheetViewInfo.GetCanvas: TcxCanvasWrapper;
begin
  Result := TcxBookSubControlAccess(Owner).Canvas;
end;

function TcxSSheetViewInfo.GetClientRect: TRect;
begin
  with TcxBookAccess(TcxBookSubControlAccess(Owner).Owner) do
  begin
    Result := ClientBounds;
    if (CaptionBar <> nil) and TcxBookSubControlAccess(CaptionBar).Visible then
      Result.Bottom := TcxBookSubControlAccess(CaptionBar).Top;
  end;
end;

function TcxSSheetViewInfo.GetColHeaderHeight: Integer;
begin
  if TcxSheetAccess(Owner).ShowHeaders then
    Result := TcxBookAccess(TcxSheetAccess(Owner).Owner).ColHeaderHeight
  else
    Result := 0;
end;

function TcxSSheetViewInfo.GetDataStorage: TcxSSDataStorage;
begin
  Result :=  TcxSheetAccess(Owner).DataStorage;
end;

function TcxSSheetViewInfo.GetFloatDigits: Byte;
begin
  Result := TcxBookAccess(TcxSheetAccess(Owner).Owner).Precision;
end;

function TcxSSheetViewInfo.GetFormulasCache: TcxSSFormulasCache;
begin
  Result := TcxBookAccess(TcxSheetAccess(Owner).Owner).FormulasCache;
end;

function TcxSSheetViewInfo.GetHeader(AType: TcxSSHeaderType): TcxSSHeader;
begin
  Result := DataStorage.Headers[AType];
end;

function TcxSSheetViewInfo.GetLeftCol: Integer;
begin
  Result := TopLeft.X;
end;

function TcxSSheetViewInfo.GetMergeCellBorders(ACol, ARow: Integer): TcxSSEdgeBorders;
var
  ARect: TRect;
begin
  Result := [];
  if DataStorage.CheckInMergeRange(Point(ACol, ARow), ARect) then
  begin
    if ACol = ARect.Left then Include(Result, eLeft);
    if ARow = ARect.Top then Include(Result, eTop);
  end;
end;

function TcxSSheetViewInfo.GetRowHeaderWidth: Integer;
begin
 with TcxBookAccess(TcxSheetAccess(Owner).Owner) do
   if ShowHeaders then
     Result := RowHeaderWidth
   else
     Result := 0;
end;

function TcxSSheetViewInfo.GetTopLeft: TPoint;
begin
  Result := FInfoData.Bounds.TopLeft;
end;

function TcxSSheetViewInfo.GetTopRow: Integer;
begin
  Result := GetTopLeft.Y;
end;

function TcxSSheetViewInfo.GetRightCol: Integer;
begin
   Result := GetBottomRight.X;
end;

procedure TcxSSheetViewInfo.SetBottomRight(const Value: TPoint);

  function CalculateTopLeft: TPoint;
  var
    ARect: TRect;
    ASize: Integer;
  begin
    Result := Value;
    ARect := ClipRect;
    ASize := ARect.Right - ARect.Left - RowHeaderWidth;
    Result.X := Result.X +
      TcxHeaderAccess(DataStorage.Headers[htCol]).GetCountItems(Result.X, ASize, False) + 1;
    ASize := ARect.Bottom - ARect.Top - ColHeaderHeight;
    Result.Y := Result.Y +
      TcxHeaderAccess(DataStorage.Headers[htRow]).GetCountItems(Result.Y, ASize, False) + 1;
  end;

begin
  SetTopLeft(CalculateTopLeft);
end;

procedure TcxSSheetViewInfo.SetBottomRow(const Value: Integer);
begin
  SetBottomRight(Point(GetBottomRight.X, Value));
end;

procedure TcxSSheetViewInfo.SetInfoChanged(const Value: Boolean);
begin
  if FInfoChanged <> Value then
  begin
    FInfoChanged := Value;
    if Value then
      if TcxSheetAccess(Owner).Owner.BufferedPaint then
        TcxSheetAccess(Owner).Invalidate;
  end;
end;

procedure TcxSSheetViewInfo.SetLeftCol(const Value: Integer);
begin
  SetTopLeft(Point(Value, TopRow));
end;

procedure TcxSSheetViewInfo.SetRightCol(const Value: Integer);
begin
  SetBottomRight(Point(Value, GetBottomRight.Y));
end;

procedure TcxSSheetViewInfo.SetTopLeft(Value: TPoint);

  function CheckValue: Boolean;
  begin
    with FInfoData.Bounds do
      Result := (Left = Value.X) and (Top = Value.Y);
    if not Result then
    begin
      if Value.Y < 0 then Value.Y := 0;
      if Value.X < 0 then Value.X := 0;
    end;
  end;

var
  AListener: TcxListenerAccess;

begin
  if CheckValue then Exit;
  AListener := TcxListenerAccess(TcxBookAccess(TcxSheetAccess(Owner).Owner).Listener);
  AListener.OnTopLeftChanging(TcxSSBookSheet(Owner), Value);
  if not CheckValue then
  begin
    FInfoData.Bounds.TopLeft := Value;
    CalculateViewInfo;
    TcxSheetAccess(FOwner).Invalidate;
  end;
end;

procedure TcxSSheetViewInfo.SetTopRow(const Value: Integer);
begin
  SetTopLeft(Point(LeftCol, Value));
end;

end.
