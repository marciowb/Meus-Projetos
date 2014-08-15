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

unit cxGridHeaderPopupMenuItems;

{$I cxVer.inc}

interface

uses
  Windows,
  Dialogs, Classes, SysUtils, cxGridTableView, cxGridCustomPopupMenu, cxGridMenuOperations;
  
type
  TcxGridHeaderPopupMenuOperation = class(TcxGridTablePopupMenuOperation)
  public
    class function GetPopupMenuClass: TcxPopupMenuClass; override;
  end;

  TcxGridSortingMenuOperation = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoSortingOperation(Sender: TObject); virtual;
    function GetVisible: Boolean; override;
    function IsSorted: Boolean;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridSortColumn = class(TcxGridSortingMenuOperation)
  protected
    procedure DoSortingOperation(Sender: TObject); override;
    function GetDown: Boolean; override;
    function GetEnabled: Boolean; override;
  end;

  TcxGridSortColumnAsc = class(TcxGridSortColumn)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridSortColumnDesc = class(TcxGridSortColumn)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridClearSorting = class(TcxGridSortingMenuOperation)
  protected
    function GetEnabled: Boolean; override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridGroupByThisField = class(TcxGridHeaderPopupMenuOperation)
  protected
    function GetCaption: string; override;
    function GetEnabled: Boolean; override;
    function GetVisible: Boolean; override;
    procedure DoGroupBy(Sender: TObject);
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridGroupByBox = class(TcxGridHeaderPopupMenuOperation)
  protected
    function GetDown: Boolean; override;
    function GetVisible: Boolean; override;
    procedure DoGroupByBox(Sender: TObject);
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridAlignmentSubMenu = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoAlign(Sender: TObject);
    function GetVisible: Boolean; override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridAlign = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoAlign(Sender: TObject);
    function GetDown: Boolean; Override;
    function GetEnabled: Boolean; override;
  public
    class function GetSubOperationClass: TcxGridPopupMenuOperationClass; override;
  end;

  TcxGridAlignLeft = class(TcxGridAlign)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridAlignRight = class(TcxGridAlign)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridAlignCenter = class(TcxGridAlign)
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridBestFit = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoBestFit(Sender: TObject);
    function GetEnabled: Boolean; override;
    function GetVisible: Boolean; override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridBestFitAllColumns = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoBestFitAllColumns(Sender: TObject);
    function GetVisible: Boolean; override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridRemoveColumn = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoRemoveThisColumn(Sender: TObject);
    function GetVisible: Boolean; override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridFieldChooser = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoFieldChooser(Sender: TObject);
    function GetDown: Boolean; Override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridShowFooter = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoShowFooter(Sender: TObject);
    function GetDown: Boolean; Override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

  TcxGridShowGroupFooter = class(TcxGridHeaderPopupMenuOperation)
  protected
    procedure DoShowFooter(Sender: TObject);
    function GetDown: Boolean; Override;
    function GetEnabled: Boolean; override;
    function GetVisible: Boolean; override;
  public
    constructor Create(const AMenuItem: TComponent); override;
  end;

var
  AOperationList: TList;
  
implementation

uses
  cxGridPopupMenu, cxGridStdPopupMenu, cxGridCustomTableView, cxClasses,
  cxCustomData, cxEdit, cxMaskEdit, cxGridPopupMenuConsts, cxGridCustomView;

type
  TcxGridTableViewAccess = class(TcxGridTableView);

const
  AImageName = 'HdrImg';

{ TcxGridHeaderPopupMenuOperation }

class function TcxGridHeaderPopupMenuOperation.GetPopupMenuClass: TcxPopupMenuClass;
begin
  Result := TcxGridStdHeaderMenu;
end;

{ TcxGridSortingMenuOperation }

constructor TcxGridSortingMenuOperation.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoSortingOperation);
end;

procedure TcxGridSortingMenuOperation.DoSortingOperation(Sender: TObject);
begin
  if IsSorted then
    GridPopupMenu.HitGridView.DataController.ClearSorting(True);
end;

function TcxGridSortingMenuOperation.GetVisible: Boolean;
begin
  Result := TcxGridTableView(GridPopupMenu.HitGridView).OptionsCustomize.ColumnSorting;
end;

function TcxGridSortingMenuOperation.IsSorted: Boolean;
var
  I: Integer;
begin
  Result := False;
  with TcxGridTableView(GridPopupMenu.HitGridView) do
    if SortedItemCount > 0 then
      for I := 0 to SortedItemCount - 1 do
        if TcxCustomGridTableItemAccess.GetGroupIndex(SortedItems[I]) = -1 then
        begin
          Result := True;
          Break; 
        end;
end;

{ TcxGridSortColumn }

procedure TcxGridSortColumn.DoSortingOperation(Sender: TObject);
var
  ASortOrder: TcxDataSortOrder;
begin
  inherited DoSortingOperation(Sender);
  case Tag of
    0: ASortOrder := soAscending;
    1: ASortOrder := soDescending;
  else
    ASortOrder := soNone;
  end;
  HitColumn.SortOrder := ASortOrder;
end;

function TcxGridSortColumn.GetDown: Boolean;
begin
  if Tag = 0 then
    Result := HitColumn.SortOrder = soAscending
  else
    Result := HitColumn.SortOrder = soDescending;
end;

function TcxGridSortColumn.GetEnabled: Boolean;
begin
  Result := TcxCustomGridTableItemAccess.CanSort(HitColumn);
end;

{ TcxGridSortColumnAsc }

constructor TcxGridSortColumnAsc.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  ResCaption := @cxSGridSortColumnAsc;
  Tag := 0;
end;

{ TcxGridSortColumnDesc }

constructor TcxGridSortColumnDesc.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  ResCaption := @cxSGridSortColumnDesc;
  Tag := 1;
end;

{ TcxGridClearSorting }

constructor TcxGridClearSorting.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  ResCaption := @cxSGridClearSorting;
end;

function TcxGridClearSorting.GetEnabled: Boolean;
begin
  Result := IsSorted;
end;

{ TcxGridGroupBy }

constructor TcxGridGroupByThisField.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoGroupBy, True);
  ResCaption := @cxSGridGroupByThisField;
end;

function TcxGridGroupByThisField.GetCaption: string;
begin
  if HitColumn.GroupIndex <> -1 then
    ResCaption := @cxSGridRemoveThisGroupItem
  else
    ResCaption := @cxSGridGroupByThisField;
  Result := inherited GetCaption;
end;

function TcxGridGroupByThisField.GetEnabled: Boolean;
begin
  Result := TcxCustomGridTableItemAccess.CanGroup(HitColumn);
end;

function TcxGridGroupByThisField.GetVisible: Boolean;
begin
  Result := TcxGridTableView(GridPopupMenu.HitGridView).OptionsCustomize.ColumnGrouping;
end;

procedure TcxGridGroupByThisField.DoGroupBy(Sender: TObject);
var
  AGroupIndex: Integer;
begin
  TcxGridTableView(GridPopupMenu.HitGridView).OptionsView.GroupByBox := True;
  if HitColumn.GroupIndex <> -1 then
    AGroupIndex := -1
  else
    AGroupIndex := TcxGridTableView(GridPopupMenu.HitGridView).GroupedColumnCount;
  HitColumn.GroupBy(AGroupIndex);
  TcxGridTableViewAccess(GridPopupMenu.HitGridView).DoColumnPosChanged(HitColumn);
end;

{ TcxGridGroupByBox }

constructor TcxGridGroupByBox.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoGroupByBox);
  ResCaption := @cxSGridGroupByBox;
end;

function TcxGridGroupByBox.GetDown: Boolean;
begin
  Result := GridOperationHelper.IsGroupingPanelShowing;
end;

function TcxGridGroupByBox.GetVisible: Boolean;
begin
  Result := TcxGridTableView(GridPopupMenu.HitGridView).OptionsCustomize.ColumnGrouping;
end;

procedure TcxGridGroupByBox.DoGroupByBox(Sender: TObject);
begin
  GridOperationHelper.DoShowGroupingPanel(not GridOperationHelper.IsGroupingPanelShowing);
end;

{ TcxGridAligmentSubMenu }

constructor TcxGridAlignmentSubMenu.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, nil, True, True);
  ResCaption := @cxSGridAlignmentSubMenu;
end;

procedure TcxGridAlignmentSubMenu.DoAlign(Sender: TObject);
begin
end;

function TcxGridAlignmentSubMenu.GetVisible: Boolean;
begin
  Result := HitColumn.Properties <> nil;
end;

{ TcxGridAlignLeft }

procedure TcxGridAlign.DoAlign(Sender: TObject);
begin
  case Tag of
    0: HitColumn.GetProperties.Alignment.Horz := taLeftJustify;
    1: HitColumn.GetProperties.Alignment.Horz := taRightJustify;
    2: HitColumn.GetProperties.Alignment.Horz := taCenter;
  end;
end;

function TcxGridAlign.GetDown: Boolean;
var
  AProperties: TcxCustomEditProperties;
begin
  AProperties := HitColumn.GetProperties;
  case Tag of
    0: Result := AProperties.Alignment.Horz = taLeftJustify;
    1: Result := AProperties.Alignment.Horz = taRightJustify;
  else
    Result := AProperties.Alignment.Horz = taCenter;
  end;
end;

function TcxGridAlign.GetEnabled: Boolean;
begin
  Result := esoHorzAlignment in HitColumn.GetProperties.GetSupportedOperations;
end;

class function TcxGridAlign.GetSubOperationClass: TcxGridPopupMenuOperationClass;
begin
  Result := TcxGridAlignmentSubMenu;
end;

{ TcxGridAlignLeft }

constructor TcxGridAlignLeft.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoAlign, False);
  ResCaption := @cxSGridAlignLeft;
  Tag := 0;
end;

{ TcxGridAlignRight }

constructor TcxGridAlignRight.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoAlign, False);
  ResCaption := @cxSGridAlignRight;
  Tag := 1;
end;

{ TcxGridAlignCenter }

constructor TcxGridAlignCenter.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoAlign, False);
  ResCaption := @cxSGridAlignCenter;
  Tag := 2;
end;

{ TcxGridBestFit }

constructor TcxGridBestFit.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoBestFit, False);
  ResCaption := @cxSGridBestFit;
end;

procedure TcxGridBestFit.DoBestFit(Sender: TObject);
begin
  HitColumn.ApplyBestFit(True, True);
end;

function TcxGridBestFit.GetEnabled: Boolean;
begin
  Result := TcxCustomGridTableItemAccess.CanHorzSize(HitColumn);
end;

function TcxGridBestFit.GetVisible: Boolean;
begin
  Result := TcxGridTableView(GridPopupMenu.HitGridView).OptionsCustomize.ColumnHorzSizing;
end;

{ TcxGridBestFitAllColumns }

constructor TcxGridBestFitAllColumns.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoBestFitAllColumns, True);
  ResCaption := @cxSGridBestFitAllColumns;
end;

procedure TcxGridBestFitAllColumns.DoBestFitAllColumns(Sender: TObject);
begin
  TcxCustomGridTableView(GridPopupMenu.HitGridView).ApplyBestFit(nil, True, True);
end;

function TcxGridBestFitAllColumns.GetVisible: Boolean;
begin
  Result := TcxGridTableView(GridPopupMenu.HitGridView).OptionsCustomize.ColumnHorzSizing;
end;

{ TcxGridCustColumns }

constructor TcxGridRemoveColumn.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoRemoveThisColumn, True);
  ResCaption := @cxSGridRemoveColumn;
end;

procedure TcxGridRemoveColumn.DoRemoveThisColumn(Sender: TObject);
begin
  HitColumn.Visible := False;
  TcxGridTableViewAccess(GridPopupMenu.HitGridView).DoColumnPosChanged(HitColumn);
end;

function TcxGridRemoveColumn.GetVisible: Boolean;
begin
  Result := TcxCustomGridTableItemAccess.CanHide(HitColumn);
end;

{ TcxGridFieldChoozer }

constructor TcxGridFieldChooser.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoFieldChooser);
  ResCaption := @cxSGridFieldChooser;
end;

procedure TcxGridFieldChooser.DoFieldChooser(Sender: TObject);
begin
  GridOperationHelper.DoShowColumnCustomizing(
    not GridOperationHelper.IsColumnsCustomizingShowing);
end;

function TcxGridFieldChooser.GetDown: Boolean;
begin
  Result := GridOperationHelper.IsColumnsCustomizingShowing;
end;

{ TcxGridShowFooter }

constructor TcxGridShowFooter.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoShowFooter, True);
  ResCaption := @cxSGridShowFooter;
end;

procedure TcxGridShowFooter.DoShowFooter(Sender: TObject);
begin
  GridOperationHelper.DoShowSummaryFooter(
    not GridOperationHelper.IsSummaryFooterShowing);
end;

function TcxGridShowFooter.GetDown: Boolean;
begin
  Result := GridOperationHelper.IsSummaryFooterShowing;
end;

{ TcxGridShowGroupFooter }

constructor TcxGridShowGroupFooter.Create(const AMenuItem: TComponent);
begin
  inherited Create(AMenuItem);
  SetProperties(AMenuItem, DoShowFooter);
  ResCaption := @cxSGridShowGroupFooter;
end;

procedure TcxGridShowGroupFooter.DoShowFooter(Sender: TObject);
begin
  with TcxGridTableView(GridPopupMenu.HitGridView).OptionsView do
    if GroupFooters = gfInvisible then
      GroupFooters := PrevGroupFooters
    else
      GroupFooters := gfInvisible;
end;

function TcxGridShowGroupFooter.GetDown: Boolean;
begin
  Result := TcxGridTableView(GridPopupMenu.HitGridView).OptionsView.GroupFooters <> gfInvisible;
end;

function TcxGridShowGroupFooter.GetEnabled: Boolean;
begin
  Result := TcxGridTableView(GridPopupMenu.HitGridView).GroupedColumnCount <> 0;
end;

function TcxGridShowGroupFooter.GetVisible: Boolean;
begin
  with TcxGridTableView(GridPopupMenu.HitGridView) do
    Result := (GroupedColumnCount <> 0) or OptionsCustomize.ColumnGrouping;
end;

initialization
  cxGridPopupMenuOperations.RegisterOperation(TcxGridSortColumnAsc, AImageName+'1');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridSortColumnDesc, AImageName+'2');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridClearSorting,'');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridGroupByThisField, AImageName+'3');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridGroupByBox, AImageName+'7');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridShowFooter, AImageName+'10');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridShowGroupFooter, AImageName+'11');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridRemoveColumn,'');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridFieldChooser, AImageName + '8');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridAlignmentSubMenu,'');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridAlignLeft, AImageName+'4');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridAlignRight, AImageName+'5');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridAlignCenter, AImageName+'6');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridBestFit, AImageName+'9');
  cxGridPopupMenuOperations.RegisterOperation(TcxGridBestFitAllColumns,'');
  
end.
