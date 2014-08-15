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

unit cxGridDBChartView;

interface

uses
  Classes, DB, cxCustomData, cxDataStorage, cxDBData, cxGridCustomView, cxGridChartView;

type
  TcxGridDBChartView = class;

  TcxGridDBChartDataController = class(TcxDBDataController, IcxCustomGridDataController,
    IcxGridChartViewItemsProvider)
  private
    function GetGridViewValue: TcxGridDBChartView;
  protected
    { IcxCustomGridDataController }
    procedure AssignData(ADataController: TcxCustomDataController);
    procedure CreateAllItems;
    procedure DeleteAllItems;
    procedure GetFakeComponentLinks(AList: TList);
    function GetGridView: TcxCustomGridView;
    function IsDataChangeable: Boolean;
    function IsDataLinked: Boolean;
    function SupportsCreateAllItems: Boolean;
    { IcxGridChartViewItemsProvider }
    function GetSeries(AIndex: Integer): TcxGridChartSeries;
    procedure GetSeriesCaptions(ACaptions: TStringList);
    procedure InitSeries(ASeries: TcxGridChartSeries; AIndex: Integer);

    procedure DoDataSourceChanged; override;
    function GetItemID(AItem: TObject): Integer; override;
    procedure GetValidValueFields(AFields: TList);
  public
    procedure BeginFullUpdate; override;
    procedure EndFullUpdate; override;
    function GetItem(Index: Integer): TObject; override;

    property GridView: TcxGridDBChartView read GetGridViewValue;
  published
    property DataModeController;
    property DataSource;
    property DetailKeyFieldNames;
    property KeyFieldNames;
    property MasterKeyFieldNames;
    property Options;
    property OnCompare;
    property OnDataChanged;
    property OnFilterRecord;
  end;

  TcxGridDBChartItemDataBinding = class(TcxGridChartItemDataBinding)
  private
    function GetDataController: TcxGridDBChartDataController;
    function GetField: TField;
    function GetFieldName: string;
    procedure SetFieldName(const Value: string);
  protected
    function GetDefaultValueTypeClass: TcxValueTypeClass; override;
    function IsValueTypeStored: Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
    property DataController: TcxGridDBChartDataController read GetDataController;
    property Field: TField read GetField;
  published
    property FieldName: string read GetFieldName write SetFieldName;
  end;

  TcxGridDBChartCategories = class(TcxGridChartCategories)
  private
    function GetDataBinding: TcxGridDBChartItemDataBinding;
    procedure SetDataBinding(Value: TcxGridDBChartItemDataBinding);
  published
    property DataBinding: TcxGridDBChartItemDataBinding read GetDataBinding write SetDataBinding;
  end;

  TcxGridDBChartSeries = class(TcxGridChartSeries)
  private
    function GetDataBinding: TcxGridDBChartItemDataBinding;
    procedure SetDataBinding(Value: TcxGridDBChartItemDataBinding);
  protected
    function GetDefaultDisplayText: string; override;
  published
    property DataBinding: TcxGridDBChartItemDataBinding read GetDataBinding write SetDataBinding;
  end;

  TcxGridDBChartView = class(TcxGridChartView)
  private
    function GetCategories: TcxGridDBChartCategories;
    function GetDataController: TcxGridDBChartDataController;
    function GetSeries(Index: Integer): TcxGridDBChartSeries;
    procedure SetCategories(Value: TcxGridDBChartCategories);
    procedure SetDataController(Value: TcxGridDBChartDataController);
    procedure SetSeries(Index: Integer; Value: TcxGridDBChartSeries);
  protected
    function GetCategoriesClass: TcxGridChartCategoriesClass; override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetItemDataBindingClass: TcxGridChartItemDataBindingClass; override;
    function GetSeriesClass: TcxGridChartSeriesClass; override;
  public
    function CreateSeries: TcxGridDBChartSeries;
    function FindSeriesByFieldName(const AFieldName: string): TcxGridDBChartSeries;
    property Series[Index: Integer]: TcxGridDBChartSeries read GetSeries write SetSeries;
  published
    property Categories: TcxGridDBChartCategories read GetCategories write SetCategories;
    property DataController: TcxGridDBChartDataController read GetDataController write SetDataController;
  end;

implementation

uses
  SysUtils, cxClasses, cxGridDBDataDefinitions;

type
  TcxComponentAccess = class(TcxComponent);
  
{ TcxGridDBChartDataController }

function TcxGridDBChartDataController.GetGridViewValue: TcxGridDBChartView;
begin
  Result := TcxGridDBChartView(GetOwner);
end;

procedure TcxGridDBChartDataController.AssignData(ADataController: TcxCustomDataController);
begin
end;

procedure TcxGridDBChartDataController.CreateAllItems;
begin
end;

procedure TcxGridDBChartDataController.DeleteAllItems;
begin
end;

procedure TcxGridDBChartDataController.GetFakeComponentLinks(AList: TList);
begin
  if (DataSource <> nil) and (DataSource.Owner <> GridView.Owner) and
    (AList.IndexOf(DataSource.Owner) = -1) then
    AList.Add(DataSource.Owner);
end;

function TcxGridDBChartDataController.GetGridView: TcxCustomGridView;
begin
  Result := GridView;
end;

function TcxGridDBChartDataController.IsDataChangeable: Boolean;
begin
  Result := False;
end;

function TcxGridDBChartDataController.IsDataLinked: Boolean;
begin
  Result := DataSet <> nil;
end;

function TcxGridDBChartDataController.SupportsCreateAllItems: Boolean;
begin
  Result := False;
end;

function TcxGridDBChartDataController.GetSeries(AIndex: Integer): TcxGridChartSeries;
var
  AFields: TList;
begin
  AFields := TList.Create;
  try
    GetValidValueFields(AFields);
    Result := GridView.FindSeriesByFieldName(TField(AFields[AIndex]).FieldName);
  finally
    AFields.Free;
  end;
end;

procedure TcxGridDBChartDataController.GetSeriesCaptions(ACaptions: TStringList);
var
  AFields: TList;
  I: Integer;
begin
  AFields := TList.Create;
  try
    GetValidValueFields(AFields);
    for I := 0 to AFields.Count - 1 do
      ACaptions.Add(TField(AFields[I]).DisplayName);
  finally
    AFields.Free;
  end;
end;

procedure TcxGridDBChartDataController.InitSeries(ASeries: TcxGridChartSeries; AIndex: Integer);
var
  AFields: TList;
begin
  AFields := TList.Create;
  try
    GetValidValueFields(AFields);
    TcxGridDBChartSeries(ASeries).DataBinding.FieldName := TField(AFields[AIndex]).FieldName;
  finally
    AFields.Free;
  end;
end;

procedure TcxGridDBChartDataController.DoDataSourceChanged;
begin
  TcxComponentAccess(GridView).UpdateFakeLinks;
end;

function TcxGridDBChartDataController.GetItemID(AItem: TObject): Integer;
begin
  if AItem is TcxGridChartCategories then
    Result := TcxGridChartCategories(AItem).ID
  else
    if AItem is TcxGridChartSeries then
      Result := TcxGridChartSeries(AItem).ID
    else
      Result := -1;
end;

function CompareFields(Item1, Item2: Pointer): Integer;
begin
  if TField(Item1).DisplayName < TField(Item2).DisplayName then
    Result := -1
  else
    if TField(Item1).DisplayName > TField(Item2).DisplayName then
      Result := 1
    else
      Result := 0;
end;

procedure TcxGridDBChartDataController.GetValidValueFields(AFields: TList);
var
  I: Integer;
  AField: TField;
begin
  if DataSet = nil then Exit;
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    AField := DataSet.Fields[I];
    if IsValueTypeClassValid(GetValueTypeClassByField(AField)) then
      AFields.Add(AField);
  end;
  AFields.Sort(CompareFields);
end;

procedure TcxGridDBChartDataController.BeginFullUpdate;
begin
  GridView.BeginUpdate;
  inherited;
end;

procedure TcxGridDBChartDataController.EndFullUpdate;
begin
  inherited;
  GridView.EndUpdate;
end;

function TcxGridDBChartDataController.GetItem(Index: Integer): TObject;
begin
  if Index = 0 then
    Result := GridView.Categories
  else
    Result := GridView.Series[Index - 1];
end;

{ TcxGridDBChartItemDataBinding }

function TcxGridDBChartItemDataBinding.GetDataController: TcxGridDBChartDataController;
begin
  Result := TcxGridDBChartDataController(inherited DataController);
end;

function TcxGridDBChartItemDataBinding.GetField: TField;
begin
  Result := DataController.GetItemField(DataIndex);
end;

function TcxGridDBChartItemDataBinding.GetFieldName: string;
begin
  Result := DataController.GetItemFieldName(DataIndex);
end;

procedure TcxGridDBChartItemDataBinding.SetFieldName(const Value: string);
begin
  DataController.ChangeFieldName(DataIndex, Value);
end;

function TcxGridDBChartItemDataBinding.GetDefaultValueTypeClass: TcxValueTypeClass;
begin
  Result := nil;
end;

function TcxGridDBChartItemDataBinding.IsValueTypeStored: Boolean;
begin
  Result := FieldName = '';
end;

procedure TcxGridDBChartItemDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxGridDBChartItemDataBinding then
    FieldName := TcxGridDBChartItemDataBinding(Source).FieldName;
  inherited;
end;

{ TcxGridDBChartCategories }

function TcxGridDBChartCategories.GetDataBinding: TcxGridDBChartItemDataBinding;
begin
  Result := TcxGridDBChartItemDataBinding(inherited DataBinding);
end;

procedure TcxGridDBChartCategories.SetDataBinding(Value: TcxGridDBChartItemDataBinding);
begin
  inherited DataBinding := Value;
end;

{ TcxGridDBChartSeries }

function TcxGridDBChartSeries.GetDataBinding: TcxGridDBChartItemDataBinding;
begin
  Result := TcxGridDBChartItemDataBinding(inherited DataBinding);
end;

procedure TcxGridDBChartSeries.SetDataBinding(Value: TcxGridDBChartItemDataBinding);
begin
  inherited DataBinding := Value;
end;

function TcxGridDBChartSeries.GetDefaultDisplayText: string;
begin
  if DataBinding.Field = nil then
    Result := ''
  else
    Result := DataBinding.Field.DisplayName;
  if Result = '' then
    Result := inherited GetDefaultDisplayText;
end;

{ TcxGridDBChartView }

function TcxGridDBChartView.GetCategories: TcxGridDBChartCategories;
begin
  Result := TcxGridDBChartCategories(inherited Categories);
end;

function TcxGridDBChartView.GetDataController: TcxGridDBChartDataController;
begin
  Result := TcxGridDBChartDataController(FDataController);
end;

function TcxGridDBChartView.GetSeries(Index: Integer): TcxGridDBChartSeries;
begin
  Result := TcxGridDBChartSeries(inherited Series[Index]);
end;

procedure TcxGridDBChartView.SetCategories(Value: TcxGridDBChartCategories);
begin
  inherited Categories := Value;
end;

procedure TcxGridDBChartView.SetDataController(Value: TcxGridDBChartDataController);
begin
  FDataController.Assign(Value);
end;

procedure TcxGridDBChartView.SetSeries(Index: Integer; Value: TcxGridDBChartSeries);
begin
  inherited Series[Index] := Value;
end;

function TcxGridDBChartView.GetCategoriesClass: TcxGridChartCategoriesClass;
begin
  Result := TcxGridDBChartCategories;
end;

function TcxGridDBChartView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridDBChartDataController;
end;

function TcxGridDBChartView.GetItemDataBindingClass: TcxGridChartItemDataBindingClass;
begin
  Result := TcxGridDBChartItemDataBinding;
end;

function TcxGridDBChartView.GetSeriesClass: TcxGridChartSeriesClass;
begin
  Result := TcxGridDBChartSeries;
end;

function TcxGridDBChartView.CreateSeries: TcxGridDBChartSeries;
begin
  Result := TcxGridDBChartSeries(inherited CreateSeries);
end;

function TcxGridDBChartView.FindSeriesByFieldName(const AFieldName: string): TcxGridDBChartSeries;
var
  I: Integer;
begin
  for I := 0 to SeriesCount - 1 do
  begin
    Result := Series[I];
    if SameText(Result.DataBinding.FieldName, AFieldName) then Exit;
  end;
  Result := nil;
end;

initialization
  cxGridRegisteredViews.Register(TcxGridDBChartView, 'DB Chart');
  Classes.RegisterClass(TcxGridDBChartSeries);

finalization
  cxGridRegisteredViews.Unregister(TcxGridDBChartView);

end.
