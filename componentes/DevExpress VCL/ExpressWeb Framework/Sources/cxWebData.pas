{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Web Data Library                                            }
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
unit cxWebData;

{$I cxVer.inc}

interface

uses Classes, TypInfo, SysUtils, DB,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebIntf, cxWebClasses, cxWebTypes, cxWebRender;

const
  scxSortingAction = 'SORT';
  scxGroupingAction = 'GROUP';
  scxUnGroupingAction = 'UNGROUP';
  scxExpandingAction = 'EXPAND';
  scxDeleteAction = 'DELETE';
  scxStartEditAction = 'STARTEDIT';
  scxPostEditAction = 'POSTEDIT';
  scxCancelEditAction = 'CANCELEDIT';
  scxCancelInsertAction = 'CANCELINSERT';
  scxInsertAction = 'INSERT';
  scxRefreshAction = 'REFRESH';
  scxMoveToAction = 'MOVETO';
  scxMoveByAction = 'MOVEBY';

  scxInfoDelimiter = ';';

type
  TcxGridDataControllerChange = (dccGlobal, dccItemAdded, dccItemRemoved, dccIndexesChanged);
  TcxCustomWebDataField = class;
  TcxStdWebDataField = class;
  TcxCustomWebDataSource = class;
  TcxStdWebDataSource = class;

  IcxWebDataSourceSupport = interface
  ['{48715446-DDBD-4F20-BF6E-7332FF53B112}']
    function GetDataSource: TcxCustomWebDataSource;
    procedure SetDataSource(Value: TcxCustomWebDataSource);
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource);
    procedure UpdateData(Sender: TcxCustomWebDataSource);

    property DataSource: TcxCustomWebDataSource read GetDataSource write SetDataSource;
  end;

  IcxDataSetSupport = interface
  ['{94D3826C-84A4-4535-8D51-7951A06C533A}']
    function GetDataSet: TDataSet;
    procedure SetDataSet(Value: TDataSet);
    property DataSet: TDataSet read GetDataSet write SetDataSet;
  end;

  IcxWebViewDataSupport = interface
  ['{66CB3E4C-915D-4479-ACFE-BC9CB4104216}']
    function GetFirstVisibleRow: Integer;
    function GetPageSize: Integer;
    procedure SetData(Value: Variant; DisplayText: string);
  end;

  TcxWebDataType = (dtValue, dtText, dtKey);
  TcxWebDataTypes = set of TcxWebDataType;
  IcxWebUpdateDataSupport = interface
  ['{C104D95D-C04B-4E35-949A-96EFF281A711}']
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;
  end;

  TcxAbstractWebDataBinding = class(TPersistent)
  private
    FComponent: TComponent;
  protected
    function GetDataSource: TcxCustomWebDataSource; virtual; abstract;
  public
    constructor Create(AComponent: TComponent); virtual;
    procedure Assign(Source: TPersistent); override;

    property Component: TComponent read FComponent;
    property DataSource: TcxCustomWebDataSource read GetDataSource;
  end;

  TcxCustomWebDataBinding = class(TcxAbstractWebDataBinding)
  private
    FDataSource: TcxCustomWebDataSource;
  protected
    function GetFieldIndex: Integer; virtual;
    { IcxWebViewDataSupport }
    function GetFirstVisibleRow: Integer; virtual;
    function GetPageSize: Integer; virtual;
    { Data control render }
    procedure WriteControlScripts(HTMLTextBuilder: TcxHTMLTextBuilder; AControlClass: string); virtual;
    { IcxWebDataSourceSupport }
    function GetDataSource: TcxCustomWebDataSource; override;
    procedure SetDataSource(Value: TcxCustomWebDataSource); virtual;
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource); virtual;
    procedure UpdateData(Sender: TcxCustomWebDataSource); virtual;
  public
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure Loaded; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); virtual;
  published
    property DataSource: TcxCustomWebDataSource read GetDataSource write SetDataSource;
  end;

  TcxDataFieldHelper = class
  private
    FField: TcxCustomWebDataField;

    function GetDataSource: TcxCustomWebDataSource;
    function GetIndex: Integer;
  protected
    function GetScriptData(ARecord: Integer): string; virtual;
    function ValidateValue(var Value: Variant): Boolean; virtual;
    function ValidateValueType(AType: TcxWebDataTypes): Boolean; virtual;
  public
    constructor Create(AField: TcxCustomWebDataField);

    property DataSource: TcxCustomWebDataSource read GetDataSource;
    property Field: TcxCustomWebDataField read FField;
    property Index: Integer read GetIndex;
  end;
  TcxDataFieldHelperClass = class of TcxDataFieldHelper;

  TcxStringFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
  end;

  TcxIntegerFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
  end;

  TcxCurrencyFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
  end;

  TcxFloatFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
  end;

  TcxDateTimeFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
  end;

  TcxBooleanFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
  end;

  TcxImageFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
    function ValidateValueType(AType: TcxWebDataTypes): Boolean; override;
  end;

  TcxMemoFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
    function ValidateValueType(AType: TcxWebDataTypes): Boolean; override;
  end;

  TcxBinaryFieldHelper = class(TcxDataFieldHelper)
  protected
    function GetScriptData(ARecord: Integer): string; override;
    function ValidateValue(var Value: Variant): Boolean; override;
    function ValidateValueType(AType: TcxWebDataTypes): Boolean; override;
  end;

  TcxCustomWebDataField = class(TCollectionItem)
  private
    FDisplayLabel: string;
    FFieldHelper: TcxDataFieldHelper;
    FName: string;
    FRequired: Boolean;

    procedure SetName(Value: string);
  protected
    function UniqueName: string;
    function GetDisplayName: string; override;
    function DataSource: TcxCustomWebDataSource; overload; virtual;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function FieldHelper: TcxDataFieldHelper;
    function GetScriptData(ARecord: Integer): string;
    function ValidateValue(var AValue: Variant): Boolean;
    function ValidateValueType(AType: TcxWebDataTypes): Boolean;
  published
    property DisplayLabel: string read FDisplayLabel write FDisplayLabel;
    property Name: string read FName write SetName;
    property Required: Boolean read FRequired write FRequired;
  end;
  TcxCustomWebDataFieldClass = class of TcxCustomWebDataField;

  TcxCustomWebDataFields = class(TCollection)
  private
    FDataSource: TcxCustomWebDataSource;

    function GetItem(Index: Integer): TcxCustomWebDataField;
    procedure SetItem(Index: Integer; Value: TcxCustomWebDataField);
  protected
    function GetOwner: TPersistent; override;
    class function FieldClass: TcxCustomWebDataFieldClass; virtual;
  public
    constructor Create(ADataSource: TcxCustomWebDataSource);
    function Add: TcxCustomWebDataField;
    function DataSource: TcxCustomWebDataSource; overload; virtual;

    property Items[Index: Integer]: TcxCustomWebDataField read GetItem write SetItem; default;
  end;

  TcxStdWebDataField = class(TcxCustomWebDataField)
  private
    FFieldName: string;

    function GetDataSet: TDataSet;
    procedure SetFieldName(const Value: string);
  protected
    function DataSource: TcxStdWebDataSource; reintroduce; overload;
  public
    property DataSet: TDataSet read GetDataSet;
    property FieldName: string read FFieldName write SetFieldName;
  end;

  TcxStdWebDataFields = class(TcxCustomWebDataFields)
  private
    function GetItem(Index: Integer): TcxStdWebDataField;
    procedure SetItem(Index: Integer; Value: TcxStdWebDataField);
  protected
    class function FieldClass: TcxCustomWebDataFieldClass; override;
  public
    function Add: TcxStdWebDataField;
    function DataSource: TcxStdWebDataSource; reintroduce; overload;

    property Items[Index: Integer]: TcxStdWebDataField read GetItem write SetItem; default;
  end;

  TcxWebDataSourceEvent = (dseOnAfterSort, dseOnAfterGroup, dseOnAfterUngroup,
    dseOnAfterExpand, dseOnAfterMove, dseOnBeforeSort, dseOnBeforeGroup,
    dseOnBeforeUngroup, dseOnBeforeExpand, dseOnBeforeMove, dseOnBeforeDelete,
    dseOnBeforeInsert, dseOnBeforeStartEdit, dseOnBeforePostEdit, dseOnBeforeCancelEdit,
    dseOnBeforeRefresh);

  TcxWebDataSourceEventsHelper = class(TcxWebScriptEventsHelper)
  protected
    function EventName(const AEvent: Integer): string; override;
    function EventProcParams(const AEvent: Integer): string; override;
    function ScriptObject: string; override;
  public
    function EventTypeInfo: PTypeInfo; override;
  end;

  TcxWebDataSortOrder = (wsoNone, wsoAscending, wsoDescending);
  TcxUpdateType = (utLayout, utData);
  TcxWebDataSourceState = (browsing, editing, inserting);

  TcxAllowingDataEvent = procedure (Sender: TObject; ARowIndex: Integer; var AllowAction: Boolean) of object;
  TcxDataEvent = procedure (Sender: TObject; ARowIndex: Integer) of object;
  TcxSetInsertValueEvent = procedure(Sender: TObject; AItemIndex, ARowIndex: Integer;
    var AValue: Variant; var CanSet: Boolean) of object;
  TcxSetEditValueEvent = procedure (Sender: TObject; AItemIndex, ARowIndex: Integer;
    var AValue: Variant; var CanSet: Boolean) of object;

  TcxCustomWebDataSource = class(TcxWebComponent)
  private
    FAllowEditing: Boolean;
    FFields: TcxCustomWebDataFields;
    FInsertingValues: array of Variant;
    FIsEditing: Boolean;
    FIsInserting: Boolean;
    FKeyFieldName: string;
    FLoadAllRecords: Boolean;
    FUpdateLock: Integer;
    FClientsList: TList;

    FOnAfterPost: TcxDataEvent;
    FOnBeforePost: TcxAllowingDataEvent;
    FOnCancelEdit: TcxDataEvent;
    FOnDeleted: TcxDataEvent;
    FOnDeleting: TcxAllowingDataEvent;
    FOnInserted: TcxDataEvent;
    FOnInserting: TcxAllowingDataEvent;
    FOnScrolled: TcxDataEvent;
    FOnScrolling: TcxAllowingDataEvent;
    FOnSetInsertValue: TcxSetInsertValueEvent;
    FOnSetEditValue: TcxSetEditValueEvent;
    FOnStartEdit: TcxAllowingDataEvent;

    function GetClient(Index: Integer): TComponent;
    function GetClientCount: Integer;
    function GetFullName: string;
    function GetState: TcxWebDataSourceState;
    procedure SetAllowEditing(Value: Boolean);
    procedure SetIsEditing(Value: Boolean);
    procedure SetIsInserting(Value: Boolean);
    procedure SetKeyFieldName(Value: string);
    { Action operations }
    procedure WebDelete(const AParameters: TcxActionParameters); virtual;
    procedure WebStartEdit(const AParameters: TcxActionParameters); virtual;
    procedure WebPostEdit(const AParameters: TcxActionParameters); virtual;
    procedure WebCancelEdit(const AParameters: TcxActionParameters); virtual;
    procedure WebInsert(const AParameters: TcxActionParameters); virtual;
    procedure WebRefresh(const AParameters: TcxActionParameters); virtual;
    procedure WebMoveTo(const AParameters: TcxActionParameters); virtual;
    procedure WebMoveBy(const AParameters: TcxActionParameters); virtual;
  protected
    procedure Loaded; override;

    function CanEdit: Boolean; virtual;
    function GetAllowEditing: Boolean; virtual;
    function GetAllowExpanding: Boolean; virtual;
    function GetAllowGrouping: Boolean; virtual;
    function GetAllowSorting: Boolean; virtual;
    function GetKeyFieldName: string; virtual;
    { actions }
    procedure DoAfterPerformActions; override;
    procedure RegisterActions; override;
    { events }
    function GetWebEventsHelper: TcxWebDataSourceEventsHelper;
    class function GetWebEventsHelperClass: TcxWebEventsHelperClass; override;
    property WebEventsHelper: TcxWebDataSourceEventsHelper read GetWebEventsHelper;
    { values }
    function CanSetValues: Boolean; override;
    procedure DoAfterSetValues; override;
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    procedure SynchronizeSelection; virtual;
    procedure SynchronizeInsertingValues; virtual;
    { Renderers }
    procedure RegisterRenderers; override;
    { Fields }
    function GetFields: TcxCustomWebDataFields; overload; virtual;
    procedure SetFields(Value: TcxCustomWebDataFields);
    { Notification }
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;
    property UpdateLock: Integer read FUpdateLock;
    procedure DataNotification(AUpdateType: TcxUpdateType); virtual;
    function NeedUpdateFields: Boolean; virtual;
    procedure UpdateDefaultFields; virtual;
    procedure UpdateDataLayout; virtual;
    procedure ChangedData(AClientName: string); virtual;
    { Data layout }
    function GetFocusedRowIndex: Integer; virtual;
    function GetRecordCount: Integer; virtual;
    function GetRowCount: Integer; virtual;
    function GetDisplayText(ARecordIndex, AItemIndex: Integer): string; virtual;
    function GetValue(ARecordIndex, AItemIndex: Integer): Variant; virtual;
    procedure SetFocusedRowIndex(Value: Integer); virtual;
    procedure SetRecordCount(Value: Integer); virtual;
    procedure SetValue(ARecordIndex, AItemIndex: Integer; const Value: Variant); virtual;
    { Inserting values }
    procedure StoreInsertingValues; virtual;
    procedure RestoreInsertingValues; virtual;
    function GetInsertingValue(Index: Integer): Variant;
    procedure SetInsertingValue(Index: Integer; Value: Variant);
    function InsertingValuesCount: Integer;
    { Key field}
    function KeyField: TcxCustomWebDataField;
    function CheckKey(ARowIndex: Integer; AKey: string; ALevel: Integer): Boolean;
    function FindKey(AKey: string; ALevel: Integer): Integer;
    function RecordKeyValue(ARecord: Integer): string;
    function IsKeyNeeded(ARowIndex: Integer): Boolean;

    function IsDesigning: Boolean;
    property IsEditing: Boolean read FIsEditing write SetIsEditing;
    property IsInserting: Boolean read FIsInserting write SetIsInserting;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Data layout }
    function CheckRowIndex(ARowIndex: Integer): Boolean;
    function ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass; virtual;
    function FieldByName(const Name: string): TcxCustomWebDataField; virtual;
    function GetRowDisplayText(RowIndex: Integer; ItemIndex: Integer): string; virtual;
    function GetRowValue(RowIndex: Integer; ItemIndex: Integer): Variant; virtual;
    function GetRowExpanded(RowIndex: Integer): Boolean; virtual;
    function GetRowLevel(RowIndex: Integer): Integer; virtual;
    function GetRowRecord(RowIndex: Integer): Integer; virtual;
    function GetGroupingItemCount: Integer; virtual;
    function GetSortingItemCount: Integer; virtual;
    function GetItemGroupIndex(ItemIndex: Integer): Integer; virtual;
    function GetItemSortOrder(ItemIndex: Integer): TcxWebDataSortOrder; virtual;
    function GetGroupingItemIndex(Item: Integer): Integer; virtual;
    function GetSortingItemIndex(Item: Integer): Integer; virtual;
    procedure ClearGrouping; virtual;
    procedure ClearSorting; virtual;
    procedure FullCollapse; virtual;
    procedure FullExpand; virtual;

    property DisplayTexts[RecordIndex, ItemIndex: Integer]: string read GetDisplayText;
    property FocusedRowIndex: Integer read GetFocusedRowIndex write SetFocusedRowIndex;
    property RecordCount: Integer read GetRecordCount;
    property RowCount: Integer read GetRowCount;
    property Values[RecordIndex, ItemIndex: Integer]: Variant read GetValue write SetValue;
    { Data clients }
    procedure RegisterClient(Client: TComponent);
    procedure UnRegisterClient(Client: TComponent);
    property ClientCount: Integer read GetClientCount;
    property Clients[Index: Integer]: TComponent read GetClient;
    { Data operations }
    procedure CancelEdit; virtual;
    procedure DeleteRecord(ARowIndex: Integer); virtual;
    procedure InsertRecord(ARowIndex: Integer); virtual;
    procedure EditRecord(ARowIndex: Integer); virtual;
    procedure Expand(ARowIndex: Integer; AExpanded, ARecursive: Boolean); virtual;
    procedure Group(GroupField, GroupIndex: Integer); virtual;
    procedure PostEdit(APriorControlName: string); virtual;
    procedure SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes); virtual;
    procedure Sort(SortIndex: Integer; SortOrder: TcxWebDataSortOrder); virtual;
    procedure UnGroup(UnGroupIndex: Integer); virtual;
    procedure Refresh; virtual;

    property AllowExpanding: Boolean read GetAllowExpanding;
    property AllowGrouping: Boolean read GetAllowGrouping;
    property AllowSorting: Boolean read GetAllowSorting;
    property Fields: TcxCustomWebDataFields read GetFields write SetFields;
    property FullName: string read GetFullName;
    property State: TcxWebDataSourceState read GetState;
  published
    property AllowEditing: Boolean read GetAllowEditing write SetAllowEditing default True;
    property KeyFieldName: string read GetKeyFieldName write SetKeyFieldName;
    property LoadAllRecords: Boolean read FLoadAllRecords write FLoadAllRecords default False;
    // Event properties
    property OnAfterPost: TcxDataEvent read FOnAfterPost write FOnAfterPost;
    property OnBeforePost: TcxAllowingDataEvent read FOnBeforePost write FOnBeforePost;
    property OnCancelEdit: TcxDataEvent read FOnCancelEdit write FOnCancelEdit;
    property OnDeleted: TcxDataEvent read FOnDeleted write FOnDeleted;
    property OnDeleting: TcxAllowingDataEvent read FOnDeleting write FOnDeleting;
    property OnInserted: TcxDataEvent read FOnInserted write FOnInserted;
    property OnInserting: TcxAllowingDataEvent read FOnInserting write FOnInserting;
    property OnScrolled: TcxDataEvent read FOnScrolled write FOnScrolled;
    property OnScrolling: TcxAllowingDataEvent read FOnScrolling write FOnScrolling;
    property OnSetInsertValue: TcxSetInsertValueEvent read FOnSetInsertValue write FOnSetInsertValue;
    property OnSetEditValue: TcxSetEditValueEvent read FOnSetEditValue write FOnSetEditValue;
    property OnStartEdit: TcxAllowingDataEvent read FOnStartEdit write FOnStartEdit;
  end;

  TcxCustomWebDataSourceRenderer = class(TcxWebComponentRenderer)
  protected
    function GetWebDataSource: TcxCustomWebDataSource; overload; virtual;
    function IsLoadAllRecordsMode: Boolean; virtual;

    procedure WriteData; virtual;
    procedure WriteHandlers; virtual;
    procedure WriteKeys; virtual;
  public
    class procedure GetScriptFiles(AList: TStrings); override;
    procedure WriteHiddenFormElements; override;
    procedure WriteScripts; override;
    class procedure WriteClassScripts(AHTMLTextBuilder: TcxHTMLTextBuilder); override;

    property WebDataSource: TcxCustomWebDataSource read GetWebDataSource;
  end;

  TcxCustomWebDataSourceNS4Renderer = class(TcxCustomWebDataSourceRenderer)
  protected
    function IsLoadAllRecordsMode: Boolean; override;
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxCustomWebDataSourceOperaRenderer = class(TcxCustomWebDataSourceNS4Renderer)
  public
    class function IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean; override;
  end;

  TcxWebDataLink = class(TDataLink)
  private
    FWebDataSource: TcxCustomWebDataSource;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
  public
    property WebDataSource: TcxCustomWebDataSource read FWebDataSource;
  end;

  TcxStdWebDataSource = class(TcxCustomWebDataSource, IcxDataSetSupport)
  private
    FDataSource: TDataSource;
    FDataLink: TcxWebDataLink;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function CanEdit: Boolean; override;
    function GetItemField(AItemName: string): TField;
    { IcxDataSetSupport }
    function GetDataSet: TDataSet;
    procedure SetDataSet(Value: TDataSet);
    { fields }
    function GetFields: TcxStdWebDataFields; reintroduce; overload;
    procedure SetFields(Value: TcxStdWebDataFields);
    { values }
    procedure DoSetValues; override;
    procedure RegisterValues; override;
    { actions }
    procedure RegisterActions; override;
    { renderes }
    procedure RegisterRenderers; override;
    { values }
    procedure SynchronizeSelection; override;
    { Data notification }
    procedure DataNotification(AUpdateType: TcxUpdateType); override;
    function NeedUpdateFields: Boolean; override;
    procedure UpdateDefaultFields; override;
    { Data layout }
    function GetFocusedRowIndex: Integer; override;
    function GetDisplayText(ARecordIndex, AItemIndex: Integer): string; override;
    function GetRecordCount: Integer; override;
    function GetValue(ARecordIndex, AItemIndex: Integer): Variant; override;
    procedure SetFocusedRowIndex(Value: Integer); override;
    procedure SetValue(ARecordIndex, AItemIndex: Integer; const Value: Variant); override;

    property DataSource: TDataSource read FDataSource;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Data operations }
    procedure DeleteRecord(ARowIndex: Integer); override;
    procedure InsertRecord(ARowIndex: Integer); override;
    procedure EditRecord(ARowIndex: Integer); override;
    procedure PostEdit(APriorControlName: string); override;
    procedure SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes); override;
    { Data layout }
    function ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass; override;

    property Fields: TcxStdWebDataFields read GetFields write SetFields;
  published
    property DataSet: TDataSet read GetDataSet write SetDataSet;
  end;

implementation

uses
  DateUtils, StrUtils, Math, Variants,
  cxWebDataCtrls, cxWebUtils, cxWebDataUtils, cxWebFileCacheManager,
  cxWebStrs, cxWebConsts;

{ TcxAbstractWebDataBinding }

constructor TcxAbstractWebDataBinding.Create(AComponent: TComponent);
begin
  inherited Create;
  FComponent := AComponent;
end;

procedure TcxAbstractWebDataBinding.Assign(Source: TPersistent);
begin
  if not (Source is TcxAbstractWebDataBinding) then
    inherited;
end;

{ TcxCustomWebDataBinding }

destructor TcxCustomWebDataBinding.Destroy;
begin
  DataSource := nil;
  inherited Destroy;
end;

function TcxCustomWebDataBinding.GetFieldIndex: Integer;
begin
  Result := -1;
end;

function TcxCustomWebDataBinding.GetFirstVisibleRow: Integer;
begin
  Result := -1;
end;

function TcxCustomWebDataBinding.GetPageSize: Integer;
begin
  Result := -1;
end;

procedure TcxCustomWebDataBinding.WriteControlScripts(HTMLTextBuilder: TcxHTMLTextBuilder;
  AControlClass: string);
begin
  HTMLTextBuilder.WriteText(Format('_DataControl = %s()', [AControlClass]));
  HTMLTextBuilder.WriteText(Format('  _DataControl.Name = "%s";', [Component.Name]));
  HTMLTextBuilder.WriteText(Format('  _DataControl.DataControllerName = "%s";',
      [DataSource.FullName]));
  HTMLTextBuilder.WriteText(Format('  _DataControl.FieldIndex = %d;', [GetFieldIndex]));
  HTMLTextBuilder.WriteText(Format('  _DataControl.PageSize = %d;', [GetPageSize]));
  HTMLTextBuilder.WriteText(Format('  _DataControl.FirstVisibleRow = %d;', [GetFirstVisibleRow]));
end;

function TcxCustomWebDataBinding.GetDataSource: TcxCustomWebDataSource;
begin
  Result := FDataSource;
end;

procedure TcxCustomWebDataBinding.SetDataSource(Value: TcxCustomWebDataSource);
begin
  if FDataSource <> Value then
  begin
    if (FDataSource <> nil) and not (csDestroying in FDataSource.ComponentState) then
    begin
      FDataSource.UnRegisterClient(Component);
      FDataSource.RemoveFreeNotification(Component);
    end;
    FDataSource := Value;
    if FDataSource <> nil then
    begin
      FDataSource.FreeNotification(Component);
      FDataSource.RegisterClient(Component);
    end;
    if not (csDestroying in Component.ComponentState) then
      ChangedDataLayout(FDataSource);
  end;
end;

procedure TcxCustomWebDataBinding.ChangedDataLayout(Sender: TcxCustomWebDataSource);
begin
end;

procedure TcxCustomWebDataBinding.UpdateData(Sender: TcxCustomWebDataSource);
begin
end;

procedure TcxCustomWebDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxCustomWebDataBinding then
    DataSource := TcxCustomWebDataBinding(Source).DataSource
  else inherited;
end;

procedure TcxCustomWebDataBinding.Loaded;
begin
  if DataSource = nil then
    ChangedDataLayout(DataSource);
end;

procedure TcxCustomWebDataBinding.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = DataSource) then
    DataSource := nil;
end;

{ TcxDataFieldHelper }

constructor TcxDataFieldHelper.Create(AField: TcxCustomWebDataField);
begin
  FField := AField;
end;

function TcxDataFieldHelper.GetDataSource: TcxCustomWebDataSource;
begin
  Result := Field.DataSource;
end;

function TcxDataFieldHelper.GetIndex: Integer;
begin
  Result := Field.Index;
end;

function TcxDataFieldHelper.ValidateValue(var Value: Variant): Boolean;
begin
  Result := True;
end;

function TcxDataFieldHelper.ValidateValueType(AType: TcxWebDataTypes): Boolean;
begin
  Result := dtText in AType;
end;

function TcxDataFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := '"Unknown format"';
end;

{ TcxStringFieldHelper }

function TcxStringFieldHelper.ValidateValue(var Value: Variant): Boolean;
begin
  if VarIsType(Value, varString) then
    Result := True
  else Result := False;
end;

function TcxStringFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := Format('["%s"]', [ScriptString(DataSource.DisplayTexts[ARecord, Index])]);
end;

{ TcxIntegerFieldHelper }

function TcxIntegerFieldHelper.ValidateValue(var Value: Variant): Boolean;
var
  Dummy: Integer;
begin
  if VarIsType(Value, [varInteger, varShortInt, varByte, varWord, varLongWord, varInt64]) then
    Result := True
  else if VarIsType(Value, varString) then
  begin
    if TryStrToInt(Value, Dummy) then
      Result := True
    else if Value = '' then
    begin
      Value := 0;
      Result := True;
    end
    else Result := False;
  end
  else Result := False;
end;

function TcxIntegerFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := Format('[%s]', [DataSource.DisplayTexts[ARecord, Index]]);
end;

{ TcxCurrencyFieldHelper }

function TcxCurrencyFieldHelper.ValidateValue(var Value: Variant): Boolean;
var
  Dummy: Currency;
begin
  if VarIsType(Value, [varDouble, varSingle, varCurrency]) then
    Result := True
  else if VarIsType(Value, varString) then
  begin
    if TryStrToCurr(Value, Dummy) then
      Result := True
    else if Value = '' then
    begin
      Value := 0;
      Result := True;
    end
    else Result := False;
  end
  else Result := False;
end;

function TcxCurrencyFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := Format('[%s, "%s"]', [ScriptValue(DataSource.Values[ARecord, Index]), DataSource.DisplayTexts[ARecord, Index]]);
end;

{ TcxFloatFieldHelper }

function TcxFloatFieldHelper.ValidateValue(var Value: Variant): Boolean;
var
  Dummy: Double;
begin
  if VarIsType(Value, [varDouble, varSingle, varCurrency]) then
    Result := True
  else if VarIsType(Value, varString) then
  begin
    if TryStrToFloat(Value, Dummy) then
      Result := True
    else if Value = '' then
    begin
      Value := 0;
      Result := True;
    end
    else Result := False;
  end
  else Result := False;
end;

function TcxFloatFieldHelper.GetScriptData(ARecord: Integer): string;
var
  SaveDecimalSeparator: Char;
  Value: Variant;
begin
  Value := DataSource.Values[ARecord, Index];
  if VarIsType(Value, [varDouble, varSingle, varCurrency]) then
  begin
    SaveDecimalSeparator := DecimalSeparator;
    try
      DecimalSeparator := '.';
      try
        Result := Format('[eval("%g")]', [Extended(Value)])
      except
        Result := '[null]';
      end
    finally
      DecimalSeparator := SaveDecimalSeparator;
    end
  end
  else Result := '[null]';
end;

{ TcxDateTimeFieldHelper }

function TcxDateTimeFieldHelper.ValidateValue(var Value: Variant): Boolean;
var
  Dummy: TDateTime;
begin
  if VarIsType(Value, varDate) then
    Result := True
  else if VarIsType(Value, varString) then
  begin
    if TryStrToDateTime(Value, Dummy) then
      Result := True
    else if Value = '' then
    begin
      Value := 0;
      Result := True;
    end
    else Result := False;
  end
  else Result := False;
end;

function TcxDateTimeFieldHelper.GetScriptData(ARecord: Integer): string;
var
  Date: Variant;
  AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
begin
  Date := DataSource.Values[ARecord, Index];
  if VarIsType(Date, varDate) then
  begin
    try
      DecodeDateTime(TDateTime(Date), AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
      Result := Format('[new Date(%d, %d, %d, %d, %d), "%s"]',
          [AYear, AMonth - 1, ADay, AHour, AMinute, DataSource.DisplayTexts[ARecord, Index]]);
    except
      Result := '[null]';
    end;
  end
  else Result := '[null]';
end;

{ TcxBooleanFieldHelper }

function TcxBooleanFieldHelper.ValidateValue(var Value: Variant): Boolean;
var
  Dummy: Boolean;
begin
  if VarIsType(Value, varBoolean) then
    Result := True
  else if VarIsType(Value, varString) then
  begin
    if TryStrToBool(Value, Dummy) then
      Result := True
    else if Value = '' then
    begin
      Value := False;
      Result := True;
    end
    else Result := False;
  end
  else Result := False;
end;

function TcxBooleanFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := Format('[%s, "%s"]', [LowerCase(DataSource.DisplayTexts[ARecord, Index]), DataSource.DisplayTexts[ARecord, Index]]);
end;

{ TcxImageFieldHelper }

function TcxImageFieldHelper.ValidateValue(var Value: Variant): Boolean;
begin
  Result := False;
end;

function TcxImageFieldHelper.ValidateValueType(AType: TcxWebDataTypes): Boolean;
begin
  Result := dtValue in AType;
end;

function TcxImageFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := '[null, "(GRAPHICS)"]';
end;

{ TcxMemoFieldHelper }

function TcxMemoFieldHelper.ValidateValue(var Value: Variant): Boolean;
begin
  if VarIsType(Value, varString) then
    Result := True
  else Result := False;
end;

function TcxMemoFieldHelper.ValidateValueType(AType: TcxWebDataTypes): Boolean;
begin
  Result := dtValue in AType;
end;

function TcxMemoFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := Format('["%s", "(MEMO)"]', [ScriptValue(DataSource.Values[ARecord, Index])]);
end;

{ TcxBinaryFieldHelper }

function TcxBinaryFieldHelper.ValidateValue(var Value: Variant): Boolean;
begin
  Result := False;
end;

function TcxBinaryFieldHelper.ValidateValueType(AType: TcxWebDataTypes): Boolean;
begin
  Result := dtValue in AType;
end;

function TcxBinaryFieldHelper.GetScriptData(ARecord: Integer): string;
begin
  Result := '[null, "(BINARY)"]';
end;

{ TcxCustomWebDataField }

constructor TcxCustomWebDataField.Create(Collection: TCollection);
begin
  inherited;
  FName := UniqueName;
end;

destructor TcxCustomWebDataField.Destroy;
begin
  FreeAndNil(FFieldHelper);
  inherited;
end;

function TcxCustomWebDataField.DataSource: TcxCustomWebDataSource;
begin
  Result := Collection.Owner as TcxCustomWebDataSource;
end;

function TcxCustomWebDataField.GetScriptData(ARecord: Integer): string;
begin
  Result := FieldHelper.GetScriptData(ARecord);
end;

function TcxCustomWebDataField.ValidateValue(var AValue: Variant): Boolean;
begin
  Result := FieldHelper.ValidateValue(AValue);
end;

function TcxCustomWebDataField.ValidateValueType(AType: TcxWebDataTypes): Boolean;
begin
  Result := FieldHelper.ValidateValueType(AType);
end;

procedure TcxCustomWebDataField.SetName(Value: string);
begin
  if FName <> Value then
  begin
    if (DataSource <> nil) and (DataSource.FieldByName(Value) = nil) then
      FName := Value;
  end;
end;

function TcxCustomWebDataField.UniqueName: string;
var
  I: Integer;
begin
  if DataSource <> nil then
  begin
    I := 0;
    while True do
    begin
      Result := 'dcfField' + IntToStr(I);
      if DataSource.FieldByName(Result) = nil then
        break
      else Inc(I);
    end;
  end
  else Result := 'dcfField' + IntToStr(Index);
end;

function TcxCustomWebDataField.FieldHelper: TcxDataFieldHelper;
var
  HelperClass: TcxDataFieldHelperClass;
begin
  if FFieldHelper = nil then
  begin
    HelperClass := DataSource.ItemHelperClass(Index);
    if HelperClass <> nil then
      FFieldHelper := HelperClass.Create(Self)
    else FFieldHelper := TcxDataFieldHelper.Create(Self);
  end;
  Result := FFieldHelper;
end;

function TcxCustomWebDataField.GetDisplayName: string;
begin
  Result := Name;
end;

{ TcxCustomWebDataFields }

constructor TcxCustomWebDataFields.Create(ADataSource: TcxCustomWebDataSource);
begin
  inherited Create(FieldClass);
  FDataSource := ADataSource;
end;

function TcxCustomWebDataFields.Add: TcxCustomWebDataField;
begin
  Result := TcxCustomWebDataField(inherited Add);
end;

function TcxCustomWebDataFields.DataSource: TcxCustomWebDataSource;
begin
  Result := FDataSource;
end;

function TcxCustomWebDataFields.GetItem(Index: Integer): TcxCustomWebDataField;
begin
  Result := TcxCustomWebDataField(inherited Items[Index]);
end;

function TcxCustomWebDataFields.GetOwner: TPersistent;
begin
  Result := FDataSource;
end;

class function TcxCustomWebDataFields.FieldClass: TcxCustomWebDataFieldClass;
begin
  Result := TcxCustomWebDataField;
end;

procedure TcxCustomWebDataFields.SetItem(Index: Integer; Value: TcxCustomWebDataField);
begin
  Items[Index].Assign(Value);
end;

{ TcxStdWebDataField }

function TcxStdWebDataField.DataSource: TcxStdWebDataSource;
begin
  Result := Collection.Owner as TcxStdWebDataSource;
end;

function TcxStdWebDataField.GetDataSet: TDataSet;
begin
  if (Collection as TcxStdWebDataFields).DataSource <> nil then
    Result := (Collection as TcxStdWebDataFields).DataSource.DataSet
  else Result := nil;
end;

procedure TcxStdWebDataField.SetFieldName(const Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
  end;
end;

{ TcxStdWebDataFields }

function TcxStdWebDataFields.GetItem(Index: Integer): TcxStdWebDataField;
begin
  Result := TcxStdWebDataField(inherited Items[Index]);
end;

procedure TcxStdWebDataFields.SetItem(Index: Integer; Value: TcxStdWebDataField);
begin
  Items[Index].Assign(Value);
end;

class function TcxStdWebDataFields.FieldClass: TcxCustomWebDataFieldClass;
begin
  Result := TcxStdWebDataField;
end;

function TcxStdWebDataFields.Add: TcxStdWebDataField;
begin
  Result := TcxStdWebDataField(inherited Add);
end;

function TcxStdWebDataFields.DataSource: TcxStdWebDataSource;
begin
  Result := inherited DataSource as TcxStdWebDataSource;
end;

{ TcxWebDataSourceEventsHelper }

function TcxWebDataSourceEventsHelper.EventName(const AEvent: Integer): string;
const
  cxHTMLEvent: array[TcxWebDataSourceEvent] of string = ('OnAfterSort', 'OnAfterGroup',
    'OnAfterUngroup', 'OnAfterExpand', 'OnAfterMove', 'OnBeforeSort',
    'OnBeforeGroup', 'OnBeforeUngroup', 'OnBeforeExpand', 'OnBeforeMove',
    'OnBeforeDelete', 'OnBeforeInsert', 'OnBeforeStartEdit', 'OnBeforePostEdit',
    'OnBeforeCancelEdit', 'OnBeforeRefresh');
begin
  Result := cxHTMLEvent[TcxWebDataSourceEvent(AEvent)];
end;

function TcxWebDataSourceEventsHelper.EventProcParams(const AEvent: Integer): string;
const
  cxHTMLEventProcParams: array[TcxWebDataSourceEvent] of string = ('(Sender, ColumnIndex)',
    '(Sender, ColumnIndex, GroupIndex)', '(Sender, ColumnIndex)', '(Sender, RowIndex)',
    '(Sender, RowIndex)', '(Sender, ColumnIndex)', '(Sender, ColumnIndex, GroupIndex)',
    '(Sender, ColumnIndex)', '(Sender, RowIndex)', '(Sender, RowIndex)', '(Sender, RowIndex)',
    '(Sender, RowIndex)', '(Sender, RowIndex)', '(Sender)', '(Sender)', '(Sender)');
begin
  Result := cxHTMLEventProcParams[TcxWebDataSourceEvent(AEvent)];
end;

function TcxWebDataSourceEventsHelper.ScriptObject: string;
begin
  Result := '_DataController';
end;

function TcxWebDataSourceEventsHelper.EventTypeInfo: PTypeInfo;
begin
  Result := TypeInfo(TcxWebDataSourceEvent);
end;

{ TcxCustomWebDataSource }

constructor TcxCustomWebDataSource.Create(AOwner: TComponent);
begin
  inherited;
  FClientsList := TList.Create;
  FAllowEditing := True;
end;

destructor TcxCustomWebDataSource.Destroy;
begin
  FClientsList.Free;
  inherited;
end;

function TcxCustomWebDataSource.CheckRowIndex(ARowIndex: Integer): Boolean;
begin
  Result := ((0 <= ARowIndex) and (ARowIndex < RowCount));
end;

function TcxCustomWebDataSource.GetFocusedRowIndex: Integer;
begin
  Result := -1;
end;

function TcxCustomWebDataSource.ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass;
begin
  Result := TcxDataFieldHelper;
end;

function TcxCustomWebDataSource.GetValue(ARecordIndex, AItemIndex: Integer): Variant;
begin
  Result := VarEmpty;
end;

procedure TcxCustomWebDataSource.Loaded;
begin
  inherited;
  DataNotification(utData);
end;

function TcxCustomWebDataSource.CanEdit: Boolean;
begin
  Result := AllowEditing;
end;

function TcxCustomWebDataSource.GetAllowEditing: Boolean;
begin
  Result := FAllowEditing;
end;

function TcxCustomWebDataSource.GetAllowExpanding: Boolean;
begin
  Result := False;
end;

function TcxCustomWebDataSource.GetAllowGrouping: Boolean;
begin
  Result := False;
end;

function TcxCustomWebDataSource.GetAllowSorting: Boolean;
begin
  Result := False;
end;

function TcxCustomWebDataSource.GetKeyFieldName: string;
begin
  Result := FKeyFieldName;
end;

procedure TcxCustomWebDataSource.SetAllowEditing(Value: Boolean);
begin
  if FAllowEditing <> Value then
  begin
    FAllowEditing := Value;
    if not Value then CancelEdit;
  end;
end;

procedure TcxCustomWebDataSource.SetIsEditing(Value: Boolean);
begin
  if FIsEditing <> Value then
  begin
    FIsEditing := Value;
  end;
end;

procedure TcxCustomWebDataSource.SetIsInserting(Value: Boolean);
begin
  if FIsInserting <> Value then
  begin
    FIsInserting := Value;
  end;
end;

procedure TcxCustomWebDataSource.SetKeyFieldName(Value: string);
begin
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
  end;
end;

procedure TcxCustomWebDataSource.SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes);
begin
end;

procedure TcxCustomWebDataSource.SetFocusedRowIndex(Value: Integer);
begin
end;

procedure TcxCustomWebDataSource.SetRecordCount(Value: Integer);
begin
end;

procedure TcxCustomWebDataSource.SetValue(ARecordIndex, AItemIndex: Integer; const Value: Variant);
begin
end;

procedure TcxCustomWebDataSource.StoreInsertingValues;
var
  I: Integer;
  AValue: Variant;
  ACanSet: Boolean;
begin
  SetLength(FInsertingValues, Fields.Count);
  for I := 0 to Fields.Count - 1 do
  begin
    AValue := Null;
    ACanSet := True;
    if(Assigned(OnSetInsertValue)) then
      OnSetInsertValue(Self, I, FocusedRowIndex, AValue, ACanSet);
    if not ACanSet then AValue := Null;
    SetInsertingValue(I, AValue);
  end;
end;

procedure TcxCustomWebDataSource.RestoreInsertingValues;
var
  I: Integer;
begin
  if Fields.Count = InsertingValuesCount then
    for I := 0 to Fields.Count - 1 do
      if FInsertingValues[I] <> Null then
        SetEditValue(I, FInsertingValues[I], [dtText, dtValue]);
end;

function TcxCustomWebDataSource.GetInsertingValue(Index: Integer): Variant;
begin
  Result := FInsertingValues[Index];
end;

procedure TcxCustomWebDataSource.SetInsertingValue(Index: Integer; Value: Variant);
begin
  FInsertingValues[Index] := Value;
end;

function TcxCustomWebDataSource.InsertingValuesCount: Integer;
begin
  Result := Length(FInsertingValues)
end;

function TcxCustomWebDataSource.KeyField: TcxCustomWebDataField;
begin
  Result := FieldByName(KeyFieldName);
end;

function TcxCustomWebDataSource.CheckKey(ARowIndex: Integer; AKey: string; ALevel: Integer): Boolean;
begin
  if not CheckRowIndex(ARowIndex) then
    Result := False
  else
  begin
    if KeyField <> nil then
      Result := (AKey = DisplayTexts[GetRowRecord(ARowIndex), KeyField.Index]) and
        (ALevel = GetRowLevel(ARowIndex))
    else Result := True;
  end;
end;

function TcxCustomWebDataSource.FindKey(AKey: string; ALevel: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  if KeyField <> nil then
    for I := 0 to RowCount - 1 do
      if (AKey = DisplayTexts[GetRowRecord(I), KeyField.Index]) and (ALevel = GetRowLevel(I)) then
      begin
        Result := I;
        break;
      end;
end;

function TcxCustomWebDataSource.RecordKeyValue(ARecord: Integer): string;
begin
  if KeyField <> nil then
    Result := DisplayTexts[ARecord, KeyField.Index]
  else Result := '';
end;

function TcxCustomWebDataSource.IsKeyNeeded(ARowIndex: Integer): Boolean;
var
  I: Integer;
  ViewIntf: IcxWebViewDataSupport;
begin
  Result := False;
  for I := 0 to ClientCount - 1 do
    if Supports(Clients[I], IcxWebViewDataSupport, ViewIntf) then
      if (ARowIndex >= ViewIntf.GetFirstVisibleRow) and
        (ARowIndex < ViewIntf.GetFirstVisibleRow + ViewIntf.GetPageSize) then
      begin
        Result := True;
        break;
      end;
end;

procedure TcxCustomWebDataSource.ClearGrouping;
begin
end;

procedure TcxCustomWebDataSource.ClearSorting;
begin
end;

procedure TcxCustomWebDataSource.FullCollapse;
begin
end;

procedure TcxCustomWebDataSource.FullExpand;
begin
end;


procedure TcxCustomWebDataSource.WebDelete(const AParameters: TcxActionParameters);
var
  ARowIndex, AKeyLevel: Integer;
  AKeyValue: string;
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
  if CheckRowIndex(ARowIndex) then DeleteRecord(ARowIndex);
end;

procedure TcxCustomWebDataSource.WebStartEdit(const AParameters: TcxActionParameters);
var
  ARowIndex, AKeyLevel: Integer;
  AKeyValue: string;
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
  if CheckRowIndex(ARowIndex) then  EditRecord(ARowIndex);
end;

procedure TcxCustomWebDataSource.WebPostEdit(const AParameters: TcxActionParameters);
var
  ARowIndex, AKeyLevel: Integer;
  ADataControlName, AKeyValue: string;
begin
  try
    AKeyValue := GetActionParameter(AParameters.ParamString, 1);
    AKeyLevel := StrToInt(GetActionParameter(AParameters.ParamString, 2));
  except
    on EConvertError do
    begin
      AKeyValue := '';
      AKeyLevel := 0;
    end
    else raise;
  end;
  ARowIndex := FocusedRowIndex;
  if not CheckKey(ARowIndex, AKeyValue, AKeyLevel) then
    ARowIndex := FindKey(AKeyValue, AKeyLevel);
  if CheckRowIndex(ARowIndex) then
  begin
    ADataControlName := GetActionParameter(AParameters.ParamString, 0);
    PostEdit(ADataControlName);
  end;
end;

procedure TcxCustomWebDataSource.WebCancelEdit(const AParameters: TcxActionParameters);
begin
  CancelEdit;
end;

procedure TcxCustomWebDataSource.WebInsert(const AParameters: TcxActionParameters);
var
  ARowIndex, AKeyLevel: Integer;
  AKeyValue: string;
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
    InsertRecord(ARowIndex)
  else InsertRecord(-1);
end;

procedure TcxCustomWebDataSource.WebRefresh(const AParameters: TcxActionParameters);
begin
  Refresh;
end;

procedure TcxCustomWebDataSource.WebMoveTo(const AParameters: TcxActionParameters);
var
  ARowIndex: Integer;
begin
  try
    ARowIndex := StrToInt(GetActionParameter(AParameters.ParamString, 0));
  except
    on EConvertError do ARowIndex := -1;
    else raise;
  end;
  if ARowIndex < 0 then ARowIndex := 0;
  if ARowIndex >= RowCount then ARowIndex := RowCount - 1;
  FocusedRowIndex := ARowIndex;
end;

procedure TcxCustomWebDataSource.WebMoveBy(const AParameters: TcxActionParameters);
var
  ARowIndex, OldRowIndex, Delta: Integer;
begin
  OldRowIndex := GetFocusedRowIndex;
  try
    Delta := StrToInt(GetActionParameter(AParameters.ParamString, 0));
  except
    on EConvertError do Delta := 0;
    else raise;
  end;
  ARowIndex := OldRowIndex + Delta;
  if ARowIndex < 0 then ARowIndex := 0;
  if ARowIndex >= RowCount then ARowIndex := RowCount - 1;
  FocusedRowIndex := ARowIndex;
end;

procedure TcxCustomWebDataSource.SynchronizeSelection;
var
  ARowIndex: Integer;
begin
  try
    ARowIndex := StrToInt(WebValuesHelper.Values.Values[FullName + 'FocusedRow']);
  except
    on EConvertError do ARowIndex := 0;
    else raise;
  end;
  if (ARowIndex < 0) then ARowIndex := 0;
  if (ARowIndex >= RowCount) then ARowIndex := RowCount - 1;
  FocusedRowIndex := ARowIndex;
end;

procedure TcxCustomWebDataSource.SynchronizeInsertingValues;
var
  I, DelimiterPos: Integer;
  S, AValue: string;
begin
  S := WebValuesHelper.Values.Values[FullName + 'InsertingValues'];
  SetLength(FInsertingValues, Fields.Count);

  for I := 0 to InsertingValuesCount - 1 do
  begin
    FInsertingValues[I] := Null;
    DelimiterPos := Pos(scxInfoDelimiter, S);
    if DelimiterPos = 0 then break;
    try
      AValue := LeftStr(S, DelimiterPos - 1);
      if AValue <> '' then FInsertingValues[I] := AValue;
    except
      on EConvertError do FInsertingValues[I] := Null;
      else raise;
    end;
    S := RightStr(S, Length(S) - DelimiterPos);
  end;

end;

{ Actions }

procedure TcxCustomWebDataSource.DoAfterPerformActions;
begin
  if not IsEditing then
    UpdateDataLayout;
end;

procedure TcxCustomWebDataSource.RegisterActions;
begin
  WebActionsHelper.RegisterAction(scxDeleteAction, WebDelete);
  WebActionsHelper.RegisterAction(scxStartEditAction, WebStartEdit);
  WebActionsHelper.RegisterAction(scxPostEditAction, WebPostEdit);
  WebActionsHelper.RegisterAction(scxCancelEditAction, WebCancelEdit);
  WebActionsHelper.RegisterAction(scxInsertAction, WebInsert);
  WebActionsHelper.RegisterAction(scxRefreshAction, WebRefresh);
  WebActionsHelper.RegisterAction(scxMoveToAction, WebMoveTo);
  WebActionsHelper.RegisterAction(scxMoveByAction, WebMoveBy);
end;

{ events }

function TcxCustomWebDataSource.GetWebEventsHelper: TcxWebDataSourceEventsHelper;
begin
  Result := inherited GetWebEventsHelper as TcxWebDataSourceEventsHelper;
end;

class function TcxCustomWebDataSource.GetWebEventsHelperClass: TcxWebEventsHelperClass;
begin
  Result := TcxWebDataSourceEventsHelper;
end;

{ Values }
function TcxCustomWebDataSource.CanSetValues: Boolean;
begin
  Result := True;
end;

procedure TcxCustomWebDataSource.DoAfterSetValues;
begin
end;

procedure TcxCustomWebDataSource.DoSetValues;
begin
  IsEditing := SameText(WebValuesHelper.Values.Values[FullName + 'IsEditing'], 'true');
  IsInserting := SameText(WebValuesHelper.Values.Values[FullName + 'IsInserting'], 'true');
  if IsInserting then SynchronizeInsertingValues;
end;

procedure TcxCustomWebDataSource.RegisterValues;
begin
  WebValuesHelper.RegisterValue(FullName + 'IsEditing', cxWebUtils.BoolToStr(IsEditing));
  WebValuesHelper.RegisterValue(FullName + 'IsInserting', cxWebUtils.BoolToStr(IsInserting));
  WebValuesHelper.RegisterValue(FullName + 'InsertingValues', '');
  WebValuesHelper.RegisterValue(FullName + 'FocusedRow', IntToStr(FocusedRowIndex));
end;

procedure TcxCustomWebDataSource.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataSourceRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataSourceNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataSourceOperaRenderer);
end;

function TcxCustomWebDataSource.GetRowDisplayText(RowIndex: Integer; ItemIndex: Integer): string;
begin
  Result := DisplayTexts[RowIndex, ItemIndex];
end;

function TcxCustomWebDataSource.GetRowValue(RowIndex: Integer; ItemIndex: Integer): Variant;
begin
  Result := Values[RowIndex, ItemIndex];
end;

function TcxCustomWebDataSource.GetRowExpanded(RowIndex: Integer): Boolean;
begin
  Result := False;
end;

function TcxCustomWebDataSource.GetRowLevel(RowIndex: Integer): Integer;
begin
  Result := 0;
end;

function TcxCustomWebDataSource.GetRowRecord(RowIndex: Integer): Integer;
begin
  Result := RowIndex;
end;

function TcxCustomWebDataSource.GetGroupingItemCount: Integer;
begin
  Result := 0;
end;

function TcxCustomWebDataSource.GetSortingItemCount: Integer;
begin
  Result := 0;
end;

function TcxCustomWebDataSource.GetItemGroupIndex(ItemIndex: Integer): Integer;
begin
  Result := -1;
end;

function TcxCustomWebDataSource.GetItemSortOrder(ItemIndex: Integer): TcxWebDataSortOrder;
begin
  Result := wsoNone;
end;

function TcxCustomWebDataSource.GetGroupingItemIndex(Item: Integer): Integer;
begin
  Result := -1;
end;

function TcxCustomWebDataSource.GetSortingItemIndex(Item: Integer): Integer;
begin
  Result := -1;
end;

procedure TcxCustomWebDataSource.BeginUpdate;
begin
  Inc(FUpdateLock);
end;

procedure TcxCustomWebDataSource.CancelUpdate;
begin
  Dec(FUpdateLock);
end;

procedure TcxCustomWebDataSource.EndUpdate;
begin
  Dec(FUpdateLock);
  if FUpdateLock = 0 then
    UpdateDataLayout;
end;

function TcxCustomWebDataSource.FieldByName(const Name: string): TcxCustomWebDataField;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Fields.Count - 1 do
    if SameText(Fields[I].Name, Name) then
    begin
      Result := Fields[I];
      break;
    end;
end;

procedure TcxCustomWebDataSource.RegisterClient(Client: TComponent);
begin
  if FClientsList.IndexOf(Client) = -1 then
    FClientsList.Add(Client);
end;

procedure TcxCustomWebDataSource.UnRegisterClient(Client: TComponent);
begin
  if FClientsList.IndexOf(Client) <> -1 then
    FClientsList.Remove(Client);
end;

function TcxCustomWebDataSource.GetClient(Index: Integer): TComponent;
begin
  Result := TComponent(FClientsList.Items[Index]);
end;

function TcxCustomWebDataSource.GetClientCount: Integer;
begin
  Result := FClientsList.Count;
end;

function TcxCustomWebDataSource.GetFullName: string;
begin
  Result := Format('%s_%s', [Owner.Name, Name]);
end;

function TcxCustomWebDataSource.GetState: TcxWebDataSourceState;
begin
  if IsInserting then
    Result := inserting
  else if IsEditing then
    Result := editing
  else Result := browsing;
end;

procedure TcxCustomWebDataSource.DataNotification(AUpdateType: TcxUpdateType);
begin
end;

function TcxCustomWebDataSource.NeedUpdateFields: Boolean;
begin
  Result := False;
end;

procedure TcxCustomWebDataSource.UpdateDefaultFields;
begin
end;

procedure TcxCustomWebDataSource.UpdateDataLayout;
var
  I: Integer;
  DataSourceIntf: IcxWebDataSourceSupport;
begin
  if FUpdateLock > 0 then exit;
  BeginUpdate;
  try
    for I := 0 to ClientCount - 1 do
    begin
      if (Clients[I] <> nil) and not (csDestroying in Clients[I].ComponentState) then
      begin
        if Supports(Clients[I], IcxWebDataSourceSupport, DataSourceIntf) then
          DataSourceIntf.ChangedDataLayout(Self);
      end;
    end;
  finally
    CancelUpdate;
  end;
end;

procedure TcxCustomWebDataSource.ChangedData(AClientName: string);
var
  I: Integer;
  DataSourceIntf: IcxWebDataSourceSupport;
begin
  if IsLoading then exit;
  BeginUpdate;
  try
    for I := 0 to ClientCount - 1 do
    begin
      if Supports(Clients[I], IcxWebDataSourceSupport, DataSourceIntf) then
        DataSourceIntf.UpdateData(Self);
      if Clients[I].Name = AClientName then break;
    end;
  finally
    EndUpdate;
  end;
end;

{ Data operations }
procedure TcxCustomWebDataSource.CancelEdit;
begin
  BeginUpdate;
  try
    IsInserting := False;
    IsEditing := False;
    if Assigned(OnCancelEdit) then
      OnCancelEdit(self, FocusedRowIndex);
  finally
    EndUpdate;
  end;

end;

procedure TcxCustomWebDataSource.DeleteRecord(ARowIndex: Integer);
begin
end;

procedure TcxCustomWebDataSource.InsertRecord(ARowIndex: Integer);
begin
end;

procedure TcxCustomWebDataSource.EditRecord(ARowIndex: Integer);
begin
end;

procedure TcxCustomWebDataSource.Expand(ARowIndex: Integer; AExpanded, ARecursive: Boolean);
begin
end;

procedure TcxCustomWebDataSource.Group(GroupField, GroupIndex: Integer);
begin
end;

procedure TcxCustomWebDataSource.PostEdit(APriorControlName: string);
begin
end;

procedure TcxCustomWebDataSource.Sort(SortIndex: Integer; SortOrder: TcxWebDataSortOrder);
begin
end;

procedure TcxCustomWebDataSource.UnGroup(UnGroupIndex: Integer);
begin
end;

procedure TcxCustomWebDataSource.Refresh;
begin
  UpdateDataLayout;
end;

function TcxCustomWebDataSource.GetFields: TcxCustomWebDataFields;
begin
  Result := FFields;
end;

procedure TcxCustomWebDataSource.SetFields(Value: TcxCustomWebDataFields);
begin
  FFields := Value;
end;

function TcxCustomWebDataSource.GetDisplayText(ARecordIndex, AItemIndex: Integer): string;
begin
  Result := '';
end;

function TcxCustomWebDataSource.GetRecordCount: Integer;
begin
  Result := 0;
end;

function TcxCustomWebDataSource.GetRowCount: Integer;
begin
  Result := RecordCount;
end;

function TcxCustomWebDataSource.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState) or ((Owner <> nil) and
    (csDesigning in Owner.ComponentState));
end;

{ TcxCustomWebDataSourceRenderer }

function TcxCustomWebDataSourceRenderer.GetWebDataSource: TcxCustomWebDataSource;
begin
  Result := Component as TcxCustomWebDataSource;
end;

function TcxCustomWebDataSourceRenderer.IsLoadAllRecordsMode: Boolean;
begin
  Result := WebDataSource.LoadAllRecords and not WebDataSource.IsDesigning and
    not WebDataSource.IsInserting;
end;

class procedure TcxCustomWebDataSourceRenderer.GetScriptFiles(AList: TStrings);
begin
  AList.Add(scxCommonScriptName);
  AList.Add(scxDataEngineScriptName);
  AList.Add(scxDataControllerScriptName);
  AList.Add(scxDataControlsScriptName);
end;

procedure TcxCustomWebDataSourceRenderer.WriteHandlers;
begin
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnChangeFocus = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnScrolling) or Assigned(WebDataSource.OnScrolled))]));
  HTMLTextBuilder.WriteText('  _DataController.AssignOnGroup = false;');
  HTMLTextBuilder.WriteText('  _DataController.AssignOnUnGroup = false;');
  HTMLTextBuilder.WriteText('  _DataController.AssignOnSort = false;');
  HTMLTextBuilder.WriteText('  _DataController.AssignOnExpand = false;');
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnEdit = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnStartEdit))]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AssignOnCancelEdit = %s;',
    [cxWebUtils.BoolToStr(Assigned(WebDataSource.OnCancelEdit))]));
end;

procedure TcxCustomWebDataSourceRenderer.WriteKeys;
var
  I, ARecordIndex: Integer;
begin
  if not WebDataSource.IsDesigning and not IsLoadAllRecordsMode and
    (WebDataSource.KeyField <> nil) then
  begin
    for I := 0 to WebDataSource.RowCount - 1 do
      if WebDataSource.IsKeyNeeded(I) then
      begin
        ARecordIndex := WebDataSource.GetRowRecord(I);
        HTMLTextBuilder.WriteText(Format('  _DataController.AddKey(%d, "%s", %d);',
          [I, WebDataSource.RecordKeyValue(ARecordIndex), WebDataSource.GetRowLevel(I)]));
      end;
  end;
end;

procedure TcxCustomWebDataSourceRenderer.WriteData;
var
  I, J: Integer;
  S: string;
begin
  if IsLoadAllRecordsMode then
  begin
    for I := 0 to WebDataSource.RecordCount - 1 do
    begin
      S := '';
      for J := 0 to WebDataSource.Fields.Count - 1 do
      begin
        S := S + WebDataSource.Fields[J].GetScriptData(I);
        if J <> WebDataSource.Fields.Count - 1 then S := S + ', ';
      end;
      HTMLTextBuilder.WriteText(Format('  _DataController.AddRecord("%s", [%s]);',
        [WebDataSource.RecordKeyValue(I), S]));
    end;
  end
  else
  begin
    HTMLTextBuilder.WriteText(Format('  _DataController.RowCount = %d;', [WebDataSource.RowCount]));
    HTMLTextBuilder.WriteText(Format('  _DataController.SortingItemCount = %d;', [WebDataSource.GetSortingItemCount]));
    HTMLTextBuilder.WriteText(Format('  _DataController.GroupingItemCount = %d;', [WebDataSource.GetGroupingItemCount]));
    WriteKeys;
  end;
end;

procedure TcxCustomWebDataSourceRenderer.WriteHiddenFormElements;
var
  I: Integer;
  S: string;
begin
  WriteHiddenField(WebDataSource.FullName + 'FocusedRow', IntToStr(WebDataSource.FocusedRowIndex));
  WriteHiddenField(WebDataSource.FullName + 'IsEditing', cxWebUtils.BoolToStr(WebDataSource.IsEditing));
  WriteHiddenField(WebDataSource.FullName + 'IsInserting', cxWebUtils.BoolToStr(WebDataSource.IsInserting));
  if WebDataSource.IsInserting then
  begin
    S := '';
    for I := 0 to WebDataSource.InsertingValuesCount - 1 do
      S := S + VarToStr(WebDataSource.GetInsertingValue(I)) + scxInfoDelimiter;
    WriteHiddenField(WebDataSource.FullName + 'InsertingValues', S);
  end;
end;

procedure TcxCustomWebDataSourceRenderer.WriteScripts;
begin
  WriteEventsScript;
  HTMLTextBuilder.WriteText(Format('_DataController = CreateDataController();', []));
  HTMLTextBuilder.WriteText(Format('  _DataController.Name = "%s";', [WebDataSource.FullName]));
  HTMLTextBuilder.WriteText(Format('  _DataController.ItemCount = %d;', [WebDataSource.Fields.Count]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AllowEditing = %s;',
    [cxWebUtils.BoolToStr(WebDataSource.AllowEditing)]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AllowGrouping = %s;',
    [cxWebUtils.BoolToStr(WebDataSource.AllowGrouping)]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AllowSorting = %s;',
    [cxWebUtils.BoolToStr(WebDataSource.AllowSorting)]));
  HTMLTextBuilder.WriteText(Format('  _DataController.AllowExpanding = %s;',
    [cxWebUtils.BoolToStr(WebDataSource.AllowExpanding)]));
  HTMLTextBuilder.WriteText(Format('  _DataController.LoadAllRecords = %s;',
    [cxWebUtils.BoolToStr(IsLoadAllRecordsMode)]));
  WriteEvents;
  WriteData;
  WriteHandlers;
end;

class procedure TcxCustomWebDataSourceRenderer.WriteClassScripts(AHTMLTextBuilder: TcxHTMLTextBuilder);
begin
  AHTMLTextBuilder.WriteText(Format('var scxDeleteConfirmText = "%s";', [scxDeleteConfirmText]));
end;

{ TcxCustomWebDataSourceNS4Renderer }
class function TcxCustomWebDataSourceNS4Renderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserNS4;
end;

function TcxCustomWebDataSourceNS4Renderer.IsLoadAllRecordsMode: Boolean;
begin
  Result := False;
end;

{ TcxCustomWebDataSourceOperaRenderer }

class function TcxCustomWebDataSourceOperaRenderer.IsBrowserSupported(AWebBrowser: TcxWebBrowserClass): Boolean;
begin
  Result := AWebBrowser = TcxWebBrowserOpera;
end;

{ TcxStdDataLink }

procedure TcxWebDataLink.ActiveChanged;
begin
  if WebDataSource <> nil then
    WebDataSource.DataNotification(utLayout);
end;

procedure TcxWebDataLink.DataSetChanged;
begin
  if WebDataSource <> nil then
    WebDataSource.DataNotification(utData);
end;

{ TcxStdWebDataSource }

constructor TcxStdWebDataSource.Create(AOwner: TComponent);
begin
  inherited;
  Fields := TcxStdWebDataFields.Create(Self);
  FDataSource := TDataSource.Create(nil);
  FDataLink := TcxWebDataLink.Create;
  FDataLink.FWebDataSource := Self;
  FDataLink.DataSource := FDataSource;
end;

destructor TcxStdWebDataSource.Destroy;
begin
  FDataSource.Free;
  FDataLink.Free;
  if Fields <> nil then Fields.Clear;
  Fields.Free;
  inherited;
end;

procedure TcxStdWebDataSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if csDestroying in ComponentState then exit;
  if (Operation = opRemove) and (AComponent = DataSet) then
    DataSet := nil;
end;

function TcxStdWebDataSource.GetDataSet: TDataSet;
begin
  Result := DataSource.DataSet;
end;

type
  TDataSetAccess = class(TDataSet);

function TcxStdWebDataSource.CanEdit: Boolean;
begin
  Result := AllowEditing and (DataSource.DataSet <> nil) and
    DataSource.DataSet.Active and TDataSetAccess(DataSource.DataSet).CanModify;
end;

function TcxStdWebDataSource.GetItemField(AItemName: string): TField;
var
  AFieldName: string;
begin
  AFieldName := FieldByName(AItemName).Name;
  Result := DataSource.DataSet.FieldByName(AFieldName);
end;

function TcxStdWebDataSource.GetFields: TcxStdWebDataFields;
begin
  Result := inherited GetFields as TcxStdWebDataFields;
end;

procedure TcxStdWebDataSource.SetDataSet(Value: TDataSet);
begin
  if DataSource.DataSet <> Value then
  begin
    Fields.Clear;
    DataSource.DataSet := Value;
    if (Value <> nil) and Value.Active then
      DataNotification(utLayout);
  end;
end;

procedure TcxStdWebDataSource.SetFields(Value: TcxStdWebDataFields);
begin
  inherited SetFields(Value);
end;

{ values }
procedure TcxStdWebDataSource.DoSetValues;
begin
  BeginUpdate;
  try
    SynchronizeSelection;
    inherited DoSetValues;
  finally
    CancelUpdate;
  end;
end;

procedure TcxStdWebDataSource.RegisterValues;
begin
  inherited;
end;

{ actions }
procedure TcxStdWebDataSource.RegisterActions;
begin
  inherited;
  WebActionsHelper.RegisterAction(scxDeleteAction, WebDelete);
  WebActionsHelper.RegisterAction(scxStartEditAction, WebStartEdit);
  WebActionsHelper.RegisterAction(scxPostEditAction, WebPostEdit);
  WebActionsHelper.RegisterAction(scxCancelEditAction, WebCancelEdit);
  WebActionsHelper.RegisterAction(scxInsertAction, WebInsert);
  WebActionsHelper.RegisterAction(scxRefreshAction, WebRefresh);
  WebActionsHelper.RegisterAction(scxMoveToAction, WebMoveTo);
  WebActionsHelper.RegisterAction(scxMoveByAction, WebMoveBy);
end;

procedure TcxStdWebDataSource.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataSourceRenderer);
  WebRenderHelper.RegisterRenderer(TcxCustomWebDataSourceNS4Renderer);
end;

procedure TcxStdWebDataSource.SynchronizeSelection;
var
  RowIndex: Integer;
begin
  try
    RowIndex := StrToInt(WebValuesHelper.Values.Values[FullName + 'FocusedRow']);
  except
    on EConvertError do RowIndex := 0;
    else raise;
  end;
  if RowIndex < 0 then RowIndex := 0;
  if (DataSet <> nil) and (DataSet.Active) then
  begin
    if RowIndex >= DataSet.RecordCount then
      RowIndex := DataSet.RecordCount - 1;
    DataSet.MoveBy(RowIndex - DataSet.RecNo + 1);
  end;
end;

procedure TcxStdWebDataSource.DataNotification(AUpdateType: TcxUpdateType);
begin
  if csDestroying in ComponentState then exit;
  if AUpdateType = utLayout then
    UpdateDefaultFields;
  UpdateDataLayout;
end;

function TcxStdWebDataSource.NeedUpdateFields: Boolean;
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

procedure TcxStdWebDataSource.UpdateDefaultFields;
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
      if NeedUpdateFields then
      begin
        Fields.Clear;

        if DataSet.Fields.Count > 0 then
          for I := 0 to DataSet.FieldCount - 1 do
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
      end;
    end
    else Fields.Clear;
  finally
    CancelUpdate;
  end;
end;

procedure TcxStdWebDataSource.DeleteRecord(ARowIndex: Integer);
var
  Processed: Boolean;
begin
  if IsEditing then CancelEdit;
  if AllowEditing then
  begin
    BeginUpdate;
    try
      Processed := True;
      if Assigned(FOnDeleting) then
        FOnDeleting(self, ARowIndex, Processed);
      if Processed and CanEdit then
      begin
        DataSet.MoveBy(ARowIndex - DataSet.RecNo + 1);
        DataSet.Delete;
        if Assigned(FOnDeleted) then
          FOnDeleted(self, ARowIndex);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxStdWebDataSource.InsertRecord(ARowIndex: Integer);
var
  Processed: Boolean;
begin
  if IsEditing then CancelEdit;
  if AllowEditing then
  begin
    BeginUpdate;
    try
      Processed := True;
      if Assigned(FOnInserting) then
        FOnInserting(self, ARowIndex, Processed);
      if Processed and CanEdit then
      begin
        if not CheckRowIndex(ARowIndex) then
          DataSet.MoveBy(RowCount - DataSet.RecNo);
        StoreInsertingValues;
        IsInserting := True;
        IsEditing := True;
        if Assigned(FOnInserted) then
          FOnInserted(self, ARowIndex);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxStdWebDataSource.EditRecord(ARowIndex: Integer);
var
  Processed: Boolean;
begin
  if AllowEditing then
  begin
    BeginUpdate;
    try
      Processed := True;
      if Assigned(OnStartEdit) then
        OnStartEdit(Self, ARowIndex, Processed);
      if Processed and CanEdit then
      begin
        DataSet.MoveBy(ARowIndex - DataSet.RecNo + 1);
        IsEditing := True;
      end;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxStdWebDataSource.PostEdit(APriorControlName: string);
var
  Processed: Boolean;
  SavedIsInserting: Boolean;
begin
  if AllowEditing then
  begin
    BeginUpdate;
    try
      Processed := True;
      if Assigned(FOnBeforePost) then
        FOnBeforePost(self, FocusedRowIndex, Processed);
      if Processed and CanEdit then
      begin
        SavedIsInserting := IsInserting;
        if IsInserting then
        begin
          ChangedData(APriorControlName);
          DataSet.Insert;
          IsInserting := False;
          RestoreInsertingValues;
        end
        else 
        begin
          DataSet.Edit;
          ChangedData(APriorControlName);
        end;
        try
          DataSet.Post;
        except
          if SavedIsInserting then IsInserting := True;
          raise;
        end;
        IsEditing := False;
        if Assigned(FOnAfterPost) then
          FOnAfterPost(self, FocusedRowIndex);
      end;
    finally
      EndUpdate;
    end;
  end;
end;

function TcxStdWebDataSource.GetFocusedRowIndex: Integer;
begin
  if (DataSet = nil) or (not DataSet.Active) then
    Result := -1
  else
  begin
    Result := DataSet.RecNo - 1;
    if (DataSet.State = dsInsert) and (Result < 0) then Result := 0;
  end;
end;

function TcxStdWebDataSource.ItemHelperClass(AItemIndex: Integer): TcxDataFieldHelperClass;
var
  AField: TField;
begin
  Result := TcxDataFieldHelper;
  AField := DataSet.Fields.FieldByName(Fields[AItemIndex].FieldName);
  if AField <> nil then
  begin
    case AField.DataType of
      ftString, ftWideString:
        Result := TcxStringFieldHelper;
      ftSmallint, ftInteger,
      ftAutoInc, ftWord,
      ftLargeint:
        Result := TcxIntegerFieldHelper;
      ftBCD:
        if (AField as TBCDField).currency then
          Result := TcxCurrencyFieldHelper
        else
          Result := TcxIntegerFieldHelper;
      ftFMTBcd:
        if (AField as TFMTBCDField).currency then
          Result := TcxCurrencyFieldHelper
        else
          Result := TcxIntegerFieldHelper;
      ftCurrency, ftFloat:
        if (AField as TFloatField).currency then
          Result := TcxCurrencyFieldHelper
        else
          Result := TcxFloatFieldHelper;
      ftBoolean:
        Result := TcxBooleanFieldHelper;
      ftDate, ftTime, ftDateTime:
        Result := TcxDateTimeFieldHelper;
    else
      if AField is TBlobField then
      begin
        if (TBlobField(AField).BlobType = ftGraphic) or
          (TBlobField(AField).BlobType = ftTypedBinary) then
          Result := TcxImageFieldHelper
        else if TBlobField(AField).BlobType = ftMemo then
          Result := TcxMemoFieldHelper
        else Result := TcxBinaryFieldHelper;
      end;
    end;
  end;
end;

function TcxStdWebDataSource.GetValue(ARecordIndex, AItemIndex: Integer): Variant;
var
  FieldName: string;
  CurrentRecord: Integer;
begin
  if (DataSet = nil) or (not DataSet.Active) then
    Result := Null
  else if IsInserting and (DataSet.RecordCount = 0) then
    Result := Null
  else if IsInserting and (ARecordIndex = FocusedRowIndex) then
    Result := GetInsertingValue(AItemIndex)
  else
  begin
    if IsInserting and (ARecordIndex > FocusedRowIndex) then Dec(ARecordIndex);
    BeginUpdate;
    try
      CurrentRecord := DataSet.RecNo - 1;
      FieldName := Fields[AItemIndex].FieldName;
      if CurrentRecord <> ARecordIndex then
        DataSet.MoveBy(ARecordIndex - CurrentRecord);
      Result := DataSet.Fields.FieldByName(FieldName).AsVariant;
      if CurrentRecord <> ARecordIndex then
        DataSet.MoveBy(CurrentRecord - ARecordIndex);
    finally
      CancelUpdate;
    end;
  end;
end;

function TcxStdWebDataSource.GetDisplayText(ARecordIndex, AItemIndex: Integer): string;
var
  FieldName: string;
  CurrentRecord: Integer;
begin
  if (DataSet = nil) or (not DataSet.Active) then
    Result := ''
  else if IsInserting and (DataSet.RecordCount = 0) then
    Result := ''
  else if IsInserting and (ARecordIndex = FocusedRowIndex) then
    Result := VarToStr(GetInsertingValue(AItemIndex))
  else
  begin
    if IsInserting and (ARecordIndex > FocusedRowIndex) then Dec(ARecordIndex);
    BeginUpdate;
    try
      CurrentRecord := DataSet.RecNo - 1;
      FieldName := Fields[AItemIndex].FieldName;
      if CurrentRecord <> ARecordIndex then
        DataSet.MoveBy(ARecordIndex - CurrentRecord);
      Result := DataSet.Fields.FieldByName(FieldName).DisplayText;
      if CurrentRecord <> ARecordIndex then
        DataSet.MoveBy(CurrentRecord - ARecordIndex);
    finally
      CancelUpdate;
    end;
  end;
end;

function TcxStdWebDataSource.GetRecordCount: Integer;
begin
  if (DataSet = nil) or (not DataSet.Active) then
    Result := 0
  else
  begin
    Result := DataSet.RecordCount;
    if IsInserting then Inc(Result);
  end;
end;

procedure TcxStdWebDataSource.SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes);
var
  Field: TField;
  ACanSet: Boolean;
begin
  BeginUpdate;
  try
    DataSet.Edit;
    try
      Field := GetItemField(Fields[AItemIndex].Name);
      ACanSet := True;
      if Assigned(OnSetEditValue) then
        OnSetEditValue(Self, AItemIndex, FocusedRowIndex, AValue, ACanSet);
      if ACanSet and Fields[AItemIndex].ValidateValueType(AType) and Fields[AItemIndex].ValidateValue(AValue) then
        if IsInserting then
          SetInsertingValue(AItemIndex, AValue)
        else
          if dtValue in AType then
            Field.AsVariant := AValue
          else
            Field.AsString := AValue;
    except
      DataSet.Cancel;
      raise;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxStdWebDataSource.SetFocusedRowIndex(Value: Integer);
var
  Processed: Boolean;
begin
  if IsEditing then CancelEdit;
  Processed := True;
  if Assigned(OnScrolling) then
    OnScrolling(self, DataSet.RecNo, Processed);

  if Processed then
  begin
    if Value < 0 then Value := 0;
    if (DataSet <> nil) and (DataSet.Active) then
    begin
      if Value >= DataSet.RecordCount then Value := DataSet.RecordCount - 1;
      DataSet.MoveBy(Value - DataSet.RecNo + 1);
    end;

    if Assigned(OnScrolled) then
      OnScrolled(self, DataSet.RecNo);
  end;
end;

procedure TcxStdWebDataSource.SetValue(ARecordIndex, AItemIndex: Integer; const Value: Variant);
var
  FieldName: string;
  CurrentRecord: Integer;
begin
  if (DataSet <> nil) and (DataSet.Active) then
  begin
    CurrentRecord := DataSet.RecNo - 1;
    FieldName := Fields[AItemIndex].FieldName;
    DataSet.MoveBy(ARecordIndex - CurrentRecord);
    DataSet.Fields.FieldByName(FieldName).AsVariant := Value;
    DataSet.MoveBy(CurrentRecord - ARecordIndex);
  end;
end;

initialization
  RegisterClasses([TcxAbstractWebDataBinding, TcxCustomWebDataBinding,
      TcxCustomWebDataField, TcxStdWebDataField, TcxStdWebDataSource]);

end.


