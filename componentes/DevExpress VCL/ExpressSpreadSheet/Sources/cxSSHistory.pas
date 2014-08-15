
{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				                                  }
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

unit cxSSHistory;

{$I cxVer.inc}

interface
uses
  Classes, SysUtils,
  Windows, {$IFDEF DELPHI6} Types, {$ENDIF} Forms, Controls,
  cxSSData, cxSSTypes, Graphics, cxSSRes, cxControls, cxClasses;

type
  TcxCustomAction = class;
  TcxActionList = class;
  TcxActionClass = class of TcxCustomAction;

  TcxSSHistoryClass = class of TcxSpreadSheetHistory;

  { TcxCustomHistory }
  TcxCustomHistory = class
  private
    FCurrentAction: TcxCustomAction;
    FFuncCount: Integer;
    FIsSafeException: Boolean;
    FMaxActionCount: Integer;
    FOwner: TObject;
    FRedoList: TcxActionList;
    FUndoList: TcxActionList;
    FUpdateRef: Integer;
    FOnChange: TNotifyEvent;
    function AddNewAction(ActionClass: TcxActionClass; var Action): Boolean;
    function GetLocked: Boolean;
    function GetIsComplexAction: Boolean;
    procedure SetMaxActionCount(const Value: Integer);
  protected
    function AddAction(ActionClass: TcxActionClass; var Action): Boolean;
    function AddComplexAction(ActionClass: TcxActionClass;
      const ADescription: string; var Action): Boolean;
    procedure Change; virtual;
    procedure ChangeUpdateState(CanUpdate: Boolean); virtual;
    procedure SafeException; virtual;
    procedure UpdateFormulas; virtual;
    property HistoryOwner: TObject read FOwner write FOwner;
    property IsComplexAction: Boolean read GetIsComplexAction;
    property Locked: Boolean read GetLocked;
    property MaxActions: Integer read FMaxActionCount write SetMaxActionCount;
    property Owner: TObject read FOwner;
    property RedoActions: TcxActionList read FRedoList;
    property UndoActions: TcxActionList read FUndoList;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function BeginUpdate: Integer;
    procedure Clear; virtual;
    function EndUpdate: Integer;
    function StartComplexAction(const ADescription: string): Boolean;
    procedure StopComplexAction;
    procedure Redo(const ACount: Integer = -1); virtual;
    procedure Undo(const ACount: Integer = -1); virtual;
  end;

  { TcxCustomAction }
  TcxCustomAction = class
  private
    FChild: TcxCustomAction;
    FHistory: TcxCustomHistory;
    FNext: TcxCustomAction;
    FOwner: TcxCustomHistory;
    FParent: TcxCustomAction;
    FPrev: TcxCustomAction;
    function GetCount: Integer;
    function GetHistoryOwner: TObject;
    function GetItem(AIndex: Integer): TcxCustomAction;
  protected
    procedure Clear; virtual;
    function GetActionDescription: string; virtual;
    procedure DeleteFromChain;
    procedure DoUndo; virtual;
    procedure DoRedo; virtual;
    class function GetCountActions(Action: TcxCustomAction): Integer;
    class function GetFirstAction(Action: TcxCustomAction): TcxCustomAction;
    class function GetLastAction(Action: TcxCustomAction): TcxCustomAction;
    class function GetPosition(Action: TcxCustomAction): Integer;
    procedure InsertAfter(Action: TcxCustomAction); virtual;
    procedure InsertBefore(Action: TcxCustomAction); virtual;
    property Item[AIndex: Integer]: TcxCustomAction read GetItem; default;
    property Count: Integer read GetCount;
    property Parent: TcxCustomAction read FParent;
    property History: TcxCustomHistory read FHistory;
    property HistoryOwner: TObject read GetHistoryOwner;
  public
    destructor Destroy; override;
    property Description: string read GetActionDescription;
  end;

  { TcxSpreadSheetHistory }
  TcxSpreadSheetHistory = class(TcxCustomHistory)
  protected
    procedure ChangeUpdateState(CanUpdate: Boolean); override;
    procedure UpdateFormulas; override;
  public
    procedure Clear; override;

    property MaxActions;
    property RedoActions;
    property UndoActions;
  end;

  { TcxActionList }
  TcxActionList = class(TcxCustomAction)
  public
    property Item;
    property Count;
  end;

  { TcxStoreCellRec }
  TcxStoreCellRec = {$IFNDEF DELPHI12} packed {$ENDIF} record
    Data: string;
    DataType: TcxSSDataType;
    FontName: string;
    FontColor: Word;
    FontStyle: TFontStyles;
    FontCharset: TFontCharset;
    FontSize: ShortInt;
    FormatIndex: Byte;
    HorzAlign: TcxHorzTextAlign;
    VertAlign: TcxVertTextAlign;
    WordBreak: Boolean;
    ShrinkToFit: Boolean;
    CellState: TcxSSCellStates;
    BrushStyle: TcxSSFillStyle;
    BrushFgColor: Word;
    BrushBkColor: Word;
    Borders: TcxSSBordersStyle;
  end;

  TcxCellsData = array of array of TcxStoreCellRec;

  { TcxSpreadSheetActions }
  TcxSpreadSheetActions = class(TcxCustomAction)
  private
    FData: TcxCellsData;
    FRect: TRect;
    FSheet: TObject;
   procedure GetCellData(const ACol, ARow: Integer;
    var AStoredData: TcxStoreCellRec);
   function GetDataStorage: TcxSSDataStorage;
   procedure SetCellData(const ACol, ARow: Integer;
     var AStoredData: TcxStoreCellRec);
  protected
    procedure DoRedo; override;
    procedure DoUndo; override;
    procedure RestoreCellsData; virtual;
    procedure SetData(ASheet: TObject; const ACellRect: TRect;
      const SaveCells: Boolean = True);
    procedure StoreCellsData(var AData: TcxCellsData); virtual;
    property CellsRect: TRect read FRect;
    property Data: TcxCellsData read FData;
    property DataStorage: TcxSSDataStorage read GetDataStorage;
    property Sheet: TObject read FSheet;
  end;

  { TcxComplexAction }
  TcxComplexAction = class(TcxCustomAction)
  private
    FDescription: string;
  protected
    procedure CheckEmpty;
    function GetActionDescription: string; override;
  public
    property Item;
    property Count;
  end;

  { TcxSpreadSheetInsertDeleteActions }
  TcxSpreadSheetInsertDeleteActions = class(TcxSpreadSheetActions)
  private
    FRects: TcxSSRectsArray;
    FModifyType: TcxSSCellsModify;
  public
    procedure BeforeAction(ASheet: TObject; const ACellRect: TRect;
      AModifyType: TcxSSCellsModify); virtual;
    property ModifyType: TcxSSCellsModify read FModifyType;
  end;

  { TcxInsertCellsAction }
  TcxInsertCellsAction = class(TcxSpreadSheetInsertDeleteActions)
  protected
    procedure DoRedo; override;
    procedure DoUndo; override;
    function GetActionDescription: string; override;
  end;

  { TcxDeleteCellsAction }
  TcxDeleteCellsAction = class(TcxSpreadSheetInsertDeleteActions)
  protected
    procedure DoRedo; override;
    procedure DoUndo; override;
    function GetActionDescription: string; override;
  public
    procedure BeforeAction(ASheet: TObject; const ACellRect: TRect;
      AModifyType: TcxSSCellsModify); override;
  end;

  {TcxSpreadSheetChangeCells}
  TcxSpreadSheetChangeCellsAction = class(TcxSpreadSheetActions)
  public
    procedure BeforeAction(ASheet: TObject; const ACellRect: TRect);
  end;

  { TcxChangeDataAction }
  TcxChangeDataAction = class(TcxSpreadSheetChangeCellsAction)
  protected
    function GetActionDescription: string; override;
  end;

  { TcxChangeStyleAction }
  TcxChangeStyleAction = class(TcxSpreadSheetChangeCellsAction)
  protected
    function GetActionDescription: string; override;
  end;

  { TcxMergeSplitActions }
  TcxMergeSplitActions = class(TcxSpreadSheetActions)
  private
    FRects: TcxSSRectsArray;
  protected
    procedure DoRedo; override;
    procedure DoUndo; override;
  public
    procedure BeforeAction(ASheet: TObject; const ACellRect: TRect); virtual;
  end;

  { TcxMergeCellsAction }
  TcxMergeCellsAction = class(TcxMergeSplitActions)
  protected
    function GetActionDescription: string; override;
  end;

  { TcxSplitCellsAction }
  TcxSplitCellsAction = class(TcxMergeSplitActions)
  protected
    function GetActionDescription: string; override;
  end;

const
  MaximumActionsCount: Integer = 15;

implementation
uses
  cxSSheet, cxSSFormulas, cxSSStyles
;
type
  TcxSheetAccess = class(TcxSSBookSheet);
  TcxBookAccess = class(TcxCustomSpreadSheetBook);
  TcxDataStorageAccess = class(TcxSSDataStorage);
  TcxMergedCellsAccess = class(TcxSSMergedCellsStorage);
  TcxFormulasCacheAccess = class(TcxSSFormulasCache); 

procedure TcxCustomHistory.AfterConstruction;
begin
  FUndoList := TcxActionList.Create;
  FRedoList := TcxActionList.Create;
  FCurrentAction := FUndoList;
  FUpdateRef := 0;
  FMaxActionCount := MaximumActionsCount;
  inherited AfterConstruction;
end;

procedure TcxCustomHistory.BeforeDestruction;
begin
  try
    Clear;
    FUndoList.Free;
    FRedoList.Free;
  finally
    inherited BeforeDestruction;
  end;
end;

procedure ClearHistoryList(Action: TcxCustomAction);

  function GetLatest(AChild: TcxCustomAction): TcxCustomAction;
  begin
    Result := AChild;
    if Result = nil then Exit;
    while Result.FChild <> nil do
      Result := Result.FChild;
  end;

var
  ASavedAction, AItem: TcxCustomAction;
begin
  ASavedAction := Action;
  try
    AItem := GetLatest(Action);
    while AItem.FParent <> nil do
    begin
      Action := AItem.Parent;
      AItem.Clear;
      AItem := Action;
    end;
    Action.Clear;
  finally
    ASavedAction.Clear;
  end;
end;

procedure TcxCustomHistory.Clear;
begin
  try
    ClearHistoryList(FUndoList);
  finally
    FCurrentAction := FUndoList;
    ClearHistoryList(FRedoList);
  end;
  Change;
end;

procedure TcxCustomHistory.Redo(const ACount: Integer = -1);
var
  I: Integer;
  AList: TcxCustomAction;
  Action: TcxCustomAction;
  ACursor: TCursor;
begin
  FFuncCount := 0;
  TcxBookAccess(Owner).BeginUpdate;
  ACursor := Screen.Cursor;
  try
    BeginUpdate;
    Screen.Cursor := crHourGlass;
    ChangeUpdateState(False);
    I := 0;
    AList := FRedoList.FChild;
    while (I <> ACount) and (AList <> nil) do
    try
      AList.DoRedo;
      Action := AList;
      AList := AList.FNext;
      FUndoList.InsertBefore(Action);
      Inc(I);
    except
      SafeException;
      raise;
    end;
  finally
    Screen.Cursor := ACursor;
    UpdateFormulas;
    ChangeUpdateState(True);
    EndUpdate;
    TcxBookAccess(Owner).EndUpdate;
    Change;
  end;
end;

function TcxCustomHistory.StartComplexAction(const ADescription: string): Boolean;
var
  Action: TcxComplexAction;
begin
  Result := AddComplexAction(TcxComplexAction, ADescription, Action);
end;

procedure TcxCustomHistory.StopComplexAction;
var
  AAction: TcxComplexAction;
begin
  if (FCurrentAction <> nil) and (FCurrentAction is TcxComplexAction) then
  begin
    AAction := FCurrentAction as TcxComplexAction;
    FCurrentAction := FCurrentAction.FParent;
    AAction.CheckEmpty;
    if AAction.Count = 0 then
      AAction.Free
    else
      Change;
  end;
end;

procedure TcxCustomHistory.Undo(const ACount: Integer = -1);
var
  I: Integer;
  AList: TcxCustomAction;
  Action: TcxCustomAction;
begin
  FFuncCount := 0; 
  TcxBookAccess(Owner).BeginUpdate;
  try
    BeginUpdate;
    I := 0;
    AList := FUndoList.FChild;
    while (I <> ACount) and (AList <> nil) do
    try
      AList.DoUndo;
      Action := AList;
      AList := AList.FNext;
      FRedoList.InsertBefore(Action);
      Inc(I);
    except
      SafeException;
      raise;
    end;
  finally
    UpdateFormulas;
    ChangeUpdateState(True);
    FCurrentAction := FUndoList;
    EndUpdate;
    Change;
  end;
end;

function TcxCustomHistory.AddAction(ActionClass: TcxActionClass; var Action): Boolean;
begin
  TcxCustomAction(Action) := nil;
  try
    if not Locked and AddNewAction(ActionClass, Action) then
    begin
      TcxCustomAction(Action).FParent := FCurrentAction;
      Change;
    end;
  finally
    Result := TcxCustomAction(Action) <> nil;
  end;
end;

function TcxCustomHistory.AddComplexAction(ActionClass: TcxActionClass;
  const ADescription: string; var Action): Boolean;
begin
  TcxCustomAction(Action) := nil;
  try
    if not Locked and AddNewAction(ActionClass, Action) then
    with TcxComplexAction(Action)  do
    begin
        FDescription := ADescription;
      FParent := FCurrentAction;
      FCurrentAction := TcxComplexAction(Action);
    end;
  finally
    Result := TcxComplexAction(Action) <> nil;
  end;
end;

function TcxCustomHistory.BeginUpdate: Integer;
begin
  Inc(FUpdateRef);
  Result := FUpdateRef;
end;

procedure TcxCustomHistory.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TcxCustomHistory.ChangeUpdateState(CanUpdate: Boolean);
begin
end;

function TcxCustomHistory.EndUpdate: Integer;
begin
  Dec(FUpdateRef);
  Result := FUpdateRef;
end;

procedure TcxCustomHistory.SafeException;
begin
  if not FIsSafeException then
  try
    FIsSafeException := True;
    Clear;
  finally
    FIsSafeException := False;
    FUndoList.FChild := nil;
    FRedoList.FChild := nil;
  end;
end;

procedure TcxCustomHistory.UpdateFormulas;
begin
end;

function TcxCustomHistory.AddNewAction(ActionClass: TcxActionClass;
  var Action): Boolean;
var
  NewAction: TcxCustomAction;
begin
  NewAction := nil;
  try
    try
      if not Locked then
      begin
        if (FCurrentAction = FUndoList) and (FUndoList.Count = FMaxActionCount) and
          (FUndoList.GetLastAction(FUndoList.FChild) <> nil) then
        begin
          with FUndoList.GetLastAction(FUndoList.FChild) do
          try
            DeleteFromChain;
          finally
            Free;
          end;
        end;
        NewAction := ActionClass.Create;
        if not (NewAction is TcxComplexAction) then
          FRedoList.Clear;
        NewAction.FOwner := Self;
        if FCurrentAction.FChild <> nil then
        begin
          NewAction.FNext := FCurrentAction.FChild;
          if FCurrentAction.FChild <> nil then
            FCurrentAction.FChild.FPrev := NewAction;
        end;
        FCurrentAction.FChild := NewAction;
      end;
    except
      SafeException;
      raise;
    end;
  finally
    Result := NewAction <> nil;
    TcxCustomAction(Action) := NewAction
  end;
end;

function TcxCustomHistory.GetLocked: Boolean;
begin
  Result := FUpdateRef > 0;
end;

function TcxCustomHistory.GetIsComplexAction: Boolean;
begin
  Result := FCurrentAction is TcxComplexAction; 
end;

procedure TcxCustomHistory.SetMaxActionCount(const Value: Integer);
begin
  if Value <> FMaxActionCount then
  begin
    FMaxActionCount := Value;
    Clear; 
  end;
end;

{ TcxCustomAction }

destructor TcxCustomAction.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TcxCustomAction.Clear;
begin
  if FChild <> nil then
  try
    while FChild.FNext <> nil do
    begin
      FChild := FChild.FNext;
      FChild.FPrev.Free;
    end;
  finally
    FreeAndNil(FChild);
  end;
end;

function TcxCustomAction.GetActionDescription: string;
begin
  Result := ClassName;
end;

procedure TcxCustomAction.DeleteFromChain;
begin
  if FPrev = nil then
  begin
    if (FParent <> nil) and (FParent.FChild = Self) then
      FParent.FChild := FNext
  end
  else
    FPrev.FNext := FNext;
  if FNext <> nil then
    FNext.FPrev := FPrev;
  FParent := nil;
  FNext := nil;
  FPrev := nil;
end;

class function TcxCustomAction.GetCountActions(
  Action: TcxCustomAction): Integer;
begin
  Result := 0;
  Action := Action.FChild;
  while Action <> nil do
  begin
    Action := Action.FNext;
    Inc(Result);
  end;
end;

procedure TcxCustomAction.DoRedo;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
    Item[I].DoRedo;
end;

procedure TcxCustomAction.DoUndo;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Item[I].DoUndo;
end;

class function TcxCustomAction.GetFirstAction(
  Action: TcxCustomAction): TcxCustomAction;
begin
  Result := Action;
  while (Result <> nil) and (Result.FPrev <> nil) do
    Result := Result.FPrev;
end;

class function TcxCustomAction.GetLastAction(
  Action: TcxCustomAction): TcxCustomAction;
begin
  Result := Action;
  while (Result <> nil) and (Result.FNext <> nil) do
    Result := Result.FNext;
end;

class function TcxCustomAction.GetPosition(
  Action: TcxCustomAction): Integer;
begin
  if Action <> nil then
  begin
    Result := 0;
    while Action.FPrev <> nil do
    begin
      Action := Action.FPrev;
      Inc(Result);
    end;
  end
  else
    Result := -1;
end;

procedure TcxCustomAction.InsertAfter(Action: TcxCustomAction);
begin
  Action.DeleteFromChain;
  Action.FParent := Self;
  if FChild <> nil then
  begin
    Action.FPrev := GetLastAction(FChild);
    Action.FPrev.FNext := Action;
  end
  else
    FChild := Action.FPrev;
end;

procedure TcxCustomAction.InsertBefore(Action: TcxCustomAction);
begin
  Action.DeleteFromChain;
  Action.FParent := Self;
  if FChild <> nil then
  begin
    Action.FNext := FChild;
    FChild.FPrev := Action;
  end;
  FChild := Action;
end;

function TcxCustomAction.GetCount: Integer;
begin
  Result := GetCountActions(Self);
end;

function TcxCustomAction.GetHistoryOwner: TObject;
begin
  if FOwner <> nil then
    Result := FOwner.Owner
  else
    Result := nil;
end;

function TcxCustomAction.GetItem(AIndex: Integer): TcxCustomAction;
begin
  if AIndex >= 0 then
  begin
    Result := FChild;
    while (Result <> nil) and (AIndex > 0) do
    begin
      Result := Result.FNext;
      Dec(AIndex);
    end;
  end
  else
    Result := nil;
end;

{ TcxSpreadSheetHistory }

procedure TcxSpreadSheetHistory.Clear;
begin
  inherited Clear;
end;

procedure TcxSpreadSheetHistory.ChangeUpdateState(CanUpdate: Boolean);
begin
  inherited ChangeUpdateState(CanUpdate);
  if CanUpdate then
    TcxBookAccess(Owner).EndUpdate
  else
    TcxBookAccess(Owner).BeginUpdate;
end;

procedure TcxSpreadSheetHistory.UpdateFormulas;
var
  I, ALockRef: Integer;
begin
  ALockRef := TcxFormulasCacheAccess(TcxBookAccess(Owner).FormulasCache).FLockRef;
  try
    TcxFormulasCacheAccess(TcxBookAccess(Owner).FormulasCache).FLockRef := 0;
    // forward and backward recalcultion
    for I := 0 to TcxBookAccess(Owner).PageCount * 2 - 1 do
      TcxFormulasCacheAccess(TcxBookAccess(Owner).FormulasCache).DoRecalc;
  finally
    TcxFormulasCacheAccess(TcxBookAccess(Owner).FormulasCache).FLockRef := ALockRef;
  end;
end;

{ TcxSpreadSheetActions }
procedure TcxSpreadSheetActions.DoRedo;
begin
  RestoreCellsData;
end;

procedure TcxSpreadSheetActions.DoUndo;
begin
  RestoreCellsData;
end;

procedure TcxSpreadSheetActions.RestoreCellsData;
var
  I, J: Integer;
  AStoredCell: TcxStoreCellRec;
begin
  for I := FRect.Left to FRect.Right do
    for J := FRect.Top to FRect.Bottom do
    begin
      GetCellData(I, J, AStoredCell);
      SetCellData(I, J, FData[I - FRect.Left, J - FRect.Top]);
      FData[I - FRect.Left, J - FRect.Top] := AStoredCell;
    end;
end;

procedure TcxSpreadSheetActions.SetData(ASheet: TObject;
  const ACellRect: TRect; const SaveCells: Boolean = True);
begin
  try
    FSheet := ASheet;
    FRect := ACellRect;
    if SaveCells then
      StoreCellsData(FData);
  except
    if FOwner <> nil then
      FOwner.SafeException;
    raise;
  end;
end;

procedure TcxSpreadSheetActions.StoreCellsData;
var
  I, J: Integer;
begin
  with FRect do
    SetLength(FData, (Right - Left + 1), (Bottom - Top + 1));
  for I := FRect.Left to FRect.Right do
    for J := FRect.Top to FRect.Bottom do
       GetCellData(I, J, FData[I - FRect.Left, J - FRect.Top]);
end;

procedure TcxSpreadSheetActions.GetCellData(const ACol, ARow: Integer;
  var AStoredData: TcxStoreCellRec);
var
  ACell: TcxSSCellRec;
begin
  ACell := DataStorage[ACol, ARow];
  with AStoredData do
  begin
    Data := ACell.Text;
    DataType := ACell.DataType;
    FontName := ACell.StylePtr.FontPtr.Name;
    FontColor := ACell.StylePtr.FontPtr.FontColor;
    FontStyle := ACell.StylePtr.FontPtr.Style;
    FontCharset := ACell.StylePtr.FontPtr.Charset;
    FontSize := ACell.StylePtr.FontPtr.Size;
    FormatIndex := ACell.StylePtr.FormatIndex;
    HorzAlign := ACell.StylePtr.HorzAlign;
    VertAlign := ACell.StylePtr.VertAlign;
    WordBreak := ACell.StylePtr.WordBreak;
    ShrinkToFit := ACell.StylePtr.ShrinkToFit;
    CellState := ACell.StylePtr.CellState;
    BrushStyle := ACell.StylePtr.BrushStyle;
    BrushFgColor := ACell.StylePtr.BrushFgColor;
    BrushBkColor := ACell.StylePtr.BrushBkColor;
    Borders := ACell.StylePtr.Borders;
  end;
end;

function TcxSpreadSheetActions.GetDataStorage: TcxSSDataStorage;
begin
  if (Sheet <> nil) and (Sheet is TcxSSBookSheet) then
    Result := TcxSheetAccess(Sheet).DataStorage
  else
    Result := nil;
end;

type
  TcxStyleAccess = class(TcxSSCellStyle);

procedure TcxSpreadSheetActions.SetCellData(const ACol, ARow: Integer;
  var AStoredData: TcxStoreCellRec);
var
  ACell: TcxSSCellObject;
  ASide: TcxSSEdgeBorder;
begin
  ACell := TcxSheetAccess(Sheet).GetCellObject(ACol, ARow);
  try
    with AStoredData do
    begin
      ACell.Text := Data;
      if DataType = dtFunction then
        Inc(FOwner.FFuncCount);
      ACell.Style.Brush.AssignInfo(BrushStyle, BrushBkColor, BrushFgColor);
      TcxStyleAccess(ACell.Style).SetState(CellState);
      TcxStyleAccess(ACell.Style).StyleInfo.FormatIndex := FormatIndex;
      TcxStyleAccess(ACell.Style).StyleInfo.HorzAlign := HorzAlign;
      TcxStyleAccess(ACell.Style).StyleInfo.VertAlign := VertAlign;
      TcxStyleAccess(ACell.Style).StyleInfo.WordBreak := WordBreak;
      ACell.Style.Font.AssignInfo(FontName, FontSize,
        FontStyle, FontCharset, FontColor);
      for ASide := eLeft to eBottom do
        with Borders[ASide] do
          ACell.Style.Borders[ASide].AssignInfo(Style, Color);
    end;
  finally
    ACell.Free;
    TcxSheetAccess(Sheet).CellsChanged(Rect(ACol, ARow, ACol, ARow));
  end;
end;

{ TcxComplexAction }
function TcxComplexAction.GetActionDescription: string;
begin
  Result := FDescription;
end;

procedure TcxComplexAction.CheckEmpty;
var
  AList: TcxCustomAction;
  AC: TcxComplexAction;
begin
  AList := FChild;
  while AList <> nil do
  begin
    if AList is TcxComplexAction then
    begin
      AC := AList as TcxComplexAction;
      AList := AList.FNext;
      AC.CheckEmpty;
    end
    else
      Break;
  end;
  if Count = 0 then
    DeleteFromChain;
end;

{ TcxSpreadSheetInsertDeleteActions }
procedure TcxSpreadSheetInsertDeleteActions.BeforeAction(ASheet: TObject;
  const ACellRect: TRect; AModifyType: TcxSSCellsModify);
begin
  FModifyType := AModifyType;
  SetData(ASheet, ACellRect, False);
  FRects :=
    TcxMergedCellsAccess(TcxDataStorageAccess(DataStorage).MergedCells).GetRects;
end;

{ TcxInsertCellsAction }
procedure TcxInsertCellsAction.DoRedo;
begin
  TcxSheetAccess(Sheet).InsertCells(FRect, FModifyType);
end;

procedure TcxInsertCellsAction.DoUndo;
begin
  TcxSheetAccess(Sheet).DeleteCells(FRect, FModifyType);
end;

function TcxInsertCellsAction.GetActionDescription: string;
begin
  Result := cxGetResourceString(@scxChangeInsertCells);
end;

{ TcxDeleteCellsAction }
procedure TcxDeleteCellsAction.BeforeAction(ASheet: TObject;
  const ACellRect: TRect; AModifyType: TcxSSCellsModify);
begin
  inherited;
  StoreCellsData(FData);
end;

procedure TcxDeleteCellsAction.DoRedo;
begin
  inherited;
  TcxSheetAccess(Sheet).DeleteCells(FRect, FModifyType);
end;

procedure TcxDeleteCellsAction.DoUndo;
begin
  try
    TcxSheetAccess(Sheet).InsertCells(FRect, FModifyType);
  finally
    TcxMergedCellsAccess(TcxDataStorageAccess(DataStorage).MergedCells).SetRects(FRects);
    inherited DoUndo;
  end;
end;

function TcxDeleteCellsAction.GetActionDescription: string;
begin
  Result := cxGetResourceString(@scxChangeDeleteCells);
end;

{ TcxSpreadSheetChangeCellsAction }
procedure TcxSpreadSheetChangeCellsAction.BeforeAction(ASheet: TObject;
  const ACellRect: TRect);
begin
  SetData(ASheet, ACellRect);
end;

{ TcxChangeDataAction }
function TcxChangeDataAction.GetActionDescription: string;
begin
  Result := cxGetResourceString(@scxChangeCellsData);
end;

{ TcxChangeStyleAction }
function TcxChangeStyleAction.GetActionDescription: string;
begin
  Result := cxGetResourceString(@scxChangeCellsStyle);
end;

{ TcxMergeCellsAction }
procedure TcxMergeSplitActions.BeforeAction(ASheet: TObject; const ACellRect: TRect);
begin
  SetData(ASheet, ACellRect);
  FRects := TcxMergedCellsAccess(TcxDataStorageAccess(DataStorage).MergedCells).GetRects;
end;

procedure TcxMergeSplitActions.DoRedo;
begin
  try
    inherited DoRedo;
  finally
    FRects :=
      TcxMergedCellsAccess(TcxDataStorageAccess(DataStorage).MergedCells).SetRects(FRects);
  end;
end;

procedure TcxMergeSplitActions.DoUndo;
begin
  try
    inherited DoUndo;
  finally
    FRects :=
      TcxMergedCellsAccess(TcxDataStorageAccess(DataStorage).MergedCells).SetRects(FRects);
  end;
end;

{ TcxMergeCellsAction }
function TcxMergeCellsAction.GetActionDescription: string;
begin
  Result := cxGetResourceString(@scxPopupMenuMergeCells);
end;

{ TcxSplitCellsAction }
function TcxSplitCellsAction.GetActionDescription: string;
begin
  Result := cxGetResourceString(@scxPopupMenuSplitCells);
end;

end.
