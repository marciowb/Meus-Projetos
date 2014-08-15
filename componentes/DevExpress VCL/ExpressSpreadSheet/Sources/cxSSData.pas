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

unit cxSSData;

{$I cxVer.inc}

interface

uses
  Classes, Math, SysUtils, Windows, Dialogs,
  cxClasses, cxSSHeaders, cxSSRes, cxSSStyles, cxSSUtils, cxSSTypes, cxExcelConst;

type
  TcxSSSelectionState = (ssCurrentSelect, ssMultiSelect, ssMergeSelect);

  TcxSSDataStorageClass = class of TcxSSDataStorage;
  TcxSSDataStorage = class;
  TcxSSMergedCellsStorage = class;

  { TcxSSDataStorage }
  TcxSSDataStorage = class
  private
    FCaption: string;
    FCapacity: TSize;
    FColCapacityInc: Integer;
    FCols: PcxSSColumns;
    FColsCount: Integer;
    FDefaultCellRec: TcxSSCellRec;
    FDimension: TSize;
    FDimensionAssigned: Boolean; 
    FHeaders: array[TcxSSHeaderType] of TcxSSHeader;
    FIsSetSelecton: Boolean;
    FIsDeleted: Boolean;
    FMaxRow: Integer;
    FMergedCells: TcxSSMergedCellsStorage;
    FOwnerSheet: TObject;
    FRowCapacityInc: Integer;
    FSelection: TRect;
    FSelectionState: TcxSSSelectionState;
    function GetCellStyle(ACol, ARow: Integer): TcxSSCellStyle;
    function GetCellDataType(ACol, ARow: Integer): TcxSSDataType;
    function GetCellDateTime(ACol, ARow: Integer): TDateTime;
    function GetCellFormulaPtr(ACol, ARow: Integer): PcxSSFuncRec;
    function GetCellStylePtr(ACol, ARow: Integer): PcxSSCellStyleRec;
    function GetCellText(ACol, ARow: Integer): string;
    function GetCurrentCol: Integer;
    function GetCurrentRow: Integer;
    function GetCurrentPage: Word;
    function GetHeaders(AType: TcxSSHeaderType): TcxSSHeader;
    function GetListener: TObject;
    function GetParentBook: TObject;
    function GetRowCount(ACol: Integer): Integer;
    function GetSelection: TRect;
    function GetMergedCellsRange: TcxSSRectsArray;
    procedure SetModified;
    procedure SetCellDateTime(ACol, ARow: Integer; const Value: TDateTime);
    procedure SetCellFormulaPtr(ACol, ARow: Integer; const Value: PcxSSFuncRec);
    procedure SetCellStylePtr(ACol, ARow: Integer; const Value: PcxSSCellStyleRec);
    procedure SetCellText(ACol, ARow: Integer; const Value: string);
    procedure SetDimension(const ASize: TSize);
    procedure SetSheetCaption(const Value: string);
    procedure SetSelectionRect(const ARect: TRect);
  protected
    procedure AddCellToHistory(const ACol, ARow: Integer);
    function CellCompare(const ACell1, ACell2: TcxSSCellRec): SmallInt;
    function CellIsEmpty(ACol, ARow: Integer): Boolean;
    function CloneCell(ACell: PcxSSCellRec): PcxSSCellRec;
    function CompareCells(const ACell1, ACell2: TcxSSCellRec): Boolean;
    function GetCellRec(ACol, ARow: Integer): TcxSSCellRec; virtual;
    function GetMultiSelection: Boolean;
    function IsLoading: Boolean;
    function IsValidCell(ACol, ARow: Integer): Boolean;
    procedure SetCellRec(ACol, ARow: Integer; const Value: TcxSSCellRec); virtual;
    procedure SetCellTextEx(ACol, ARow: Integer; const Value: string; IsFormula: Boolean = False; Analyze: Boolean = True);
    procedure SetCurrentCol(const Value: Integer); virtual;
    procedure SetCurrentRow(const Value: Integer); virtual;
    property AccessTable: PcxSSColumns read FCols write FCols;
    property AccessColsCount: Integer read FColsCount write FColsCount;
    property AccessMaxRow: Integer read FMaxRow write FMaxRow;
    property Capacity: TSize read FCapacity;
    property Columns: PcxSSColumns read FCols;
    property DefaultCellRec: TcxSSCellRec read FDefaultCellRec;
    property Listener: TObject read GetListener;
    property MergedCells: TcxSSMergedCellsStorage read FMergedCells;
    property MergedCellsRange: TcxSSRectsArray read GetMergedCellsRange;
  public
    constructor Create(AOwner: TObject); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TcxSSDataStorage); virtual;
    function CellRect(ALeft, ATop, ACol, ARow: Integer;
                      IsExtendedRect: Boolean = False): TRect; virtual;
    function CheckInMergeRange(const APoint: TPoint; var AMergeRange: TRect): Boolean;
    function CheckIntersection(const ARect: TRect; IsHorz: Boolean): Boolean;
    function CheckSelectionRect(const ARect: TRect): TRect; virtual;
    procedure Clear; virtual;
    procedure ClearCells(ARect: TRect; SetDefaultStyle: Boolean = False); virtual;
    procedure CopyCells(const ADestCol, ASourceCol: Integer;
                        AFromRow, AToRow, ACount: Integer;
                        IsClearSource: Boolean = True); virtual;
    function CreateAccessCellObject(ACol, ARow: Integer): TObject; virtual;
    procedure DeleteCells(ACells: TRect; ACellsModify: TcxSSCellsModify); virtual;
    function HasCell(ACol, ARow: Integer): Boolean;
    procedure InsertCells(ACells: TRect; ACellsModify: TcxSSCellsModify); virtual;
    function IsMerge(ACol, ARow: Integer): Boolean;
    function GetContentColCount: Integer; virtual;
    function GetContentRowCount: Integer; virtual;
    procedure MergeUnMerge(const ARect: TRect; AIsMerge: Boolean); virtual;
    procedure SetCapacity(const ASize: TSize); virtual;
    procedure Sort(const ARect: TRect; const ASortTypes: array of TcxSortType); virtual;
    property Caption: string read FCaption write SetSheetCaption;
    property Cells[ACol, ARow: Integer]: TcxSSCellRec read GetCellRec
                                                      write SetCellRec; default;
    property CellText[ACol, ARow: Integer]: string read GetCellText write SetCellText;
    property CellStyle[ACol, ARow: Integer]: TcxSSCellStyle read GetCellStyle;
    property CellStylePtr[ACol, ARow: Integer]: PcxSSCellStyleRec read GetCellStylePtr
                                                          write SetCellStylePtr;
    property CellDataType[ACol, ARow: Integer]: TcxSSDataType read GetCellDataType;
    property CellDateTime[ACol, ARow: Integer]: TDateTime read GetCellDateTime
                                                          write SetCellDateTime;
    property CellFormulaPtr[ACol, ARow: Integer]: PcxSSFuncRec read GetCellFormulaPtr
                                                               write SetCellFormulaPtr;
    property Col: Integer read GetCurrentCol write SetCurrentCol;
    property CurrentPage: Word read GetCurrentPage;
    property Dimension: TSize read FDimension write SetDimension;
    property DimensionAssigned: Boolean read FDimensionAssigned; 
    property Row: Integer read GetCurrentRow write SetCurrentRow;
    property Headers[AType: TcxSSHeaderType]: TcxSSHeader read GetHeaders;
    property IsMultiSelection: boolean read GetMultiSelection;
    property MaxColumn: Integer read FColsCount;
    property MaxRow: Integer read FMaxRow;
    property Owner: TObject read FOwnerSheet;
    property ParentBook: TObject read GetParentBook;
    property RowCount[ACol: Integer]: Integer read GetRowCount;
    property SheetCaption: string read FCaption write SetSheetCaption;
    property Selection: TRect read GetSelection write SetSelectionRect;
    property SelectionState: TcxSSSelectionState read FSelectionState;
  end;

  { TcxSSMergedCellsStorage }
  TcxSSMergedCellsStorage = class
  private
    FCount: Integer;
    FData: Pointer;
    FOwner: TcxSSDataStorage;
    function CheckRect(const ARect: TRect; out AIndex: Integer): Boolean;
    function GetItemBounds(AIndex: Integer): TRect;
    function GetItemRect(AIndex: Integer): TRect;
    function GetItemsRects: TcxSSRectsArray;
  protected
    procedure AddMergeItem(const ARect: TRect);
    procedure CheckAfterClear(ARect: TRect);
    function CheckInMergeRange(const APoint: TPoint; var ARect: TRect): Boolean;
    function CheckSelection(const ARect: TRect): TRect;
    procedure Clear;
    procedure DeleteMergeCell(const ACol, ARow: Integer);
    procedure DeleteMergeItem(const AIndex: Integer);
    function GetRects: TcxSSRectsArray;
    function GetRectItem(const AIndex: Integer; var AItem: TRect): Boolean;
    procedure InflateItem(const AIndex, DW, DH: Integer);
    procedure InflatePoint(var APoint: TPoint; const DX, DY: Integer);
    function RectIsBelow(const ATopRect, ABottomRect: TRect): Boolean;
    function RectIsRight(const ALeftRect, ARightRect: TRect): Boolean;
    procedure SetMergeStyle(const ARect: TRect; AIsMerge: Boolean);
    function SetRects(const ARects: TcxSSRectsArray): TcxSSRectsArray;
    procedure ShiftItem(const AItem, DX, DY: Integer);
    procedure UpdateOnInsertCells(ARect: TRect; AShift: TcxSSCellsModify);
    procedure UpdateOnDeleteCells(ARect: TRect; AShift: TcxSSCellsModify);
    function ValidateRect(const ARect: TRect): TRect;
    property Owner: TcxSSDataStorage read FOwner;
  public
    procedure Assign(Source: TcxSSMergedCellsStorage); virtual;
    procedure AddMerges(const ARects: TcxSSRectsArray);
    function IntersectMerge(const ARect: TRect): Boolean;
    function IntersectMergedCells(const ARect: TRect): TcxSSRectsArray;
    property MergedAsRect[AIndex: Integer]: TRect read GetItemRect; default;
    property MergedAsBounds[AIndex: Integer]: TRect read GetItemBounds;
    property Rects: TcxSSRectsArray read GetItemsRects;
    property Count: Integer read FCount;
  end;

implementation
uses
  cxSSheet, cxSSFormulas, cxSSHistory;

type
  TcxSSListenerAccess = class(TcxSSListener);
  TcxSSBookAccess = class(TcxCustomSpreadSheetBook);
  TcxSSBookSheetAccess = class(TcxSSBookSheet);
  TcxSSCellStyleAccess = class(TcxSSCellStyle);
  TcxSSHeaderAccess = class(TcxSSHeader);
  TcxHistoryAccess = class(TcxCustomHistory);
  TcxActionAccess = class(TcxSpreadSheetActions);

{ TcxDataAccessDefinition }
constructor TcxSSDataStorage.Create(AOwner: TObject);
begin
  FIsDeleted := False;
  FOwnerSheet := AOwner;
  FColCapacityInc := 10;
  FRowCapacityInc := 1000;
  with FDefaultCellRec do
  begin
    Text := '';
    DataType := dtText;
    StylePtr := TcxSSBookAccess(ParentBook).StyleCache.StyleList[0];
  end;
  with TcxSSBookAccess(ParentBook) do
  begin
    FHeaders[htCol] := GetHeaderClass.Create(Self, htCol, DefaultColWidth);
    FHeaders[htRow] := GetHeaderClass.Create(Self, htRow, DefaultRowHeight);
  end;
  FMergedCells := TcxSSMergedCellsStorage.Create;
  FMergedCells.FOwner := Self;
end;

destructor TcxSSDataStorage.Destroy;
begin
  Clear;
  FMergedCells.Free;
  FHeaders[htCol].Free;
  FHeaders[htRow].Free;
  inherited Destroy;
end;

procedure TcxSSDataStorage.Assign(Source: TcxSSDataStorage);
var
  SrcCells, DstCells: PcxSSCellsArray;
  I, J: Integer;
begin
  if Source <> nil then
  begin
    Clear;
    FColCapacityInc := Source.FColCapacityInc;
    FRowCapacityInc := Source.FRowCapacityInc;
    SetCapacity(Source.FCapacity);
    FColsCount := Source.FColsCount;
    FMergedCells.Assign(Source.FMergedCells);
    FSelection := Source.Selection;
    FSelectionState := Source.SelectionState;
    FColsCount := Source.MaxColumn;
    FMaxRow := Source.MaxRow;
    if Source.Listener <> Listener then
      FCaption := Source.FCaption
    else
      FCaption := Source.FCaption + IntToStr(2);
    for I := 0 to FColsCount - 1 do
    begin
      FCols^[I].CellsCount := Source.FCols^[I].CellsCount;
      SrcCells := Source.FCols^[I].Cells;
      DstCells := FCols^[I].Cells;
      for J := 0 to FCols^[I].CellsCount - 1 do
        DstCells^[J] := CloneCell(SrcCells^[J]);
    end;
  end;
end;

function TcxSSDataStorage.CellRect(ALeft, ATop, ACol, ARow: Integer;
                                   IsExtendedRect: Boolean = False): TRect;
  function ExRect(ARect: TRect): TRect;
  var
    ACol, ARow: Integer;
  begin
     FillChar(Result, SizeOf(Result), 0);
     for ACol := ARect.Left to ARect.Right do
       Inc(Result.Right, Headers[htCol][ACol]);
     for ARow := ARect.Top to ARect.Bottom do
       Inc(Result.Bottom, Headers[htRow][ARow]);
  end;

var
  AR: TRect;
begin
  AR := Rect(ACol, ARow, ACol, ARow);
  try
    if IsExtendedRect then
      CheckInMergeRange(Point(ACol, ARow), AR)
  finally
    Result := ExRect(AR);
    OffsetRect(Result,
               TcxSSHeaderAccess(Headers[htCol]).GetLength(ALeft, AR.Left),
               TcxSSHeaderAccess(Headers[htRow]).GetLength(ATop, AR.Top));
  end;
end;

function TcxSSDataStorage.CheckInMergeRange(const APoint: TPoint; var AMergeRange: TRect): Boolean;
begin
  Result := FMergedCells.CheckInMergeRange(APoint, AMergeRange);
  if Result then
    FMergedCells.InflatePoint(AMergeRange.BottomRight, -1, -1);
end;

function TcxSSDataStorage.CheckIntersection(const ARect: TRect; IsHorz: Boolean): Boolean;
var
  AIndex: Integer;
  R, R1: TRect;
begin
  Result := False;
  AIndex := 0;
  if IsHorz then
    R := Rect(ARect.Left, 0, ARect.Right + 1, cxMaxViewCoord)
  else
    R := Rect(0, ARect.Top, cxMaxViewCoord, ARect.Bottom + 1);
  with FMergedCells do
  begin
    while (AIndex < FCount) and not Result do
    begin
      Result := IntersectRect(R1, PRectArray(FData)^[AIndex], R);
      Inc(AIndex);
    end;
  end;
end;

function TcxSSDataStorage.CheckSelectionRect(const ARect: TRect): TRect;
begin
  Result := FMergedCells.CheckSelection(ARect);
end;

procedure TcxSSDataStorage.Clear;
var
  I, J : Integer;
  FStyleCache: TcxSSStyleCache;
begin
  try
    FIsDeleted := True;
    FStyleCache := TcxSSBookAccess(ParentBook).StyleCache;
    try
      for I := 0 to FCapacity.Cx - 1 do
      with FCols^[I] do
      try
        for J := 0 to CellsCount - 1 do
          if Cells^[J] <> nil then
          try
            with Cells^[J]^ do
            begin
              FStyleCache.ReleaseRefCount(FStyleCache.StyleList.IndexOf(StylePtr));
              if DataType = dtFunction then
                TcxSSBookAccess(ParentBook).FormulasCache.DestroyFunction(FuncRecPtr);
            end;
          finally
            Dispose(PcxSSCellRec(Cells^[J]));
          end;
      finally
        FreeMem(Cells, FCapacity.Cy * SizeOf(Pointer));
      end;
    finally
      FreeMem(FCols, FCapacity.Cx * SizeOf(TcxSSColumn));
    end;
  finally
    FIsDeleted := False;
    FCols := nil;
    FColsCount := 0;
    FMaxRow := 0;
    FillChar(FCapacity, SizeOf(FCapacity), 0);
    FMergedCells.Clear;
  end;
end;

procedure TcxSSDataStorage.ClearCells(ARect: TRect;
  SetDefaultStyle: Boolean = False);
var
  I, J: Integer;
  FStyleCache: TcxSSStyleCache;
  FFormulasCache: TcxSSFormulasCache;
  ACanClear, IsClearAll: Boolean;
  Action: TcxComplexAction;

  function LockedCell: Boolean;
  begin
    Result := cReadOnly in FCols^[I].Cells^[J].StylePtr.CellState;
  end;

begin
  if not FIsDeleted then
  begin
    ACanClear := True;
    TcxSSListenerAccess(Listener).OnClearCells(Owner as TcxSSBookSheet, ARect, SetDefaultStyle, ACanClear);
    if not ACanClear then Exit;
  end;
  IsClearAll := EqualRect(Rect(-1, -1, -1, -1), ARect);
  if IsClearAll then
    ARect := Rect(0, 0, FColsCount, FMaxRow);
  TcxSSListenerAccess(Listener).BeginUpdate;
  if SetDefaultStyle then
    FMergedCells.CheckAfterClear(ARect);
  FStyleCache := TcxSSBookAccess(ParentBook).StyleCache;
  FFormulasCache := TcxSSBookAccess(ParentBook).FormulasCache;
  TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).AddComplexAction(TcxComplexAction, cxGetResourceString(@scxChangeDeleteCells), Action);
  try
    for I := ARect.Left to ARect.Right do
      if I >= MaxColumn then
        Break
      else
      begin
        for J := ARect.Top to ARect.Bottom do
          if J >= RowCount[I] then
            Break
          else
          begin
            if (I < 0) or (J < 0) or (FCols^[I].Cells^[J] = nil) then
                Continue
            else
            begin
              if LockedCell then Exit;
              if not FIsDeleted then
                AddCellToHistory(I, J);
              with FCols^[I].Cells^[J]^ do
              begin
                if (StylePtr <> FStyleCache.StyleList[0]) and SetDefaultStyle then
                begin
                  if StylePtr <> FStyleCache.StyleList[0] then
                    FStyleCache.ReleaseRefCount(FStyleCache.StyleList.IndexOf(StylePtr));
                  StylePtr := FStyleCache.StyleList[0];
                  Inc(StylePtr^.RefCount);
                end;
                case DataType of
                  dtFunction:
                  begin
                    FFormulasCache.DestroyFunction(FuncRecPtr);
                    FuncRecPtr := nil;
                  end;
                  dtControl:
                    Control.Free;
                end;
                DateTime := 0;
                DataType := dtText;
                Text := '';
              end;
            end;
          end;
      end;
    if SetDefaultStyle then
      for I := ARect.Left to ARect.Right do
      begin
        if I >= MaxColumn then
          Break
        else
          for J := ARect.Top to ARect.Bottom do
          begin
            if J >= FCols^[I].CellsCount then
              Continue
            else
              if FCols^[I].Cells^[J] <> nil then
              begin
                if LockedCell then Exit;
                Dispose(PcxSSCellRec(FCols^[I].Cells^[J]));
                FCols^[I].Cells^[J] := nil;
              end;
          end;
      end;
  finally
    if Action <> nil then
      TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).StopComplexAction;
    TcxSSListenerAccess(Listener).EndUpdate;
    TcxSSListenerAccess(Listener).UpdateAfterChanged(Owner as TcxSSBookSheet, ARect);
    if IsClearAll then Clear;
  end;
end;

procedure TcxSSDataStorage.CopyCells(const ADestCol, ASourceCol: Integer;
  AFromRow, AToRow, ACount: Integer; IsClearSource: Boolean = True);
var
  ADstColPtr, ASrcColPtr: PcxSSColumn;
begin
  if (ASourceCol >=  FColsCount) then Exit;
  if (AFromRow + ACount) >=  FCols^[ASourceCol].CellsCount then
    ACount := FCols^[ASourceCol].CellsCount - AFromRow;
  if ACount <= 0 then Exit;
  if ADestCol >= FCapacity.Cx then
    SetCapacity(TSize(Point(ADestCol + FColCapacityInc, FCapacity.Cy)));
  if ADestCol >= FColsCount then
    FColsCount := ADestCol + 1;
  ADstColPtr := @FCols^[ADestCol];
  ASrcColPtr := @FCols^[ASourceCol];
  if (AToRow + ACount) >= FCapacity.Cy then
    SetCapacity(TSize(Point(FCapacity.Cx, AToRow + ACount + FRowCapacityInc)));
  if (AToRow + ACount) >= ADstColPtr^.CellsCount then
    ADstColPtr^.CellsCount := AToRow + ACount;
  Move(ASrcColPtr^.Cells^[AFromRow],
       ADstColPtr^.Cells^[AToRow], ACount * SizeOf(Pointer));
  if IsClearSource then
    FillChar(ASrcColPtr^.Cells[AFromRow], ACount * SizeOf(Pointer), 0);
end;

function TcxSSDataStorage.CreateAccessCellObject(ACol, ARow: Integer): TObject;
begin
  Result := TcxSSCellObject.Create(Self, ACol, ARow);
end;

procedure TcxSSDataStorage.DeleteCells(ACells: TRect; ACellsModify: TcxSSCellsModify);

  procedure DeleteAndShiftColumn(ACells: TRect);
  var
    I, J: Integer;
    ALen: Integer;
  begin
    ALen := ACells.Right - ACells.Left + 1;
    for I := ACells.Right + 1 to FColsCount - 1 do
      for J := ACells.Top to ACells.Bottom do
        if (J < FCols^[I].CellsCount) and (FCols^[I].Cells^[J] <> nil) then
        begin
          SetCellRec(I - ALen, J, FCols^[I].Cells^[J]^);
          Dispose(FCols^[I].Cells^[J]);
          FCols^[I].Cells^[J] := nil;
        end
        else
          Continue;
  end;

  procedure DeleteAndShiftRow(ACells: TRect);
  var
    I: Integer;
    ALen: Integer;
  begin
    ALen := ACells.Bottom - ACells.Top + 1;
    for I := ACells.Left to ACells.Right do
      if I >= FColsCount then
        Break
    else
      if ACells.Top < FCols^[I].CellsCount then
      begin
         Move(FCols^[I].Cells^[ACells.Bottom + 1], FCols^[I].Cells^[ACells.Top],
                   (FCols^[I].CellsCount - ACells.Bottom - 1) * SizeOf(Pointer));
         Dec(FCols^[I].CellsCount, ALen);
         FillChar(Pointer(@FCols^[I].Cells^[FCols^[I].CellsCount])^, ALen * SizeOf(Pointer), 0)
      end;
  end;

  procedure DeleteAllColRow(ACellRect: TRect; AllowCol: Boolean);
  var
    I, J: Integer;
    ALen: Integer;
  begin
    with ACellRect do
    begin
      if AllowCol then
      begin
        for J := Left to Right do
          TcxSSHeaderAccess(Headers[htCol]).DeleteAt(Left);
        J := Right;
        for I := Left to FColsCount - 1 do
        begin
          Inc(J);
          if J < FColsCount then
          begin
            FCols^[I].CellsCount := FCols^[J].CellsCount;
            Move(FCols^[J].Cells^, FCols^[I].Cells^, FCapacity.Cy * SizeOf(Pointer));
            FillChar(FCols^[J].Cells^, FCapacity.Cy * SizeOf(Pointer), 0);
            FCols^[J].CellsCount := 0;
          end
          else
            if I < FCapacity.Cx then
            begin
              FCols^[I].CellsCount := 0;
              FillChar(FCols^[I].Cells^, FCapacity.Cy * SizeOf(Pointer), 0);
            end;
        end;
      end
      else
      begin
        for J := Top to Bottom do
          TcxSSHeaderAccess(Headers[htRow]).DeleteAt(Top);
        for I := 0 to FColsCount - 1 do
        with FCols^[I] do
        begin
          if Top < FCols^[I].CellsCount then
          begin
            ALen := (CellsCount - 1) - Bottom;
            if CellsCount > Bottom then
            begin
              Move(Cells^[Bottom + 1], Cells^[Top], ALen * SizeOf(Pointer));
              Dec(CellsCount, (Bottom - Top) + 1);
              FillChar(Cells^[CellsCount], (FCapacity.CY - CellsCount) * SizeOf(Pointer), 0);
            end
            else
              FCols^[I].CellsCount := Top;
          end;
        end;
      end;
    end;
  end;

var
  ACellRect: TRect;
  Action: TcxDeleteCellsAction;
begin
  SetModified;
  ACells := Rect(Max(0, ACells.Left), Max(0, ACells.Top),
    ACells.Right, ACells.Bottom);
  ACellRect := ACells;
  if ACellsModify = msAllRow then
  begin
    ACellRect.Left := 0;
    ACellRect.Right := Max(0, MaxColumn - 1);
  end
  else
    if ACellsModify = msAllCol then
    begin
      ACellRect.Top := 0;
      ACellRect.Bottom := Max(0, MaxRow - 1);
    end;

  if (ACellsModify in [msShiftCol, msShiftRow]) then
  begin
    if CheckIntersection(ACellRect, ACellsModify = msShiftRow) then
      raise ESpreadSheetError.Create(cxGetResourceString(@scxSpreadSheetMergeCellError2));
  end;
  FIsDeleted := True;
  if TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).AddAction(TcxDeleteCellsAction, Action) then
    Action.BeforeAction(Owner, ACellRect, ACellsModify);
  TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).BeginUpdate;
  try
    ClearCells(ACellRect, True);
  finally
    FIsDeleted := False;
    case ACellsModify of
      msShiftCol:
        DeleteAndShiftColumn(ACells);
      msShiftRow:
        DeleteAndShiftRow(ACells);
      msAllRow:
        DeleteAllColRow(ACells, False);
      msAllCol:
        DeleteAllColRow(ACells, True);
    end;
    if not (ACellsModify in [msShiftCol, msShiftRow]) then
    try
      FMergedCells.InflatePoint(ACells.BottomRight, 1, 1);
      FMergedCells.UpdateOnDeleteCells(ACells, ACellsModify);
    finally
      FMergedCells.InflatePoint(ACells.BottomRight, -1, -1);
    end;
    TcxSSBookAccess(ParentBook).UpdateScrollBars;
    TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).EndUpdate;
  end;
end;

function TcxSSDataStorage.HasCell(ACol, ARow: Integer): Boolean;
begin
  Result := (ACol < FColsCount) and (ARow < FCols^[ACol].CellsCount) and
    (FCols^[ACol].Cells^[ARow] <> nil);
end;

procedure TcxSSDataStorage.InsertCells(ACells: TRect; ACellsModify: TcxSSCellsModify);

  procedure InsertAndShiftColumn(ACells: TRect);
  var
    I, J: Integer;
    ALen: Integer;
  begin
    ALen := ACells.Right - ACells.Left + 1;
    for I := FColsCount - 1 downto ACells.Left do
      for J := ACells.Top to ACells.Bottom do
      if (FCols^[I].CellsCount > J) and (FCols^[I].Cells^[J] <> nil) then
      begin
        SetCellRec(I + ALen, J, FCols^[I].Cells^[J]^);
        Dispose(FCols^[I].Cells^[J]);
        FCols^[I].Cells^[J] := nil;
      end;
  end;

  procedure InsertAndShiftRow(ACells: TRect);
  var
    I, J: Integer;
    ALen: Integer;
  begin
    ALen := ACells.Bottom - ACells.Top + 1;
    for I := ACells.Left to ACells.Right do
      if I >= FColsCount then
        Break
    else
      if ACells.Top < FCols^[I].CellsCount then
      begin
        if (FCols^[I].CellsCount + ALen) >= FCapacity.Cy then
          SetCapacity(TSize(Point(FCapacity.Cx, FCols^[I].CellsCount + ALen + FRowCapacityInc)));
        Move(FCols^[I].Cells^[ACells.Top], FCols^[I].Cells^[ACells.Bottom + 1],
         (FCols^[I].CellsCount - ACells.Top) * SizeOf(Pointer));
        Inc(FCols^[I].CellsCount, ALen);
        FillChar(FCols^[I].Cells^[ACells.Top], SizeOf(Pointer) * ALen, 0);
        if FCols^[I].CellsCount > FMaxRow then
          FMaxRow := FCols^[I].CellsCount;
        for J := 0 to FCols^[I].CellsCount - 1 do
          if (FCols^[I].Cells^[J] <> nil) and (FCols^[I].Cells^[J]^.DataType = dtFunction) then
            FCols^[I].Cells^[J]^.FuncRecPtr^.Row := J;
      end;
  end;

  procedure InsertAllColRow(ACellRect: TRect; AllowCol: Boolean);
  var
    I: Integer;
  begin
    if AllowCol then
    begin
      ACellRect.Top := 0;
      ACellRect.Bottom := MaxRow - 1;
      InsertAndShiftColumn(ACellRect);
      for I := ACellRect.Left to ACellRect.Right do
        TcxSSHeaderAccess(Headers[htCol]).InsertAt(ACellRect.Left, Headers[htCol].DefaultSize, True);
    end
    else
    begin
      ACellRect.Left := 0;
      ACellRect.Right := FCapacity.cx;
      InsertAndShiftRow(ACellRect);
      for I := ACellRect.Top to ACellRect.Bottom do
        TcxSSHeaderAccess(Headers[htRow]).InsertAt(ACellRect.Top, Headers[htRow].DefaultSize, True);
    end;
  end;

var
  ACellRect: TRect;
  Action: TcxInsertCellsAction;

begin
  SetModified;
  ACells := Rect(Max(0, ACells.Left), Max(0, ACells.Top),
                 ACells.Right, ACells.Bottom);
  ACellRect := ACells;
  if (ACellsModify in [msShiftCol, msShiftRow]) then
  begin
    if CheckIntersection(ACells, ACellsModify = msShiftRow) then
      raise ESpreadSheetError.Create(cxGetResourceString(@scxSpreadSheetMergeCellError2));
  end;
  if TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).AddAction(TcxInsertCellsAction, Action) then
    Action.BeforeAction(Owner, ACells, ACellsModify);
  TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).BeginUpdate;
  try
    case ACellsModify of
      msShiftCol:
        InsertAndShiftColumn(ACells);
      msShiftRow:
        InsertAndShiftRow(ACells);
      msAllRow:
        InsertAllColRow(ACells, False);
      msAllCol:
        InsertAllColRow(ACells, True);
    end;
    if not (ACellsModify in [msShiftCol, msShiftRow]) then
    try
      FMergedCells.InflatePoint(ACells.BottomRight, 1, 1);
      FMergedCells.UpdateOnInsertCells(ACells, ACellsModify);
    finally
      FMergedCells.InflatePoint(ACells.BottomRight, -1, -1);
    end;
    TcxSSBookAccess(ParentBook).UpdateScrollBars;
  finally
    TcxHistoryAccess(TcxSSBookSheetAccess(FOwnerSheet).History).EndUpdate;
  end;
end;

function TcxSSDataStorage.IsMerge(ACol, ARow: Integer): Boolean;
begin
  with TcxSSCellStyleAccess(GetCellStyle(ACol, ARow)) do
  begin
    Result := Merge;
    Free;
  end;
end;

function TcxSSDataStorage.GetContentColCount: Integer;
var
  I, J: Integer;
begin
  Result := 0;
  I := 0;
  while I < FCapacity.cx do
  begin
    J := 0;
    while J < FCapacity.cy do
    begin
      if not CellIsEmpty(I, J) then
      begin
        Result := I + 1;
        Break;
      end;
      Inc(J);
    end;
    Inc(I);
  end;
end;

function TcxSSDataStorage.GetContentRowCount: Integer;
var
  I, J: Integer;
begin
  Result := 0;
  J := 0;
  while J < FCapacity.cy do
  begin
    I := 0;
    while I < FCapacity.cx do
    begin
      if not CellIsEmpty(I, J) then
      begin
        Result := J + 1;
        Break;
      end;
      Inc(I);
    end;
    Inc(J);
  end;
end;

procedure TcxSSDataStorage.MergeUnMerge(const ARect: TRect; AIsMerge: Boolean);
begin
   TcxSSListenerAccess(Listener).OnMergeCells(TcxSSBookSheet(Owner), ARect, AIsMerge, AIsMerge);
   TcxSSBookAccess(ParentBook).BeginUpdate;
   try
     FMergedCells.SetMergeStyle(ARect, AIsMerge);
   finally
     TcxSSBookAccess(ParentBook).EndUpdate;
   end;
end;

procedure TcxSSDataStorage.SetCapacity(const ASize: TSize);
var
  I: Integer;
  DX, DY: Integer;
begin
  DX := ASize.Cx - FCapacity.Cx;
  DY := ASize.Cy - FCapacity.Cy;
  if DX > 0 then
  begin
    ReallocMem(Pointer(FCols), ASize.Cx * SizeOf(TcxSSColumn));
    FillChar(FCols^[FCapacity.Cx], DX * SizeOf(TcxSSColumn), 0);
    for I := FCapacity.Cx to ASize.Cx - 1 do
         FCols^[I].Cells := AllocMem(ASize.Cy * SizeOf(Pointer));
  end;
  if DY > 0 then
  begin
    for I := 0 to FCapacity.Cx - 1 do
    begin
      ReallocMem(Pointer(FCols^[I].Cells), ASize.Cy * SizeOf(Pointer));
      FillChar(FCols^[I].Cells^[FCapacity.Cy], DY * SizeOf(Pointer), 0);
    end;
    FCapacity.Cy := ASize.Cy
  end;
  FCapacity.Cx := ASize.Cx;
end;

procedure TcxSSDataStorage.Sort(const ARect: TRect; const ASortTypes: array of TcxSortType);
var
  CurrentSortOrder: TcxSortType;

  procedure SwapRecords(const ARow1, ARow2, ALeft, ARight: Integer);

    procedure SetRec(const ACol, ARow: Integer; ARec: TcxSSCellRec);
    begin
      if ARec.DataType = dtFunction then
      begin
        ARec.FuncRecPtr^.Col := ACol;
        ARec.FuncRecPtr^.Row := ARow;
        ARec.Text := TcxSSBookAccess(ParentBook).FormulasCache.FuncHandler.TokensToString(ARec.FuncRecPtr);
      end;
      SetCellRec(ACol, ARow, ARec);
    end;

  var
    ACellRec: TcxSSCellRec;
    AColIndex: Integer;
  begin
    if ARow1 = ARow2 then Exit;
    for AColIndex := ALeft to ARight do
    begin
      ACellRec := GetCellRec(AColIndex, ARow1);
      SetRec(AColIndex, ARow1, GetCellRec(AColIndex, ARow2));
      SetRec(AColIndex, ARow2, ACellRec);
    end;
  end;

  procedure QuickSort(L, H: Integer);
  var
    I, J, M: Integer;
    MValue: TcxSSCellRec;
  begin
    repeat
      I := L;
      J := H;
      M := (L + H) div 2;
      repeat
        MValue := GetCellRec(ARect.Left, M);
        if CurrentSortOrder = stAscending then
        begin
          while CellCompare(GetCellRec(ARect.Left, I), MValue) < 0 do Inc(I);
          while CellCompare(GetCellRec(ARect.Left, J), MValue) > 0 do Dec(J);
        end
        else
        begin
          while CellCompare(GetCellRec(ARect.Left, I), MValue) > 0 do Inc(I);
          while CellCompare(GetCellRec(ARect.Left, J), MValue) < 0 do Dec(J);
        end;
        if I <= J then
        begin
          SwapRecords(I, J, ARect.Left, ARect.Right);
          if M = I then
            M := J
          else
            if M = J then
              M := I;
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if L < J then
        QuickSort(L, J);
      L := I;
    until I >= H;
  end;

var
  I: Integer;
  R: TRect; 
  V: TcxSSCellRec;
  ASortOrders: array of TcxSortType;
begin
  if (Min(ARect.Right - ARect.Left, Length(ASortTypes) - 1) < 0) or ((ARect.Bottom - ARect.Top) < 1) then Exit;
  CurrentSortOrder := ASortTypes[0];
  QuickSort(ARect.Top, ARect.Bottom);
  if Length(ASortTypes) = 1 then Exit;
  SetLength(ASortOrders, Length(ASortTypes) - 1);
  Move(ASortTypes[1], ASortOrders[0], Length(ASortOrders));
  R := ARect;
  Inc(R.Left); 
  repeat
    I := R.Top;
    V := GetCellRec(ARect.Left, I);
    while (I < ARect.Bottom) and (CellCompare(GetCellRec(ARect.Left, I + 1), V) = 0) do Inc(I);
    R.Bottom := I;
    if R.Top <> R.Bottom then
      Sort(R, ASortOrders);
    R.Top := I + 1;
    R.Bottom := ARect.Bottom;
  until R.Top >= R.Bottom;
  SetLength(ASortOrders, 0);
end;

function TcxSSDataStorage.GetCellRec(ACol, ARow: Integer): TcxSSCellRec;
var
  R: TRect;
begin
  if (ACol >= 0) and (ARow >= 0)and (ACol < FColsCount) and
     (ARow < FCols^[ACol].CellsCount) and (FCols^[ACol].Cells^[ARow] <> nil) then
    Result := FCols^[ACol].Cells^[ARow]^
  else
  begin
    Result := FDefaultCellRec;
    if MergedCells.Count > 0 then
    begin
      if MergedCells.CheckInMergeRange(Point(ACol, ARow), R) and ((R.Left <> ACol) or (R.Top <> ARow)) then
        Result := GetCellRec(R.Left, R.Top);
    end; 
  end;
end;

function TcxSSDataStorage.GetMultiSelection: Boolean;
begin
  Result := not (ssCurrentSelect = FSelectionState);
end;

function TcxSSDataStorage.CellCompare(const ACell1, ACell2: TcxSSCellRec): SmallInt;

  function GetResult(ACondition1, ACondition2: Boolean): SmallInt;
  const
    AResValue: array[Boolean] of SmallInt = (-1, 1);

  begin
    if ACondition1 then
      Result := 0
    else
      Result := AResValue[not ACondition2];
  end;

  function GetCellValue(const ACell: TcxSSCellRec): string;
  var
    AColor: Word;
  begin
    with ACell do
    begin
      if DataType = dtDateTime then
        Result := FloatToStr(DateTime)
      else
        if DataType = dtFunction then
          Result := TcxSSBookAccess(ParentBook).FormulasCache.FuncRecToDisplayText(FuncRecPtr, AColor)
        else
          Result := Text;
    end;
  end;

var
  AF1, AF2: Double;
  AB1, AB2: Boolean;
  S1, S2: string;
begin
  S1 := GetCellValue(ACell1);
  S2 := GetCellValue(ACell2);
  if S1 = S2 then
    Result := 0
  else
  begin
    if S1 = '' then
      Result := -1
    else
    begin
      if S2 = '' then
        Result := 1
      else
      begin
        if cxTryStrToFloat(S1, AF1)and cxTryStrToFloat(S2, AF2) then
            Result := GetResult(AF1 = AF2, AF1 < AF2)
        else
          if cxTryStrToBool(S1, AB1) and cxTryStrToBool(S2, AB2) then
            Result := GetResult(AB1 = AB2, AB1 < AB2)
          else
            Result := AnsiCompareText(S1, S2);
      end;
    end;
  end;
end;

procedure TcxSSDataStorage.AddCellToHistory(const ACol, ARow: Integer);
var
  Action: TcxChangeDataAction;
begin
  if TcxHistoryAccess(TcxSSBookAccess(ParentBook).History).AddAction(TcxChangeDataAction, Action) then
    Action.BeforeAction(Owner, Rect(ACol, ARow, ACol, ARow));
end;

function TcxSSDataStorage.CellIsEmpty(ACol, ARow: Integer): Boolean;
var
  ACell: TcxSSCellRec;
  AStyle: PcxSSCellStyleRec;
begin
  ACell := GetCellRec(ACol, ARow);
  Result := CompareMem(@ACell, @FDefaultCellRec, SizeOf(TcxSSCellRec));
  if not Result then
  begin
    AStyle := FDefaultCellRec.StylePtr;
    with ACell.StylePtr^ do
    begin
      Result := (BrushStyle = AStyle^.BrushStyle) and
        (BrushBkColor = AStyle^.BrushBkColor) and
          (BrushFgColor = AStyle^.BrushFgColor) and
            CompareMem(@Borders, @AStyle^.Borders, SizeOf(Borders));
    end;
    Result := Result and (ACell.Text = '') and (ACell.DateTime = 0);
  end;
end;

function TcxSSDataStorage.CloneCell(ACell: PcxSSCellRec): PcxSSCellRec;
begin
  if ACell <> nil then
  begin
    New(Result);
    Result^ := ACell^;
    if Result^.DataType = dtFunction then
    begin
      Result^.FuncRecPtr := TcxSSBookAccess(ParentBook).
        FormulasCache.Clone(Result^.FuncRecPtr);
      Result^.FuncRecPtr^.Page := TcxSSBookSheetAccess(Owner).PageIndex;
    end;
    if Result^.StylePtr <> nil then
      Result^.StylePtr := TcxSSBookAccess(ParentBook).StyleCache.Clone(Result^.StylePtr);
  end
  else
    Result := nil;
end;

function TcxSSDataStorage.CompareCells(const ACell1, ACell2: TcxSSCellRec): Boolean;
begin
  Result := (ACell1.Text = ACell2.Text) and (ACell1.StylePtr = ACell2.StylePtr) and
    (ACell1.DataType = ACell2.DataType) and (ACell1.DateTime = ACell2.DateTime);
end;

function TcxSSDataStorage.IsLoading: Boolean;
begin
  Result := TcxSSBookAccess(ParentBook).IsLoaded;
end;

function TcxSSDataStorage.IsValidCell(ACol, ARow: Integer): Boolean;
begin
  if IsLoading and FDimensionAssigned then
    Result := {(ACol <= (Dimension.cx)) and }ARow <= Dimension.cy
  else
    Result := True;
end;

procedure TcxSSDataStorage.SetCellRec(ACol, ARow: Integer; const Value: TcxSSCellRec);
var
  AMaxCol, AMaxRow: Integer;
begin
  if not IsValidCell(ACol, ARow) then Exit;
  if (CompareCells(Value, GetCellRec(ACol, ARow)) and not (cMerge in Value.StylePtr^.CellState))
     or (ACol < 0) or (ARow < 0) then Exit;
  try
    SetModified;
    AddCellToHistory(ACol, ARow);
    AMaxCol := FColsCount;
    AMaxRow := FMaxRow;
    if ACol >= FColsCount then
      AMaxCol := ACol + 1;
    if ARow >= FMaxRow then
      AMaxRow := ARow + 1;
    if ACol >= FCapacity.Cx then
      SetCapacity(TSize(Point(ACol + FColCapacityInc, FCapacity.Cy)));
    if ARow >= FCapacity.Cy then
      SetCapacity(TSize(Point(FCapacity.Cx, ARow + FRowCapacityInc)));
    if FCols^[ACol].Cells^[ARow] = nil then
      New(FCols^[ACol].Cells^[ARow]);
    FCols^[ACol].Cells^[ARow]^ := Value;
    if FCols^[ACol].CellsCount <= ARow then
      FCols^[ACol].CellsCount := ARow + 1;
    if AMaxCol <> FColsCount then
    begin
      TcxSSListenerAccess(Listener).OnResizeDataLength(Owner as TcxSSBookSheet, htCol);
      FColsCount := AMaxCol;
    end;
    if AMaxRow <> FMaxRow then
    begin
      TcxSSListenerAccess(Listener).OnResizeDataLength(Owner as TcxSSBookSheet, htRow);
      FMaxRow := AMaxRow;
    end;
  finally
    TcxSSListenerAccess(Listener).OnChangeCellData(Owner as TcxSSBookSheet, ACol, ARow);
  end;
end;

procedure TcxSSDataStorage.SetCurrentCol(const Value: Integer);
var
  ASelRect: TRect;
  FCol: Integer;
  ACanSelect: Boolean;
begin
  ACanSelect := True;
  TcxSSListenerAccess(Listener).OnActiveCellChanging(Owner as TcxSSBookSheet,
    Point(Value, Row), ACanSelect);
  if ACanSelect then
  begin
    FCol := Col;
    if (FCol = Value) or (Value < 0) then Exit;
    if not CheckInMergeRange(Point(Value, Row), ASelRect) then
    begin
      if FCol < Value then
         FCol := TcxSSHeaderAccess(Headers[htCol]).GetNextItem(Value - 1 ,  FCol < Value)
       else
         FCol := TcxSSHeaderAccess(Headers[htCol]).GetNextItem(Value + 1 ,  FCol < Value);
      ASelRect := Rect(FCol, Row, FCol, Row);
    end;
    SetSelectionRect(ASelRect);
  end;
end;

procedure TcxSSDataStorage.SetCurrentRow(const Value: Integer);
var
  ASelRect: TRect;
  FRow: Integer;
  ACanSelect: Boolean;
begin
  ACanSelect := True;
  TcxSSListenerAccess(Listener).OnActiveCellChanging(Owner as TcxSSBookSheet,
    Point(Col, Value), ACanSelect);
  if ACanSelect then
  begin
    FRow := Row;
    if (FRow = Value) or (Value < 0) then Exit;
    FRow := Value;
    if not CheckInMergeRange(Point(Col, Value), ASelRect) then
    begin
      if FRow > Value then
        FRow := TcxSSHeaderAccess(Headers[htRow]).GetNextItem(Value - 1 ,  FRow < Value)
      else
        FRow := TcxSSHeaderAccess(Headers[htRow]).GetNextItem(Value + 1 ,  FRow < Value);
      ASelRect := Rect(Col, FRow, Col, FRow);
    end;
    SetSelectionRect(ASelRect);
  end;
end;

function TcxSSDataStorage.GetCellStyle(ACol, ARow: Integer): TcxSSCellStyle;
begin
  Result := TcxSSCellStyle.Create(TcxSSBookAccess(ParentBook).StyleCache, Self, ACol, ARow);
end;

function TcxSSDataStorage.GetCellDataType(ACol, ARow: Integer): TcxSSDataType;
begin
  Result := GetCellRec(ACol, ARow).DataType;
end;

function TcxSSDataStorage.GetCellDateTime(ACol, ARow: Integer): TDateTime;
begin
  Result := GetCellRec(ACol, ARow).DateTime;
end;

function TcxSSDataStorage.GetCellFormulaPtr(ACol, ARow: Integer): PcxSSFuncRec;
begin
  Result := GetCellRec(ACol, ARow).FuncRecPtr;
end;

function TcxSSDataStorage.GetCellStylePtr(ACol, ARow: Integer): PcxSSCellStyleRec;
begin
  Result := GetCellRec(ACol, ARow).StylePtr;
end;

function TcxSSDataStorage.GetCellText(ACol, ARow: Integer): string;
var
  F: Double;
  AColor: Word;
  R: TcxSSCellRec;
begin
  R := GetCellRec(ACol, ARow);
  with R do
  begin
    if (StylePtr^.FormatIndex in DateTimeFormats) and cxTryStrToFloat(Text, R.DateTime) then
    begin
      Result := TcxSSUtils.FormatText(DateTime, StylePtr^.FormatIndex, 0, AColor)
{      else
        Result := FormatDateTime(ShortDateFormat, DateTime) + ' ' +
          FormatDateTime(ShortTimeFormat, DateTime)}
    end
    else
    begin
      if DataType = dtFunction then
      begin
        if FuncRecPtr <> nil then
          Result := TcxSSBookAccess(ParentBook).FormulasCache.FuncHandler.TokensToString(FuncRecPtr)
        else
          Result := Text;
      end
      else
        if (StylePtr^.FormatIndex in [$9, $A]) and cxTryStrToFloat(Text, F) then
          Result := FloatToStr(F * 100) + '%'  
        else
          Result := Text;
    end; 
  end;
end;

function TcxSSDataStorage.GetCurrentCol: Integer;
begin
  Result := FSelection.Left;
end;

function TcxSSDataStorage.GetCurrentRow: Integer;
begin
  Result := FSelection.Top;
end;

function TcxSSDataStorage.GetCurrentPage: Word;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to TcxSSBookAccess(ParentBook).PageCount - 1 do
    if TcxSSBookAccess(ParentBook).Pages[I] = Owner then
    begin
      Result := I;
      Break;
    end;
end;

function TcxSSDataStorage.GetHeaders(AType: TcxSSHeaderType): TcxSSHeader;
begin
  Result := FHeaders[AType];
end;

function TcxSSDataStorage.GetListener: TObject;
begin
  Result := TcxSSBookAccess(ParentBook).Listener;
end;

function TcxSSDataStorage.GetParentBook: TObject;
begin
  Result := TcxSSBookSheetAccess(Owner).Owner;
end;

function TcxSSDataStorage.GetRowCount(ACol: Integer): Integer;
begin
  if Assigned(FCols) and (ACol < FColsCount) then
    Result := FCols^[ACol].CellsCount
  else
    Result := 0;
end;

function TcxSSDataStorage.GetSelection: TRect;
begin
  Result := FSelection;
end;

function TcxSSDataStorage.GetMergedCellsRange: TcxSSRectsArray;
begin
  Result := MergedCells.Rects;
end;

procedure TcxSSDataStorage.SetModified;
begin
  TcxSSBookAccess(ParentBook).SetModified;
end;

procedure TcxSSDataStorage.SetCellTextEx(ACol, ARow: Integer;
  const Value: string; IsFormula: Boolean = False; Analyze: Boolean = True);

  function IsFormulaStr(Value: string): Boolean;
  var
    APos: Integer;
  begin
    Value := Trim(Value);
    Result := (Length(Value) > 1) and (Pos('=', Value) = 1);
    APos := Pos('#', Value);
    if Result and (APos > 0) then
    begin
      while APos > 0 do
      begin
        if Value[APos] = '"' then
          Exit;
        Dec(APos);
      end;
      Result := False; 
    end;
  end;

var
  ACellRec: TcxSSCellRec;
  F: Double;
begin
  if not IsValidCell(ACol, ARow) then Exit;
  ACellRec := GetCellRec(ACol, ARow);
  with ACellRec do
  begin
    Text := Value;
    if IsFormula or (Analyze and IsFormulaStr(Value) and (ACellRec.StylePtr^.FormatIndex <> $31)) then
    begin
      SetCellRec(ACol, ARow, ACellRec);
      if (DataType = dtFunction) then
      begin
        TcxSSBookAccess(ParentBook).FormulasCache.DestroyFunction(FuncRecPtr);
        DataType := dtText;
        FuncRecPtr := nil;
        SetCellRec(ACol, ARow, ACellRec);
        DateTime := 0;
      end;
      TcxSSBookAccess(ParentBook).FormulasCache.AddFunction(Self, ACol, ARow);
    end
    else
    begin
      if DataType = dtFunction then
      begin
        TcxSSBookAccess(ParentBook).FormulasCache.DestroyFunction(FuncRecPtr);
        FuncRecPtr := nil;
      end;
      DateTime := 0;
      if (StylePtr^.FormatIndex in [$9, $A]) and (Pos('%', Value) <> 0) then
      begin
        Delete(Text, Pos('%', Value), 1);
        if not cxTryStrToFloat(Text, F) then
          Text := Value
        else
          Text := FloatToStr(F / 100);
      end;
      DataType := dtText;
      SetCellRec(ACol, ARow, ACellRec);
    end;
  end;
end;

procedure TcxSSDataStorage.SetCellText(ACol, ARow: Integer; const Value: string);
begin
  SetCellTextEx(ACol, ARow, Value);
end;

procedure TcxSSDataStorage.SetCellDateTime(ACol, ARow: Integer; const Value: TDateTime);
var
  ACellRec: TcxSSCellRec;
begin
  ACellRec := GetCellRec(ACol, ARow);
  if ACellRec.DataType = dtFunction then
    TcxSSBookAccess(ParentBook).FormulasCache.DestroyFunction(ACellRec.FuncRecPtr);
  with ACellRec do
  begin
    Text := FloatToStr(Value);
    DateTime := Value;
    DataType := dtDateTime;
  end;
  SetCellRec(ACol, ARow, ACellRec);
end;

procedure TcxSSDataStorage.SetCellFormulaPtr(ACol, ARow: Integer; const Value: PcxSSFuncRec);
var
  ACellRec: TcxSSCellRec;
begin
  ACellRec := GetCellRec(ACol, ARow);
  ACellRec.FuncRecPtr := Value;
  ACellRec.DataType := dtFunction;
  SetCellRec(ACol, ARow, ACellRec);
end;

procedure TcxSSDataStorage.SetCellStylePtr(ACol, ARow: Integer; const Value: PcxSSCellStyleRec);
var
  ACellRec: TcxSSCellRec;
begin
  ACellRec := GetCellRec(ACol, ARow);
  ACellRec.StylePtr := Value;
  SetCellRec(ACol, ARow, ACellRec);
end;

procedure TcxSSDataStorage.SetSelectionRect(const ARect: TRect);

  function CheckSelectionState: TcxSSSelectionState;
  var
    ARect, AMergeRect: TRect;
  begin
    ARect := FSelection;
    Result := ssMultiSelect;
    if (ARect.Left = ARect.Right) and (ARect.Top = ARect.Bottom) then
      Result := ssCurrentSelect
    else
      if CheckInMergeRange(ARect.TopLeft, AMergeRect) and
         EqualRect(AMergeRect, ARect) then
        Result := ssMergeSelect;
  end;

var
  AOldR, ANewR: TRect;
  CanSelect: Boolean;

begin
  if not EqualRect(ARect, FSelection) then
  begin
    ANewR := CheckSelectionRect(ARect);
    if not EqualRect(FSelection, ANewR) then
    begin
      CanSelect := True;
      if ((ANewR.Left <> Col) or (ANewR.Top <> Row)) and  not FIsSetSelecton then
      try
        FIsSetSelecton := True;
        TcxSSListenerAccess(Listener).OnActiveCellChanging(Owner as TcxSSBookSheet,
          Point(ANewR.Left, ANewR.Top), CanSelect);
      finally
        FIsSetSelecton := False
      end;
      if CanSelect then
      begin
        AOldR := FSelection;
        FSelection := ANewR;
        if not FIsSetSelecton then
        try
          TcxSSListenerAccess(Listener).OnChangeSelection(Owner as TcxSSBookSheet, AOldR, ANewR);
        finally
          FIsSetSelecton := False
        end;
        FSelectionState := CheckSelectionState;
      end;
    end;
  end;
end;

procedure TcxSSDataStorage.SetDimension(const ASize: TSize);
begin
  FDimension := ASize;
  FDimensionAssigned := True;  
end;

procedure TcxSSDataStorage.SetSheetCaption(const Value: string);
var
  AOldCaption: string;
begin
  if Value = FCaption then Exit;
  AOldCaption := FCaption;
  FCaption := Value;
end;

{ TcxSSMergedCellsStorage }
procedure TcxSSMergedCellsStorage.Assign(Source: TcxSSMergedCellsStorage);
var
  ASize: Integer;
begin
  if Source <> nil then
  begin
    FCount := Source.FCount;
    ASize := FCount shl 4;
    GetMem(FData, ASize);
    Move(Source.FData^, FData^, ASize);
  end;
end;

procedure TcxSSMergedCellsStorage.AddMerges(const ARects: TcxSSRectsArray);
var
  I: Integer;
begin
  for I := 0 to Length(ARects) - 1 do
    AddMergeItem(ARects[I]);
end;

function TcxSSMergedCellsStorage.IntersectMerge(const ARect: TRect): Boolean;
var
  R: TRect;
  I: Integer;
begin
  I := 0;
  Result := False;
  while (I < FCount) and (not Result) do
  begin
    Result := IntersectRect(R, ARect, PRectArray(FData)^[I]);
    Inc(I);
  end;
end;

function TcxSSMergedCellsStorage.IntersectMergedCells(
  const ARect: TRect): TcxSSRectsArray;
var
  R: TRect;
  I, C: Integer;
begin
  I := 0;
  SetLength(Result, 0);
  while I < FCount do
  begin
    if IntersectRect(R, ARect, PRectArray(FData)^[I]) then
    begin
      C := Length(Result);
      SetLength(Result, C + 1);
      Result[C] := PRectArray(FData)^[I];
    end;
    Inc(I);
  end;
end;

procedure TcxSSMergedCellsStorage.AddMergeItem(const ARect: TRect);
begin
  Inc(FCount);
  ReallocMem(FData, FCount shl 4);
  PRectArray(FData)^[FCount - 1] := ARect;
end;

procedure TcxSSMergedCellsStorage.CheckAfterClear(ARect: TRect);
var
  R: TRect;
  I: Integer;
begin
  I := 0;
  InflatePoint(ARect.BottomRight, 1, 1);
  while I < FCount do
  begin
    if IntersectRect(R, ARect, PRectArray(FData)^[I]) and EqualRect(R, PRectArray(FData)^[I]) then
      DeleteMergeItem(I)
    else
      Inc(I);
  end;
end;

function TcxSSMergedCellsStorage.CheckInMergeRange(const APoint: TPoint;
  var ARect: TRect): Boolean;
var
  I: Integer;
begin
  I := 0;
  Result := False;
  while (I < FCount) and not Result do
  begin
    Result := PtInRect(PRectArray(FData)^[I], APoint);
    if Result then
      ARect := PRectArray(FData)^[I];
    Inc(I);
  end;
  if not Result then
  begin
    ARect.TopLeft := APoint;
    ARect.BottomRight := APoint;
  end;
end;

function TcxSSMergedCellsStorage.CheckSelection(const ARect: TRect): TRect;
var
  I: Integer;
  R: TRect;
begin
  Result := ValidateRect(ARect);
  InflatePoint(Result.BottomRight, 1, 1);
  I := 0;
  while I < FCount do
  begin
    if IntersectRect(R, Result, PRectArray(FData)^[I]) and not EqualRect(R, PRectArray(FData)^[I]) then
    begin
      UnionRect(Result, Result, PRectArray(FData)^[I]);
      I := 0;
      Continue;
    end
    else
      Inc(I);
  end;
  InflatePoint(Result.BottomRight, -1, -1);
end;

procedure TcxSSMergedCellsStorage.Clear;
begin
  try
    ReallocMem(FData, 0);
  finally
    FData := nil;
    FCount := 0;
  end;
end;

procedure TcxSSMergedCellsStorage.DeleteMergeCell(const ACol, ARow: Integer);
var
  AItem: Integer;
begin
  AItem := 0;
  while AItem < FCount do
  begin
    if PtInRect(PRectArray(FData)^[AItem], Point(ACol, ARow)) then
      DeleteMergeItem(AItem)
    else
      Inc(AItem);
  end;
end;

procedure TcxSSMergedCellsStorage.DeleteMergeItem(const AIndex: Integer);
begin
  if (AIndex >= FCount) or (AIndex < 0) then Exit;
  Dec(FCount);
  if AIndex < FCount then
    Move(PRectArray(FData)^[AIndex + 1], PRectArray(FData)^[AIndex], (FCount - AIndex) * SizeOf(TRect));
  ReallocMem(FData, FCount * SizeOf(TRect));
end;

function TcxSSMergedCellsStorage.GetRectItem(const AIndex: Integer;
  var AItem: TRect): Boolean;
begin
  Result := (AIndex >=0) and (AIndex < FCount);
  if Result then
    AItem := PRectArray(FData)^[AIndex]
  else
    AItem := Rect(-1, -1, -1, -1);
end;

function TcxSSMergedCellsStorage.GetRects: TcxSSRectsArray;
begin
  SetLength(Result, FCount);
  if FCount > 0 then
    Move(PRectArray(FData)^[0], Result[0], FCount * SizeOf(TRect));
end;

procedure TcxSSMergedCellsStorage.InflateItem(const AIndex, DW, DH: Integer);
var
  I, J: Integer; 
begin
  if ((DW * DH) < 0) or (AIndex < 0) and (AIndex >= FCount) then Exit;
  InflatePoint(PRectArray(FData)^[AIndex].BottomRight, DW, DH);
  if (DW < 0) or (DH < 0) then
  begin
    if IsRectEmpty(PRectArray(FData)^[AIndex]) then
      DeleteMergeItem(AIndex);
  end
  else
    with PRectArray(FData)^[AIndex] do
    begin
      for I := Left to Right - 1 do
        for J := Top to Bottom - 1 do
        begin
          with TcxSSCellStyleAccess(Owner.CellStyle[I, J]) do
          try
            Merge := True;
          finally
            Free;
          end;
        end;
    end;
end;

procedure TcxSSMergedCellsStorage.InflatePoint(var APoint: TPoint;
  const DX, DY: Integer);
begin
  APoint.X := APoint.X + DX;
  APoint.Y := APoint.Y + DY;
end;

function TcxSSMergedCellsStorage.RectIsBelow(
  const ATopRect, ABottomRect: TRect): Boolean;
begin
  Result := ATopRect.Top <= ABottomRect.Top;
end;

function TcxSSMergedCellsStorage.RectIsRight(
  const ALeftRect, ARightRect: TRect): Boolean;
begin
  Result := ALeftRect.Left <= ARightRect.Left;
end;

procedure TcxSSMergedCellsStorage.SetMergeStyle(const ARect: TRect; AIsMerge: Boolean);

  procedure SetStyle(const ACells: TRect);
  var
    I, J: Integer;
  begin
    with ACells do
    begin
      for I := Left to Right - 1 do
        for J := Top to Bottom - 1 do
         if not Owner.IsValidCell(I, J) then
           Continue
         else
         with TcxSSCellStyleAccess(Owner.CellStyle[I, J]) do
         try
           Merge := AIsMerge;
         finally
           Free;
         end;
    end;
  end;

var
  I: Integer;
  Action: TcxMergeSplitActions;
  R: TRect;
  ValidRect: TRect;
const
  ActionClass: array[Boolean] of TcxActionClass =
    (TcxSplitCellsAction, TcxMergeCellsAction);

begin
  ValidRect := CheckSelection(ARect);
  if TcxHistoryAccess(TcxSSBookSheetAccess(Owner.FOwnerSheet).History).AddAction(ActionClass[AIsMerge], Action) then
  begin
    TcxHistoryAccess(TcxSSBookSheetAccess(Owner.FOwnerSheet).History).BeginUpdate;
    Action.BeforeAction(TcxSSBookSheet(Owner.Owner), ValidRect);
  end;
  try
    InflatePoint(ValidRect.BottomRight, 1, 1);
    I := 0;
    while I < FCount do
    begin
      if IntersectRect(R, ValidRect, PRectArray(FData)^[I]) then
        DeleteMergeItem(I)
      else
        Inc(I);
    end;
    SetStyle(ValidRect);
    if AIsMerge then
      AddMergeItem(ValidRect);
  finally
    if Action <> nil then
      TcxHistoryAccess(TcxSSBookSheetAccess(Owner.FOwnerSheet).History).EndUpdate;
  end;
end;

function TcxSSMergedCellsStorage.SetRects(const ARects: TcxSSRectsArray): TcxSSRectsArray;
begin
  Result := GetRects;
  FCount := Length(ARects);
  ReallocMem(FData, FCount * SizeOf(TRect));
  if FCount > 0 then
    Move(ARects[0], FData^, FCount * SizeOf(TRect))
  else
    FData := nil;
end;

procedure TcxSSMergedCellsStorage.ShiftItem(const AItem, DX, DY: Integer);
begin
  if (AItem < 0) or (AItem >= FCount) then Exit;
  OffsetRect(PRectArray(FData)^[AItem], DX, DY);
  with PRectArray(FData)^[AItem] do
  begin
    if Left < 0 then
      Left := 0;
    if Top < 0 then
      Top := 0;
  end;
  if IsRectEmpty(PRectArray(FData)^[AItem]) then
    DeleteMergeItem(AItem);
end;

procedure TcxSSMergedCellsStorage.UpdateOnInsertCells(ARect: TRect;
  AShift: TcxSSCellsModify);
var
  AIndex, W, H: Integer;
  R: TRect;
begin
  if AShift = msAllRow then
  begin
    H := ARect.Bottom - ARect.Top;
    W := 0;
    ARect.Left := 0;
  end
  else
  begin
    H := 0;
    W := ARect.Right - ARect.Left;
    ARect.Top := 0;
  end;
  ARect.BottomRight := Point(cxMaxViewCoord, cxMaxViewCoord);
  if not CheckRect(ARect, AIndex) then Exit;
  while AIndex < FCount do
  begin
    if ((AShift = msAllCol) and RectIsRight(ARect, PRectArray(FData)^[AIndex])) or
       ((AShift = msAllRow) and RectIsBelow(ARect, PRectArray(FData)^[AIndex]))
     then
        ShiftItem(AIndex, W, H)
    else
      if IntersectRect(R, ARect, PRectArray(FData)^[AIndex]) then
        InflateItem(AIndex, W, H);
    Inc(AIndex);
  end;
end;

procedure TcxSSMergedCellsStorage.UpdateOnDeleteCells(ARect: TRect;
  AShift: TcxSSCellsModify);
var
  AIndex, W, H: Integer;
  R: TRect;
  C: Integer;
begin
  if AShift = msAllRow then
  begin
    H := ARect.Bottom - ARect.Top;
    W := 0;
    ARect.Left := 0;
  end
  else
  begin
    H := 0;
    W := ARect.Right - ARect.Left;
    ARect.Top := 0;
  end;
  ARect.BottomRight := Point(cxMaxViewCoord, cxMaxViewCoord);
  if not CheckRect(ARect, AIndex) then Exit;
  while AIndex < FCount do
  begin
    C := FCount;
    if ((AShift = msAllCol) and RectIsRight(ARect, PRectArray(FData)^[AIndex])) or
       ((AShift = msAllRow) and RectIsBelow(ARect, PRectArray(FData)^[AIndex]))
     then
        ShiftItem(AIndex, -W, -H)
    else
      if IntersectRect(R, ARect, PRectArray(FData)^[AIndex]) then
        InflateItem(AIndex, -W, -H);
    if C = FCount then Inc(AIndex);
  end;
end;

function TcxSSMergedCellsStorage.ValidateRect(const ARect: TRect): TRect;
begin
  with Result do
  begin
    Left := Min(ARect.Left, ARect.Right);
    Top := Min(ARect.Top, ARect.Bottom);
    Right := Max(ARect.Left, ARect.Right);
    Bottom := Max(ARect.Top, ARect.Bottom);
  end;
end;

function TcxSSMergedCellsStorage.CheckRect(const ARect: TRect;
  out AIndex: Integer): Boolean;
var
  R: TRect;
begin
  Result := False;
  if FCount > 0 then
  begin
    AIndex := -1;
    while (AIndex < FCount) and not Result do
    begin
      Inc(AIndex);
      Result := IntersectRect(R, ARect, PRectArray(FData)^[AIndex]);
    end;
  end;
end;

function TcxSSMergedCellsStorage.GetItemBounds(AIndex: Integer): TRect;
begin
  if GetRectItem(AIndex, Result) then
  with Result do
  begin
    Right := Right - Left;
    Bottom := Bottom - Top;
  end
  else
    FillChar(Result.BottomRight, SizeOf(TPoint), 0);
end;

function TcxSSMergedCellsStorage.GetItemRect(AIndex: Integer): TRect;
begin
  if GetRectItem(AIndex, Result) then
    InflatePoint(Result.BottomRight, -1, -1);
end;

function TcxSSMergedCellsStorage.GetItemsRects: TcxSSRectsArray;
var
  I: Integer;
begin
  SetLength(Result, FCount);
  Move(FData^, Result[0], FCount * SizeOf(TRect));
  for I := 0 to FCount - 1 do
    InflatePoint(Result[I].BottomRight, -1, -1);
end;

end.
