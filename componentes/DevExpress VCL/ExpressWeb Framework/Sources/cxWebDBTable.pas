{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual Web Controls Library                                 }
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
unit cxWebDBTable;

interface

{$I cxVer.inc}

uses
  Classes, SysUtils, DB,
  cxWebIntf,  cxWebClasses, cxWebControls, cxWebTypes, cxWebRender, cxWebTable,
  cxWebData;

type
  TcxWebDBTableColumn = class;
  TcxWebDBTableColumns = class;
  TcxWebDBTable = class;

  TcxWebTableColumnDataBinding = class(TcxAbstractWebDataBinding)
  private
    FFieldName: string;
    FDBColumn: TcxWebDBTableColumn;

    function GetFieldIndex: Integer;
    procedure SetFieldName(Value: string);
  protected
    function GetDataSource: TcxCustomWebDataSource; override;
  public
    procedure Assign(Source: TPersistent); override;

    property DataSource: TcxCustomWebDataSource read GetDataSource;
    property FieldIndex: Integer read GetFieldIndex;
    property DBColumn: TcxWebDBTableColumn read FDBColumn;
  published
    property FieldName: string read FFieldName write SetFieldName;
  end;

  TcxWebDBTableColumn = class(TcxCustomWebTableColumn)
  private
    FDataBinding: TcxWebTableColumnDataBinding;

    procedure SetDataBinding(Value: TcxWebTableColumnDataBinding);
  protected
    function GetDisplayName: string; override;

    function DBTable: TcxWebDBTable;
    function DBColumns: TcxWebDBTableColumns;
    function FieldIndex: Integer;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    function DataSource: TcxCustomWebDataSource;
    function SortOrder: TcxWebDataSortOrder;
  published
    property Alignment;
    property DataBinding: TcxWebTableColumnDataBinding read FDataBinding write SetDataBinding;
    property Styles;
    property Title;
    property TitleAlignment;
    property ViewType;
    property Width;
    property WordWrap;
  end;

  TcxWebDBTableColumns = class(TcxCustomWebTableColumns)
  private
    function GetItem(Index: Integer): TcxWebDBTableColumn;
    procedure SetItem(Index: Integer; const Value: TcxWebDBTableColumn);
  protected
    function DBTable: TcxWebDBTable;
  public
    function Add: TcxWebDBTableColumn;
    property Items[Index: Integer]: TcxWebDBTableColumn read GetItem write SetItem; default;
  end;

  TcxWebTableDataBinding = class(TcxCustomWebDataBinding)
  protected
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource); override;
  end;

  TcxWebDBTableGetDisplayText = procedure(Sender: TObject;
        AColumn: TcxWebDBTableColumn; ARecIndex: Integer; var AText: String) of object;
  TcxWebDBTableGetDisplayTextEx = procedure(Sender: TObject;
        AColumn: TcxWebDBTableColumn; ARecIndex: Integer;
        const AKeyValue: string; var AText: String) of object;
  TcxWebDBTableGetValue = procedure(Sender: TObject;
        AColumn: TcxWebDBTableColumn; ARecIndex: Integer; var Value: Variant) of object;
  TcxWebDBTableGetURLValue = procedure(Sender: TObject;
        AColumn: TcxWebDBTableColumn; ARecIndex: Integer;
        const AKeyValue: string; AURL: TcxURL) of object;

  TcxWebTableCellClick = procedure(Sender: TObject; AColumn: TcxWebDBTableColumn;
        const AKeyValue: string) of object;

  TcxWebDBTable = class(TcxCustomWebTable, IcxWebDataSourceSupport)
  private
    FDataBinding: TcxWebTableDataBinding;
    FColumnsAutoGenerated: Boolean;
    FPageIndex: Integer;
    FOnCellClick: TcxWebTableCellClick;
    FOnGetDisplayText: TcxWebDBTableGetDisplayText;
    FOnGetDisplayTextEx: TcxWebDBTableGetDisplayTextEx;
    FOnGetValue: TcxWebDBTableGetValue;
    FOnGetHrefValue: TcxWebDBTableGetURLValue;

    procedure DoPagingSizeChanged(Sender: TObject);

    function GetColumns: TcxWebDBTableColumns;
    procedure SetColumns(const Value: TcxWebDBTableColumns);
    procedure SetDataBinding(Value: TcxWebTableDataBinding);
    procedure SetPageIndex(Index: Integer);

    function GetInternalFieldValue(ARecIndex, AFieldIndex: Integer): Variant;
    function GetInternalFieldDisplayText(ARecIndex, AFieldIndex: Integer): string;
    function GetInternalFieldIndex(AFieldName: string): Integer;
    function GetKeyValueByRecIndex(ARecIndex: Integer): string;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
    {CustomWebTable}
    function CreateColumns: TcxCustomWebTableColumns; override;
    function GetRecordCount: Integer; override;
    function GetDisplayText(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer): string; override;
    function GetValue(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer): Variant; override;
    procedure GetURL(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer; AURL: TcxURL); override;

    function GetPageIndex: Integer; override;
    function GetAllowSorting: Boolean; override;

    procedure DoColumnClick(AColumnIndex: Integer); override;
    procedure DoPagingClick(APageIndex: Integer); override;
    procedure DoRowClick(AColIndex: Integer; ARowValue: string); override;

    procedure DoBeforeRender; override;
    procedure DoAfterRender; override;

    { Data binding }
    function KeyFieldIndex: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DataSource: TcxCustomWebDataSource;
    function GetFieldValue(ARecIndex: Integer; AFieldName: string): Variant;
    function GetFieldDisplayText(ARecIndex: Integer; AFieldName: string): string;
  published
    property DataBinding: TcxWebTableDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport;
    property Columns: TcxWebDBTableColumns read GetColumns write SetColumns;
    property MaximumWidth;
    property Paging;
    property PageIndex: Integer read FPageIndex write SetPageIndex;

    property AlternatingItemsStyles;
    property HeaderStyles;
    property ItemsStyles;
    property PagingStyles;
    property PagingNumbersStyles;
    property SelectingPagingNumberStyles;
    property Styles;

    property PopupMenu;
    property PopupShowingType;

    property BorderColor;    
    property BorderWidth;
    property CellPadding;
    property CellSpacing;
    property ShowHeaders;
        
    property OnCellClick: TcxWebTableCellClick read FOnCellClick write FOnCellClick;
    property OnGetDisplayText: TcxWebDBTableGetDisplayText read FOnGetDisplayText write FOnGetDisplayText;
    property OnGetDisplayTextEx: TcxWebDBTableGetDisplayTextEx read FOnGetDisplayTextEx write FOnGetDisplayTextEx;
    property OnGetValue: TcxWebDBTableGetValue read FOnGetValue write FOnGetValue;
    property OnGetHrefValue: TcxWebDBTableGetURLValue read FOnGetHrefValue write FOnGetHrefValue;
    property OnGetTitleHTML;
    property OnGetBeforePagingHTML;
    property OnGetAfterPagingHTML;
    property OnGetPagingStatus;
    property OnLoadImage;
    property OnBeforeWriteRow;
    property OnEndWriteRow;
  end;

implementation

uses Variants,
  cxWebDataUtils;

{ TcxWebTableColumnDataBinding }

procedure TcxWebTableColumnDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxWebTableColumnDataBinding then
  begin
    FieldName := (Source as TcxWebTableColumnDataBinding).FieldName;
  end else inherited Assign(Source);
end;

function TcxWebTableColumnDataBinding.GetDataSource: TcxCustomWebDataSource;
begin
  Result := DBColumn.DataSource;
end;

function TcxWebTableColumnDataBinding.GetFieldIndex: Integer;
begin
  if (DBColumn <> nil ) and (DBColumn.DBTable <> nil) then
    Result := DBColumn.DBTable.GetInternalFieldIndex(FieldName)
  else Result := -1;
end;

procedure TcxWebTableColumnDataBinding.SetFieldName(Value: string);
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    if (DBColumn <> nil ) and (DBColumn.DBTable <> nil) then
      DBColumn.DBTable.UpdateDesignerContext;
  end;
end;



{ TcxWebDBTableColumn }

constructor TcxWebDBTableColumn.Create(Collection: TCollection);
begin
  inherited;
  FDataBinding := TcxWebTableColumnDataBinding.Create(DBTable);
  FDataBinding.FDBColumn := Self;
end;

destructor TcxWebDBTableColumn.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited Destroy;
end;

function TcxWebDBTableColumn.DataSource: TcxCustomWebDataSource;
begin
  Result := DBTable.DataSource
end;

function TcxWebDBTableColumn.SortOrder: TcxWebDataSortOrder;
begin
  if FieldIndex > -1 then
    Result := DataSource.GetItemSortOrder(FieldIndex)
  else Result := wsoNone;
end;

function TcxWebDBTableColumn.GetDisplayName: string;
begin
  if (DataBinding <> nil) and (DataBinding.FieldName <> '') then
    Result := DataBinding.FieldName + 'Column'
  else Result := inherited GetDisplayName;
end;

function TcxWebDBTableColumn.DBTable: TcxWebDBTable;
begin
  Result := DBColumns.DBTable;
end;

function TcxWebDBTableColumn.DBColumns: TcxWebDBTableColumns;
begin
  Result := Columns as TcxWebDBTableColumns;
end;

function TcxWebDBTableColumn.FieldIndex: Integer;
begin
  Result := DataBinding.FieldIndex;
end;

procedure TcxWebDBTableColumn.SetDataBinding(Value: TcxWebTableColumnDataBinding);
begin
  DataBinding.Assign(Value);
end;

{ TcxWebDBTableColumns }
function TcxWebDBTableColumns.DBTable: TcxWebDBTable;
begin
  Result := Table as TcxWebDBTable;
end;

function TcxWebDBTableColumns.Add: TcxWebDBTableColumn;
begin
  Result := TcxWebDBTableColumn(inherited Add);
end;


function TcxWebDBTableColumns.GetItem(Index: Integer): TcxWebDBTableColumn;
begin
  Result := TcxWebDBTableColumn(inherited Items[Index]);
end;

procedure TcxWebDBTableColumns.SetItem(Index: Integer; const Value: TcxWebDBTableColumn);
begin
  Items[Index].Assign(Value);
end;

{ TcxWebTableDataBinding }

procedure TcxWebTableDataBinding.ChangedDataLayout(Sender: TcxCustomWebDataSource);
var
  AWebControl: IcxWebControl;
begin
  if Supports(Component, IcxWebControl, AWebControl) and (AWebControl.DesignerControl <> nil) then
     AWebControl.DesignerControl.UpdateContext;
end;

{ TcxWebDBTable }

type
  TcxWebTablePagingAccess = class(TcxWebTablePaging);

constructor TcxWebDBTable.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TcxWebTablePagingAccess(Paging).PagingSizeChagned :=  DoPagingSizeChanged;
  FDataBinding := TcxWebTableDataBinding.Create(self);
end;

destructor TcxWebDBTable.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited Destroy;
end;

procedure TcxWebDBTable.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if FDataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

function TcxWebDBTable.CreateColumns: TcxCustomWebTableColumns;
begin
  Result := TcxWebDBTableColumns.Create(TcxWebDBTableColumn);
end;

function TcxWebDBTable.DataSource: TcxCustomWebDataSource;
begin
  Result := DataBinding.DataSource;
end;

function TcxWebDBTable.GetFieldValue(ARecIndex: Integer; AFieldName: string): Variant;
begin
  Result := GetInternalFieldValue(ARecIndex, GetInternalFieldIndex(AFieldName));
end;

function TcxWebDBTable.GetFieldDisplayText(ARecIndex: Integer; AFieldName: string): string;
begin
  Result := GetInternalFieldDisplayText(ARecIndex, GetInternalFieldIndex(AFieldName));
end;

procedure TcxWebDBTable.DoColumnClick(AColumnIndex: Integer);
var
  AFieldIndex: Integer;
  AOldSortOrder: TcxWebDataSortOrder;
begin
  if (DataSource <> nil) and (AColumnIndex > -1) then
  begin
    AFieldIndex := -1;

    if (AColumnIndex < Columns.Count) then
      AFieldIndex := Columns[AColumnIndex].FieldIndex
    else
      if (AColumnIndex < DataSource.Fields.Count) then
        AFieldIndex := AColumnIndex;
    if AFieldIndex > -1 then
    begin
      AOldSortOrder := DataSource.GetItemSortOrder(AFieldIndex);
      DataSource.ClearSorting;
      if AOldSortOrder in [wsoNone, wsoDescending] then
        DataSource.Sort(AFieldIndex, wsoAscending)
      else DataSource.Sort(AFieldIndex, wsoDescending);
    end;
  end;
end;

procedure TcxWebDBTable.DoPagingClick(APageIndex: Integer);
begin
  PageIndex := APageIndex;
end;

procedure TcxWebDBTable.DoRowClick(AColIndex: Integer; ARowValue: string);
var
  AColumn: TcxWebDBTableColumn;
begin
  if Assigned(OnCellClick) then
  begin
    if (AColIndex > -1) and (AColIndex < Columns.Count) then
      AColumn := Columns[AColIndex]
    else AColumn := nil;
    onCellClick(self, AColumn, ARowValue);
  end;
end;

procedure TcxWebDBTable.DoBeforeRender;
var
  I: Integer;
  AField: TcxCustomWebDataField;
begin
  inherited DoBeforeRender;
  if (Columns.Count > 0) or (DataSource = nil) or
  (csLoading in ComponentState) then exit;
  try
    BeginUpdateDesignerContext;
    for I := 0 to DataSource.Fields.Count - 1 do
    begin
      AField := TcxCustomWebDataField(DataSource.Fields.Items[I]);
      with Columns.Add do
      begin
        DataBinding.FieldName := AField.Name;
        Title := AField.DisplayLabel;
      end;
    end;
    CancelUpdateDesignerContext;
  finally
    FColumnsAutoGenerated := True;
  end;
end;

procedure TcxWebDBTable.DoAfterRender;
begin
  if FColumnsAutoGenerated then
  begin
    try
      BeginUpdateDesignerContext;
      Columns.Clear;
      CancelUpdateDesignerContext;
    finally
      FColumnsAutoGenerated := False;
    end;
  end;
  inherited DoAfterRender;  
end;

function TcxWebDBTable.KeyFieldIndex: Integer;
var
  AField: TcxCustomWebDataField;
begin
  Result := -1;
  if DataSource <> nil then
  begin
    AField := DataSource.FieldByName(DataSource.KeyFieldName);
    if AField <> nil then
      Result := AField.Index
  end;
end;

function TcxWebDBTable.GetRecordCount: Integer;
begin
  if DataSource <> nil then
    Result := DataSource.RecordCount
  else Result := 0;
end;

function TcxWebDBTable.GetInternalFieldValue(ARecIndex, AFieldIndex: Integer): Variant;
begin
  if AFieldIndex < 0 then
    Result := Null
  else
  begin
    if DataSource.GetGroupingItemCount = 0 then
      Result := DataSource.GetRowValue(ARecIndex, AFieldIndex)
    else Result := DataSource.Values[ARecIndex, AFieldIndex];
  end;
end;

function TcxWebDBTable.GetInternalFieldDisplayText(ARecIndex, AFieldIndex: Integer): string;
begin
  if AFieldIndex < 0 then
    Result := ''
  else
  begin
    if DataSource.GetGroupingItemCount = 0 then
      Result := DataSource.GetRowDisplayText(ARecIndex, AFieldIndex)
    else Result := DataSource.DisplayTexts[ARecIndex, AFieldIndex];
  end;
end;

function TcxWebDBTable.GetInternalFieldIndex(AFieldName: string): Integer;
var
  AField: TcxCustomWebDataField;
begin
  Result := -1;
  if DataSource <> nil then
  begin
    AField := DataSource.FieldByName(AFieldName);
    if AField <> nil then
      Result := AField.Index
  end;
end;

function TcxWebDBTable.GetKeyValueByRecIndex(ARecIndex: Integer): string;
var
  V: Variant;
begin
  if KeyFieldIndex < 0 then
    Result := IntToStr(ARecIndex)
  else
  begin
    if DataSource.GetGroupingItemCount = 0 then
      V := DataSource.GetRowValue(ARecIndex, KeyFieldIndex)
    else V := DataSource.Values[ARecIndex, KeyFieldIndex];
    Result := HTMLValue(V);
  end;
end;

function TcxWebDBTable.GetDisplayText(AColumn: TcxCustomWebTableColumn;
  ARecIndex: Integer): string;
begin
  Result := GetInternalFieldDisplayText(ARecIndex, TcxWebDBTableColumn(AColumn).FieldIndex);
  if Assigned(OnGetDisplayText) then
     OnGetDisplayText(self, AColumn as TcxWebDBTableColumn, ARecIndex, Result);
  if Assigned(OnGetDisplayTextEx) then
   OnGetDisplayTextEx(self, AColumn as TcxWebDBTableColumn, ARecIndex,
     GetKeyValueByRecIndex(ARecIndex), Result);
end;

function TcxWebDBTable.GetValue(AColumn: TcxCustomWebTableColumn;
  ARecIndex: Integer): Variant;
begin
  Result := GetInternalFieldValue(ARecIndex, TcxWebDBTableColumn(AColumn).FieldIndex);
  if Assigned(OnGetValue) then
    OnGetValue(self, AColumn as TcxWebDBTableColumn, ARecIndex, Result);
end;

procedure TcxWebDBTable.GetURL(AColumn: TcxCustomWebTableColumn; ARecIndex: Integer; AURL: TcxURL);
var
  KeyValue: string;
begin
  KeyValue := GetKeyValueByRecIndex(ARecIndex);
  AURL.Href := Format('javascript:__doPostBack(''%s'', ''ROWCLICK:%d:%s'')',
                [Name, AColumn.Index, KeyValue]);
  if Assigned(OnGetHrefValue) then
    OnGetHrefValue(self, AColumn as TcxWebDBTableColumn, ARecIndex, KeyValue, AURL);
end;


function TcxWebDBTable.GetPageIndex: Integer;
begin
  Result := PageIndex;
end;

function TcxWebDBTable.GetAllowSorting: Boolean; 
begin
  if DataSource <> nil then
    Result := DataSource.AllowSorting and (DataSource.GetGroupingItemCount = 0)
  else Result := False;
end;

procedure TcxWebDBTable.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if DataSource <> nil then
    AList.Add(DataSource);
end;


function TcxWebDBTable.GetColumns: TcxWebDBTableColumns;
begin
  Result := TcxWebDBTableColumns(inherited Columns);
end;

procedure TcxWebDBTable.SetColumns(const Value: TcxWebDBTableColumns);
begin
  Columns.Assign(Value);
end;

procedure TcxWebDBTable.SetDataBinding(Value: TcxWebTableDataBinding);
begin
  DataBinding.Assign(Value);
end;

procedure TcxWebDBTable.SetPageIndex(Index: Integer);
begin
  if not (csLoading in ComponentState) and ((Index < 0) or (Index * Paging.PagingSize > GetRecordCount)) then
    exit;
  FPageIndex := Index;
end;

procedure TcxWebDBTable.DoPagingSizeChanged(Sender: TObject);
begin
  PageIndex := 0;
end;

initialization
  RegisterClasses([TcxWebDBTableColumn, TcxWebDBTable]);

end.
