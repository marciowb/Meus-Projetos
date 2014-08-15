{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumGrid Utils                                     }
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

unit cxGridFooterPopupMenuItems;

{$I cxVer.inc}

interface

uses
  Windows, 
{$IFDEF DELPHI6}
  Types,
{$ENDIF}
  Dialogs, Classes, SysUtils, cxGridTableView,
  cxGridCustomPopupMenu, cxGridMenuOperations, cxCustomData;
type

  TcxGridFooterPopupMenuOperation = class(TcxGridTablePopupMenuOperation)
  public
    class function GetPopupMenuClass: TcxPopupMenuClass; override;
  end;

  TcxGridFooterMenuItem = class(TcxGridFooterPopupMenuOperation)
  private
    function GetKind: TcxSummaryKind;
    function GetGroupSummaryItemsByGroupedColumn: TcxDataSummaryItems;
    procedure AddSummaryItem(ASummaryItems: TcxDataSummaryItems);
  protected
    procedure DoFooter(Sender: TObject); virtual;
    function GetDown: Boolean; override;
    function GetEnabled: Boolean; override;
  end;

  TcxGridSumMenuItem = class(TcxGridFooterMenuItem)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridMinMenuItem = class(TcxGridFooterMenuItem)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridMaxMenuItem = class(TcxGridFooterMenuItem)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridCountMenuItem = class(TcxGridFooterMenuItem)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridAvgMenuItem = class(TcxGridFooterMenuItem)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridNoneMenuItem = class(TcxGridFooterMenuItem)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

implementation

uses
  Controls, cxGridPopupMenu, cxGridDBTableView, DB, cxDBData,
  cxGridCustomTableView, cxGridDBDataDefinitions, cxGridStdPopupMenu,
  cxGridCustomView, cxLookupEdit, cxClasses, cxGridPopupMenuConsts,
  cxDataStorage;

const
  AImageName = 'FtrImg';

{ TcxGridFooterPopupMenuOperation }

class function TcxGridFooterPopupMenuOperation.GetPopupMenuClass: TcxPopupMenuClass;
begin
  Result := TcxGridStdFooterMenu;
end;

{ TcxGridFooterMenuItem }

procedure TcxGridFooterMenuItem.DoFooter(Sender: TObject);
var
  AHitType: TcxGridViewHitType;
  ASummary: TcxDataSummary;
  ASummaryItems: TcxDataSummaryItems;
begin
  ASummary := GridPopupMenu.HitGridView.DataController.Summary;
  AHitType := GridPopupMenu.HitType;
  try
    ASummary.BeginUpdate;
    case AHitType of
      gvhtFooterCell:
        AddSummaryItem(ASummary.FooterSummaryItems);
      gvhtGroupFooterCell:
        begin
          ASummaryItems := GetGroupSummaryItemsByGroupedColumn;
          if not Assigned(ASummaryItems) then
            ASummaryItems := ASummary.DefaultGroupSummaryItems;
          AddSummaryItem(ASummaryItems);
        end;
    end;
  finally
    ASummary.EndUpdate;
  end;
end;

procedure TcxGridFooterMenuItem.AddSummaryItem(ASummaryItems: TcxDataSummaryItems);
var
  AItem: TcxDataSummaryItem;

  function AddItem(ASummaryItems: TcxDataSummaryItems): TcxDataSummaryItem;
  var
    I: Integer;
  begin
    for I := 0 to ASummaryItems.Count - 1 do
    begin
      Result := ASummaryItems[I];
      if (Result.ItemLink = HitColumn) and (Result.Position = spFooter) then
        Exit;
    end;
    if GetKind <> skNone then
    begin
      Result := ASummaryItems.Add;
      Result.ItemLink := HitColumn;
      Result.Position := spFooter;
    end
    else
      Result := nil;
  end;

begin
  AItem := AddItem(ASummaryItems);
  if AItem <> nil then
    if (GetKind = skNone) and (AItem.Format = '') then
      AItem.Free
    else
    begin
      AItem.Kind := GetKind;
      Params.Add(AItem);
    end;
end;

function TcxGridFooterMenuItem.GetDown: Boolean;

  function GetDownBySummaryItems(ASummaryItems: TcxDataSummaryItems): Boolean;
  var
    I: Integer;
  begin
    Result := False or (GetKind = skNone);
    for I := 0 to ASummaryItems.Count - 1 do
      If ASummaryItems[I].ItemLink = HitColumn then
      begin
        Result := False;
        if (ASummaryItems[I].Kind = GetKind) and
          (ASummaryItems[I].Position = spFooter) then
        begin
          Result := True;
          break;
        end;
      end;
  end;

var
  AHitType: TcxGridViewHitType;
  ASummary: TcxDataSummary;
  ASummaryItems: TcxDataSummaryItems;
begin
  AHitType := GridPopupMenu.HitType;
  ASummary := GridPopupMenu.HitGridView.DataController.Summary;
  case AHitType of
    gvhtFooterCell:
      Result := GetDownBySummaryItems(ASummary.FooterSummaryItems);
    gvhtGroupFooterCell:
      begin
        ASummaryItems := GetGroupSummaryItemsByGroupedColumn;
        if not Assigned(ASummaryItems) then
          ASummaryItems := ASummary.DefaultGroupSummaryItems;
        Result := GetDownBySummaryItems(ASummaryItems);
      end
  else
    Result := False;
  end;
end;

function TcxGridFooterMenuItem.GetEnabled: Boolean;
const
  NumberFieldTypes =
    [varSmallint, varInteger, varSmallint, varSingle, varByte,
      varDouble, varCurrency, varDate
  {$IFDEF DELPHI6}, varLongWord, varWord, varInt64, varShortInt{$ENDIF}];
  TimeFieldTypes = [varDate];
var
  AVarType: Integer;
{$IFDEF DELPHI6}
  AFMTBcdValueType: Integer;
{$ENDIF}
begin
  Result := HitColumn.DataBinding.ValueTypeClass <> nil;
  if not Result then
    Exit;
  AVarType := HitColumn.DataBinding.ValueTypeClass.GetVarType;
{$IFDEF DELPHI6}
  AFMTBcdValueType := TcxFMTBcdValueType.GetVarType;
{$ENDIF}
  Result := {$IFDEF DELPHI6}(AVarType = AFMTBcdValueType) or {$ENDIF}
    (AVarType in NumberFieldTypes);
  if GetKind in [skSum, skAverage] then
    Result := Result and not (AVarType in TimeFieldTypes);
  if GetKind in [skCount, skNone] then Result := True;
  if (HitColumn.PropertiesClass <> nil) and
    (HitColumn.PropertiesClass.InheritsFrom(TcxCustomLookupEditProperties)) or
    ((HitColumn.RepositoryItem <> nil) and
    (HitColumn.RepositoryItem.Properties.InheritsFrom(TcxCustomLookupEditProperties))) then
  begin
    if GetKind in [skCount, skNone] then
      Result := True
    else Result := False;
  end;
end;

function TcxGridFooterMenuItem.GetKind: TcxSummaryKind;
begin
    case Tag of
      0: Result := skSum;
      1: Result := skMin;
      2: Result := skMax;
      3: Result := skCount;
      4: Result := skAverage;
    else
      Result := skNone;
    end;
end;

function TcxGridFooterMenuItem.GetGroupSummaryItemsByGroupedColumn:
  TcxDataSummaryItems;
var
  ASummary: TcxDataSummary;
  I,J: Integer;
  ALink: TcxDataSummaryGroupItemLink;
  AViewInfo: TcxCustomGridCellViewInfo;
  AColumn: TcxGridColumn;
  ADataControllerGroups: TcxDataControllerGroups;
begin
  Result := nil;
  AViewInfo := GridPopupMenu.HitTest.ViewInfo;
  ASummary :=  GridPopupMenu.HitGridView.DataController.Summary;
  ADataControllerGroups := GridPopupMenu.HitGridView.DataController.Groups;
  AColumn := nil;
  if AViewInfo is TcxGridRowFooterCellViewInfo then
  begin
    I := ADataControllerGroups.DataGroupIndexByRowIndex[
      TcxGridRowFooterCellViewInfo(AViewInfo).GridRecord.Index];
    I := ADataControllerGroups.Level[I];
    I := ADataControllerGroups.GroupingItemIndex[I];
    if GridPopupMenu.HitGridView is TcxGridTableView then
      AColumn := TcxGridTableView(GridPopupMenu.HitGridView).Columns[I];
    if Assigned(AColumn) then
      for I := 0 to ASummary.SummaryGroups.Count - 1 do
        for J := 0 to ASummary.SummaryGroups[I].Links.Count - 1 do
        begin
          ALink := ASummary.SummaryGroups[I].Links[J];
          if ALink is TcxGridTableSummaryGroupItemLink then
            if TcxGridTableSummaryGroupItemLink(ALink).Column = AColumn then
            begin
              Result := ASummary.SummaryGroups[I].SummaryItems;
              break;
            end;
        end;
  end
end;

{ TcxGridSumMenuItem }

constructor TcxGridSumMenuItem.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoFooter);
  Tag := 0;
  ResCaption := @cxSGridSumMenuItem;
end;

{ TcxGridMinMenuItem }

constructor TcxGridMinMenuItem.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoFooter);
  Tag := 1;
  ResCaption := @cxSGridMinMenuItem;
end;

{ TcxGridMaxMenuItem }

constructor TcxGridMaxMenuItem.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoFooter);
  Tag := 2;
  ResCaption := @cxSGridMaxMenuItem;
end;

{ TcxGridCountMenuItem }

constructor TcxGridCountMenuItem.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoFooter);
  Tag := 3;
  ResCaption := @cxSGridCountMenuItem;
end;

{ TcxGridAvgMenuItem }

constructor TcxGridAvgMenuItem.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoFooter);
  Tag := 4;
  ResCaption := @cxSGridAvgMenuItem;
end;

{ TcxGridNoneMenuItem }

constructor TcxGridNoneMenuItem.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoFooter, True);
  Tag := 5;
  ResCaption := @cxSGridNoneMenuItem;
end;

Initialization
  cxGridPopupMenuOperations.RegisterOperation(TcxGridSumMenuItem, AImageName+'1');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridMinMenuItem, AImageName+'2');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridMaxMenuItem, AImageName+'3');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridCountMenuItem, AImageName+'4');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridAvgMenuItem, AImageName+'5');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridNoneMenuItem, '');
end.
