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

unit cxGridDBBandedTableView;

{$I cxGridVer.inc}

interface

uses
  Classes, cxStorage, cxCustomData, cxDBData,
  cxGridCustomTableView, cxGridDBDataDefinitions, cxGridBandedTableView;

type
  TcxGridDBBandedTableView = class;

  TcxGridDBBandedColumn = class(TcxGridBandedColumn)
  private
    function GetDataBinding: TcxGridItemDBDataBinding;
    procedure SetDataBinding(Value: TcxGridItemDBDataBinding);
  protected
    // IcxStoredObject
    function GetStoredProperties(AProperties: TStrings): Boolean; override;
    procedure GetPropertyValue(const AName: string; var AValue: Variant); override;
    procedure SetPropertyValue(const AName: string; const AValue: Variant); override;
  published
    property DataBinding: TcxGridItemDBDataBinding read GetDataBinding write SetDataBinding;
  end;

  TcxGridDBBandedTableSummaryItem = class(TcxDBDataSummaryItem,
    {$IFNDEF DELPHI6}IUnknown,{$ENDIF} IcxStoredObject)
  private
    function GetColumn: TcxGridDBBandedColumn;
    function GetGridView: TcxGridDBBandedTableView;
    procedure SetColumn(Value: TcxGridDBBandedColumn);
  protected
    // IInterface
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IcxStoredObject
    function GetObjectName: string;
    function GetProperties(AProperties: TStrings): Boolean;
    procedure GetPropertyValue(const AName: string; var AValue: Variant);
    procedure SetPropertyValue(const AName: string; const AValue: Variant);
    property GridView: TcxGridDBBandedTableView read GetGridView;
  published
    property Column: TcxGridDBBandedColumn read GetColumn write SetColumn;
  end;

  TcxGridDBBandedTableView = class(TcxGridBandedTableView)
  private
    function GetColumn(Index: Integer): TcxGridDBBandedColumn;
    function GetDataController: TcxGridDBDataController;
    procedure SetColumn(Index: Integer; Value: TcxGridDBBandedColumn);
    procedure SetDataController(Value: TcxGridDBDataController);
  protected
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetItemClass: TcxCustomGridTableItemClass; override;
    function GetSummaryItemClass: TcxDataSummaryItemClass; override;
  public
    function CreateColumn: TcxGridDBBandedColumn;
    function GetColumnByFieldName(const AFieldName: string): TcxGridDBBandedColumn;
    property Columns[Index: Integer]: TcxGridDBBandedColumn read GetColumn write SetColumn;
  published
    property DataController: TcxGridDBDataController read GetDataController write SetDataController;
  end;

implementation

uses
  cxGridCustomView, cxGridDBTableView;

{ TcxGridDBBandedColumn }

function TcxGridDBBandedColumn.GetDataBinding: TcxGridItemDBDataBinding;
begin
  Result := TcxGridItemDBDataBinding(inherited DataBinding);
end;

procedure TcxGridDBBandedColumn.SetDataBinding(Value: TcxGridItemDBDataBinding);
begin
  inherited DataBinding := Value;
end;

function TcxGridDBBandedColumn.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  inherited GetStoredProperties(AProperties);
  with AProperties do
    Add('FieldName');
  Result := True;
end;

procedure TcxGridDBBandedColumn.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'FieldName' then
    AValue := DataBinding.FieldName
  else
    inherited;
end;

procedure TcxGridDBBandedColumn.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'FieldName' then
    DataBinding.FieldName := AValue
  else
    inherited;
end;

{ TcxGridDBBandedTableSummaryItem }

function TcxGridDBBandedTableSummaryItem.GetColumn: TcxGridDBBandedColumn;
begin
  Result := TcxGridDBBandedColumn(ItemLink);
end;

function TcxGridDBBandedTableSummaryItem.GetGridView: TcxGridDBBandedTableView;
begin
  Result := TcxGridDBBandedTableView(TcxGridDBDataController(DataController).GridView);
end;

procedure TcxGridDBBandedTableSummaryItem.SetColumn(Value: TcxGridDBBandedColumn);
begin
  ItemLink := Value;
end;

function TcxGridDBBandedTableSummaryItem.QueryInterface(const IID: TGUID;
  out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxGridDBBandedTableSummaryItem._AddRef: Integer;
begin
  Result := -1;
end;

function TcxGridDBBandedTableSummaryItem._Release: Integer;
begin
  Result := -1;
end;

function TcxGridDBBandedTableSummaryItem.GetObjectName: string;
begin
  Result := '';
end;

function TcxGridDBBandedTableSummaryItem.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Column');
  Result := False;
end;

procedure TcxGridDBBandedTableSummaryItem.GetPropertyValue(const AName: string;
  var AValue: Variant);
begin
  if AName = 'Column' then
    if Column <> nil then
      AValue := Column.GetObjectName
    else
      AValue := '';
end;

procedure TcxGridDBBandedTableSummaryItem.SetPropertyValue(const AName: string;
  const AValue: Variant);
begin
  if AName = 'Column' then
    Column := TcxGridDBBandedColumn(GridView.FindItemByObjectName(AValue));
end;

{ TcxGridDBBandedTableView }

function TcxGridDBBandedTableView.GetColumn(Index: Integer): TcxGridDBBandedColumn;
begin
  Result := TcxGridDBBandedColumn(inherited Columns[Index]);
end;

function TcxGridDBBandedTableView.GetDataController: TcxGridDBDataController;
begin
  Result := TcxGridDBDataController(inherited DataController);
end;

procedure TcxGridDBBandedTableView.SetColumn(Index: Integer; Value: TcxGridDBBandedColumn);
begin
  inherited Columns[Index] := Value;
end;

procedure TcxGridDBBandedTableView.SetDataController(Value: TcxGridDBDataController);
begin
  inherited DataController := TcxGridDataController(Value);
end;

function TcxGridDBBandedTableView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridDBDataController;
end;

function TcxGridDBBandedTableView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridDBBandedColumn;
end;

function TcxGridDBBandedTableView.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := TcxGridDBBandedTableSummaryItem;
end;

function TcxGridDBBandedTableView.CreateColumn: TcxGridDBBandedColumn;
begin
  Result := TcxGridDBBandedColumn(inherited CreateColumn);
end;

function TcxGridDBBandedTableView.GetColumnByFieldName(const AFieldName: string): TcxGridDBBandedColumn;
begin
  Result := TcxGridDBBandedColumn(DataController.GetItemByFieldName(AFieldName));
end;

initialization
  cxGridRegisteredViews.Register(TcxGridDBBandedTableView, 'DB Banded Table');
  Classes.RegisterClass(TcxGridDBBandedColumn);

finalization
  cxGridRegisteredViews.Unregister(TcxGridDBBandedTableView);

end.
