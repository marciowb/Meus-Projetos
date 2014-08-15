
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid filter implementation                    }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSGRID AND ALL ACCOMPANYING VCL }
{   CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.                 }
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

unit dxGrFltr;

interface

{$I dxTLVer.inc}

uses
  Classes, SysUtils, Controls, dxFilter, dxDBCtrl, dxDBGrid{$IFDEF DELPHI6}, Variants{$ENDIF};

type
  { TdxDBGridCriteriaItem }

  TdxDBGridCriteriaItem = class(TdxCriteriaItem)
  private
    FColumn: TdxDBTreeListColumn;
  protected
    function GetCaption: string; override;
    function GetDataValue(AData: Pointer): Variant; override;
    function GetText: string; override;
  public
    constructor Create(AOwner: TdxCriteriaItemList); override;
    property Column: TdxDBTreeListColumn read FColumn;
  end;

  { TdxDBGridCriteria }

  TdxDBGridCriteria = class(TdxCriteria)
  private
    FCaseInsensitive: Boolean;
    FDBGrid: TdxDBGrid;
  protected
    function GetItemClass: TdxCriteriaItemClass; override;
    function PrepareValue(const AValue: Variant): Variant; override;
    property DBGrid: TdxDBGrid read FDBGrid;
  public
    constructor Create(ADBGrid: TdxDBGrid);
    function AddItem(AItemList: TdxCriteriaItemList; AColumn: TdxDBTreeListColumn;
      AOperator: TdxOperatorType; const AValue: Variant; const ADisplayValue: string;
      AIsNot: Boolean): TdxDBGridCriteriaItem;
    function DoFilterNode(ANode: TdxDBGridNode): Boolean;
    function ExistCustomCriteriaByColumn(AColumn: TdxDBTreeListColumn): Boolean;
    function FindItemByColumn(AColumn: TdxDBTreeListColumn): TdxCriteriaItem;
    procedure Prepare; override;
    procedure RemoveItemsByColumn(AColumn: TdxDBTreeListColumn);
    function ShowCustomDialog(AColumn: TdxDBTreeListColumn): Boolean;
    property CaseInsensitive: Boolean read FCaseInsensitive write FCaseInsensitive;
  end;

implementation

uses
  DB, dxGrFDlg;

type
  TdxColumnWrapper = class(TdxDBGridColumn);

procedure CheckFieldName(var AFieldName: string);
begin
  if not IsValidIdent(AFieldName) then
    AFieldName := '[' + AFieldName + ']';
end;
  
{ TdxDBGridCriteriaItem }

constructor TdxDBGridCriteriaItem.Create(AOwner: TdxCriteriaItemList);
begin
  inherited Create(AOwner);
  FColumn := nil;
end;

function TdxDBGridCriteriaItem.GetCaption: string;
begin
  if Assigned(Column) then
    Result := Column.Caption
  else
    Result := '';
end;

function TdxDBGridCriteriaItem.GetDataValue(AData: Pointer): Variant;
begin
  if Assigned(Column) then
    Result := (TdxColumnWrapper(Column)).GetFilterValue(TdxDBGridNode(AData))
  else
    Result := Null;
end;

function TdxDBGridCriteriaItem.GetText: string;

  function GetFieldName(AField: TField): string;
  begin
    if AField.Lookup then
      AField := AField.DataSet.FindField(AField.KeyFields);
    if Assigned(AField) then
      Result := AField.FieldName
    else
      Result := '';
  end;

begin
  Result := '';
  if Assigned(Column) and Assigned(TdxColumnWrapper(Column).FField) then
  begin
    Result := TdxColumnWrapper(Column).FField.Origin;
    if Result = '' then
    begin
      Result := GetFieldName(TdxColumnWrapper(Column).FField);
      CheckFieldName(Result);
    end;
  end;
end;

{ TdxDBGridCriteria }

constructor TdxDBGridCriteria.Create(ADBGrid: TdxDBGrid);
begin
  inherited Create;
  FDBGrid := ADBGrid;
end;

function TdxDBGridCriteria.AddItem(AItemList: TdxCriteriaItemList; AColumn: TdxDBTreeListColumn;
  AOperator: TdxOperatorType; const AValue: Variant; const ADisplayValue: string;
  AIsNot: Boolean): TdxDBGridCriteriaItem;
begin
  if AItemList = nil then
    AItemList := Root;
  Result := TdxDBGridCriteriaItem(AItemList.AddItem(AColumn.Name, AOperator, AValue, ADisplayValue));
  Result.IsNot := AIsNot;
end;

function TdxDBGridCriteria.DoFilterNode(ANode: TdxDBGridNode): Boolean;
begin
  Result := DoFilterData(ANode);
end;

function TdxDBGridCriteria.ExistCustomCriteriaByColumn(AColumn: TdxDBTreeListColumn): Boolean;
var
  CriteriaItem: TdxCriteriaItem;
begin
  CriteriaItem := FindItemByColumn(AColumn);
  if CriteriaItem <> nil then
     Result := not ((CriteriaItem.Parent = Root) and (CriteriaItem.Operator = otEqual))
  else
    Result := False;
end;

function TdxDBGridCriteria.FindItemByColumn(AColumn: TdxDBTreeListColumn): TdxCriteriaItem;
begin
  Result := FindItemByName(AColumn.Name);
end;

procedure TdxDBGridCriteria.Prepare;

  procedure PrepareBranch(Branch: TdxCriteriaItemList);
  var
    I: Integer;
    AItem: TdxDBGridCriteriaItem; 
  begin
    for I := 0 to Branch.Count - 1 do
      if Branch.Items[I].IsItemList then
        PrepareBranch(TdxCriteriaItemList(Branch.Items[I]))
      else
      begin
        AItem := TdxDBGridCriteriaItem(Branch.Items[I]);
        AItem.FColumn := DBGrid.ColumnByName(AItem.ID);
      end;
  end;

begin
  inherited Prepare;
  PrepareBranch(Root);
end;

procedure TdxDBGridCriteria.RemoveItemsByColumn(AColumn: TdxDBTreeListColumn);
begin
  RemoveItemByName(AColumn.Name);
end;

function TdxDBGridCriteria.ShowCustomDialog(AColumn: TdxDBTreeListColumn): Boolean;
begin
  Result := CustomDialog(AColumn, Self);
end;

function TdxDBGridCriteria.GetItemClass: TdxCriteriaItemClass;
begin
  Result := TdxDBGridCriteriaItem;
end;

function TdxDBGridCriteria.PrepareValue(const AValue: Variant): Variant;
begin
  Result := inherited PrepareValue(AValue);
  if VarType(Result) = varCurrency then
    Result := VarAsType(Result, varDouble)
  else
    if (VarType(Result) = varString) and CaseInsensitive then
      Result := AnsiUpperCase(Result);
end;

end.
