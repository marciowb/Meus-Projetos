{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Visual data aware Web Controls                              }
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
unit cxWebDBGrid;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, DB, DBConsts,
  cxWebRender, cxWebClasses, cxWebControls, cxWebStdCtrls, cxWebData,
  cxWebCalendar, cxWebDateEdit, cxWebGrids, cxWebDataNavigator;

type
  TcxWebDBColumn = class;
  TcxWebDBGrid = class;

  TcxWebGridColumnDataBinding = class(TcxAbstractWebDataBinding)
  private
    FFieldName: string;
    FKeyFieldName: string;
    FListFieldName: string;
    FListSource: TcxCustomWebDataSource;

    function GetFieldName: string;
    function GetWebDBColumn: TcxWebDBColumn;
    procedure SetFieldName(Value: string);
    procedure SetKeyFieldName(Value: string);
    procedure SetListFieldName(Value: string);
    procedure SetListSource(Value: TcxCustomWebDataSource);
  protected
    function GetDataSource: TcxCustomWebDataSource; override;
    { IcxWebDataSourceSupport }
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource); virtual;
    procedure UpdateData(Sender: TcxCustomWebDataSource); virtual;
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function FieldIndex: Integer;
    function KeyFieldIndex: Integer;
    function ListFieldIndex: Integer;

    property DataSource: TcxCustomWebDataSource read GetDataSource;
    property WebDBColumn: TcxWebDBColumn read GetWebDBColumn;
  published
    property FieldName: string read GetFieldName write SetFieldName;
    property KeyFieldName: string read FKeyFieldName write SetKeyFieldName;
    property ListFieldName: string read FListFieldName write SetListFieldName;
    property ListSource: TcxCustomWebDataSource read FListSource write SetListSource;
  end;

  TcxWebLookupColumnHelper = class(TcxWebListColumnHelper)
  protected
    procedure WriteCellText(HTMLTextBuilder: TcxHTMLTextBuilder; ARowIndex: Integer;
        AText: string); override;
    procedure WriteScriptValues(HTMLTextBuilder: TcxHTMLTextBuilder); override;
    procedure WriteValues(HTMLTextBuilder: TcxHTMLTextBuilder; AText: string); override;
  public
    function WebDBColumn: TcxWebDBColumn;
  end;

  TcxWebDBColumn = class(TcxWebColumn, IcxWebUpdateDataSupport)
  private
    FDataBinding: TcxWebGridColumnDataBinding;

    function GetDataSource: TcxCustomWebDataSource;
    procedure SetDataBinding(Value: TcxWebGridColumnDataBinding);
  protected
    { IcxWebUpdateDataSupport }
    function CanGetData: Boolean;
    function GetData: Variant;
    function GetDataTypes: TcxWebDataTypes;

    function GetFieldHelperClass: TcxDataFieldHelperClass; virtual;
    function GetColumnHelper: TcxWebColumnHelper; override;
    function GetFieldIndex: Integer; override;
    function GetWebGrid: TcxWebDBGrid; reintroduce; overload;
    procedure SetWebGrid(Value: TcxWebDBGrid); reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property DataSource: TcxCustomWebDataSource read GetDataSource;
    property WebGrid: TcxWebDBGrid read GetWebGrid write SetWebGrid;
  published
    property DataBinding: TcxWebGridColumnDataBinding read FDataBinding write SetDataBinding;
  end;

  TcxWebGridDataBinding = class(TcxCustomWebDataBinding)
  private
    function GetWebDBGrid: TcxWebDBGrid;
  protected
    { IcxWebViewDataSupport }
    function GetFirstVisibleRow: Integer; override;
    function GetPageSize: Integer; override;
    procedure SetData(Value: Variant; DisplayText: string);
    { IcxWebDBData }
    procedure ChangedDataLayout(Sender: TcxCustomWebDataSource); override;
    procedure UpdateData(Sender: TcxCustomWebDataSource); override;

    procedure SetDataSource(Value: TcxCustomWebDataSource); override;
  public
    property WebDBGrid: TcxWebDBGrid read GetWebDBGrid;
  end;

  TcxWebDBGrid = class(TcxCustomWebGrid, IcxWebDataSourceSupport, IcxWebViewDataSupport)
  private
    FDataBinding: TcxWebGridDataBinding;
    procedure SetDataBinding(Value: TcxWebGridDataBinding);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { IcxWebProvidersSupport }
    procedure ImplGetProviders(AList: TList); override;
    { Scripts }
    procedure ScriptsSubscription; override;
    { renderers }
    procedure RegisterRenderers; override;
    { Datasource }
    function GetDataSource: TcxCustomWebDataSource; virtual;
    { Columns }
    function GetColumn(Index: Integer): TcxWebDBColumn; reintroduce; overload;
    procedure SetColumn(Index: Integer; Value: TcxWebDBColumn); reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Columsn }
    function Add: TcxWebColumn; override;
    function ColumnByName(const AName: string): TcxWebDBColumn; reintroduce; overload;
    function CanCreateDefaultColumns: Boolean; override;
    procedure CreateDefaultColumns(ADeleteExistColumns: Boolean); override;
    { Data }
    function Mode: TcxWebGridMode; override;
    function AllowExpanding: Boolean; override;
    function AllowGrouping: Boolean; override;
    function AllowSorting: Boolean; override;
    function LoadAllRecords: Boolean; override;

    function GetFocusedRow: Integer; override;
    function GetRecordCount: Integer; override;
    function GetRowCount: Integer; override;
    function GetDisplayText(ARecordIndex, AColIndex: Integer): string; override;
    function GetValue(ARecordIndex, AColIndex: Integer): Variant; override;
    function GetRowDisplayText(ARowIndex, AColIndex: Integer): string; override;
    function GetRowValue(ARowIndex, AColIndex: Integer): Variant; override;
    function GetRowExpanded(RowIndex: Integer): Boolean; override;
    function GetRowLevel(RowIndex: Integer): Integer; override;
    function GetRowRecord(RowIndex: Integer): Integer; override;
    function GetGroupingItemCount: Integer; override;
    function GetSortingItemCount: Integer; override;
    function GetItemGroupIndex(AColIndex: Integer): Integer; override;
    function GetItemSortOrder(AColIndex: Integer): TcxWebGridSortMode; override;
    function GetSortingItemIndex(Item: Integer): Integer; override;
    function GetGroupingItemIndex(Item: Integer): Integer; override;

    property Columns[Index: Integer]: TcxWebDBColumn read GetColumn write SetColumn;
    property DataSource: TcxCustomWebDataSource read GetDataSource;
  published
    property DataBinding: TcxWebGridDataBinding read FDataBinding write SetDataBinding
        implements IcxWebDataSourceSupport, IcxWebViewDataSupport;
  end;

  TcxWebDBGridRenderer = class(TcxCustomWebGridRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBGridNS4Renderer = class(TcxCustomWebGridNS4Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBGridNS6Renderer = class(TcxCustomWebGridNS6Renderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

  TcxWebDBGridOperaRenderer = class(TcxCustomWebGridOperaRenderer)
  public
    procedure WriteScripts; override;
    class procedure GetScriptFiles(AList: TStrings); override;
  end;

implementation

uses Variants,
  {$IFDEF VCL}
  Graphics,
  {$ENDIF}
  cxWebConsts, cxWebIntf, cxWebScriptFactory, cxWebDataUtils, cxWebFileCacheManager;


{ TcxWebGridColumnDataBinding }

destructor TcxWebGridColumnDataBinding.Destroy;
begin
  ListSource := nil;
  inherited;
end;

function TcxWebGridColumnDataBinding.FieldIndex: Integer;
var
  AField: TcxCustomWebDataField;
begin
  Result := -1;
  if DataSource <> nil then
  begin
    AField := DataSource.FieldByName(FFieldName);
    if AField <> nil then
      Result := AField.Index
  end;
end;

function TcxWebGridColumnDataBinding.KeyFieldIndex: Integer;
var
  AField: TcxCustomWebDataField;
begin
  Result := -1;
  if ListSource <> nil then
  begin
    AField := ListSource.FieldByName(FKeyFieldName);
    if AField <> nil then
      Result := AField.Index
  end;
end;

function TcxWebGridColumnDataBinding.ListFieldIndex: Integer;
var
  AField: TcxCustomWebDataField;
begin
  Result := -1;
  if ListSource <> nil then
  begin
    AField := ListSource.FieldByName(FListFieldName);
    if AField <> nil then
      Result := AField.Index
  end;
end;

function TcxWebGridColumnDataBinding.GetFieldName: string;
begin
  Result := FFieldName;
end;

function TcxWebGridColumnDataBinding.GetWebDBColumn: TcxWebDBColumn;
begin
  Result := Component as TcxWebDBColumn;
end;

procedure TcxWebGridColumnDataBinding.SetFieldName(Value: string);
var
  AWebGrid: TcxWebDBGrid;
begin
  if FFieldName <> Value then
  begin
    FFieldName := Value;
    WebDBColumn.ColumnHelper := nil;
    AWebGrid := WebDBColumn.WebGrid;
    AWebGrid.UpdateDesignerContext;
  end;
end;

procedure TcxWebGridColumnDataBinding.SetKeyFieldName(Value: string);
begin
  if FKeyFieldName <> Value then
  begin
    FKeyFieldName := Value;
    ChangedDataLayout(ListSource);
  end;
end;

procedure TcxWebGridColumnDataBinding.SetListFieldName(Value: string);
begin
  if FListFieldName <> Value then
  begin
    FListFieldName := Value;
    ChangedDataLayout(ListSource);
  end;
end;

procedure TcxWebGridColumnDataBinding.SetListSource(Value: TcxCustomWebDataSource);
begin
  if FListSource <> Value then
  begin
    if (DataSource <> nil) and (DataSource = Value) then
      DatabaseError(SCircularDataLink);
    if (FListSource <> nil) and not (csDestroying in FListSource.ComponentState) then
    begin
      FListSource.UnRegisterClient(Component);
      FListSource.RemoveFreeNotification(Component);
    end;
    FListSource := Value;
    if FListSource <> nil then
    begin
      FListSource.FreeNotification(Component);
      FListSource.RegisterClient(Component);
    end;
    ChangedDataLayout(FListSource);
  end;
end;

function TcxWebGridColumnDataBinding.GetDataSource: TcxCustomWebDataSource;
begin
  Result := WebDBColumn.WebGrid.DataSource;
end;

procedure TcxWebGridColumnDataBinding.ChangedDataLayout(Sender: TcxCustomWebDataSource);
begin
end;

procedure TcxWebGridColumnDataBinding.UpdateData(Sender: TcxCustomWebDataSource);
var
  DataIntf: IcxWebUpdateDataSupport;
begin
  if FieldIndex > -1 then
    if Supports(WebDBColumn, IcxWebUpdateDataSupport, DataIntf) and DataIntf.CanGetData then
      DataSource.SetEditValue(FieldIndex, DataIntf.GetData, DataIntf.GetDataTypes);
end;

procedure TcxWebGridColumnDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxWebGridColumnDataBinding then
    FieldName := TcxWebGridColumnDataBinding(Source).FieldName
  else inherited;
end;

{ TcxWebLookupColumnHelper }

function TcxWebLookupColumnHelper.WebDBColumn: TcxWebDBColumn;
begin
  Result := Column as TcxWebDBColumn;
end;

procedure TcxWebLookupColumnHelper.WriteCellText(HTMLTextBuilder: TcxHTMLTextBuilder;
    ARowIndex: Integer; AText: string);
var
  I: Integer;
begin
    if (WebDBColumn.DataBinding.ListFieldIndex > -1) and
      (WebDBColumn.DataBinding.KeyFieldIndex > -1) then
    begin
      for I := 0 to WebDBColumn.DataBinding.ListSource.RecordCount - 1 do
        if AText = WebDBColumn.DataBinding.ListSource.DisplayTexts[I, WebDBColumn.DataBinding.KeyFieldIndex] then
        begin
          inherited WriteCellText(HTMLTextBuilder, ARowIndex,
             WebDBColumn.DataBinding.ListSource.DisplayTexts[I, WebDBColumn.DataBinding.ListFieldIndex]);
          break;
        end;
    end;
end;

procedure TcxWebLookupColumnHelper.WriteScriptValues(HTMLTextBuilder: TcxHTMLTextBuilder);
var
  I: Integer;
begin
  if (WebDBColumn.DataBinding.ListFieldIndex > -1) and
    (WebDBColumn.DataBinding.KeyFieldIndex > -1) then
    for I := 0 to WebDBColumn.DataBinding.ListSource.RecordCount - 1 do
    begin
      HTMLTextBuilder.WriteText(Format('    _Column.AddPossibleValue("%s", "%s");',
          [WebDBColumn.DataBinding.ListSource.DisplayTexts[I, WebDBColumn.DataBinding.ListFieldIndex],
          WebDBColumn.DataBinding.ListSource.DisplayTexts[I, WebDBColumn.DataBinding.KeyFieldIndex]]));
    end;
end;

procedure TcxWebLookupColumnHelper.WriteValues(HTMLTextBuilder: TcxHTMLTextBuilder; AText: string);
var
  I: Integer;
begin
  if (WebDBColumn.DataBinding.ListFieldIndex > -1) and
    (WebDBColumn.DataBinding.KeyFieldIndex > -1) then
    for I := 0 to WebDBColumn.DataBinding.ListSource.RecordCount - 1 do
    begin
      HTMLTextBuilder.WriteBeginTag(TcxHTMLTagOption, True, False);
      HTMLTextBuilder.WriteAttribute(aValue, WebDBColumn.DataBinding.ListSource.DisplayTexts[I, WebDBColumn.DataBinding.KeyFieldIndex]);
      if AText = WebDBColumn.DataBinding.ListSource.DisplayTexts[I, WebDBColumn.DataBinding.KeyFieldIndex] then
        HTMLTextBuilder.WriteAttribute(aSelected);
      HTMLTextBuilder.WriteText(WebDBColumn.DataBinding.ListSource.DisplayTexts[I, WebDBColumn.DataBinding.ListFieldIndex], False, False);
      HTMLTextBuilder.WriteEndTag(TcxHTMLTagOption, False, True);
    end;
end;

{ TcxWebDBColumn }

constructor TcxWebDBColumn.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebGridColumnDataBinding.Create(Self);
end;

destructor TcxWebDBColumn.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

{ IcxWebUpdateDataSupport }
function TcxWebDBColumn.CanGetData: Boolean;
begin
  Result := not ReadOnly and Visible and (EditValue <> Null) and WebGrid.EditMode;
end;

function TcxWebDBColumn.GetData: Variant;
begin
  Result := EditValue;
end;

function TcxWebDBColumn.GetDataTypes: TcxWebDataTypes;
begin
  Result := [dtText];
end;

function TcxWebDBColumn.GetFieldHelperClass: TcxDataFieldHelperClass;
begin
  Result := TcxDataFieldHelper;
  if FieldIndex <> -1 then
    Result := DataSource.ItemHelperClass(FieldIndex);
end;

function TcxWebDBColumn.GetColumnHelper: TcxWebColumnHelper;
var
  AFieldHelperClass: TcxDataFieldHelperClass;
begin
  Result := inherited GetColumnHelper;
  if FieldIndex <> -1 then
  begin
    AFieldHelperClass := GetFieldHelperClass;
    if ViewType = cvtLookup
      then Result := CreateColumnHelper(TcxWebLookupColumnHelper);
    case ViewType of
      cvtText, cvtHyperText,
      cvtList, cvtCheck, cvtLookup:
        if (AFieldHelperClass = TcxImageFieldHelper) or (AFieldHelperClass = TcxMemoFieldHelper) then
          Result := CreateColumnHelper(TcxWebColumnHelper);
      cvtImage:
        if AFieldHelperClass <> TcxImageFieldHelper then
          Result := CreateColumnHelper(TcxWebColumnHelper);
    end;
  end;  
end;

function TcxWebDBColumn.GetFieldIndex: Integer;
begin
  Result := DataBinding.FieldIndex;
end;

function TcxWebDBColumn.GetWebGrid: TcxWebDBGrid;
begin
  Result := (inherited GetWebGrid) as TcxWebDBGrid;
end;

function TcxWebDBColumn.GetDataSource: TcxCustomWebDataSource;
begin
  Result := DataBinding.DataSource;
end;

procedure TcxWebDBColumn.SetWebGrid(Value: TcxWebDBGrid);
begin
  inherited SetWebGrid(Value);
end;

procedure TcxWebDBColumn.SetDataBinding(Value: TcxWebGridColumnDataBinding);
begin
  DataBinding.Assign(Value);
end;

{ TcxWebGridDataBinding }

function TcxWebGridDataBinding.GetWebDBGrid: TcxWebDBGrid;
begin
  Result := Component as TcxWebDBGrid;
end;

function TcxWebGridDataBinding.GetFirstVisibleRow: Integer;
begin
  Result := WebDBGrid.FirstVisibleRow;
end;

function TcxWebGridDataBinding.GetPageSize: Integer;
begin
  Result := WebDBGrid.PageSize;
end;

procedure TcxWebGridDataBinding.SetData(Value: Variant; DisplayText: string);
begin
// Do nothing
end;

procedure TcxWebGridDataBinding.ChangedDataLayout(Sender: TcxCustomWebDataSource);
begin
  WebDBGrid.BeginUpdateDesignerContext;
  try
    if WebDBGrid.FocusedRow >= 0 then
    begin
      if (WebDBGrid.FocusedRow < WebDBGrid.FirstVisibleRow) or
         (WebDBGrid.FocusedRow >= WebDBGrid.FirstVisibleRow + WebDBGrid.PageSize) then
      begin
        if WebDBGrid.FocusedRow > WebDBGrid.FirstVisibleRow then
          WebDBGrid.FirstVisibleRow := WebDBGrid.FocusedRow - WebDBGrid.PageSize + 1
        else
          WebDBGrid.FirstVisibleRow := WebDBGrid.FocusedRow;
      end;
      if WebDBGrid.FirstVisibleRow > WebDBGrid.RowCount - WebDBGrid.PageSize then
        WebDBGrid.FirstVisibleRow := WebDBGrid.RowCount - WebDBGrid.PageSize;
      if WebDBGrid.FirstVisibleRow < 0 then WebDBGrid.FirstVisibleRow := 0;
    end;
    WebDBGrid.RefreshHeight;
    WebDBGrid.UpdateColumnsLayout;
  finally
    WebDBGrid.EndUpdateDesignerContext;
  end;
end;

type
  TcxCustomWebDataSourceAccess = class(TcxCustomWebDataSource);

procedure TcxWebGridDataBinding.UpdateData(Sender: TcxCustomWebDataSource);
var
  I: Integer;
begin
  if (DataSource <> nil) and not WebDBGrid.ReadOnly then
  begin
    if DataSource.CheckRowIndex(DataSource.FocusedRowIndex) then
    begin
      for I := 0 to WebDBGrid.ColumnCount - 1 do
        WebDBGrid.Columns[I].DataBinding.UpdateData(Sender);
    end;
  end;
end;

procedure TcxWebGridDataBinding.SetDataSource(Value: TcxCustomWebDataSource);
var
  I: Integer;
begin
  for I := 0 to WebDBGrid.ColumnCount - 1 do
    if (WebDBGrid.Columns[I].DataBinding.ListSource <> nil) and
      (WebDBGrid.Columns[I].DataBinding.ListSource = Value) then
      DatabaseError(SCircularDataLink);
  inherited SetDataSource(Value);
end;

{ TcxWebDBGrid }

constructor TcxWebDBGrid.Create(AOwner: TComponent);
begin
  inherited;
  FDataBinding := TcxWebGridDataBinding.Create(Self);
end;

destructor TcxWebDBGrid.Destroy;
begin
  FreeAndNil(FDataBinding);
  inherited;
end;

function TcxWebDBGrid.Add: TcxWebColumn;
begin
  BeginUpdateDesignerContext;
  Result := TcxWebDBColumn.Create(Owner);
  Result.WebGrid := Self;
  Result.Name := UniqueColumnName(Result);

  UpdateColumnsLayout;
  RefreshPageSize;
  EndUpdateDesignerContext;
  DesignerModified;
end;

function TcxWebDBGrid.ColumnByName(const AName: string): TcxWebDBColumn;
begin
  Result := inherited ColumnByName(AName) as TcxWebDBColumn;
end;

function TcxWebDBGrid.CanCreateDefaultColumns: Boolean;
begin
  Result := DataSource <> nil;
end;

procedure TcxWebDBGrid.CreateDefaultColumns(ADeleteExistColumns: Boolean);
var
  I, AColumnCount: Integer;
  AField: TcxCustomWebDataField;
begin
  if DataSource = nil then exit;

  BeginUpdateDesignerContext;
  BeginUpdateLayout;
  try
    if ADeleteExistColumns then Clear;

    AColumnCount := ColumnCount;
    TcxCustomWebDataSourceAccess(DataSource).UpdateDefaultFields;
    for I := 0 to DataSource.Fields.Count - 1 do
    begin
      AField := DataSource.Fields[I];
      with Add as TcxWebDBColumn do
      begin
        DataBinding.FieldName := AField.Name;
        Title := AField.DisplayLabel;
        Width := (WebGrid.Width - WebGrid.IndicatorWidth) div (DataSource.Fields.Count + AColumnCount);
      end;
    end;
  finally
    EndUpdateLayout;
    UpdateColumnsLayout;
    EndUpdateDesignerContext;
    DesignerModified;
  end;
end;

function TcxWebDBGrid.GetFocusedRow: Integer;
begin
  if DataSource <> nil then
    Result := DataSource.FocusedRowIndex
  else Result := 0;
end;

function TcxWebDBGrid.GetRecordCount: Integer;
begin
  if DataSource <> nil then
    Result := DataSource.RecordCount
  else Result := 0;
end;

function TcxWebDBGrid.GetRowCount: Integer;
begin
  if DataSource <> nil then
    Result := DataSource.RowCount
  else Result := 0;
end;

function TcxWebDBGrid.GetValue(ARecordIndex, AColIndex: Integer): Variant;
var
  AFieldIndex: Integer;
begin
  if DataSource <> nil then
  begin
    AFieldIndex := Columns[AColIndex].DataBinding.FieldIndex;
    if AFieldIndex <> -1 then
      Result := DataSource.Values[ARecordIndex, AFieldIndex]
    else Result := '';
  end
  else Result := '';
end;

function TcxWebDBGrid.GetDisplayText(ARecordIndex, AColIndex: Integer): string;
var
  AFieldIndex: Integer;
begin
  if DataSource <> nil then
  begin
    AFieldIndex := Columns[AColIndex].DataBinding.FieldIndex;
    if AFieldIndex <> -1 then
      Result := DataSource.DisplayTexts[ARecordIndex, AFieldIndex]
    else Result := Null;
  end
  else Result := Null;
end;

function TcxWebDBGrid.GetRowDisplayText(ARowIndex, AColIndex: Integer): string;
var
  AFieldIndex: Integer;
begin
  if DataSource <> nil then
  begin
    AFieldIndex := Columns[AColIndex].DataBinding.FieldIndex;
    if AFieldIndex <> -1 then
      Result := DataSource.GetRowDisplayText(ARowIndex, AFieldIndex)
    else Result := '';
  end
  else Result := '';
end;

function TcxWebDBGrid.GetRowValue(ARowIndex, AColIndex: Integer): Variant;
var
  AFieldIndex: Integer;
begin
  if DataSource <> nil then
  begin
    AFieldIndex := Columns[AColIndex].DataBinding.FieldIndex;
    if AFieldIndex <> -1 then
      Result := DataSource.GetRowValue(ARowIndex, AFieldIndex)
    else Result := Null;
  end
  else Result := Null;
end;

function TcxWebDBGrid.GetRowExpanded(RowIndex: Integer): Boolean;
begin
  if DataSource <> nil then
    Result := DataSource.GetRowExpanded(RowIndex)
  else Result := False;
end;

function TcxWebDBGrid.GetRowLevel(RowIndex: Integer): Integer;
begin
  if DataSource <> nil then
    Result := DataSource.GetRowLevel(RowIndex)
  else Result := 0;
end;

function TcxWebDBGrid.GetRowRecord(RowIndex: Integer): Integer;
begin
  if DataSource <> nil then
    Result := DataSource.GetRowRecord(RowIndex)
  else Result := 0;
end;

function TcxWebDBGrid.GetGroupingItemCount: Integer;
begin
  if DataSource <> nil then
    Result := DataSource.GetGroupingItemCount
  else Result := 0;
end;

function TcxWebDBGrid.GetSortingItemCount: Integer;
begin
  if DataSource <> nil then
    Result := DataSource.GetSortingItemCount
  else Result := 0;
end;

function TcxWebDBGrid.GetItemGroupIndex(AColIndex: Integer): Integer;
var
  AFieldIndex: Integer;
begin
  if DataSource <> nil then
  begin
    AFieldIndex := Columns[AColIndex].DataBinding.FieldIndex;
    if AFieldIndex <> -1 then
      Result := DataSource.GetItemGroupIndex(AFieldIndex)
    else Result := -1;
  end
  else Result := -1;
end;

function TcxWebDBGrid.GetItemSortOrder(AColIndex: Integer): TcxWebGridSortMode;
var
  AFieldIndex: Integer;
begin
  if DataSource <> nil then
  begin
    AFieldIndex := Columns[AColIndex].DataBinding.FieldIndex;
    if AFieldIndex <> -1 then
      Result := TcxWebGridSortMode(DataSource.GetItemSortOrder(AFieldIndex))
    else Result := smNone;
  end
  else Result := smNone;
end;

function TcxWebDBGrid.GetSortingItemIndex(Item: Integer): Integer;
var
  I, FieldIndex: Integer;
begin
  Result := -1;
  if DataSource <> nil then
  begin
    FieldIndex := DataSource.GetSortingItemIndex(Item);
    for I := 0 to ColumnCount - 1 do
    begin
      if Columns[I].DataBinding.FieldIndex = FieldIndex then
      begin
        Result := I;
        break;
      end;
    end;
  end;
end;

function TcxWebDBGrid.GetGroupingItemIndex(Item: Integer): Integer;
var
  I, FieldIndex: Integer;
begin
  Result := -1;
  if DataSource <> nil then
  begin
    FieldIndex := DataSource.GetGroupingItemIndex(Item);
    for I := 0 to ColumnCount - 1 do
    begin
      if Columns[I].DataBinding.FieldIndex = FieldIndex then
      begin
        Result := I;
        break;
      end;
    end;
  end;
end;

function TcxWebDBGrid.Mode: TcxWebGridMode;
begin
  Result := mBrowse;
  if not ReadOnly and (DataSource <> nil) then
    if TcxCustomWebDataSourceAccess(DataSource).IsEditing then
      Result := mEdit;
end;

function TcxWebDBGrid.AllowExpanding: Boolean;
begin
  if DataSource <> nil then
    Result := DataSource.AllowExpanding
  else Result := False;
end;

function TcxWebDBGrid.AllowGrouping: Boolean;
begin
  if DataSource <> nil then
    Result := DataSource.AllowGrouping
  else Result := False;
end;

function TcxWebDBGrid.AllowSorting: Boolean;
begin
  if DataSource <> nil then
    Result := DataSource.AllowSorting
  else Result := False;
end;

function TcxWebDBGrid.LoadAllRecords: Boolean;
begin
  if DataSource <> nil then
    Result := DataSource.LoadAllRecords
  else Result := False;
end;

function TcxWebDBGrid.GetDataSource: TcxCustomWebDataSource;
begin
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) and
    not (csDestroying in DataBinding.DataSource.ComponentState) then
    Result := DataBinding.DataSource
  else Result := nil;
end;

procedure TcxWebDBGrid.SetDataBinding(Value: TcxWebGridDataBinding);
begin
  DataBinding.Assign(Value);
end;

function TcxWebDBGrid.GetColumn(Index: Integer): TcxWebDBColumn;
begin
  Result := (inherited GetColumn(Index)) as TcxWebDBColumn;
end;

procedure TcxWebDBGrid.SetColumn(Index: Integer; Value: TcxWebDBColumn);
begin
  inherited SetColumn(Index, Value);
end;

procedure TcxWebDBGrid.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if DataBinding <> nil then
    DataBinding.Notification(AComponent, Operation);
end;

procedure TcxWebDBGrid.ImplGetProviders(AList: TList);
begin
  inherited ImplGetProviders(AList);
  if (DataBinding <> nil) and (DataBinding.DataSource <> nil) then
    AList.Add(DataBinding.DataSource);
end;

procedure TcxWebDBGrid.ScriptsSubscription;
begin
  inherited;
  WebScriptsHelper.ScriptSubscription(TcxWebPostBackScript);
  WebScriptsHelper.ScriptSubscription(TcxWebAdvancedPostBackScript);
end;

procedure TcxWebDBGrid.RegisterRenderers;
begin
  WebRenderHelper.RegisterRenderer(TcxWebDBGridRenderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBGridNS4Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBGridNS6Renderer);
  WebRenderHelper.RegisterRenderer(TcxWebDBGridOperaRenderer);
end;

{ TcxWebDBGridRenderer }

procedure TcxWebDBGridRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBGrid(WebGrid).DataBinding.DataSource <> nil then
    TcxWebDBGrid(WebGrid).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBGrid');
end;

class procedure TcxWebDBGridRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBGridNS4Renderer }

procedure TcxWebDBGridNS4Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBGrid(WebGrid).DataBinding.DataSource <> nil then
    TcxWebDBGrid(WebGrid).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBGrid');
end;

class procedure TcxWebDBGridNS4Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBGridNS6Renderer }

procedure TcxWebDBGridNS6Renderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBGrid(WebGrid).DataBinding.DataSource <> nil then
    TcxWebDBGrid(WebGrid).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBGrid');
end;

class procedure TcxWebDBGridNS6Renderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

{ TcxWebDBGridOperaRenderer }

procedure TcxWebDBGridOperaRenderer.WriteScripts;
begin
  inherited WriteScripts;
  if TcxWebDBGrid(WebGrid).DataBinding.DataSource <> nil then
    TcxWebDBGrid(WebGrid).DataBinding.WriteControlScripts(HTMLTextBuilder, 'CreateDBGrid');
end;

class procedure TcxWebDBGridOperaRenderer.GetScriptFiles(AList: TStrings);
begin
  inherited GetScriptFiles(AList);
  AList.Add(scxDataControlsScriptName);
end;

initialization
  RegisterClasses([TcxWebGridColumnDataBinding, TcxWebGridDataBinding,
      TcxWebDBColumn, TcxWebDBGrid]);

end.


