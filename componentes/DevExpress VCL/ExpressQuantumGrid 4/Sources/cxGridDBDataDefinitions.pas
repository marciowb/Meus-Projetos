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

unit cxGridDBDataDefinitions;

interface

uses
  Classes, DB, cxGridCustomView, cxGridCustomTableView,
  cxCustomData, cxFilter, cxDBData, cxDataUtils,
  cxEdit, cxDBEdit;

type
  TcxGridDBDefaultValuesProvider = class(TcxCustomDBEditDefaultValuesProvider)
  public
    function IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean; override;
  end;

  TcxGridDBDataController = class(TcxDBDataController,
    IcxCustomGridDataController, IcxGridDataController)
  private
    FPrevScrollBarPos: Integer;
    function GetController: TcxCustomGridTableController;
    function GetGridViewValue: TcxCustomGridTableView;
  protected
    { IcxCustomGridDataController }
    procedure GetFakeComponentLinks(AList: TList);
    function GetGridView: TcxCustomGridView;
    { IcxGridDataController }
    procedure CheckGridModeBufferCount;
    function DoScroll(AForward: Boolean): Boolean;
    function DoScrollPage(AForward: Boolean): Boolean;
    function GetFilterPropertyValue(const AName: string; var AValue: Variant): Boolean;
    function GetItemDataBindingClass: TcxGridItemDataBindingClass;
    function GetItemDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
    function GetNavigatorIsBof: Boolean;
    function GetNavigatorIsEof: Boolean;
    function GetScrollBarPos: Integer;
    function GetScrollBarRecordCount: Integer;
    function SetFilterPropertyValue(const AName: string; const AValue: Variant): Boolean;
    function SetScrollBarPos(Value: Integer): Boolean;

    function CanSelectRow(ARowIndex: Integer): Boolean; override;
    procedure DoDataSetCurrentChanged(AIsCurrent: Boolean); override;
    procedure DoDataSourceChanged; override;
    procedure DoValueTypeClassChanged(AItemIndex: Integer); override;
    function GetDefaultActiveRelationIndex: Integer; override;
    function GetDefaultGridModeBufferCount: Integer; override;
    //function GetIncrementalSearchText(ARecordIndex, AItemIndex: Integer): string; override;
    function GetItemID(AItem: TObject): Integer; override;
    function GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass; override;
    function GetSummaryItemClass: TcxDataSummaryItemClass; override;
    function SupportsScrollBarParams: Boolean; virtual;
    procedure UpdateScrollBars; override;
  public
    procedure BeginFullUpdate; override;
    procedure EndFullUpdate; override;
    function CreateDetailLinkObject(ARelation: TcxCustomDataRelation;
      ARecordIndex: Integer): TObject; override;
    procedure FocusControl(AItemIndex: Integer; var Done: Boolean); override;
    function GetDetailDataControllerByLinkObject(ALinkObject: TObject): TcxCustomDataController; override;
    function GetDisplayText(ARecordIndex, AItemIndex: Integer): string; override;
    function GetFilterItemFieldCaption(AItem: TObject): string; override;
    function GetItem(Index: Integer): TObject; override;
    function GetItemSortByDisplayText(AItemIndex: Integer; ASortByDisplayText: Boolean): Boolean; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    procedure UpdateData; override;

    function AddItemToFilter(AParent: TcxFilterCriteriaItemList; AItem: TcxCustomGridTableItem;
      AOperatorKind: TcxFilterOperatorKind; const AValue: Variant; ADisplayText: string = '';
      AReplaceExistent: Boolean = True): TcxFilterCriteriaItem;
    procedure CreateAllItems;
    function GetItemByFieldName(const AFieldName: string): TcxCustomGridTableItem;

    property Controller: TcxCustomGridTableController read GetController;
    property GridView: TcxCustomGridTableView read GetGridViewValue;
  published
    property DataModeController;
    property DataSource;
    property DetailKeyFieldNames;
    property Filter;
    property KeyFieldNames;
    property MasterKeyFieldNames;
    property Options;
    property Summary;
    property OnCompare;
    property OnDataChanged;
    property OnDetailHasChildren;
    property OnGroupingChanged;
    property OnRecordChanged;
    property OnSortingChanged;
  end;

  TcxGridItemDBDataBinding = class(TcxGridItemDataBinding)
  private
    function GetDataController: TcxGridDBDataController;
    function GetField: TField;
    function GetFieldName: string;
    procedure SetFieldName(const Value: string);
  protected
    procedure Init; override;
    property DataController: TcxGridDBDataController read GetDataController;
  public
    procedure Assign(Source: TPersistent); override;
    function DefaultCaption: string; override;
    function DefaultRepositoryItem: TcxEditRepositoryItem; override;
    function DefaultWidth(ATakeHeaderIntoAccount: Boolean = True): Integer; override;
    property Field: TField read GetField;
  published
    property FieldName: string read GetFieldName write SetFieldName;
  end;

implementation

uses
  SysUtils, cxGraphics, cxControls, cxLookAndFeelPainters, cxEditDBRegisteredRepositoryItems,
  cxStorage, cxGridCommon, cxGridLevel, Controls, Forms;

type
  TcxGridLevelAccess = class(TcxGridLevel);
  TcxCustomGridTableControllerAccess = class(TcxCustomGridTableController);
  TcxCustomGridTableViewInfoAccess = class(TcxCustomGridTableViewInfo);
  TcxCustomGridTableItemAccess = class(TcxCustomGridTableItem);
  TcxCustomGridTableViewAccess = class(TcxCustomGridTableView);
  TcxDBDataProviderAccess = class(TcxDBDataProvider);

{ TcxGridDBDefaultValuesProvider }

function TcxGridDBDefaultValuesProvider.IsDisplayFormatDefined(AIsCurrencyValueAccepted: Boolean): Boolean;
begin
  Result := TcxGridItemDataBinding(Owner).IsDisplayFormatDefined;
end;

{ TcxGridDBDataController }

function TcxGridDBDataController.GetController: TcxCustomGridTableController;
begin
  Result := GridView.Controller;
end;

function TcxGridDBDataController.GetGridViewValue: TcxCustomGridTableView;
begin
  Result := TcxCustomGridTableView(GetGridView);
end;

procedure TcxGridDBDataController.GetFakeComponentLinks(AList: TList);
begin
  if (DataSource <> nil) and (DataSource.Owner <> GridView.Owner) and
    (AList.IndexOf(DataSource.Owner) = -1) then
    AList.Add(DataSource.Owner);
end;

function TcxGridDBDataController.GetGridView: TcxCustomGridView;
begin
  Result := TcxCustomGridView(GetOwner);
end;

procedure TcxGridDBDataController.CheckGridModeBufferCount;
begin
  UpdateGridModeBufferCount;
end;

function TcxGridDBDataController.DoScroll(AForward: Boolean): Boolean;
begin
  Result := SupportsScrollBarParams;
  if Result then
    with Controller do
      if AForward then
        GoToNext(False, False)
      else
        GoToPrev(False, False);
end;

function TcxGridDBDataController.DoScrollPage(AForward: Boolean): Boolean;
begin
  Result := SupportsScrollBarParams;
  if Result then
    with TcxCustomGridTableControllerAccess(Controller) do
      if AForward then
        FocusNextPage(False)
      else
        FocusPrevPage(False);
end;

function TcxGridDBDataController.GetFilterPropertyValue(const AName: string;
  var AValue: Variant): Boolean;
begin
  Result := True;
  if AName = 'FilterAutoDataSetFilter' then
    AValue := Filter.AutoDataSetFilter
  else
    Result := False;
end;

function TcxGridDBDataController.GetItemDataBindingClass: TcxGridItemDataBindingClass;
begin
  Result := TcxGridItemDBDataBinding;
end;

function TcxGridDBDataController.GetItemDefaultValuesProviderClass: TcxCustomEditDefaultValuesProviderClass;
begin
  Result := TcxGridDBDefaultValuesProvider;
end;

function TcxGridDBDataController.GetNavigatorIsBof: Boolean;
begin
  if IsGridMode then
    Result := IsBOF
  else
    Result := GridView.Controller.IsStart;
end;

function TcxGridDBDataController.GetNavigatorIsEof: Boolean;
begin
  if IsGridMode then
    Result := IsEOF
  else
    Result := GridView.Controller.IsFinish;
end;

function TcxGridDBDataController.GetScrollBarPos: Integer;
begin
  if SupportsScrollBarParams then
    if dceInsert in EditState then
      Result := FPrevScrollBarPos
    else
      Result := RecNo - 1
  else
    Result := -1;
  FPrevScrollBarPos := Result;
end;

function TcxGridDBDataController.GetScrollBarRecordCount: Integer;
begin
  if SupportsScrollBarParams then
    Result := DataSetRecordCount + GridView.ViewInfo.VisibleRecordCount - 1
  else
    Result := -1;
end;

function TcxGridDBDataController.SetFilterPropertyValue(const AName: string;
  const AValue: Variant): Boolean;
begin
  Result := True;
  if AName = 'FilterAutoDataSetFilter' then
    Filter.AutoDataSetFilter := StringToBoolean(AValue)
  else
    Result := False;
end;

function TcxGridDBDataController.SetScrollBarPos(Value: Integer): Boolean;
begin
  Result := SupportsScrollBarParams;
  if Result then
    RecNo := Value + 1;
end;

function TcxGridDBDataController.CanSelectRow(ARowIndex: Integer): Boolean;
begin
  Result := TcxCustomGridTableViewAccess(GridView).CanSelectRecord(ARowIndex);
end;

procedure TcxGridDBDataController.DoDataSetCurrentChanged(AIsCurrent: Boolean);
begin
  inherited;
  TcxCustomGridTableViewAccess(GridView).RefreshNavigators;
end;

procedure TcxGridDBDataController.DoDataSourceChanged;
begin
  TcxCustomGridTableViewAccess(GridView).UpdateFakeLinks;
end;

procedure TcxGridDBDataController.DoValueTypeClassChanged(AItemIndex: Integer);
begin
  inherited;
  TcxCustomGridTableViewAccess(GridView).ItemValueTypeClassChanged(AItemIndex);
end;

function TcxGridDBDataController.GetDefaultActiveRelationIndex: Integer;
begin
  Result := TcxCustomGridTableViewAccess(GridView).GetDefaultActiveDetailIndex;
end;

function TcxGridDBDataController.GetDefaultGridModeBufferCount: Integer;
begin
  Result := TcxCustomGridTableViewInfoAccess(GridView.ViewInfo).GetDefaultGridModeBufferCount;
  if Result = 0 then
    Result := inherited GetDefaultGridModeBufferCount;
end;

{function TcxGridDBDataController.GetIncrementalSearchText(ARecordIndex, AItemIndex: Integer): string;
begin
  if not TcxCustomGridTableViewAccess(GridView).GetDisplayText(ARecordIndex, AItemIndex, Result) then
    Result := inherited GetIncrementalSearchText(ARecordIndex, AItemIndex);
end;}

function TcxGridDBDataController.GetItemID(AItem: TObject): Integer;
begin
  if AItem is TcxCustomGridTableItem then
    Result := TcxCustomGridTableItem(AItem).ID
  else
    Result := -1;
end;

function TcxGridDBDataController.GetSummaryGroupItemLinkClass: TcxDataSummaryGroupItemLinkClass;
begin
  Result := TcxCustomGridTableViewAccess(GridView).GetSummaryGroupItemLinkClass;
  if Result = nil then
    Result := inherited GetSummaryGroupItemLinkClass;
end;

function TcxGridDBDataController.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := TcxCustomGridTableViewAccess(GridView).GetSummaryItemClass;
  if Result = nil then
    Result := inherited GetSummaryItemClass;
end;

function TcxGridDBDataController.SupportsScrollBarParams: Boolean;
begin
  Result := IsGridMode and IsSequenced and
    TcxCustomGridTableViewAccess(GridView).IsEqualHeightRecords;
end;

procedure TcxGridDBDataController.UpdateScrollBars;
begin
  inherited;
  Controller.UpdateScrollBars;
end;

procedure TcxGridDBDataController.BeginFullUpdate;
begin
  GridView.BeginUpdate;
  inherited;
end;

procedure TcxGridDBDataController.EndFullUpdate;
begin
  inherited;
  GridView.EndUpdate;
end;

function TcxGridDBDataController.CreateDetailLinkObject(ARelation: TcxCustomDataRelation;
  ARecordIndex: Integer): TObject;
begin
  Result := TcxGridLevelAccess(ARelation.Item).CreateLinkObject(ARelation, ARecordIndex);
end;

procedure TcxGridDBDataController.FocusControl(AItemIndex: Integer; var Done: Boolean);
begin
  inherited;
  TcxCustomGridTableViewAccess(GridView).FocusEdit(AItemIndex, Done);
end;

function TcxGridDBDataController.GetDetailDataControllerByLinkObject(ALinkObject: TObject): TcxCustomDataController;
begin
  Result := TcxCustomGridView(ALinkObject).DataController;
end;

function TcxGridDBDataController.GetDisplayText(ARecordIndex, AItemIndex: Integer): string;
begin                                     
  if not TcxCustomGridTableViewAccess(GridView).GetDisplayText(ARecordIndex, AItemIndex, Result) then
    Result := inherited GetDisplayText(ARecordIndex, AItemIndex);
  {with TcxCustomGridTableViewAccess(GridView) do
    DoGetDisplayText(ViewData.GetRecordByRecordIndex(ARecordIndex), AItemIndex, Result);}
end;

function TcxGridDBDataController.GetFilterItemFieldCaption(AItem: TObject): string;
begin
  Result := TcxCustomGridTableItemAccess(AItem).FilterCaption;
end;

function TcxGridDBDataController.GetItem(Index: Integer): TObject;
begin
  Result := TcxCustomGridTableViewAccess(GridView).Items[Index];
end;

function TcxGridDBDataController.GetItemSortByDisplayText(AItemIndex: Integer;
  ASortByDisplayText: Boolean): Boolean;
begin
  Result := TcxCustomGridTableViewAccess(GridView).GetItemSortByDisplayText(AItemIndex);
end;

function TcxGridDBDataController.GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := TcxCustomGridTableViewAccess(GridView).GetItemValueSource(AItemIndex);
end;

procedure TcxGridDBDataController.UpdateData;
begin
  inherited;
  TcxCustomGridTableViewAccess(GridView).UpdateRecord;
end;

function TcxGridDBDataController.AddItemToFilter(AParent: TcxFilterCriteriaItemList;
  AItem: TcxCustomGridTableItem; AOperatorKind: TcxFilterOperatorKind;
  const AValue: Variant; ADisplayText: string; AReplaceExistent: Boolean): TcxFilterCriteriaItem;
begin
  if ADisplayText = '' then ADisplayText := AValue;  //!!!
  AItem.DataBinding.GetFilterDisplayText(AValue, ADisplayText);
  if AReplaceExistent then
    Filter.RemoveItemByItemLink(AItem);
  Result := Filter.AddItem(AParent, AItem, AOperatorKind, AValue, ADisplayText);
end;

procedure TcxGridDBDataController.CreateAllItems;
var
  I: Integer;
  AItem: TcxCustomGridTableItem;
begin
  if DataSet = nil then Exit;
  ShowHourglassCursor;
  try
    GridView.BeginUpdate;
    try
      with DataSet do
        for I := 0 to FieldCount - 1 do
        begin
          AItem := TcxCustomGridTableViewAccess(GridView).CreateItem;
          with TcxCustomGridTableItemAccess(AItem) do
          begin
            with DataBinding as TcxGridItemDBDataBinding do
              FieldName := Fields[I].FieldName;
            Visible := Fields[I].Visible;
          end;
        end;
    finally
      GridView.EndUpdate;
    end;
  finally
    HideHourglassCursor;
  end;
end;

function TcxGridDBDataController.GetItemByFieldName(const AFieldName: string): TcxCustomGridTableItem;
begin
  Result := TcxCustomGridTableItem(inherited GetItemByFieldName(AFieldName));
end;

{ TcxGridItemDBDataBinding }

function TcxGridItemDBDataBinding.GetDataController: TcxGridDBDataController;
begin
  Result := TcxGridDBDataController(inherited DataController);
end;

function TcxGridItemDBDataBinding.GetField: TField;
begin
  Result := DataController.GetItemField(Item.Index);
end;

function TcxGridItemDBDataBinding.GetFieldName: string;
begin
  Result := DataController.GetItemFieldName(Item.Index);
end;

procedure TcxGridItemDBDataBinding.SetFieldName(const Value: string);
begin
  DataController.ChangeFieldName(Item.Index, Value);
end;

procedure TcxGridItemDBDataBinding.Init;
begin
  inherited;
  TcxCustomDBEditDefaultValuesProvider(DefaultValuesProvider).DataSource := DataController.DataSource;
  TcxCustomDBEditDefaultValuesProvider(DefaultValuesProvider).Field := Field;
end;

procedure TcxGridItemDBDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxGridItemDBDataBinding then
    FieldName := TcxGridItemDBDataBinding(Source).FieldName;
  inherited;
end;

function TcxGridItemDBDataBinding.DefaultCaption: string;
var
  AField: TField;
begin
  AField := Field;
  if AField = nil then
    Result := FieldName
  else
    Result := AField.DisplayName;
end;

function TcxGridItemDBDataBinding.DefaultRepositoryItem: TcxEditRepositoryItem;
begin
  Result := GetDefaultEditDBRepositoryItems.GetItemByField(Field);
end;

function TcxGridItemDBDataBinding.DefaultWidth(ATakeHeaderIntoAccount: Boolean = True): Integer;
var
  AField: TField;
  ACanvas: TcxCanvas;
  AParams: TcxViewParams;
  //W: Integer;
begin
  AField := Field;
  if AField = nil then
    Result := inherited DefaultWidth(ATakeHeaderIntoAccount)
  else
  begin
    ACanvas := GridView.ViewInfo.Canvas;
    TcxCustomGridTableItemAccess(Item).Styles.GetContentParams(nil, AParams);
    ACanvas.Font := AParams.Font;
    Result := AField.DisplayWidth * ACanvas.TextWidth('0') + 2 * cxTextOffset;
    {if ATakeHeaderIntoAccount then
    begin
      W := ACanvas.TextWidth(TcxCustomGridTableItemAccess(Item).Caption) +
        2 * (GridView.LookAndFeelPainter.HeaderBorderSize + cxTextOffset);
      if W > Result then Result := W;
    end;}
  end;
  TcxCustomGridTableItemAccess(Item).CheckWidthValue(Result);
end;

initialization
  RegisterClasses([TcxGridItemDBDataBinding]);

end.
