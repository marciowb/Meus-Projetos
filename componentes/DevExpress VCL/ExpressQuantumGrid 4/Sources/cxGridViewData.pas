{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid                                           }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMGRID AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxGridViewData;

{$I cxGridVer.inc}

interface

uses
  Classes, SysUtils, Controls,
  cxControls, cxGrid, cxGridCustomView, cxGridCustomTableView, cxGridLevel,
  cxDataStorage, cxCustomData;

type
  TcxGridViewData = class;

  TcxCustomGridRowClass = class of TcxCustomGridRow;

  TcxCustomGridRow = class(TcxCustomGridRecord)
  private
    function GetIsNewItemRow: Boolean;
    function GetViewData: TcxGridViewData;
  public
    function ExpandOnDblClick: Boolean; virtual;
    property IsNewItemRow: Boolean read GetIsNewItemRow;
    property ViewData: TcxGridViewData read GetViewData;
  end;

  TcxGridDataRow = class(TcxCustomGridRow)
  protected
    function GetHasCells: Boolean; override;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
  end;

  TcxGridNewItemRowClass = class of TcxGridNewItemRow;

  TcxGridNewItemRow = class(TcxGridDataRow);

  TcxGridMasterDataRow = class(TcxGridDataRow)
  private
    function GetActiveDetailGridView: TcxCustomGridView;
    function GetActiveDetailGridViewExists: Boolean;
    function GetActiveDetailIndex: Integer;
    function GetActiveDetailLevel: TcxGridLevel;
    function GetDetailGridView(Index: Integer): TcxCustomGridView;
    function GetDetailGridViewCount: Integer;
    function GetInternalActiveDetailIndex: Integer;
    procedure SetActiveDetailIndex(Value: Integer);
  protected
    procedure DoCollapse(ARecurse: Boolean); override;
    procedure DoExpand(ARecurse: Boolean); override;
    function GetExpandable: Boolean; override;
    function GetExpanded: Boolean; override;
    function GetHasChildren: Boolean; virtual;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
    property InternalActiveDetailIndex: Integer read GetInternalActiveDetailIndex;
  public
    function ExpandOnDblClick: Boolean; override;
    function GetFirstFocusableChild: TcxCustomGridRecord; override;
    function GetLastFocusableChild(ARecursive: Boolean): TcxCustomGridRecord; override;

    property ActiveDetailGridView: TcxCustomGridView read GetActiveDetailGridView;
    property ActiveDetailGridViewExists: Boolean read GetActiveDetailGridViewExists;
    property ActiveDetailIndex: Integer read GetActiveDetailIndex write SetActiveDetailIndex;
    property ActiveDetailLevel: TcxGridLevel read GetActiveDetailLevel;
    property DetailGridViewCount: Integer read GetDetailGridViewCount;
    property DetailGridViews[Index: Integer]: TcxCustomGridView read GetDetailGridView;
    property HasChildren: Boolean read GetHasChildren;
  end;

  TcxGridGroupRow = class(TcxCustomGridRow)
  protected
    procedure DoCollapse(ARecurse: Boolean); override;
    procedure DoExpand(ARecurse: Boolean); override;
    function GetDestroyingOnExpanding: Boolean; override;
    function GetExpandable: Boolean; override;
    function GetExpanded: Boolean; override;

    function GetDisplayText: string; reintroduce;
    function GetIsData: Boolean; override;
    function GetIsParent: Boolean; override;
    function GetValue: Variant; reintroduce;
    function GetViewInfoClass: TcxCustomGridRecordViewInfoClass; override;
  public
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    property DisplayText: string read GetDisplayText;
    property Value: Variant read GetValue;
  end;

  TcxGridViewData = class(TcxCustomGridTableViewData)
  private
    function GetNewItemRow: TcxGridNewItemRow;
    function GetRow(Index: Integer): TcxCustomGridRow;
    function GetRowCount: Integer;
  protected
    function GetNewItemRecordClass: TcxCustomGridRecordClass; override;
    function GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass; override;
  public
    function HasNewItemRecord: Boolean; override;
    property NewItemRow: TcxGridNewItemRow read GetNewItemRow;
    property RowCount: Integer read GetRowCount;
    property Rows[Index: Integer]: TcxCustomGridRow read GetRow;
  end;

implementation

uses
  Windows,
  cxGridTableView, cxGridRows;

type
  TcxCustomGridAccess = class(TcxCustomGrid);
  TcxGridColumnAccess = class(TcxGridColumn);
  TcxGridTableViewAccess = class(TcxGridTableView);

{ TcxCustomGridRow }

function TcxCustomGridRow.GetIsNewItemRow: Boolean;
begin
  Result := IsNewItemRecord;
end;

function TcxCustomGridRow.GetViewData: TcxGridViewData;
begin
  Result := TcxGridViewData(inherited ViewData);
end;

function TcxCustomGridRow.ExpandOnDblClick: Boolean;
begin
  Result := Expandable;
end;

{ TcxGridDataRow }

function TcxGridDataRow.GetHasCells: Boolean;
begin
  Result := True;
end;

function TcxGridDataRow.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridDataRowViewInfo;
end;

{ TcxGridMasterDataRow }

function TcxGridMasterDataRow.GetActiveDetailGridView: TcxCustomGridView;
begin
  if ActiveDetailIndex = -1 then
    Result := nil
  else
    Result := DetailGridViews[ActiveDetailIndex];
end;

function TcxGridMasterDataRow.GetActiveDetailGridViewExists: Boolean;
begin
  Result := IsValid and (ActiveDetailIndex <> -1) and
    DataController.IsDetailDataControllerExist(RecordIndex, ActiveDetailIndex);
end;

function TcxGridMasterDataRow.GetActiveDetailIndex: Integer;
begin
  Result := InternalActiveDetailIndex;
  if (Result <> -1) and not GridView.IsDestroying and
    not TcxGridLevel(GridView.Level)[Result].Visible then
  begin
    GridView.BeginUpdate;
    try
      Result := TcxGridTableViewAccess(GridView).GetDefaultActiveDetailIndex;
      ActiveDetailIndex := Result;
    finally
      GridView.CancelUpdate;
    end;
  end;
end;

function TcxGridMasterDataRow.GetActiveDetailLevel: TcxGridLevel;
begin
  if ActiveDetailIndex = -1 then
    Result := nil
  else
    Result := TcxGridLevel(GridView.Level)[ActiveDetailIndex];
end;

function TcxGridMasterDataRow.GetDetailGridView(Index: Integer): TcxCustomGridView;
begin
  Result := DataController.GetDetailLinkObject(RecordIndex, Index) as TcxCustomGridView;
end;

function TcxGridMasterDataRow.GetDetailGridViewCount: Integer;
begin
  Result := DataController.Relations.Count;
end;

function TcxGridMasterDataRow.GetInternalActiveDetailIndex: Integer;
begin
  Result := DataController.GetDetailActiveRelationIndex(RecordIndex);
end;

procedure TcxGridMasterDataRow.SetActiveDetailIndex(Value: Integer);
var
  AGridView: TcxCustomGridTableView;
  APrevValue: Integer;
  ANewActiveDetailLevel: TcxGridLevel;
begin
  AGridView := GridView;
  APrevValue := InternalActiveDetailIndex;
  if APrevValue <> Value then
  begin
    ANewActiveDetailLevel := TcxGridLevel(GridView.Level).Items[Value];
    DataController.ChangeDetailActiveRelationIndex(RecordIndex, Value);
    //if InternalActiveDetailIndex <> APrevValue then
      TcxCustomGridAccess(AGridView.Control).DoActiveTabChanged(ANewActiveDetailLevel);
  end;
end;

procedure TcxGridMasterDataRow.DoCollapse(ARecurse: Boolean);
var
  I: Integer;
  AGridView: TcxCustomGridView;
begin
{  if Expanded and ARecurse and (ActiveDetailGridView is TcxCustomGridTableView) then
    TcxCustomGridTableView(ActiveDetailGridView).ViewData.Collapse(ARecurse);}
  if Expanded and ARecurse then
    for I := 0 to DetailGridViewCount - 1 do
    begin
      AGridView := DetailGridViews[I];
      if AGridView is TcxCustomGridTableView then
        TcxCustomGridTableView(AGridView).ViewData.Collapse(ARecurse);
    end;
  ViewData.DataController.ChangeDetailExpanding(RecordIndex, False);
end;

procedure TcxGridMasterDataRow.DoExpand(ARecurse: Boolean);
var
  AViewData: TcxGridViewData;
  ARecordIndex, I: Integer;
  ARecord: TcxCustomGridRecord;
  AGridView: TcxCustomGridView;
begin
  AViewData := ViewData;
  ARecordIndex := RecordIndex;
  if not ViewData.DataController.ChangeDetailExpanding(RecordIndex, True) then Exit;
  ARecord := AViewData.GetRecordByRecordIndex(ARecordIndex);
  if Self <> ARecord then
    TcxGridMasterDataRow(ARecord).DoExpand(ARecurse)
  else
  begin
    if Expanded and ARecurse then
      for I := 0 to DetailGridViewCount - 1 do
      begin
        AGridView := DetailGridViews[I];
        if AGridView is TcxCustomGridTableView then
          TcxCustomGridTableView(AGridView).ViewData.Expand(ARecurse);
      end;
    {if Expanded and ARecurse and (ActiveDetailGridView is TcxCustomGridTableView) then
      TcxCustomGridTableView(ActiveDetailGridView).ViewData.Expand(ARecurse);}
  end;
end;

function TcxGridMasterDataRow.GetExpandable: Boolean;
begin
  Result := TcxGridTableView(GridView).OptionsView.ExpandButtonsForEmptyDetails or
    HasChildren or Expanded;
end;

function TcxGridMasterDataRow.GetExpanded: Boolean;
begin
  Result := ViewData.DataController.GetDetailExpanding(RecordInfo.RecordIndex);
end;

function TcxGridMasterDataRow.GetHasChildren: Boolean;
var
  ALevel: TcxGridLevel;
  I: Integer;
begin
  ALevel := TcxGridLevel(GridView.Level);
  for I := 0 to ALevel.VisibleCount - 1 do
  begin
    Result := DataController.GetDetailHasChildren(RecordIndex,
      ALevel.VisibleItems[I].DataRelation.Index);
    if Result then Exit;
  end;
  Result := False;
end;

function TcxGridMasterDataRow.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridMasterDataRowViewInfo;
end;

function TcxGridMasterDataRow.ExpandOnDblClick: Boolean;
begin
  Result := inherited ExpandOnDblClick and
    TcxGridTableView(GridView).OptionsBehavior.ExpandMasterRowOnDblClick;
end;

function TcxGridMasterDataRow.GetFirstFocusableChild: TcxCustomGridRecord;
var
  AGridView: TcxCustomGridView;
  AGridRecordIndex: Integer;
  ACycleChanged: Boolean;
begin
  Result := inherited GetFirstFocusableChild;
  if Expanded then
  begin
    AGridView := ActiveDetailGridView;
    if AGridView is TcxCustomGridTableView then
      with TcxCustomGridTableView(AGridView) do
        if ViewData.HasNewItemRecord then
          Result := ViewData.NewItemRecord
        else
        begin
          AGridRecordIndex := Controller.FindNextRecord(-1, True, False, ACycleChanged);
          if AGridRecordIndex <> -1 then
            Result := ViewData.Records[AGridRecordIndex];
        end;
  end;
end;

function TcxGridMasterDataRow.GetLastFocusableChild(ARecursive: Boolean): TcxCustomGridRecord;
var
  AGridView: TcxCustomGridView;
  AGridRecordIndex: Integer;
  AGridRecord: TcxCustomGridRecord;
  ACycleChanged: Boolean;
begin
  Result := inherited GetLastFocusableChild(ARecursive);
  if Expanded then
  begin
    AGridView := ActiveDetailGridView;
    if AGridView is TcxCustomGridTableView then
      with TcxCustomGridTableView(AGridView) do
      begin
        AGridRecordIndex := Controller.FindNextRecord(-1, False, True, ACycleChanged);
        if AGridRecordIndex <> -1 then
        begin
          Result := ViewData.Records[AGridRecordIndex];
          if ARecursive then
          begin
            AGridRecord := Result.GetLastFocusableChild(ARecursive);
            if AGridRecord <> nil then Result := AGridRecord;
          end;
        end
        else
          if ViewData.HasNewItemRecord then
            Result := ViewData.NewItemRecord;
      end;
  end;
end;

{ TcxGridGroupRow }

procedure TcxGridGroupRow.DoCollapse(ARecurse: Boolean);
begin
  ViewData.DataController.Groups.ChangeExpanding(Index, False, ARecurse);
end;

procedure TcxGridGroupRow.DoExpand(ARecurse: Boolean);
begin
  ViewData.DataController.Groups.ChangeExpanding(Index, True, ARecurse);
end;

function TcxGridGroupRow.GetDestroyingOnExpanding: Boolean;
begin
  Result := True;
end;

function TcxGridGroupRow.GetExpandable: Boolean;
begin
  Result := True;
end;

function TcxGridGroupRow.GetExpanded: Boolean;
begin
  Result := RecordInfo.Expanded;
end;

function TcxGridGroupRow.GetDisplayText: string;
var
  S: string;
begin
  Result := Format('%s : %s', [
    TcxGridTableView(GridView).GroupedColumns[Level].Caption,
    DisplayTexts[-1]]);
  S := DataController.Summary.GroupSummaryText[Index];
  if S <> '' then
    Result := Result + ' ' + S;
end;

function TcxGridGroupRow.GetIsData: Boolean;
begin
  Result := False;
end;

function TcxGridGroupRow.GetIsParent: Boolean;
begin
  Result := RecordInfo.Level < ViewData.DataController.Groups.GroupingItemCount;  //!!!
end;

function TcxGridGroupRow.GetValue: Variant;
begin
  Result := ViewData.DataController.GetRowValue(RecordInfo, -1); //!!!
end;

function TcxGridGroupRow.GetViewInfoClass: TcxCustomGridRecordViewInfoClass;
begin
  Result := TcxGridGroupRowViewInfo;
end;

procedure TcxGridGroupRow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_MULTIPLY:
      begin
        Expand(True);
        Key := 0;
      end;
  end;
end;

{ TcxGridViewData }

function TcxGridViewData.GetNewItemRow: TcxGridNewItemRow;
begin
  Result := TcxGridNewItemRow(NewItemRecord);
end;

function TcxGridViewData.GetRow(Index: Integer): TcxCustomGridRow;
begin
  Result := TcxCustomGridRow(Records[Index]);
end;

function TcxGridViewData.GetRowCount: Integer;
begin
  Result := RecordCount;
end;

function TcxGridViewData.GetNewItemRecordClass: TcxCustomGridRecordClass;
begin
  Result := TcxGridNewItemRow;
end;

function TcxGridViewData.GetRecordClass(ARecordInfo: TcxRowInfo): TcxCustomGridRecordClass;
begin
  if ARecordInfo.Level < DataController.Groups.GroupingItemCount then
    Result := TcxGridGroupRow
  else
    if GridView.IsMaster then
      Result := TcxGridMasterDataRow
    else
      Result := TcxGridDataRow;
end;

function TcxGridViewData.HasNewItemRecord: Boolean;
begin
  Result := TcxGridTableView(GridView).OptionsView.NewItemRow;
end;

end.
