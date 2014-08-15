{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit cxPivotGridOLAPQueryBuilder;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, Contnrs, ADODB, cxClasses, cxCustomPivotGrid, cxADOMDInt;

type

  { TdxOLAPDataQueryBuilder }

  TcxOLAPDataQueryBuilder = class
  protected
    FFilters: TcxPivotGridFields;
    FVersion: Integer;

    function CreateFilterAggregates(AFilters: TcxPivotGridFields): string;
    function CreateFilterAggregate(AField: TcxPivotGridField): string;
    function CreateFilterWhereClause(AFilters: TcxPivotGridFields): string;
    function CreateTotal(AField: TcxPivotGridField): string;
    function CreateVisualTotals(AFilters: TcxPivotGridFields): string;
    function FiltersEnabled(AFilters: TcxPivotGridFields): Boolean;
    function GetAllTuples(AFields: TcxPivotGridFields; ATuples: TList): string;
    function GetCrossJoinExpand(AField: TcxPivotGridField;
      ATuple: TcxPivotGridGroupItem): string;
    function GetDescendantsCore(AField: TcxPivotGridField;
      ATuple: TcxPivotGridGroupItem): string;
    function GetEverything(AFields: TcxPivotGridFields{;
      AMembers: TList; Expand: Boolean; AnExpandLevel: Integer}): string;
    function GetExpand(AField: TcxPivotGridField; ATuples: TList): string;
    function GetFieldMembers(AField: TcxPivotGridField): string;
    function GetFilter(AFilter: TInterfaceList; AnID: Integer): string;
    function GetHierarchyExpand(AField: TcxPivotGridField;
      ATuple: TcxPivotGridGroupItem): string;
    function GetMeasures(AMeasures: TcxPivotGridFields): string;
    function GetMember(AField: TcxPivotGridField; const AType: string): string;
    function GetMemberCount(ATuple: TcxPivotGridGroupItem): Integer;
    function GetMemberName(AField: TcxPivotGridField; const AType: string): string;
    function GetMembers(AFilter: TInterfaceList): string;
    function GetSortOrder(AField: TcxPivotGridField): string;
    function GetSource(const ACubeName: string; AFilters: TcxPivotGridFields): string;
    function GetTotalMember(AField: TcxPivotGridOLAPField): string;
    function GetTuple(ATuple: TcxPivotGridGroupItem;
      IncludeLastMember: Boolean = True; MembersCount: Integer = 0): string;
    function IsHierarchy(AField: TcxPivotGridField;
      AParentField: TcxPivotGridField): Boolean;
    function IsFiltered(AField: TcxPivotGridField): Boolean;
    function IsStrongRelationshipBetweenFilterAndDimensions(AColumns: TcxPivotGridFields;
      ARows: TcxPivotGridFields; AFilters: TcxPivotGridFields): Boolean;
    function MultipleFilteredValues(AField: TcxPivotGridField): Boolean;
    function WriteAllMembers(AField: TcxPivotGridField;
      IncludeCalculatedMembers: Boolean): string;
    function WriteAllMembersWithSorting(AField: TcxPivotGridField;
      IncludeTotal: Boolean): string;
    function WriteAllMembersCore(AField: TcxPivotGridField;
      IncludeCalculatedMembers, ExcludeTotal: Boolean): string;
    function WriteSortedMembers(AField: TcxPivotGridField;
      AContent: string): string;

    function CorrectMemberName(const AName: string): string;
    procedure TrimTrailingComma(var Str: string);

    function GetSortBy(AField: TcxPivotGridOLAPField): string;
  public
    constructor Create(AVersion: Integer);
    function GetDrillDownQueryString(const ACubeName: string;
      ACrossCell: TcxPivotGridCrossCell; AFieldList: TcxObjectList;
      ReturnDefaultFields: Boolean): string;
    function GetExpandQueryString(const ACubeName: string;
      AnExpandedItems: TList; AFields, AMeasures: TcxPivotGridFields;
      AFilters: TcxPivotGridFields): string;
    function GetQueryString(const ACubeName: string; AColumns: TcxPivotGridFields;
      ARows: TcxPivotGridFields; AMeasures: TcxPivotGridFields;
      {AColumnRowFilters: TList;} AFilters: TcxPivotGridFields{;
      AColumnTuples: TList = nil; ARowTuples: TList = nil;
      ColumnExpand: Boolean = False; RowExpand: Boolean = False;
      AnExpandLevel: Integer = -1}): string;
    function GetTotalsQueryString(const ACubeName: string; ADimensions: TcxPivotGridFields;
      AMeasures: TcxPivotGridFields; AFilters: TcxPivotGridFields): string;
  end;

implementation

uses
  Math, cxCustomData, cxPivotGridStrs;

const
  EmptyMeasureString = '[Measures].[cxPivotGrid Empty]';
  VisualTotalIDPrefix = 'cxPivotGridVTSet';
  Comma = ', ';

{ TdxOLAPDataQueryBuilder }

constructor TcxOLAPDataQueryBuilder.Create(AVersion: Integer);
begin
  inherited Create;
  FVersion := AVersion;
end;

function TcxOLAPDataQueryBuilder.GetDrillDownQueryString(const ACubeName: string;
  ACrossCell: TcxPivotGridCrossCell; AFieldList: TcxObjectList;
  ReturnDefaultFields: Boolean): string;

  function GetDimensionList(AFieldList: TcxObjectList): string;
  var
    AField: TcxPivotGridOLAPField;
    AFieldDimension: string;
    I: Integer;
  begin
    Result := '';
    for I := 0 to AFieldList.Count - 1 do
    begin
      AField := TcxPivotGridField(AFieldList.List^[I]).Link;
      AFieldDimension := AField.DimensionUniqueName;
      Insert('$', AFieldDimension, 2);
      Result := Result + AFieldDimension + '.[' + AField.Caption + '], ';
    end;
    TrimTrailingComma(Result);
  end;

 { function GetMeasureList(ACrossCell: TcxPivotGridCrossCell): string;
  var
    I: Integer;
    AMeasure: WideString;
  begin
    Result := '';
    for I := 0 to ACrossCell.SummaryCellCount - 1 do
    begin
      AMeasure := (ACrossCell.SummaryCells[I].DataField.Link.Hierarchy as Member).UniqueName;
      Insert('$', AMeasure, 2);
      Result := Result + AMeasure + ', ';
    end;
    TrimTrailingComma(Result);
  end;}

var
  AMeasure: TcxPivotGridField;
  ATempColumnTuple, ATempRowTuple, AColumnTuple, ARowTuple: string;
begin
  Result := '';
  if ACrossCell = nil then
    Exit;
  AMeasure := ACrossCell.SummaryCells[0].DataField;
  if (AMeasure = nil) or (ACubeName = '') then
    Exit;
  Result := 'drillthrough select non empty ';

  AColumnTuple := GetTuple(ACrossCell.Column);
  ARowTuple := GetTuple(ACrossCell.Row);

  case FVersion of
  7, 8:
    begin
      ATempColumnTuple := AColumnTuple;
      ATempRowTuple := ARowTuple;
      if (ATempColumnTuple = '') and (ATempRowTuple <> '') then
      begin
        ATempColumnTuple := ATempRowTuple;
        ATempRowTuple := '';
      end;
      Result := Result + '{ ' + ATempColumnTuple + ' } on columns ';
      if ATempRowTuple <> '' then
        Result := Result + ', { ' + ATempRowTuple + ' } on rows ';
      Result := Result + 'from [' + ACubeName + '] ';
    end;
  9:
    begin
      if AColumnTuple <> '' then
        Result := Result + '{ { ' + AColumnTuple + ' } } * ';
      Result := Result + '{ ' + (AMeasure.Link.Hierarchy as Member).UniqueName +
        ' } on columns ';
      if ARowTuple <> '' then
        Result := Result + ', { { ' + ARowTuple + ' } } on rows ';
      Result := Result + 'from [' + ACubeName + '] ';
    end;
  end;
  if not ReturnDefaultFields then
    Result := Result + 'return ' + GetDimensionList(AFieldList);
end;

function TcxOLAPDataQueryBuilder.GetExpandQueryString(const ACubeName: string;
  AnExpandedItems: TList; AFields, AMeasures: TcxPivotGridFields;
  AFilters: TcxPivotGridFields): string;

  function AreMeasuresExist: Boolean;
  begin
    Result := (AMeasures <> nil) and (AMeasures.Count > 0);
  end;

  function GetItemString(Index: Integer): string;
  var
    AnItemName: string;
  begin
    AnItemName := TcxPivotGridGroupItem(AnExpandedItems[Index]).UniqueName;
    if IsNotLastVisibleOLAPHierarchyItem(TcxPivotGridGroupItem(AnExpandedItems[Index])) then
      Result := WriteSortedMembers(TcxPivotGridGroupItem(
        AnExpandedItems[Index]).Field, 'addcalculatedmembers(' +
        AnItemName + '.children)')
    else
      Result := AnItemName;
  end;

  function GetExpandedItems: string;
  var
    I: Integer;
  begin
    Result := '';
    if (AnExpandedItems <> nil) and (AnExpandedItems.Count > 0) then
    begin
      for I := 0 to AnExpandedItems.Count - 1 do
        Result := Result + '{' + GetItemString(I) + '}*';
      if not AreMeasuresExist then
        Delete(Result, Length(Result), 1);
    end;
  end;

  function GetFields: string;
  var
    I: Integer;
  begin
    Result := '';
    if (AFields <> nil) and (AFields.Count > 0) then
      for I := 0 to AFields.Count - 1 do
        Result := Result + '{' + WriteSortedMembers(AFields[I],
          (AFields[I].Link.Level as Level).UniqueName + '.allmembers') + '}*';
  end;

  function GetMeasures: string;
  var
    I: Integer;
  begin
    Result := '';
    if AreMeasuresExist then
    begin
      Result := Result + '{';
      for I := 0 to AMeasures.Count - 1 do
        Result := Result + '{' + (AMeasures[I].Link.Hierarchy as Member).UniqueName + '}+';
      Delete(Result, Length(Result), 1);
      Result := Result + '}';
    end;
  end;

begin
  Result := 'select non empty ' + GetFields + GetExpandedItems + GetMeasures +
    ' dimension properties member_type on columns ' +
    GetSource(ACubeName, AFilters);
end;

function TcxOLAPDataQueryBuilder.GetQueryString(const ACubeName: string;
  AColumns: TcxPivotGridFields; ARows: TcxPivotGridFields;
  AMeasures: TcxPivotGridFields; {AColumnRowFilters: TList;}
  AFilters: TcxPivotGridFields{;
  AColumnTuples: TList = nil; ARowTuples: TList = nil;
  ColumnExpand: Boolean = False; RowExpand: Boolean = False;
  AnExpandLevel: Integer = -1}): string;
var
  I: Integer;
  AIsStrongRelationshipBetweenFilterAndDimensions: Boolean;
begin
  Result := '';
  if AMeasures.Count = 0 then
    Exit;

  FFilters := AFilters;

  {if (not ColumnExpand and (AColumns.Count > 0)) or
    (not RowExpand and (ARows.Count > 0)) or
    FiltersEnabled(AFilters) then
    Result := 'with ';}
  if (AColumns.Count > 0) or (ARows.Count > 0) or FiltersEnabled(AFilters) then
    Result := 'with ';

  for I := 0 to AColumns.Count - 1 do
    if (I = 0) or not IsHierarchy(AColumns[I], AColumns[I - 1]) then
      Result := Result + CreateTotal(AColumns[I]);
  for I := 0 to ARows.Count - 1 do
    if (I = 0) or not IsHierarchy(ARows[I], ARows[I - 1]) then
      Result := Result + CreateTotal(ARows[I]);

  Result := Result + CreateVisualTotals(AFilters);

  AIsStrongRelationshipBetweenFilterAndDimensions :=
    IsStrongRelationshipBetweenFilterAndDimensions(AColumns, ARows, AFilters);
  if not AIsStrongRelationshipBetweenFilterAndDimensions then
    Result := Result + CreateFilterAggregates(AFilters);

  Result := Result + 'select non empty { ';
  if AColumns.Count > 0 then
    Result := Result + GetEverything(AColumns{, AColumnTuples, ColumnExpand,
      AnExpandLevel}) + '* ';
  Result := Result + GetMeasures(AMeasures) + '} on columns ';
  if ARows.Count > 0 then
    Result := Result + ', non empty ' + GetEverything(ARows{, ARowTuples,
      RowExpand, AnExpandLevel}) +
      'dimension properties member_unique_name on rows ';

  if not AIsStrongRelationshipBetweenFilterAndDimensions then
  begin
    Result := Result + 'from [' + ACubeName + ']';
    Result := Result + CreateFilterWhereClause(AFilters);
  end
  else
    Result := Result + GetSource(ACubeName, AFilters);
end;

function TcxOLAPDataQueryBuilder.GetTotalsQueryString(const ACubeName: string;
  ADimensions: TcxPivotGridFields; AMeasures: TcxPivotGridFields; AFilters: TcxPivotGridFields): string;
begin
  Result := '';
  if AMeasures.Count = 0 then
    Exit;

  FFilters := AFilters;

  Result := 'select non empty { ';
  if (ADimensions <> nil) and (ADimensions.Count > 0) then
    Result := Result + GetEverything(ADimensions) + '* ';
  Result := Result + GetMeasures(AMeasures) + ' } on columns ' +
    GetSource(ACubeName, AFilters);
end;

function TcxOLAPDataQueryBuilder.CreateFilterAggregates(AFilters: TcxPivotGridFields): string;
var
  I: Integer;
begin
  Result := '';
  for I := AFilters.Count - 1 downto 0 do
    if (I = AFilters.Count - 1) or not IsHierarchy(AFilters[I], AFilters[I + 1]) then
      Result := Result + CreateFilterAggregate(AFilters[I]) + ' ';
end;

function TcxOLAPDataQueryBuilder.CreateFilterAggregate(AField: TcxPivotGridField): string;
begin
  if AField.Area <> faFilter then
    Exit;
  if MultipleFilteredValues(AField) then
  begin
    Result := GetMember(AField, scxOLAPFilterCaption);
    Result := Result + '''aggregate(existing{' + WriteAllMembers(AField, False) + '})'' '
  end;
end;

function TcxOLAPDataQueryBuilder.CreateFilterWhereClause(AFilters: TcxPivotGridFields): string;
var
  I, ACount: Integer;
begin
  Result := '';
  if AFilters.Count = 0 then
    Exit;
  Result := ' where (';
  ACount := 0;
  for I := AFilters.Count - 1 downto 0 do
    if ((I = AFilters.Count - 1) or not IsHierarchy(AFilters[I], AFilters[I + 1])) and
      (AFilters[I].Area = faFilter) then
    begin
      if MultipleFilteredValues(AFilters[I]) then
      begin
        Result := Result + GetMemberName(AFilters[I], scxOLAPFilterCaption) + Comma;
        Inc(ACount);
      end
      else
      begin
        Result := Result + WriteAllMembersCore(AFilters[I], False, False) + Comma;
        Inc(ACount);
      end;
  end;
  if ACount <> 0 then
  begin
    TrimTrailingComma(Result);
    Result := Result + ')';
  end
  else
    Result := '';
end;

function TcxOLAPDataQueryBuilder.CreateTotal(AField: TcxPivotGridField): string;
begin
  Result := 'member ' + GetTotalMember(AField.Link) +
    ' as ''aggregate(' +
    WriteAllMembers(AField, True) +
    ' - {' + GetTotalMember(AField.Link) + '})'' ';
end;

function TcxOLAPDataQueryBuilder.CreateVisualTotals(AFilters: TcxPivotGridFields): string;
var
  I, J, K: Integer;
  AList, ACommonList: TInterfaceList;
begin
  ACommonList := TInterfaceList.Create;
  try
    Result := '';
    K := 0;
    for I := 0 to AFilters.Count - 1 do
    begin
      if (I <> 0) and not IsHierarchy(AFilters[I], AFilters[I - 1]) then
      begin
        Result := Result + GetFilter(ACommonList, K);
        Inc(K);
        ACommonList.Clear;
      end;
      AList := TcxPivotGridOLAPField.PopulateFilteredValues(AFilters[I]);
      try
        for J := 0 to AList.Count - 1 do
          ACommonList.Add(AList[J]);
      finally
        AList.Free;
      end;
    end;
    if AFilters.Count > 0 then
      Result := Result + GetFilter(ACommonList, K);
  finally
    ACommonList.Free;
  end;
end;

function TcxOLAPDataQueryBuilder.FiltersEnabled(AFilters: TcxPivotGridFields): Boolean;
begin
  Result := (AFilters <> nil) and (AFilters.Count > 0);
end;

function TcxOLAPDataQueryBuilder.GetAllTuples(AFields: TcxPivotGridFields;
  ATuples: TList): string;

  procedure PrepareTupleElements(ATupleElements: TStringList; ATuples: TList);
  var
    I, AMaxLevel: Integer;
    AField: TcxPivotGridField;
  begin
    AMaxLevel := 0;
    AField := nil;
    for I := 0 to ATuples.Count - 1 do
    begin
      if (AField = nil) or
        not IsHierarchy(TcxPivotGridGroupItem(ATuples[I]).Field, AField) then
        AMaxLevel := Max(AMaxLevel, TcxPivotGridGroupItem(ATuples[I]).Level);
      AField := TcxPivotGridGroupItem(ATuples[I]).Field;
    end;
    ATupleElements.Capacity := AMaxLevel + 1;
    for I := 0 to AMaxLevel do
      ATupleElements.Add('');
  end;

  procedure FillTupleElementsWithTotals(ATupleElements: TStringList;
    AStartLevel: Integer; AFields: TcxPivotGridFields);
  var
    I: Integer;
  begin
    for I := AStartLevel to ATupleElements.Count - 1 do
      if (I = 0) or not IsHierarchy(AFields[I], AFields[I - 1]) then
        ATupleElements[I] := GetTotalMember(AFields[I].Link);
  end;

  function GetTuple(ATupleElements: TStringList): string;
  var
    I: Integer;
  begin
    Result := '(';
    for I := 0 to ATupleElements.Count - 1 do
      Result := Result + ATupleElements[I] + Comma;
    TrimTrailingComma(Result);
    Result := Result + ')';
  end;

var
  I, ALevel: Integer;
  ATupleElements: TStringList;
begin
  ATupleElements := TStringList.Create;
  try
    PrepareTupleElements(ATupleElements, ATuples);
    FillTupleElementsWithTotals(ATupleElements, 0, AFields);
    Result := '{ ';
    if ATupleElements.Count > 0 then
      Result := Result + GetTuple(ATupleElements) + Comma;
    ALevel := 0;
    for I := 0 to ATuples.Count - 1 do
    begin
      if ALevel > TcxPivotGridGroupItem(ATuples[I]).Level then
        FillTupleElementsWithTotals(ATupleElements,
          TcxPivotGridGroupItem(ATuples[I]).Level + 1, AFields);
      ALevel := TcxPivotGridGroupItem(ATuples[I]).Level;
      if ALevel < ATupleElements.Count then
        ATupleElements[ALevel] := TcxPivotGridGroupItem(ATuples[I]).UniqueName
      else
        ATupleElements[0] := TcxPivotGridGroupItem(ATuples[I]).UniqueName;
      Result := Result + GetTuple(ATupleElements) + Comma;
    end;
    TrimTrailingComma(Result);
    Result := Result + '} ';
  finally
    ATupleElements.Free;
  end;
end;

function TcxOLAPDataQueryBuilder.GetCrossJoinExpand(AField: TcxPivotGridField;
  ATuple: TcxPivotGridGroupItem): string;
begin
  Result := 'crossjoin({' + GetTuple(ATuple) + '}, ' +
    WriteAllMembersWithSorting(AField, False) + ') ';
end;

function TcxOLAPDataQueryBuilder.GetDescendantsCore(AField: TcxPivotGridField;
  ATuple: TcxPivotGridGroupItem): string;

  function GetNames: string;
  begin
    Result := ATuple.UniqueName + Comma +
      (AField.Link.Level as Level).UniqueName;
  end;

var
  AList: TInterfaceList;
begin
  if not AField.Filter.HasFilter then
    Result := 'descendants(' + GetNames + ')'
  else
  begin
    AList := TcxPivotGridOLAPField.PopulateFilteredValues(AField);
    try
      if AList.Count > 0 then
        Result := 'intersect({' + GetMembers(AList) + '}, descendants(' +
          GetNames + '))'
      else
        Result := '{}';
    finally
      AList.Free;
    end;
  end;
end;

function TcxOLAPDataQueryBuilder.GetEverything(AFields: TcxPivotGridFields{;
  AMembers: TList; Expand: Boolean; AnExpandLevel: Integer}): string;
begin
  {if Expand then
  begin
    if AnExpandLevel < 0 then
      AnExpandLevel := AFields.Count - 1;
    Result := GetExpand(AFields[AnExpandLevel + 1], AMembers);
  end
  else
    if (AMembers <> nil) and (AMembers.Count > 0) then
      Result := GetAllTuples(AFields, AMembers)
    else}
      Result := GetFieldMembers(AFields[0]);
end;

function TcxOLAPDataQueryBuilder.GetExpand(AField: TcxPivotGridField;
  ATuples: TList): string;
var
  I: Integer;
begin
  Result := '{ ';
  if IsHierarchy(AField, TcxPivotGridGroupItem(ATuples[0]).Field) then
  begin
    for I := 0 to ATuples.Count - 1 do
      Result := Result + GetHierarchyExpand(AField, ATuples[I]) + Comma;
  end
  else
  begin
    for I := 0 to ATuples.Count - 1 do
      Result := Result + GetCrossJoinExpand(AField, ATuples[I]) + Comma;
  end;
  TrimTrailingComma(Result);
  Result := Result + ' } ';
end;

function TcxOLAPDataQueryBuilder.GetFieldMembers(AField: TcxPivotGridField): string;
begin
  Result := WriteAllMembersWithSorting(AField, True);
end;

function TcxOLAPDataQueryBuilder.GetFilter(AFilter: TInterfaceList;
  AnID: Integer): string;

  function GetAllMember(AFilter: TInterfaceList): string;
  var
    APos: Integer;
  begin
    Result := CorrectMemberName(Member(AFilter[0]).UniqueName);
    APos := Pos('&', Result);
    if APos <> 0 then
    begin
      Delete(Result, APos, Length(Result) - APos + 1);
      Result := Result + '[All], ';
    end
    else
      Result := '';
  end;

begin
  if AFilter.Count > 0 then
    Result := 'set ' + VisualTotalIDPrefix + IntToStr(AnID) +
      ' as ''visualtotals(hierarchize({ '+ GetAllMember(AFilter) +
      GetMembers(AFilter) + ' } ))'' '
  else
    Result := '';
end;

function TcxOLAPDataQueryBuilder.GetHierarchyExpand(AField: TcxPivotGridField;
 ATuple: TcxPivotGridGroupItem): string;
begin
  Result := '{ ' + GetTuple(ATuple, True, 1) + Comma;
  Result := Result + WriteSortedMembers(AField, GetDescendantsCore(AField,
    ATuple)) + ' } ';
end;

function TcxOLAPDataQueryBuilder.GetMemberCount(
  ATuple: TcxPivotGridGroupItem): Integer;
begin
  Result := 0;
  while ATuple.Parent <> nil do
  begin
    ATuple := ATuple.Parent;
    Inc(Result);
  end;
end;

function TcxOLAPDataQueryBuilder.GetMemberName(AField: TcxPivotGridField;
  const AType: string): string;
begin
  Result := (AField.Link.Hierarchy as Hierarchy).UniqueName + '.[' +
    AField.Name + ' ' + AType + ']';
end;

function TcxOLAPDataQueryBuilder.GetMembers(AFilter: TInterfaceList): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to AFilter.Count - 1 do
    Result := Result + CorrectMemberName(Member(AFilter[I]).UniqueName) + Comma;
  TrimTrailingComma(Result);
end;

function TcxOLAPDataQueryBuilder.GetMeasures(AMeasures: TcxPivotGridFields): string;
var
  I: Integer;
begin
  Result := '{ ';
  for I := 0 to AMeasures.Count - 1 do
    Result := Result + (AMeasures[I].Link.Hierarchy as Member).UniqueName + Comma;
  TrimTrailingComma(Result);
  Result := Result + ' } ';
end;

function TcxOLAPDataQueryBuilder.GetMember(AField: TcxPivotGridField; const AType: string): string;
begin
  Result := 'member ' + GetMemberName(AField, AType) + ' as ';
end;

function TcxOLAPDataQueryBuilder.IsHierarchy(AField: TcxPivotGridField;
  AParentField: TcxPivotGridField): Boolean;
begin
  Result := (AField.Group <> nil) and (AParentField.Group = AField.Group);
end;

function TcxOLAPDataQueryBuilder.IsStrongRelationshipBetweenFilterAndDimensions(
  AColumns: TcxPivotGridFields; ARows: TcxPivotGridFields; AFilters: TcxPivotGridFields): Boolean;

  function FindStrongRelationshipMemberInFilter(AField: TcxPivotGridField): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to AFilters.Count - 1 do
     { if IsStrongRelationship(AField, AFilters[I]) then
      begin
        Result := True;
        Exit;
      end;}
  end;

var
  I: Integer;
begin
  Result := GetCountInArea(AFilters, faFilter) > 0;
  Exit;

  Result := False;
  for I := 0 to AColumns.Count - 1 do
    if FindStrongRelationshipMemberInFilter(AColumns[I]) then
    begin
      Result := True;
      Exit;
    end;
  if not Result then
    for I := 0 to ARows.Count - 1 do
      if FindStrongRelationshipMemberInFilter(ARows[I]) then
      begin
        Result := True;
        Exit;
      end;
end;

function TcxOLAPDataQueryBuilder.GetSortOrder(AField: TcxPivotGridField): string;
begin
  if AField.SortOrder = soDescending then
    Result := 'desc'
  else
    Result := 'asc';
end;

function TcxOLAPDataQueryBuilder.GetSource(const ACubeName: string;
  AFilters: TcxPivotGridFields): string;

  function GetCubeName: string;
  begin
    Result := 'from [' + ACubeName + ']'
  end;

var
  I, AxisIndex: Integer;
  AList: TInterfaceList;
begin
  if AFilters.Count > 0 then
  begin
    Result := 'from (select ';
    AxisIndex := 0;
    for I := 0 to AFilters.Count - 1 do
    begin
      if (AFilters[I].Group <> nil) and (I + 1 < AFilters.Count) and
        (AFilters[I].Group = AFilters[I + 1].Group) then
        Continue;
      AList := TcxPivotGridOLAPField.PopulateFilteredValues(AFilters[I], True);
      try
        Result := Result + '{' + GetMembers(AList) + '} on ' + IntToStr(AxisIndex) + Comma;
        Inc(AxisIndex);
      finally
        AList.Free;
      end;
    end;
    TrimTrailingComma(Result);
    Result := Result + ' ' + GetCubeName + ')';
  end
  else
    Result := GetCubeName;
end;

function TcxOLAPDataQueryBuilder.GetTotalMember(AField: TcxPivotGridOLAPField): string;
begin
  Result := (AField.Hierarchy as Hierarchy).UniqueName + '.[' + scxOLAPTotalCaption + ']';
end;

function TcxOLAPDataQueryBuilder.GetTuple(ATuple: TcxPivotGridGroupItem;
  IncludeLastMember: Boolean = True; MembersCount: Integer = 0): string;
var
  I: Integer;
begin
  if ATuple.Parent <> nil then
  begin
    Result := ' )';
    I := 0;
    while (ATuple.Parent <> nil) and ((MembersCount = 0) or (I < MembersCount)) do
    begin
      if IncludeLastMember or (I > 0) then
        Result := Comma + ATuple.UniqueName + Result;
      ATuple := ATuple.Parent;
      Inc(I);
    end;
    Delete(Result, 1, 2);
    Result := '( ' + Result;
  end
  else
    Result := '';
end;

function TcxOLAPDataQueryBuilder.IsFiltered(AField: TcxPivotGridField): Boolean;
var
  I: Integer;
begin
  Result := AField.Filter.HasFilter;
  I := 0;
  while (I < FFilters.Count) and not Result do
  begin
    Result := (AField.Group <> nil) and (FFilters[I].Group = AField.Group) and
      FFilters[I].Filter.HasFilter;
    Inc(I);
  end;
end;

function TcxOLAPDataQueryBuilder.MultipleFilteredValues(AField: TcxPivotGridField): Boolean;
var
  AFilterCount: Integer;
begin
  AFilterCount := TcxPivotGridOLAPField.FilteredValueCount(AField);
  Result := (AFilterCount > 1) or
    (AField.Filter.FilterType = ftExcluded) and (AFilterCount > 0);
end;

function TcxOLAPDataQueryBuilder.WriteAllMembers(AField: TcxPivotGridField;
  IncludeCalculatedMembers: Boolean): string;
begin
  Result := '{ ' +
    WriteAllMembersCore(AField, IncludeCalculatedMembers, False) + '} ';
end;

function TcxOLAPDataQueryBuilder.WriteAllMembersWithSorting(AField: TcxPivotGridField;
  IncludeTotal: Boolean): string;
begin
  Result := '{ ';
  if IncludeTotal then
    Result := Result + GetTotalMember(AField.Link) + Comma;
  //if(column.TopValueCount == 0)
  Result := Result + WriteSortedMembers(AField,
    WriteAllMembersCore(AField, True, IncludeTotal)) + '} ';
end;

function TcxOLAPDataQueryBuilder.WriteAllMembersCore(AField: TcxPivotGridField;
  IncludeCalculatedMembers, ExcludeTotal: Boolean): string;
var
  AList: TInterfaceList;
begin
  Result := '';
  if IsFiltered(AField) then
  begin
    AList := TcxPivotGridOLAPField.PopulateFilteredValues(AField);
    try
      Result := Result + GetMembers(AList);
    finally
      AList.Free;
    end;
  end
  else
  begin
    if IncludeCalculatedMembers then
      Result := Result + 'addcalculatedmembers({';
    Result := Result + (AField.Link.Level as Level).UniqueName + '.members';
    if IncludeCalculatedMembers then
      Result := Result + '})';
    if ExcludeTotal then
      Result := Result + ' - {' + GetTotalMember(AField.Link) + '}';
  end;
end;

function TcxOLAPDataQueryBuilder.WriteSortedMembers(AField: TcxPivotGridField;
  AContent: string): string;
begin
  Result := 'order({' + AContent + '}, ' + GetSortBy(AField.Link) + Comma +
    GetSortOrder(AField) + ')';
end;

function TcxOLAPDataQueryBuilder.CorrectMemberName(const AName: string): string;
var
  APos: Integer;
begin
  Result := AName;
  APos := Pos('''', Result);
  if APos <> 0 then
    Insert('''', Result, APos);
end;

procedure TcxOLAPDataQueryBuilder.TrimTrailingComma(var Str: string);
begin
  Delete(Str, Length(Str) - 1, 2);
end;

function TcxOLAPDataQueryBuilder.GetSortBy(AField: TcxPivotGridOLAPField): string;
begin
  Result := (AField.Hierarchy as Hierarchy).UniqueName;
  case FVersion of
    7, 8: Result := Result + '.currentmember.properties("' + 'caption' + '")';
  else
    Result := Result + '.currentmember.' + 'member_value';
  end;
end;

end.
