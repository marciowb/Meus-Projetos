{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Extended Data Module                                    }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebExtData;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, DB,
  cxWebIntf, cxWebClasses, cxWebTypes, cxWebRender,
  cxWebData, cxCustomData, cxDataUtils, cxDataStorage, cxDBData;

type
  TcxGridDataControllerChange = (dccGlobal, dccItemAdded, dccItemRemoved, dccIndexesChanged);
  TcxWebDataController = class;
  TcxWebDBDataController = class;
  TcxWebDataControllerField = class;
  TcxWebDBDataControllerField = class;
  TcxExtWebDataSource = class;
  TcxWebDataSource = class;
  TcxWebDBDataSource = class;

  TcxCustomWebDataControllerField = class(TcxCustomWebDataField)
  private
    function GetGroupingIndex: Integer;
    function GetSortingOrder: TcxWebDataSortOrder;
    procedure SetGroupingIndex(const Value: Integer);
    procedure SetSortingOrder(const Value: TcxWebDataSortOrder);
    procedure UpdateDataController(AChange: TcxGridDataControllerChange);
  protected
    function DataController: TcxCustomDataController; overload; virtual;
    function DataSource: TcxExtWebDataSource; reintroduce; overload;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property GroupingIndex: Integer read GetGroupingIndex write SetGroupingIndex;
    property SortingOrder: TcxWebDataSortOrder read GetSortingOrder write SetSortingOrder;
  end;

  TcxCustomWebDataControllerFields = class(TcxCustomWebDataFields)
  private
    function GetItem(Index: Integer): TcxCustomWebDataControllerField;
    procedure SetItem(Index: Integer; Value: TcxCustomWebDataControllerField);
  protected
    class function FieldClass: TcxCustomWebDataFieldClass; override;
  public
    function Add: TcxCustomWebDataControllerField;
    function DataSource: TcxExtWebDataSource; reintroduce; overload;

    property Items[Index: Integer]: TcxCustomWebDataControllerField read GetItem write SetItem; default;
  end;

  TcxValueType = (StringType, WideStringType, SmallintType,
      IntegerType, WordType, BooleanType, FloatType,
      CurrencyType, DateTimeType, FMTBcdType, LargeIntType,
      VariantType, ObjectType);

  TcxWebDataControllerField = class(TcxCustomWebDataControllerField)
  private
    FValueType: TcxValueType;

    function GetValueType: TcxValueType;
    function GetValueTypeClass: TcxValueTypeClass;
    procedure SetValueType(Value: TcxValueType);
  protected
    function DataController: TcxWebDataController; reintroduce; overload;
    function DataSource: TcxWebDataSource; reintroduce; overload;
  public
    constructor Create(Collection: TCollection); override;

    property ValueTypeClass: TcxValueTypeClass read GetValueTypeClass;
  published
    property ValueType: TcxValueType read GetValueType write SetValueType;
  end;

  TcxWebDBDataControllerField = class(TcxCustomWebDataControllerField)
  private
    function GetDataSet: TDataSet;
    function GetFieldName: string;
    procedure SetFieldName(const Value: string);
  protected
    function DataController: TcxWebDBDataController;  reintroduce; overload;
    function DataSource: TcxWebDBDataSource; reintroduce; overload;
  public
    property DataSet: TDataSet read GetDataSet;
  published
    property FieldName: string read GetFieldName write SetFieldName;
  end;

  TcxWebDataControllerFields = class(TcxCustomWebDataControllerFields)
  private
    function GetItem(Index: Integer): TcxWebDataControllerField;
    procedure SetItem(Index: Integer; Value: TcxWebDataControllerField);
  protected
    class function FieldClass: TcxCustomWebDataFieldClass; override;
  public
    function Add: TcxWebDataControllerField;
    function DataSource: TcxWebDataSource; reintroduce; overload;

    property Items[Index: Integer]: TcxWebDataControllerField read GetItem write SetItem; default;
  end;

  TcxWebDBDataControllerFields = class(TcxCustomWebDataControllerFields)
  private
    function GetItem(Index: Integer): TcxWebDBDataControllerField;
    procedure SetItem(Index: Integer; Value: TcxWebDBDataControllerField);
  protected
    class function FieldClass: TcxCustomWebDataFieldClass; override;
  public
    function Add: TcxWebDBDataControllerField;
    function DataSource: TcxWebDBDataSource; reintroduce; overload;

    property Items[Index: Integer]: TcxWebDBDataControllerField read GetItem write SetItem; default;
  end;

  TcxWebDataControllerClass = class of TcxWebDataController;
  TcxWebDataController = class(TcxCustomDataController)
  private
    FWebDataSource: TcxWebDataSource;
  public
    function GetItem(Index: Integer): TObject; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;

    property WebDataSource: TcxWebDataSource read FWebDataSource write FWebDataSource;
  end;

  TcxWebDBDataControllerClass = class of TcxWebDBDataController;
  TcxWebDBDataController = class(TcxDBDataController)
  private
    FWebDataSource: TcxWebDBDataSource;

    function GetDataSet: TDataSet;
  public
    function GetItem(Index: Integer): TObject; override;
    function GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource; override;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;

    property DataSet: TDataSet read GetDataSet;
    property WebDataSource: TcxWebDBDataSource read FWebDataSource write FWebDataSource;
  end;

  TGroupingEvent = procedure (Sender: TObject; GroupField, GroupIndex: Integer) of object;
  TSortingEvent = procedure (Sender: TObject; SortField: Integer; SortOrder: TcxWebDataSortOrder) of object;
  TExpandingEvent = procedure (Sender: TObject; ARowIndex: Integer; AExpanded, ARecursive: Boolean) of object;

  TcxExtWebDataSource = class(TcxCustomWebDataSource)
  private
    FDataController: TcxCustomDataController;

    FAllowExpanding: Boolean;
    FAllowGrouping: Boolean;
    FAllowSorting: Boolean;
    FAutoCompleteGroupedFields: Boolean;

    FOnExpanded: TExpandingEvent;
    FOnExpanding: TExpandingEvent;
    FOnGrouped: TGroupingEvent;
    FOnGrouping: TGroupingEvent;
    FOnSorted: TSortingEvent;
    FOnSorting: TSortingEvent;

    procedure SetAllowExpanding(Value: Boolean);
    procedure SetAllowGrouping(Value: Boolean);
    procedure SetAllowSorting(Value: Boolean);

    function GetItemSortIndex(AItemIndex: Integer): Integer;
    { Web actions }
    procedure WebSort(const AParameters: TcxActionParameters); virtual;
    procedure WebGroup(const AParameters: TcxActionParameters); virtual;
    procedure WebUnGroup(const AParameters: TcxActionParameters); virtual;
    procedure WebExpand(const AParameters: TcxActionParameters); virtual;
  protected
    function GetAllowExpanding: Boolean; override;
    function GetAllowGrouping: Boolean; override;
    function GetAllowSorting: Boolean; override;
    { fields }
    function GetFields: TcxCustomWebDataControllerFields; reintroduce; overload;
    procedure SetFields(Value: TcxCustomWebDataControllerFields);
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    procedure SynchronizeSelection; override;
    procedure SynchronizeGrouping; virtual;
    procedure SynchronizeSorting; virtual;
    procedure SynchronizeExpanding; virtual;
    { actions }
    procedure RegisterActions; override;
    { IcxCodeProvider }
    procedure RegisterRenderers; override;
    { Data layout }
    function GetFocusedRowIndex: Integer; override;
    function GetRecordCount: Integer; override;
    function GetRowCount: Integer; override;
    function GetDisplayText(ARecordIndex, AItemIndex: Integer): string; override;
    function GetValue(ARecordIndex, AItemIndex: Integer): Variant; override;
    procedure SetFocusedRowIndex(Value: Integer); override;
    procedure SetValue(ARecordIndex, AItemIndex: Integer; const Value: Variant); override;
    { Inserting values }
    procedure StoreInsertingValues; override;
    { Datacontroller }
    procedure SetDataController(Value: TcxCustomDataController);
    function GetDataController: TcxCustomDataController; overload; virtual;
    property DataController: TcxCustomDataController read GetDataController write SetDataController;
  public
    constructor Create(AOwner: TComponent); override;
    { Data operations }
    procedure DeleteRecord(ARowIndex: Integer); override;
    procedure InsertRecord(ARowIndex: Integer); override;
    procedure EditRecord(ARowIndex: Integer); override;
    procedure Expand(ARowIndex: Integer; AExpanded, ARecursive: Boolean); override;
    procedure Group(GroupField, GroupIndex: Integer); override;
    procedure PostEdit(APriorControlName: string); override;
    procedure SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes); override;
    procedure Sort(SortIndex: Integer; SortOrder: TcxWebDataSortOrder); override;
    procedure UnGroup(UnGroupIndex: Integer); override;
    { Data layout }
    function ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass; override;
    function GetRowDisplayText(RowIndex: Integer; ItemIndex: Integer): string; override;
    function GetRowValue(RowIndex: Integer; ItemIndex: Integer): Variant; override;
    function GetRowExpanded(RowIndex: Integer): Boolean; override;
    function GetRowLevel(RowIndex: Integer): Integer; override;
    function GetRowRecord(RowIndex: Integer): Integer; override;
    function GetGroupingItemCount: Integer; override;
    function GetSortingItemCount: Integer; override;
    function GetItemGroupIndex(ItemIndex: Integer): Integer; override;
    function GetItemSortOrder(ItemIndex: Integer): TcxWebDataSortOrder; override;
    function GetGroupingItemIndex(Item: Integer): Integer; override;
    function GetSortingItemIndex(Item: Integer): Integer; override;
    procedure ClearGrouping; override;
    procedure ClearSorting; override;
    procedure FullCollapse; override;
    procedure FullExpand; override;

    property Fields: TcxCustomWebDataControllerFields read GetFields write SetFields;
  published
    property AllowExpanding: Boolean read FAllowExpanding write SetAllowExpanding default True;
    property AllowGrouping: Boolean read FAllowGrouping write SetAllowGrouping default True;
    property AllowSorting: Boolean read FAllowSorting write SetAllowSorting default True;
    property AutoCompleteGroupedFields: Boolean read FAutoCompleteGroupedFields
      write FAutoCompleteGroupedFields default True;

    property OnExpanded: TExpandingEvent read FOnExpanded write FOnExpanded;
    property OnExpanding: TExpandingEvent read FOnExpanding write FOnExpanding;
    property OnGrouped: TGroupingEvent read FOnGrouped write FOnGrouped;
    property OnGrouping: TGroupingEvent read FOnGrouping write FOnGrouping;
    property OnSorted: TSortingEvent read FOnSorted write FOnSorted;
    property OnSorting: TSortingEvent read FOnSorting write FOnSorting;
  end;

  TcxExtWebDataSourceRenderer = class(TcxCustomWebDataSourceRenderer)
  protected
    function GetWebDataSource: TcxExtWebDataSource; reintroduce; overload;
    procedure WriteHandlers; override;
  public
    procedure WriteHiddenFormElements; override;
    property WebDataSource: TcxExtWebDataSource read GetWebDataSource;
  end;

  TcxExtWebDataSourceNS4Renderer = class(TcxCustomWebDataSourceNS4Renderer)
  protected
    function GetWebDataSource: TcxExtWebDataSource; reintroduce; overload;
  public
    procedure WriteHiddenFormElements; override;
    property WebDataSource: TcxExtWebDataSource read GetWebDataSource;
  end;

  TcxExtWebDataSourceOperaRenderer = class(TcxExtWebDataSourceNS4Renderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxWebDataSource = class(TcxExtWebDataSource)
  protected
    { Persistent }
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadData(Stream: TStream); virtual;
    procedure WriteData(Stream: TStream); virtual;
    { fields }
    function GetFields: TcxWebDataControllerFields; reintroduce; overload;
    procedure SetFields(Value: TcxWebDataControllerFields);
    { Data notification }
    procedure DataNotification(AUpdateType: TcxUpdateType); override;
    { Data layout }
    procedure SetRecordCount(Value: Integer); override;
    { Datacontroller }
    procedure SetDataController(Value: TcxWebDataController);
    function GetDataController: TcxWebDataController; reintroduce; overload;
    property DataController: TcxWebDataController read GetDataController write SetDataController;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Data Save/Load }
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToStream(AStream: TStream);
  published
    property Fields: TcxWebDataControllerFields read GetFields write SetFields;
    property RecordCount: Integer read GetRecordCount write SetRecordCount;
  end;

  TcxWebDBDataSource = class(TcxExtWebDataSource, IcxDataSetSupport)
  private
    FDataSource: TDataSource;
  protected
    function CanEdit: Boolean; override;
    function GetItemField(AItemName: string): TField;
    { IcxDataSetSupport }
    function GetDataSet: TDataSet;
    procedure SetDataSet(Value: TDataSet);
    { fields }
    function GetFields: TcxWebDBDataControllerFields; reintroduce; overload;
    procedure SetFields(Value: TcxWebDBDataControllerFields);
    { Data notification }
    procedure DataNotification(AUpdateType: TcxUpdateType); override;
    function NeedUpdateFields: Boolean; override;
    procedure UpdateDefaultFields; override;
    { Datacontroller }
    procedure SetDataController(Value: TcxWebDBDataController);
    function GetDataController: TcxWebDBDataController; reintroduce; overload;
    property DataController: TcxWebDBDataController read GetDataController write SetDataController;
    property DataSource: TDataSource read FDataSource;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Data operations }
    function ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass; override;

    property Fields: TcxWebDBDataControllerFields read GetFields write SetFields;
  published
    property DataSet: TDataSet read GetDataSet write SetDataSet;
  end;

implementation

uses DateUtils, StrUtils, Math, Variants,
  cxWebScriptFactory, cxWebDataCtrls, cxWebUtils, cxWebDataUtils;

{ TcxCustomWebDataControllerField }

constructor TcxCustomWebDataControllerField.Create(Collection: TCollection);
begin
  inherited;
  UpdateDataController(dccItemAdded);
end;

destructor TcxCustomWebDataControllerField.Destroy;
begin
  if not (csDestroying in TcxCustomWebDataControllerFields(Collection).DataSource.ComponentState) then
    UpdateDataController(dccItemRemoved);
  inherited;
end;

function TcxCustomWebDataControllerField.DataController: TcxCustomDataController;
begin
  Result := DataSource.DataController;
end;

function TcxCustomWebDataControllerField.DataSource: TcxExtWebDataSource;
begin
  Result := Collection.Owner as TcxExtWebDataSource;
end;

function TcxCustomWebDataControllerField.GetGroupingIndex: Integer;
begin
  Result := DataSource.GetItemGroupIndex(Index);
end;

function TcxCustomWebDataControllerField.GetSortingOrder: TcxWebDataSortOrder;
begin
  Result := DataSource.GetItemSortOrder(Index);
end;

procedure TcxCustomWebDataControllerField.SetGroupingIndex(const Value: Integer);
begin
  DataController.Groups.ChangeGrouping(Index, Value);
end;

procedure TcxCustomWebDataControllerField.SetSortingOrder(const Value: TcxWebDataSortOrder);
begin
  DataController.ChangeSorting(Index, TcxDataSortOrder(Value));
end;

procedure TcxCustomWebDataControllerField.UpdateDataController(
  AChange: TcxGridDataControllerChange);
begin
  if DataController <> nil then
    with DataController do
      case AChange of
        dccGlobal:
          UpdateItems(True);
        dccItemAdded:
          AddItem(Self);
        dccItemRemoved:
          RemoveItem(Self);
        dccIndexesChanged:
          UpdateItemIndexes;
      end;
end;

{ TcxCustomWebDataControllerFields }

function TcxCustomWebDataControllerFields.Add: TcxCustomWebDataControllerField;
begin
  Result := TcxCustomWebDataControllerField(inherited Add);
end;

function TcxCustomWebDataControllerFields.DataSource: TcxExtWebDataSource;
begin
  Result := inherited DataSource as TcxExtWebDataSource;
end;

class function TcxCustomWebDataControllerFields.FieldClass: TcxCustomWebDataFieldClass;
begin
  Result := TcxCustomWebDataControllerField;
end;

function TcxCustomWebDataControllerFields.GetItem(Index: Integer): TcxCustomWebDataControllerField;
begin
  Result := TcxCustomWebDataControllerField(inherited Items[Index]);
end;

procedure TcxCustomWebDataControllerFields.SetItem(Index: Integer; Value: TcxCustomWebDataControllerField);
begin
  Items[Index].Assign(Value);
end;

{ TcxWebDataControllerField }

constructor TcxWebDataControllerField.Create(Collection: TCollection);
begin
  inherited;
  ValueType := StringType;
end;

function TcxWebDataControllerField.DataController: TcxWebDataController;
begin
  Result := DataSource.DataController;
end;

function TcxWebDataControllerField.DataSource: TcxWebDataSource;
begin
  Result := Collection.Owner as TcxWebDataSource;
end;

const
  TypeClasses: array[TcxValueType] of string = ('TcxStringValueType', 'TcxWideStringValueType',
      'TcxSmallintValueType', 'TcxIntegerValueType', 'TcxWordValueType', 'TcxBooleanValueType',
      'TcxFloatValueType', 'TcxCurrencyValueType', 'TcxDateTimeValueType', 'TcxFMTBcdValueType',
      'TcxLargeIntValueType', 'TcxVariantValueType', 'TcxObjectValueType');

function TcxWebDataControllerField.GetValueType: TcxValueType;
begin
  Result := FValueType;
end;

function TcxWebDataControllerField.GetValueTypeClass: TcxValueTypeClass;
begin
  if DataController <> nil then
    Result := DataController.GetItemValueTypeClass(Index)
  else Result := nil;
end;

procedure TcxWebDataControllerField.SetValueType(Value: TcxValueType);
var
  ValueTypeClass: TcxValueTypeClass;
begin
  if DataController <> nil then
  begin
    FValueType := Value;
    case Value of
      StringType:
        ValueTypeClass := TcxStringValueType;
      WideStringType:
        ValueTypeClass := TcxWideStringValueType;
      SmallintType:
        ValueTypeClass := TcxSmallintValueType;
      IntegerType:
        ValueTypeClass := TcxIntegerValueType;
      WordType:
        ValueTypeClass := TcxWordValueType;
      BooleanType:
        ValueTypeClass := TcxBooleanValueType;
      FloatType:
        ValueTypeClass := TcxFloatValueType;
      CurrencyType:
        ValueTypeClass := TcxCurrencyValueType;
      DateTimeType:
        ValueTypeClass := TcxDateTimeValueType;
      FMTBcdType:
        ValueTypeClass := TcxFMTBcdValueType;
      LargeIntType:
        ValueTypeClass := TcxLargeIntValueType;
      VariantType:
        ValueTypeClass := TcxVariantValueType;
      ObjectType:
        ValueTypeClass := TcxObjectValueType;
    else
      ValueTypeClass := TcxVariantValueType;
    end;
    DataController.ChangeValueTypeClass(Index, ValueTypeClass);
  end;
end;

{ TcxWebDBDataControllerField }

function TcxWebDBDataControllerField.DataController: TcxWebDBDataController;
begin
  Result := DataSource.DataController;
end;

function TcxWebDBDataControllerField.DataSource: TcxWebDBDataSource;
begin
  Result := Collection.Owner as TcxWebDBDataSource;
end;

function TcxWebDBDataControllerField.GetDataSet: TDataSet;
begin
  if (Collection as TcxWebDBDataControllerFields).DataSource <> nil then
    Result := (Collection as TcxWebDBDataControllerFields).DataSource.DataSet
  else Result := nil;
end;

function TcxWebDBDataControllerField.GetFieldName: string;
begin
  if DataController <> nil then
    Result := DataController.GetItemFieldName(Index)
  else Result := '';
end;

procedure TcxWebDBDataControllerField.SetFieldName(const Value: string);
begin
  if DataController <> nil then
    DataController.ChangeFieldName(Index, Value);
end;

{ TcxWebDataControllerFields }

function TcxWebDataControllerFields.GetItem(Index: Integer): TcxWebDataControllerField;
begin
  Result := TcxWebDataControllerField(inherited Items[Index]);
end;

procedure TcxWebDataControllerFields.SetItem(Index: Integer; Value: TcxWebDataControllerField);
begin
  Items[Index].Assign(Value);
end;

class function TcxWebDataControllerFields.FieldClass: TcxCustomWebDataFieldClass;
begin
  Result := TcxWebDataControllerField;
end;

function TcxWebDataControllerFields.Add: TcxWebDataControllerField;
begin
  Result := TcxWebDataControllerField(inherited Add);
end;

function TcxWebDataControllerFields.DataSource: TcxWebDataSource;
begin
  Result := inherited DataSource as TcxWebDataSource;
end;

{ TcxWebDBDataControllerFields }

function TcxWebDBDataControllerFields.GetItem(Index: Integer): TcxWebDBDataControllerField;
begin
  Result := TcxWebDBDataControllerField(inherited Items[Index]);
end;

procedure TcxWebDBDataControllerFields.SetItem(Index: Integer; Value: TcxWebDBDataControllerField);
begin
  Items[Index].Assign(Value);
end;

class function TcxWebDBDataControllerFields.FieldClass: TcxCustomWebDataFieldClass;
begin
  Result := TcxWebDBDataControllerField
end;

function TcxWebDBDataControllerFields.Add: TcxWebDBDataControllerField;
begin
  Result := TcxWebDBDataControllerField(inherited Add);
end;

function TcxWebDBDataControllerFields.DataSource: TcxWebDBDataSource;
begin
  Result := inherited DataSource as TcxWebDBDataSource;
end;

{ TcxWebDataController }

function TcxWebDataController.GetItem(Index: Integer): TObject;
begin
  Result := WebDataSource.Fields[Index];
end;

function TcxWebDataController.GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := evsValue;
end;

procedure TcxWebDataController.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  if not (csDestroying in WebDataSource.ComponentState) then
    WebDataSource.DataNotification(utLayout);
  inherited;    
end;

{ TcxWebDBGridDataController }

function TcxWebDBDataController.GetDataSet: TDataSet;
begin
  if DataSource <> nil then
    Result := DataSource.DataSet
  else Result := nil;
end;

function TcxWebDBDataController.GetItem(Index: Integer): TObject;
begin
  Result := WebDataSource.Fields[Index];
end;

function TcxWebDBDataController.GetItemValueSource(AItemIndex: Integer): TcxDataEditValueSource;
begin
  Result := evsValue;
end;

procedure TcxWebDBDataController.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  if not (csDestroying in WebDataSource.ComponentState) then
    WebDataSource.DataNotification(utLayout);
  inherited;
end;

{ TcxExtWebDataSource }

constructor TcxExtWebDataSource.Create(AOwner: TComponent);
begin
  inherited;
  FAllowExpanding := True;
  FAllowGrouping := True;
  FAllowSorting := True;
  FAutoCompleteGroupedFields := True;
end;

procedure TcxExtWebDataSource.SetAllowExpanding(Value: Boolean);
begin
  if FAllowExpanding <> Value then
  begin
    FAllowExpanding := Value;
    if not Value then
      DataController.Groups.FullExpand;
  end;
end;

procedure TcxExtWebDataSource.SetAllowGrouping(Value: Boolean);
begin
  if FAllowGrouping <> Value then
  begin
    FAllowGrouping := Value;
    if not Value then
      DataController.Groups.ClearGrouping;
  end;
end;

procedure TcxExtWebDataSource.SetAllowSorting(Value: Boolean);
begin
  if FAllowSorting <> Value then
  begin
    FAllowSorting := Value;
    if not Value then
      DataController.ClearSorting(True);
  end;
end;

function TcxExtWebDataSource.GetAllowExpanding: Boolean;
begin
  Result := FAllowExpanding;
end;

function TcxExtWebDataSource.GetAllowGrouping: Boolean;
begin
  Result := FAllowGrouping;
end;

function TcxExtWebDataSource.GetAllowSorting: Boolean;
begin
  Result := FAllowSorting;
end;

function TcxExtWebDataSource.GetItemSortIndex(AItemIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to DataController.GetSortingItemCount - 1 do
  begin
    if DataController.GetSortingItemIndex(I) = AItemIndex then
    begin
      Result := I;
      break;
    end;
  end;
end;

function TcxExtWebDataSource.GetFields: TcxCustomWebDataControllerFields;
begin
  Result := inherited GetFields as TcxCustomWebDataControllerFields;
end;

procedure TcxExtWebDataSource.SetFields(Value: TcxCustomWebDataControllerFields);
begin
  inherited SetFields(Value);
end;

procedure TcxExtWebDataSource.WebSort(const AParameters: TcxActionParameters);
var
  SortIndex: Integer;
  SortOrder: TcxWebDataSortOrder;
begin
  SortIndex := StrToInt(GetActionParameter(AParameters.ParamString, 0));
  SortOrder := TcxWebDataSortOrder(DataController.GetItemSortOrder(SortIndex));

  if (AParameters.ShiftState and wssCtrl) <> 0 then
    SortOrder := wsoNone
  else
  begin
    if (AParameters.ShiftState and wssShift) = 0 then
      DataController.ClearSorting(True);
    if (SortOrder = wsoNone) or (SortOrder = wsoDescending) then
      SortOrder := wsoAscending
    else SortOrder := wsoDescending;
  end;
  Sort(SortIndex, SortOrder);
end;

procedure TcxExtWebDataSource.WebGroup(const AParameters: TcxActionParameters);
var
  GroupField, GroupIndex: Integer;
begin
  GroupField := StrToInt(GetActionParameter(AParameters.ParamString, 0));
  GroupIndex := StrToInt(GetActionParameter(AParameters.ParamString, 1));
  Group(GroupField, GroupIndex);
end;

procedure TcxExtWebDataSource.WebUnGroup(const AParameters: TcxActionParameters);
var
  GroupField: Integer;
begin
  GroupField := StrToInt(GetActionParameter(AParameters.ParamString, 0));
  UnGroup(GroupField);
end;

procedure TcxExtWebDataSource.WebExpand(const AParameters: TcxActionParameters);
var
  ARowIndex, AKeyLevel: Integer;
  AKeyValue: string;
  AExpanded, ARecursive: Boolean;
begin
  try
    ARowIndex := StrToInt(GetActionParameter(AParameters.ParamString, 0));
    AKeyValue := GetActionParameter(AParameters.ParamString, 1);
    AKeyLevel := StrToInt(GetActionParameter(AParameters.ParamString, 2));
  except
    on EConvertError do
    begin
      ARowIndex := -1;
      AKeyValue := '';
      AKeyLevel := 0;
    end
    else raise;
  end;
  if not CheckKey(ARowIndex, AKeyValue, AKeyLevel) then
    ARowIndex := FindKey(AKeyValue, AKeyLevel);
  if CheckRowIndex(ARowIndex) then
  begin
    if DataController.GetRowInfo(ARowIndex).Expanded then
      AExpanded := False
    else AExpanded := True;
    if (AParameters.ShiftState and wssShift) <> 0 then
      ARecursive := True
    else ARecursive := False;
    Expand(ARowIndex, AExpanded, ARecursive);
  end;
end;

{ values }
procedure TcxExtWebDataSource.DoSetValues;
begin
  BeginUpdate;
  try
    if AllowGrouping then SynchronizeGrouping;
    if AllowSorting then SynchronizeSorting;
    if AllowExpanding then SynchronizeExpanding;
    SynchronizeSelection;
    inherited DoSetValues;
  finally
    CancelUpdate;
  end;
end;

procedure TcxExtWebDataSource.RegisterValues;
begin
  inherited RegisterValues;
  if AllowGrouping then WebValuesHelper.RegisterValue(FullName + 'GroupingInfo', '');
  if AllowSorting then WebValuesHelper.RegisterValue(FullName + 'SortingInfo', '');
  if AllowExpanding then WebValuesHelper.RegisterValue(FullName + 'ExpandingInfo', '');
end;

{ actions }
procedure TcxExtWebDataSource.RegisterActions;
begin
  inherited;
  WebActionsHelper.RegisterAction(scxSortingAction, WebSort);
  WebActionsHelper.RegisterAction(scxGroupingAction, WebGroup);
  WebActionsHelper.RegisterAction(scxUnGroupingAction, WebUnGroup);
  WebActionsHelper.RegisterAction(scxExpandingAction, WebExpand);
end;

{ IcxCodeProvider }
procedure TcxExtWebDataSource.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxExtWebDataSourceRenderer);
  WebRenderHelper.RegisterRenderer(TcxExtWebDataSourceNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxExtWebDataSourceOperaRenderer);
end;

procedure TcxExtWebDataSource.SynchronizeSelection;
var
  ARowIndex: Integer;
begin
  try
    ARowIndex := StrToInt(WebValuesHelper.Values.Values[FullName + 'FocusedRow']);
  except
    ARowIndex := 0;
  end;
  if ARowIndex < 0 then ARowIndex := 0;
  if(ARowIndex >= FDataController.GetRowCount) then ARowIndex := FDataController.GetRowCount - 1;
  FDataController.ChangeFocusedRowIndex(ARowIndex);
end;

procedure TcxExtWebDataSource.SynchronizeGrouping;
var
  I, DelimiterPos: Integer;
  GroupingIndex: Integer;
  S: string;
begin
  S := WebValuesHelper.Values.Values[FullName + 'GroupingInfo'];

  for I := 0 to Fields.Count - 1 do
  begin
    DelimiterPos := Pos(scxInfoDelimiter, S);
    if DelimiterPos = 0 then break;
    try
      GroupingIndex := StrToInt(LeftStr(S, DelimiterPos - 1));
      DataController.Groups.ChangeGrouping(I, GroupingIndex);
    except
      on EConvertError do ;
      else raise;
    end;
    S := RightStr(S, Length(S) - DelimiterPos);
  end;
end;

procedure TcxExtWebDataSource.SynchronizeSorting;
var
  I, J, DelimiterPos: Integer;
  SortingItemsCount: Integer;
  SortingIndex, SortingOrder: array of Integer;
  S: string;
begin
  SortingItemsCount := 0;
  SetLength(SortingIndex, Fields.Count);
  SetLength(SortingOrder, Fields.Count);
  for I := 0 to Fields.Count - 1 do
  begin
    SortingIndex[I] := -1;
    SortingOrder[I] := 0;
  end;
  S := WebValuesHelper.Values.Values[FullName + 'SortingInfo'];

  for I := 0 to Fields.Count - 1 do
  begin
    DelimiterPos := Pos(scxInfoDelimiter, S);
    if DelimiterPos = 0 then break;
    SortingIndex[I] := StrToInt(LeftStr(S, DelimiterPos - 1));
    S := RightStr(S, Length(S) - DelimiterPos);
    DelimiterPos := Pos(scxInfoDelimiter, S);
    if DelimiterPos = 0 then break;
    SortingOrder[I] := StrToInt(LeftStr(S, DelimiterPos - 1));
    S := RightStr(S, Length(S) - DelimiterPos);

    if SortingIndex[I] <> -1 then
      Inc(SortingItemsCount);
  end;

  for J := 0 to SortingItemsCount - 1 do
    for I := 0 to Fields.Count - 1 do
    begin
      if SortingIndex[I] = J then
        DataController.ChangeSorting(I, TcxDataSortOrder(SortingOrder[I]));
    end;
end;

procedure TcxExtWebDataSource.SynchronizeExpanding;
var
  I, DelimiterPos: Integer;
  Expanded: Integer;
  S: string;
begin
  I := 0;
  S := WebValuesHelper.Values.Values[FullName + 'ExpandingInfo'];

  repeat
    if IsInserting and (I = FocusedRowIndex) then
    begin
      Dec(I);
      continue;
    end;

    DelimiterPos := Pos(scxInfoDelimiter, S);
    if DelimiterPos = 0 then break;
    try
      if CheckRowIndex(I) then
      begin
        Expanded := StrToInt(LeftStr(S, DelimiterPos - 1));
        if Expanded = 1 then
          DataController.Groups.ChangeExpanding(I, True, False)
        else DataController.Groups.ChangeExpanding(I, False, False);
      end;
    except
      on EConvertError do ;
      else raise;
    end;
    S := RightStr(S, Length(S) - DelimiterPos);
    Inc(I);
  until(S = '');
end;

function TcxExtWebDataSource.GetDataController: TcxCustomDataController;
begin
  Result := FDataController;
end;

procedure TcxExtWebDataSource.SetDataController(Value: TcxCustomDataController);
begin
  if FDataController <> Value then
  begin
    FDataController := Value;
  end;
end;

{ Data operations }
procedure TcxExtWebDataSource.DeleteRecord(ARowIndex: Integer);
var
  Processed: Boolean;
begin
  if IsEditing then CancelEdit;
  if AllowEditing then
  begin
    BeginUpdate;
    try
      Processed := True;
      if Assigned(OnDeleting) then
        OnDeleting(self, ARowIndex, Processed);
      if Processed and CanEdit then
      begin
        DataController.ChangeFocusedRowIndex(ARowIndex);
        DataController.DeleteFocused;
        if Assigned(OnDeleted) then
          OnDeleted(self, ARowIndex);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxExtWebDataSource.InsertRecord(ARowIndex: Integer);
var
  ANewRowIndex: Integer;
  Processed: Boolean;
begin
  if IsEditing then CancelEdit;
  if AllowEditing then
  begin
    BeginUpdate;
    try
      Processed := True;
      if Assigned(OnInserting) then
        OnInserting(self, ARowIndex, Processed);
      if Processed and CanEdit then
      begin
        if not CheckRowIndex(ARowIndex) then
          DataController.ChangeFocusedRowIndex(DataController.FocusedRowIndex)
        else if GetRowLevel(ARowIndex) < DataController.Groups.GroupingItemCount then
        begin
          ANewRowIndex := DataController.GetRowIndexByRecordIndex(GetRowRecord(ARowIndex), True);
          DataController.ChangeFocusedRowIndex(ANewRowIndex);
        end;
        StoreInsertingValues;
        IsInserting := True;
        IsEditing := True;
        if Assigned(OnInserted) then
          OnInserted(self, ARowIndex);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxExtWebDataSource.EditRecord(ARowIndex: Integer);
var
  Processed: Boolean;
begin
  if AllowEditing then
    if DataController.GetRowInfo(ARowIndex).Level = DataController.Groups.GroupingItemCount then
    begin
      BeginUpdate;
      try
        Processed := True;
        if Assigned(OnStartEdit) then
          OnStartEdit(Self, ARowIndex, Processed);
        if Processed and CanEdit then
        begin
          DataController.ChangeFocusedRowIndex(ARowIndex);
          IsEditing := True;
        end;
      finally
        EndUpdate;
      end;
    end;
end;

procedure TcxExtWebDataSource.Expand(ARowIndex: Integer; AExpanded, ARecursive: Boolean);
begin
  if IsEditing then CancelEdit;
  if AllowExpanding then
  begin
    if Assigned(FOnExpanding) then
      FOnExpanding(self, ARowIndex, AExpanded, ARecursive);

    DataController.Groups.ChangeExpanding(ARowIndex, AExpanded, ARecursive);

    if Assigned(FOnExpanded) then
      FOnExpanded(self, ARowIndex, AExpanded, ARecursive);
  end;
end;

procedure TcxExtWebDataSource.Group(GroupField, GroupIndex: Integer);
begin
  if IsEditing then CancelEdit;
  if AllowGrouping then
  begin
    if Assigned(OnGrouping) then
      OnGrouping(self, GroupField, GroupIndex);

    if (GetGroupingItemCount <> Fields.Count - 1) or (GetItemGroupIndex(GroupField) <> -1) then
    begin
      if GroupField > -1 then
        DataController.Groups.ChangeGrouping(GroupField, GroupIndex);
    end;

    if Assigned(OnGrouped) then
      OnGrouped(self, GroupField, GroupIndex);
  end;
end;

procedure TcxExtWebDataSource.PostEdit(APriorControlName: string);
var
  Processed: Boolean;
  SavedIsInserting: Boolean;
begin
  if AllowEditing then
  begin
    BeginUpdate;
    try
      Processed := True;
      if Assigned(OnBeforePost) then
        OnBeforePost(self, FocusedRowIndex, Processed);
      if Processed and CanEdit then
      begin
        SavedIsInserting := IsInserting;
        ChangedData(APriorControlName);
        if IsInserting then
        begin
          DataController.Insert;
          IsInserting := False;
          RestoreInsertingValues;
        end;
        try
          DataController.Post;
        except
          if SavedIsInserting then IsInserting := True;
          raise;
        end;
        IsEditing := False;
        if Assigned(OnAfterPost) then
          OnAfterPost(self, FocusedRowIndex);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxExtWebDataSource.Sort(SortIndex: Integer; SortOrder: TcxWebDataSortOrder);
begin
  if IsEditing then CancelEdit;
  if AllowSorting then
  begin
    if Assigned(OnSorting) then
      OnSorting(self, SortIndex, SortOrder);

    if SortIndex > -1 then
      DataController.ChangeSorting(SortIndex, TcxDataSortOrder(SortOrder));

    if Assigned(OnSorted) then
      OnSorted(self, SortIndex, SortOrder);
  end;
end;

procedure TcxExtWebDataSource.UnGroup(UnGroupIndex: Integer);
begin
  if IsEditing then CancelEdit;
  if AllowGrouping then
  begin
    if Assigned(FOnGrouping) then
      FOnGrouping(self, UnGroupIndex, -1);

    if UnGroupIndex > -1 then
      DataController.Groups.ChangeGrouping(UnGroupIndex, -1);

    if Assigned(FOnGrouped) then
      FOnGrouped(self, UnGroupIndex, -1);
  end;
end;

function TcxExtWebDataSource.GetFocusedRowIndex: Integer;
begin
  Result := FDataController.GetFocusedRowIndex;
  if IsInserting and (Result < 0) then Inc(Result);
end;

function TcxExtWebDataSource.ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass;
var
  TypeClass: TcxValueTypeClass;
begin
  Result := TcxDataFieldHelper;
  TypeClass := FDataController.GetItemValueTypeClass(AItemIndex);

  if (TypeClass = TcxStringValueType) or (TypeClass = TcxWideStringValueType) or
    (TypeClass = TcxVariantValueType) then
    Result := TcxStringFieldHelper
  else
    if TypeClass = TcxCurrencyValueType then
      Result := TcxCurrencyFieldHelper
  else if (TypeClass = TcxSmallintValueType) or (TypeClass = TcxIntegerValueType) or
    (TypeClass = TcxWordValueType) or
    (TypeClass = TcxFMTBcdValueType) or (TypeClass = TcxFMTBcdValueType) then
     Result := TcxIntegerFieldHelper
  else if TypeClass = TcxBooleanValueType then
    Result := TcxBooleanFieldHelper
  else if TypeClass = TcxFloatValueType then
    Result := TcxFloatFieldHelper
  else if TypeClass = TcxDateTimeValueType then
    Result := TcxDateTimeFieldHelper;
end;

function TcxExtWebDataSource.GetValue(ARecordIndex, AItemIndex: Integer): Variant;
var
  FocusedRecord: Integer;
begin
  if IsInserting and (DataController.GetRecordCount = 0) then
    FocusedRecord := ARecordIndex
  else
    if CheckRowIndex(FocusedRowIndex) then
      FocusedRecord := DataController.GetRowInfo(FocusedRowIndex).RecordIndex
    else FocusedRecord := -1;
  if IsInserting and (ARecordIndex = FocusedRecord) then
    Result := GetInsertingValue(AItemIndex)
  else
  begin
    if IsInserting and (ARecordIndex > FocusedRecord) and
      (FocusedRecord > -1) then Dec(ARecordIndex);
    Result := DataController.Values[ARecordIndex, AItemIndex];
  end;
end;

function TcxExtWebDataSource.GetDisplayText(ARecordIndex, AItemIndex: Integer): string;
var
  FocusedRecord: Integer;
begin
  if IsInserting and (DataController.GetRecordCount = 0) then
    FocusedRecord := ARecordIndex
  else
    if CheckRowIndex(FocusedRowIndex) then
      FocusedRecord := DataController.GetRowInfo(FocusedRowIndex).RecordIndex
    else FocusedRecord := -1;
  if IsInserting and (ARecordIndex = FocusedRecord) then
    Result := VarToStr(GetInsertingValue(AItemIndex))
  else
  begin
    if IsInserting and (ARecordIndex > FocusedRecord) and
      (FocusedRecord > -1) then Dec(ARecordIndex);
      Result := DataController.DisplayTexts[ARecordIndex, AItemIndex];
  end;
end;

function TcxExtWebDataSource.GetRecordCount: Integer;
begin
  Result := FDataController.RecordCount;
  if IsInserting then Inc(Result);
end;

function TcxExtWebDataSource.GetRowCount: Integer;
begin
  Result := FDataController.GetRowCount;
  if IsInserting then Inc(Result);
end;

function TcxExtWebDataSource.GetRowDisplayText(RowIndex: Integer; ItemIndex: Integer): string;
var
  RowInfo: TcxRowInfo;
begin
  if IsInserting and (RowIndex = FocusedRowIndex) then
    Result := VarToStr(GetInsertingValue(ItemIndex))
  else
  begin
    if IsInserting and (RowIndex > FocusedRowIndex) and
      (FocusedRowIndex > -1) then Dec(RowIndex);
    RowInfo := FDataController.GetRowInfo(RowIndex);
    Result := FDataController.GetRowDisplayText(RowInfo, ItemIndex);
  end;
end;

function TcxExtWebDataSource.GetRowValue(RowIndex: Integer; ItemIndex: Integer): Variant;
var
  RowInfo: TcxRowInfo;
begin
  if IsInserting and (RowIndex = FocusedRowIndex) then
    Result := GetInsertingValue(ItemIndex)
  else
  begin
    if IsInserting and (RowIndex > FocusedRowIndex) and
      (FocusedRowIndex > -1) then Dec(RowIndex);
    RowInfo := DataController.GetRowInfo(RowIndex);
    Result := DataController.GetRowValue(RowInfo, ItemIndex);
  end;
end;

function TcxExtWebDataSource.GetRowExpanded(RowIndex: Integer): Boolean;
var
  RowInfo: TcxRowInfo;
begin
  if IsInserting and (DataController.GetRecordCount = 0) then
    Result := False
  else
  begin
    if IsInserting and (RowIndex = FocusedRowIndex) then
      Result := False
    else
    begin
      if IsInserting and (RowIndex > FocusedRowIndex) and
        (FocusedRowIndex > -1) then Dec(RowIndex);
      RowInfo := DataController.GetRowInfo(RowIndex);
      Result := RowInfo.Expanded;
    end;
  end;
end;

function TcxExtWebDataSource.GetRowLevel(RowIndex: Integer): Integer;
var
  RowInfo: TcxRowInfo;
begin
  if IsInserting and (DataController.GetRecordCount = 0) then
    Result := 0
  else
  begin
    if IsInserting and (RowIndex = FocusedRowIndex) then
      Result := DataController.Groups.GroupingItemCount
    else
    begin
      if IsInserting and (RowIndex > FocusedRowIndex) and
        (FocusedRowIndex > -1) then Dec(RowIndex);
      RowInfo := DataController.GetRowInfo(RowIndex);
      Result := RowInfo.Level;
    end;
  end;
end;

function TcxExtWebDataSource.GetRowRecord(RowIndex: Integer): Integer;
var
  RowInfo: TcxRowInfo;
begin
  if IsInserting and (DataController.GetRecordCount = 0) then
    Result := 0
  else
  begin
    if IsInserting and (RowIndex = FocusedRowIndex) then
      Result := DataController.GetRowInfo(RowIndex).RecordIndex
    else
    begin
      if IsInserting and (RowIndex > FocusedRowIndex) and
        (FocusedRowIndex > -1) then Dec(RowIndex);
      RowInfo := DataController.GetRowInfo(RowIndex);
      Result := RowInfo.RecordIndex;
    end;
  end;
end;

function TcxExtWebDataSource.GetGroupingItemCount: Integer;
begin
  if DataController <> nil then
    Result := DataController.Groups.GroupingItemCount
  else Result := 0;
end;

function TcxExtWebDataSource.GetSortingItemCount: Integer;
begin
  if DataController <> nil then
    Result := DataController.GetSortingItemCount
  else Result := 0;
end;

function TcxExtWebDataSource.GetItemGroupIndex(ItemIndex: Integer): Integer;
begin
  if DataController <> nil then
    Result := FDataController.Groups.ItemGroupIndex[ItemIndex]
  else Result := -1;
end;

function TcxExtWebDataSource.GetItemSortOrder(ItemIndex: Integer): TcxWebDataSortOrder;
begin
  if DataController <> nil then
    Result := TcxWebDataSortOrder(DataController.GetItemSortOrder(ItemIndex))
  else Result := wsoNone;
end;

function TcxExtWebDataSource.GetGroupingItemIndex(Item: Integer): Integer;
begin
  if DataController <> nil then
    Result := DataController.Groups.GroupingItemIndex[Item]
  else Result := -1;
end;

function TcxExtWebDataSource.GetSortingItemIndex(Item: Integer): Integer;
begin
  if DataController <> nil then
    Result := DataController.GetSortingItemIndex(Item)
  else Result := -1;
end;

procedure TcxExtWebDataSource.ClearGrouping;
begin
  if DataController <> nil then
    DataController.Groups.ClearGrouping;
end;

procedure TcxExtWebDataSource.ClearSorting;
begin
  if DataController <> nil then
    DataController.ClearSorting(True);
end;

procedure TcxExtWebDataSource.FullCollapse;
begin
  if DataController <> nil then
    DataController.Groups.FullCollapse;
end;

procedure TcxExtWebDataSource.FullExpand;
begin
  if DataController <> nil then
    DataController.Groups.FullExpand;
end;

procedure TcxExtWebDataSource.SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes);
var
  ACanSet: Boolean;
begin
  BeginUpdate;
  try
    ACanSet := True;
    if Assigned(OnSetEditValue) then
      OnSetEditValue(Self, AItemIndex, FocusedRowIndex, AValue, ACanSet);
    if ACanSet and Fields[AItemIndex].ValidateValueType(AType) and Fields[AItemIndex].ValidateValue(AValue) then
      if IsInserting then
        SetInsertingValue(AItemIndex, AValue)
      else if dtValue in AType then
        DataController.SetEditValue(AItemIndex, AValue, evsValue)
      else DataController.SetEditValue(AItemIndex, AValue, evsText)
  finally
    EndUpdate;
  end;
end;

procedure TcxExtWebDataSource.SetFocusedRowIndex(Value: Integer);
var
  Processed: Boolean;
begin
  if IsEditing then CancelEdit;
  Processed := True;
  if Assigned(OnScrolling) then
    OnScrolling(self, FDataController.GetFocusedRowIndex, Processed);

  if Processed then
  begin
    FDataController.ChangeFocusedRowIndex(Value);

    if Assigned(OnScrolled) then
      OnScrolled(self, FDataController.GetFocusedRowIndex);
  end;
end;

procedure TcxExtWebDataSource.SetValue(ARecordIndex, AItemIndex: Integer; const Value: Variant);
begin
  FDataController.Values[ARecordIndex, AItemIndex] := Value;
end;

procedure TcxExtWebDataSource.StoreInsertingValues;
var
  I: Integer;
begin
  inherited;
  if AutoCompleteGroupedFields and (DataController.Groups.GroupingItemCount > 0) then
    for I := 0 to Fields.Count - 1 do
      if DataController.Groups.ItemGroupIndex[I] > -1 then
        SetInsertingValue(I, DataController.Values[GetRowRecord(FocusedRowIndex), I]);
end;

{ TcxExtWebDataSourceRenderer }

function TcxExtWebDataSourceRenderer.GetWebDataSource: TcxExtWebDataSource;
begin
  Result := Component as TcxExtWebDataSource;
end;

procedure TcxExtWebDataSourceRenderer.WriteHandlers;
begin
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnChangeFocus = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnScrolling) or Assigned(WebDataSource.OnScrolled))]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnGroup = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnGrouping) or Assigned(WebDataSource.OnGrouped))]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnUnGroup = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnGrouping) or Assigned(WebDataSource.OnGrouped))]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnSort = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnSorting) or Assigned(WebDataSource.OnSorted))]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnExpand = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnExpanding) or Assigned(WebDataSource.OnExpanded))]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnEdit = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnStartEdit))]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnCancelEdit = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnCancelEdit))]));
end;

procedure TcxExtWebDataSourceRenderer.WriteHiddenFormElements;
var
  I: Integer;
  S: string;
begin
  inherited WriteHiddenFormElements;
  if WebDataSource.AllowGrouping then
  begin
    S := '';
    for I := 0 to WebDataSource.DataController.ItemCount - 1 do
      S := S + IntToStr(WebDataSource.GetItemGroupIndex(I)) + scxInfoDelimiter;
    WriteHiddenField(WebDataSource.FullName + 'GroupingInfo', S);
  end;
  if WebDataSource.AllowSorting then
  begin
    S := '';
    for I := 0 to WebDataSource.DataController.ItemCount - 1 do
    begin
      S := S + IntToStr(WebDataSource.GetItemSortIndex(I)) + scxInfoDelimiter;
      S := S + IntToStr(Integer(WebDataSource.GetItemSortOrder(I))) + scxInfoDelimiter;
    end;
    WriteHiddenField(WebDataSource.FullName + 'SortingInfo', S);
  end;
  if WebDataSource.AllowExpanding then
  begin
    S := '';
    for I := 0 to WebDataSource.RowCount - 1 do
      if WebDataSource.GetRowExpanded(I) then
        S := S + '1' + scxInfoDelimiter
      else S := S + '0' + scxInfoDelimiter;
    WriteHiddenField(WebDataSource.FullName + 'ExpandingInfo', S);
  end;
end;

{ TcxExtWebDataSourceNS4Renderer }

function TcxExtWebDataSourceNS4Renderer.GetWebDataSource: TcxExtWebDataSource;
begin
  Result := Component as TcxExtWebDataSource;
end;

procedure TcxExtWebDataSourceNS4Renderer.WriteHiddenFormElements;
var
  I: Integer;
  S: string;
begin
  inherited WriteHiddenFormElements;
  if WebDataSource.AllowGrouping then
  begin
    S := '';
    for I := 0 to WebDataSource.DataController.ItemCount - 1 do
      S := S + IntToStr(WebDataSource.GetItemGroupIndex(I)) + scxInfoDelimiter;
    WriteHiddenField(WebDataSource.FullName + 'GroupingInfo', S);
  end;
  if WebDataSource.AllowSorting then
  begin
    S := '';
    for I := 0 to WebDataSource.DataController.ItemCount - 1 do
    begin
      S := S + IntToStr(WebDataSource.GetItemSortIndex(I)) + scxInfoDelimiter;
      S := S + IntToStr(Integer(WebDataSource.GetItemSortOrder(I))) + scxInfoDelimiter;
    end;
    WriteHiddenField(WebDataSource.FullName + 'SortingInfo', S);
  end;
  if WebDataSource.AllowExpanding then
  begin
    S := '';
    for I := 0 to WebDataSource.RowCount - 1 do
      if WebDataSource.GetRowExpanded(I) then
        S := S + '1' + scxInfoDelimiter
      else S := S + '0' + scxInfoDelimiter;
    WriteHiddenField(WebDataSource.FullName + 'ExpandingInfo', S);
  end;
end;

{ TcxExtWebDataSourceOperaRenderer }

class function TcxExtWebDataSourceOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

{ TcxWebDataSource }

constructor TcxWebDataSource.Create(AOwner: TComponent);
begin
  inherited;
  Fields := TcxWebDataControllerFields.Create(Self);
  DataController := TcxWebDataController.Create(Self);
  DataController.WebDataSource := Self;
end;

destructor TcxWebDataSource.Destroy;
begin
  DataController.Free;
  if Fields <> nil then Fields.Clear;
  Fields.Free;
  inherited;
end;

procedure TcxWebDataSource.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, RecordCount > 0);
end;

procedure TcxWebDataSource.ReadData(Stream: TStream);
begin
  DataController.LoadFromStream(Stream);
end;

procedure TcxWebDataSource.WriteData(Stream: TStream);
begin
  DataController.SaveToStream(Stream);
end;

function TcxWebDataSource.GetFields: TcxWebDataControllerFields;
begin
  Result := inherited GetFields as TcxWebDataControllerFields;
end;

procedure TcxWebDataSource.SetFields(Value: TcxWebDataControllerFields);
begin
  inherited SetFields(Value);
end;

procedure TcxWebDataSource.DataNotification(AUpdateType: TcxUpdateType);
begin
  if csDestroying in ComponentState then exit;
  UpdateDataLayout;
end;

procedure TcxWebDataSource.SetDataController(Value: TcxWebDataController);
begin
  inherited SetDataController(Value);
end;

function TcxWebDataSource.GetDataController: TcxWebDataController;
begin
  Result := inherited GetDataController as TcxWebDataController;
end;

procedure TcxWebDataSource.SetRecordCount(Value: Integer);
begin
  DataController.SetRecordCount(Value);
end;

procedure TcxWebDataSource.LoadFromStream(AStream: TStream);
begin
  DataController.LoadFromStream(AStream);
end;

procedure TcxWebDataSource.SaveToStream(AStream: TStream);
begin
  DataController.SaveToStream(AStream);
end;

{ TcxWebDBDataSource }

constructor TcxWebDBDataSource.Create(AOwner: TComponent);
begin
  inherited;
  Fields := TcxWebDBDataControllerFields.Create(Self);
  FDataSource := TDataSource.Create(nil);
  DataController := TcxWebDBDataController.Create(Self);
  DataController.WebDataSource := Self;
  DataController.DataSource := FDataSource;
end;

destructor TcxWebDBDataSource.Destroy;
begin
  DataController.Free;
  FDataSource.Free;
  if Fields <> nil then Fields.Clear;
  Fields.Free;
  inherited;
end;

function TcxWebDBDataSource.ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass;
var
  AField: TField;
  TypeClass: TcxValueTypeClass;
begin
  Result := inherited ItemHelperClass(AItemIndex);
  TypeClass := DataController.GetItemValueTypeClass(AItemIndex);
  AField := DataController.GetItemField(AItemIndex);
  if (TypeClass = TcxFloatValueType) and (AField is TFloatField) and
     (AField as TFloatField).currency then
    Result := TcxCurrencyFieldHelper;
  if (TypeClass = TcxFMTBcdValueType) and (AField is TFMTBCDField) and
     (AField as TFMTBCDField).currency then
    Result := TcxCurrencyFieldHelper;
  if TypeClass = TcxCurrencyValueType then
    if (AField is TCurrencyField) then
    begin
      if not (AField as TCurrencyField).currency then
        Result := TcxFloatFieldHelper;
    end
    else
      if (AField is TBCDField) then
        if not (AField as TBCDField).currency then
          Result := TcxFloatFieldHelper;
  if TypeClass = TcxVariantValueType then
  begin
    Result := TcxStringFieldHelper;
    if AField is TBlobField then
      if (TBlobField(AField).BlobType = ftGraphic) or
        (TBlobField(AField).BlobType = ftTypedBinary) then
        Result := TcxImageFieldHelper
      else if TBlobField(AField).BlobType = ftMemo then
          Result := TcxMemoFieldHelper
        else Result := TcxBinaryFieldHelper;
  end;
end;

function TcxWebDBDataSource.GetDataSet: TDataSet;
begin
  Result := DataSource.DataSet;
end;

type
  TDataSetAccess = class(TDataSet);

function TcxWebDBDataSource.CanEdit: Boolean;
begin
  Result := AllowEditing and (DataSource.DataSet <> nil) and
    DataSource.DataSet.Active and TDataSetAccess(DataSource.DataSet).CanModify;
end;

function TcxWebDBDataSource.GetItemField(AItemName: string): TField;
var
  AFieldName: string;
begin
  AFieldName := TcxWebDBDataControllerField(FieldByName(AItemName)).FieldName;
  Result := DataSource.DataSet.FieldByName(AFieldName);
end;

procedure TcxWebDBDataSource.SetDataSet(Value: TDataSet);
begin
  if DataSource.DataSet <> Value then
  begin
    ClearGrouping;
    ClearSorting;
    Fields.Clear;
    DataSource.DataSet := Value;
    if (Value <> nil) and Value.Active then
      DataNotification(utLayout);
  end;
end;

function TcxWebDBDataSource.GetFields: TcxWebDBDataControllerFields;
begin
  Result := inherited GetFields as TcxWebDBDataControllerFields;
end;

procedure TcxWebDBDataSource.SetFields(Value: TcxWebDBDataControllerFields);
begin
  inherited SetFields(Value);
end;

procedure TcxWebDBDataSource.SetDataController(Value: TcxWebDBDataController);
begin
  inherited SetDataController(Value);
end;

procedure TcxWebDBDataSource.DataNotification(AUpdateType: TcxUpdateType);
begin
  if csDestroying in ComponentState then exit;

  if AUpdateType = utLayout then
  begin
    UpdateDefaultFields;
  end;
  UpdateDataLayout;
end;

function TcxWebDBDataSource.NeedUpdateFields: Boolean;
var
  I: Integer;
begin
  if DataSet = nil then
  begin
    if Fields.Count > 0 then Result := True
    else Result := False;
  end
  else if (DataSet.FieldCount = 0) and (DataSet.FieldDefs.Count <> Fields.Count) then
    Result := True
  else if DataSet.FieldCount = Fields.Count then
  begin
    Result := False;
    for I := 0 to Fields.Count - 1 do
      if DataSet.FindField(Fields[I].FieldName) = nil then
      begin
        Result := True;
        break;
      end;
  end
  else Result := True;
end;

procedure TcxWebDBDataSource.UpdateDefaultFields;
var
  I: Integer;
  AField: TField;
begin
  if Fields = nil then exit;
  if UpdateLock > 0 then exit;

  if (DataSet <> nil) and (csDesigning in DataSet.ComponentState) and
    not (csLoading in DataSet.ComponentState) and not DataSet.Active and
    (DataSet.FieldDefs.Count = 0) then
    TDataSetAccess(DataSet).InitFieldDefs;
  
  BeginUpdate;
  try
    if DataSet <> nil then
    begin
      if not DataSet.Active and DataSet.DefaultFields then
        Fields.Clear
      else
        if NeedUpdateFields then
        begin
          DataController.BeginUpdate;
          try
            Fields.Clear;
            if DataSet.Fields.Count > 0 then
              for I := 0 to DataSet.Fields.Count - 1 do
              begin
                AField := DataSet.Fields[I];
                with Fields.Add do
                begin
                  Name := AField.FieldName;
                  FieldName := AField.FieldName;
                  DisplayLabel  := AField.DisplayLabel;
                end;
              end
            else for I := 0 to DataSet.FieldDefs.Count - 1 do
            begin
              with Fields.Add do
              begin
                Name := DataSet.FieldDefs[I].Name;
                FieldName := DataSet.FieldDefs[I].Name;
                DisplayLabel  := DataSet.FieldDefs[I].DisplayName;
              end;
            end;
          finally
            DataController.EndUpdate;
          end;
        end;
    end
    else Fields.Clear;
  finally
    CancelUpdate;
  end;
end;

function TcxWebDBDataSource.GetDataController: TcxWebDBDataController;
begin
  Result := inherited GetDataController as TcxWebDBDataController;
end;

initialization
  RegisterClasses([TcxCustomWebDataControllerField, TcxWebDataControllerField, TcxWebDBDataControllerField,
      TcxWebDataController, TcxWebDBDataController, TcxWebDataSource, TcxWebDBDataSource]);

end.


