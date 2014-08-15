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

unit cxGridDBTableView;

{$I cxGridVer.inc}

interface

uses
  Classes, cxGridCustomTableView, cxGridTableView, cxGridDBDataDefinitions,
  cxStorage, cxCustomData, cxDBData;

type
  TcxGridDBTableView = class;

  TcxGridDBColumn = class(TcxGridColumn)
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

  TcxGridDBTableSummaryItem = class(TcxDBDataSummaryItem,
    {$IFNDEF DELPHI6}IUnknown,{$ENDIF} IcxStoredObject)
  private
    function GetColumn: TcxGridDBColumn;
    function GetGridView: TcxGridDBTableView;
    procedure SetColumn(Value: TcxGridDBColumn);
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
    property GridView: TcxGridDBTableView read GetGridView;
  published
    property Column: TcxGridDBColumn read GetColumn write SetColumn;
  end;

  TcxGridDBTableView = class(TcxGridTableView)
  private
    function GetColumn(Index: Integer): TcxGridDBColumn;
    function GetDataController: TcxGridDBDataController;
    procedure SetColumn(Index: Integer; Value: TcxGridDBColumn);
    procedure SetDataController(Value: TcxGridDBDataController);
  protected
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetItemClass: TcxCustomGridTableItemClass; override;
    function GetSummaryItemClass: TcxDataSummaryItemClass; override;
  public
    function CreateColumn: TcxGridDBColumn;
    function GetColumnByFieldName(const AFieldName: string): TcxGridDBColumn;
    property Columns[Index: Integer]: TcxGridDBColumn read GetColumn write SetColumn;
  published
    property DataController: TcxGridDBDataController read GetDataController write SetDataController;
  end;

implementation

uses
  cxGridCustomView;

{ TcxGridDBColumn }

function TcxGridDBColumn.GetDataBinding: TcxGridItemDBDataBinding;
begin
  Result := TcxGridItemDBDataBinding(inherited DataBinding);
end;

procedure TcxGridDBColumn.SetDataBinding(Value: TcxGridItemDBDataBinding);
begin
  inherited DataBinding := Value;
end;

function TcxGridDBColumn.GetStoredProperties(AProperties: TStrings): Boolean;
begin
  inherited GetStoredProperties(AProperties);
  with AProperties do
    Add('FieldName');
  Result := True;
end;

procedure TcxGridDBColumn.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'FieldName' then
    AValue := DataBinding.FieldName
  else
    inherited;
end;

procedure TcxGridDBColumn.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'FieldName' then
    DataBinding.FieldName := AValue
  else
    inherited;
end;

{ TcxGridDBTableSummaryItem }

function TcxGridDBTableSummaryItem.GetColumn: TcxGridDBColumn;
begin
  Result := TcxGridDBColumn(ItemLink);
end;

function TcxGridDBTableSummaryItem.GetGridView: TcxGridDBTableView;
begin
  Result := TcxGridDBTableView(TcxGridDBDataController(DataController).GridView);
end;

procedure TcxGridDBTableSummaryItem.SetColumn(Value: TcxGridDBColumn);
begin
  ItemLink := Value;
end;

function TcxGridDBTableSummaryItem.QueryInterface(const IID: TGUID; out Obj): HResult;
const
  E_NOINTERFACE = HResult($80004002);
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TcxGridDBTableSummaryItem._AddRef: Integer;
begin
  Result := -1;
end;

function TcxGridDBTableSummaryItem._Release: Integer;
begin
  Result := -1;
end;

function TcxGridDBTableSummaryItem.GetObjectName: string;
begin
  Result := '';
end;

function TcxGridDBTableSummaryItem.GetProperties(AProperties: TStrings): Boolean;
begin
  AProperties.Add('Column');
  Result := False;
end;

procedure TcxGridDBTableSummaryItem.GetPropertyValue(const AName: string; var AValue: Variant);
begin
  if AName = 'Column' then
    if Column <> nil then
      AValue := Column.GetObjectName
    else
      AValue := '';
end;

procedure TcxGridDBTableSummaryItem.SetPropertyValue(const AName: string; const AValue: Variant);
begin
  if AName = 'Column' then
    Column := TcxGridDBColumn(GridView.FindItemByObjectName(AValue));
end;

{ TcxGridDBTableView }

function TcxGridDBTableView.GetColumn(Index: Integer): TcxGridDBColumn;
begin
  Result := TcxGridDBColumn(inherited Columns[Index]);
end;

function TcxGridDBTableView.GetDataController: TcxGridDBDataController;
begin
  Result := TcxGridDBDataController(inherited DataController);
end;

procedure TcxGridDBTableView.SetColumn(Index: Integer; Value: TcxGridDBColumn);
begin
  inherited Columns[Index] := Value;
end;

procedure TcxGridDBTableView.SetDataController(Value: TcxGridDBDataController);
begin
  inherited DataController := TcxGridDataController(Value);
end;

function TcxGridDBTableView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridDBDataController;
end;

function TcxGridDBTableView.GetItemClass: TcxCustomGridTableItemClass;
begin
  Result := TcxGridDBColumn;
end;

function TcxGridDBTableView.GetSummaryItemClass: TcxDataSummaryItemClass;
begin
  Result := TcxGridDBTableSummaryItem;
end;

function TcxGridDBTableView.CreateColumn: TcxGridDBColumn;
begin
  Result := TcxGridDBColumn(inherited CreateColumn);
end;

function TcxGridDBTableView.GetColumnByFieldName(const AFieldName: string): TcxGridDBColumn;
begin
  Result := TcxGridDBColumn(DataController.GetItemByFieldName(AFieldName));
end;

initialization
  cxGridRegisteredViews.Register(TcxGridDBTableView, 'DB Table');
  Classes.RegisterClass(TcxGridDBColumn);

finalization
  cxGridRegisteredViews.Unregister(TcxGridDBTableView);

end.
