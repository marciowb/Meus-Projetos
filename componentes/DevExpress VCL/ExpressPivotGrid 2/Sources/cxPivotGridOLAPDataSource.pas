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

unit cxPivotGridOLAPDataSource;

{$I cxVer.inc}

interface

uses
  Classes, SysUtils, cxClasses, cxCustomPivotGrid, Math, ADODB, cxADOMDInt,
  ActiveX, cxPivotGridOLAPQueryBuilder, Windows, cxCustomData, cxPivotGridStrs;

type

  { TcxPivotGridOLAPDrillDownDataSource }

  TcxPivotGridOLAPDrillDownDataSource = class(TcxPivotGridCrossCellDataSource)
  private
    function IsUniqueNamesEqual(APivotFieldName, ADrillDownName: string;
      var ACoincidenceCount: Integer): Boolean;
  protected
    FDataSet: TADOQuery;
    FDataSetFields: TList;
    FPivotGridFields: TList;
    function GetFieldCount: Integer; override;
    function GetPivotGridField(AIndex: Integer): TcxPivotGridField; override;
    function GetRecordCount: Integer; override;
    function GetValue(ARecordHandle: TcxDataRecordHandle;
      AItemHandle: TcxDataItemHandle): Variant; override;
  public
    destructor Destroy; override;
  end;

  TcxPivotGridAddOLAPStructureItemProc = function(AParent: Pointer; const ACaption: string;
    const ANameIndex, AImageIndex: Integer): Pointer of object;

  { TcxPivotGridOLAPDataSource }

  TcxPivotGridOLAPDataSource = class(TcxPivotGridCustomOLAPDataSource)
  private
    FConnection: TADOConnection;
    FCube: WideString;
    FCells: ICellSet;
    FCubeDefinition: CubeDef;
    FIsCubeNameAssigned: Boolean;
    FTerminated: Boolean;
    FVersion: Integer;
    procedure ExpandedItemWithParentsToList(AnItem: TcxPivotGridGroupItem; AList: TList);
    function GetActive: Boolean;
    function GetCommandText(ACell: TcxPivotGridCrossCell;
      AFieldList: TcxObjectList): string;
    function GetConnectionString: WideString;
    procedure SetActive(AValue: Boolean);
    procedure SetConnectionString(const AValue: WideString);
    procedure SetCube(const AValue: WideString);
  protected
    FCatalog: ICatalog;
    FCubeDef: CubeDef;
    procedure ArrangeGroupsByMembers(AGroups: TList; AAxisIndex, ALevel: Integer);
    procedure AddDimensions(ADimensions: Dimensions);
    procedure AddHierarchyFields(ADimension: Dimension);
    procedure AddMeasuresFields(ADimension: Dimension);
    procedure Clear; override;
    function CreateDrillDownDataSet(ACells: TList; AFieldList: TcxObjectList): TADOQuery;
    function CreateDrillDownDataSource(ACells: TList;
      AFieldList: TcxObjectList): TcxPivotGridCrossCellDataSource; override;
    function CreateInternalField(AList: TcxObjectList; const ADimension: Dimension;
      const AHierarchy: IUnknown; const ALevel: Level; const ADisplayName,
      AUniqueName: WideString): TcxPivotGridOLAPField;
    procedure CreateMembers(AField: TcxPivotGridField; AParents: TList;
      AHasChildren: Boolean); override;
    procedure CreateMembersForExpanding(AField: TcxPivotGridField;
      AHasChildren: Boolean; AMember: TcxPivotGridGroupItem);
    procedure ExecuteQuery(AQuery: WideString);
    procedure ExtractProviderVersion(const AVersion: string);
    procedure ExtractStructure(AddItemProc: TcxPivotGridAddOLAPStructureItemProc; AUniqueNames: TStringList);

//    function FindGroupMember(AGroupItem: TcxPivotGridGroupItem; const AAxisIndex, ALevel: Integer): Boolean;
    function FindMemberParent(APosition: Position; AParents: TList; var AParent: TcxPivotGridGroupItem): Boolean;
    function GetIsActive: Boolean; override;
    function GetIsTerminated: Boolean; override;
    procedure Initialize; override;
    procedure InitializeCrossCells(ARowsGroup, AColumnsGroup: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields); override;
    procedure InitializeCrossCellsForExpanding(ADataBuilder: TcxPivotGridDataBuilder;
      AnExpandingItem, ACrossGroup: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields); override;
    procedure InitializeGrandTotal(ADataBuilder: TcxPivotGridDataBuilder;
      AMember: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);
    procedure InitializeMembersAndTotalsForExpanding(ADataBuilder: TcxPivotGridDataBuilder;
      AField: TcxPivotGridField; AMember: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields); override;
    procedure InitializeMembers(AField: TcxPivotGridOLAPField; AMembers: TcxPivotGridVariantList); override;
    procedure InitializeLayout(ARowFields, AColumnFields, ADataFields, AFilterFields: TcxPivotGridFields); override;
    procedure InitializeTotals(ADimensionFields, ADataFields, AFilterFields: TcxPivotGridFields); override;
    function IsMemberEqualGroup(APosition: Position; ALevel: Integer; AGroup: TcxPivotGridGroupItem): Boolean;
    function IsValueVisible(AFilter: TcxPivotGridFieldFilter; const AValue: WideString): Boolean;
    procedure PopulateFilteredUniqueNames(AField: TcxPivotGridOLAPField;
      AFilter: TcxPivotGridFieldFilter; var AUniqueValues: TStringList); override;
    procedure PopulateFilteredValues(AField: TcxPivotGridOLAPField; AFilter: TcxPivotGridFieldFilter;
      AValues: TInterfaceList; AUniqueValues: TStringList); override;
    procedure ReplaceTotals(ADataBuilder: TcxPivotGridDataBuilder;
      AGroupItem: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields); override;
    procedure TerminateConnection;

    property Catalog: ICatalog read FCatalog;
    property Cells: ICellSet read FCells;
    property CubeDefinition: CubeDef read FCubeDefinition;
    property IsCubeNameAssigned: Boolean read FIsCubeNameAssigned write FIsCubeNameAssigned;
    property Version: Integer read FVersion;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Connection: TADOConnection read FConnection;
  published
    property ConnectionString: WideString read GetConnectionString write SetConnectionString;
    property Active: Boolean read GetActive write SetActive;
    property Cube: WideString read FCube write SetCube stored FIsCubeNameAssigned;
    property OnInitializeField;
  end;

implementation

uses
  Variants, Contnrs, DB, dxCore;

type
  TcxPivotGridGroupItemAccess = class(TcxPivotGridGroupItem);

{ TcxPivotGridOLAPDrillDownDataSource }

destructor TcxPivotGridOLAPDrillDownDataSource.Destroy;
begin
  FreeAndNil(FDataSet);
  FreeAndNil(FDataSetFields);
  FreeAndNil(FPivotGridFields);
  inherited Destroy;
end;

function TcxPivotGridOLAPDrillDownDataSource.GetFieldCount: Integer;
var
  ACoincidenceCount, ACurrentCoincidenceCount, I, J: Integer;
  IsFound: Boolean;
  ADataSetField, APivotGridField: Pointer;
begin

  if FDataSetFields = nil then
  begin
    FDataSetFields := TList.Create;
    FPivotGridFields := TList.Create;
  end
  else
  begin
    FDataSetFields.Clear;
    FPivotGridFields.Clear;
  end;

  Result := 0;
  if HasData and (FDataSet <> nil) and FDataSet.Active then
  begin
    for I := 0 to FDataSet.FieldCount - 1 do
    begin
      IsFound := False;
      ADataSetField := nil;
      APivotGridField := nil;
      ACoincidenceCount := 0;
      J := 0;
      while J < PivotGrid.FieldCount do
      begin
        if IsUniqueNamesEqual(PivotGrid.Fields[J].UniqueName,
          FDataSet.Fields[I].FullName, ACurrentCoincidenceCount) and
          (ACoincidenceCount < ACurrentCoincidenceCount) then
        begin
          IsFound := True;
          ADataSetField := FDataSet.Fields[I];
          APivotGridField := PivotGrid.Fields[J];
        end;
        Inc(J);
      end;
      if IsFound then
      begin
        Inc(Result);
        FDataSetFields.Add(ADataSetField);
        FPivotGridFields.Add(APivotGridField);
      end;
    end;
  end;
end;

function TcxPivotGridOLAPDrillDownDataSource.GetPivotGridField(
  AIndex: Integer): TcxPivotGridField;
begin
  Result := TcxPivotGridField(FPivotGridFields.Items[AIndex]);
end;

function TcxPivotGridOLAPDrillDownDataSource.GetRecordCount: Integer;
begin
  if HasData and (FDataSet <> nil) and FDataSet.Active then
    Result := FDataSet.RecordCount
  else
    Result := 0;
end;

function TcxPivotGridOLAPDrillDownDataSource.GetValue(
  ARecordHandle: TcxDataRecordHandle; AItemHandle: TcxDataItemHandle): Variant;
begin
  if Integer(AItemHandle) < FDataSet.FieldCount then
  begin
    FDataSet.RecNo := Integer(ARecordHandle) + 1;
    Result := TField(FDataSetFields[Integer(AItemHandle)]).AsVariant;
  end;
end;

function TcxPivotGridOLAPDrillDownDataSource.IsUniqueNamesEqual(
  APivotFieldName, ADrillDownName: string;
  var ACoincidenceCount: Integer): Boolean;

  procedure TrimBrackets(var AName: string);
  var
    ALength: Integer;
  begin
    if dxCharInSet(AName[1], ['{', '[', '(']) then
      Delete(AName, 1, 1);
    ALength := Length(AName);
    if dxCharInSet(AName[ALength], ['}', ']', ')']) then
      Delete(AName, ALength, 1);
  end;

var
  APivotPart, ADrillDownPart: string;
  APos: Integer;
begin
  ACoincidenceCount := 0;
  while (APivotFieldName <> '') and (ADrillDownName <> '') do
  begin
    APos := Pos('.', APivotFieldName);
    if APos <> 0 then
    begin
      APivotPart := Copy(APivotFieldName, 0, APos - 1);
      Delete(APivotFieldName, 1, APos);
      TrimBrackets(APivotPart);
      APos := Pos('.', ADrillDownName);
      if APos <> 0 then
      begin
        ADrillDownPart := Copy(ADrillDownName, 0, APos - 1);
        Delete(ADrillDownName, 1, APos);
        if (Pos(APivotPart, ADrillDownPart) <> 0) or
          (Pos('Measures', APivotPart) <> 0) then
          Inc(ACoincidenceCount)
        else
          Dec(ACoincidenceCount);
      end
      else
        Dec(ACoincidenceCount);
    end
    else
    begin
      APivotPart := APivotFieldName;
      APivotFieldName := '';
      TrimBrackets(APivotPart);
      APos := Pos('.', ADrillDownName);
      if (APos = 0) and (Pos(APivotPart, ADrillDownName) <> 0) then
        Inc(ACoincidenceCount)
      else
        Dec(ACoincidenceCount);
    end;
  end;
  Result := ACoincidenceCount > 0;
end;

{ TcxPivotGridOLAPDataSource }

constructor TcxPivotGridOLAPDataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConnection := TADOConnection.Create(Self);
  FConnection.LoginPrompt := False;
  FConnection.KeepConnection := False; 
end;

destructor TcxPivotGridOLAPDataSource.Destroy;
begin
  Active := False;
  FConnection.Free;
  inherited Destroy;
end;

procedure TcxPivotGridOLAPDataSource.ArrangeGroupsByMembers(
  AGroups: TList; AAxisIndex, ALevel: Integer);
var
  AAxis: Axis;
  AItem: TcxPivotGridGroupItem;
  I, J, APos, AItemLevel, AStartLevel: Integer;
begin
  AAxis := nil;
  if AAxisIndex < Cells.Axes.Count then
    AAxis := Cells.Axes[AAxisIndex];
  APos := 0;
  AStartLevel := ALevel;
  for I := 0 to AGroups.Count - 1 do
  begin
    ALevel := AStartLevel;
    AItem := TcxPivotGridGroupItem(AGroups.List^[I]);
    AItem.MemberIndex := -1;
    AItemLevel := Max(0, AItem.Level);
    if (AItemLevel > ALevel) and not AItem.IsHierarchy then
    begin
      if (AItem.Level = -1) and (ALevel = -1) and (AAxis <> nil) then
        AItem.MemberIndex := 0;
      Continue;
    end;
    if APos >= AAxis.Positions.Count then Break;
    for J := APos to AAxis.Positions.Count - 1 do
    begin
      if AItem.IsHierarchy then
        AItemLevel := Min(ALevel, AItem.Level);
      while (ALevel <> AItemLevel) and (ALevel > 0) and
        SameText(AAxis.Positions[J].Members[ALevel].Caption, scxOLAPTotalCaption) do Dec(ALevel);
      if (ALevel = AItemLevel) and IsMemberEqualGroup(AAxis.Positions.Item[J], ALevel, AItem) then
      begin
        APos := J + 1;
        AItem.MemberIndex := J;
        Break;
      end;
    end;
  end;
end;

procedure TcxPivotGridOLAPDataSource.AddDimensions(ADimensions: Dimensions);
var
  I: Integer;
begin
  for I := 0 to ADimensions.Count - 1 do
  begin
    if SameText(ADimensions.Item[I].UniqueName, '[' + scxMeasures + ']') then
      AddMeasuresFields(ADimensions.Item[I])
    else
      AddHierarchyFields(ADimensions.Item[I]);
  end;
end;

procedure TcxPivotGridOLAPDataSource.AddHierarchyFields(ADimension: Dimension);
var
  ALevel: Level;
  AHierarchy: Hierarchy;
  I, J, ACount, AGroupIndex: Integer;
  AField: TcxPivotGridOLAPField;
begin
  for I := 0 to ADimension.Hierarchies.Count - 1 do
  begin
    AHierarchy := ADimension.Hierarchies.Item[I];
    ACount := 0;
    for J := 0 to AHierarchy.Levels.Count - 1 do
      if AHierarchy.Levels[J].Properties.Item['LEVEL_TYPE'].Value <> 1 then
        Inc(ACount);
    AGroupIndex := Min(0, ACount - 2);
    for J := 0 to AHierarchy.Levels.Count - 1 do
    begin
      ALevel := AHierarchy.Levels[J];
      // add items w/o "(ALL)" level, LevelType.Value = 1
      if ALevel.Properties.Item['LEVEL_TYPE'].Value = 1 then Continue;
      AField := CreateInternalField(FFields, ADimension, AHierarchy, ALevel, ALevel.Caption, ALevel.UniqueName);
      AField.GroupName := AHierarchy.UniqueName;
      AField.GroupIndex := AGroupIndex;
      Inc(AGroupIndex);
    end;
    AHierarchy := nil;
  end;
end;

procedure TcxPivotGridOLAPDataSource.AddMeasuresFields(ADimension: Dimension);
var
  I: Integer;
  ALevel: Level;
  AMember: Member;
begin
  ALevel := ADimension.Hierarchies.Item[0].Levels[0];
  for I := 0 to ALevel.Members.Count - 1 do
  begin
    AMember := ALevel.Members.Item[I];
    CreateInternalField(FMeasures, ADimension, AMember, ALevel, AMember.Caption, AMember.UniqueName).GroupIndex := -1;
    AMember := nil;
  end;
end;

procedure TcxPivotGridOLAPDataSource.Clear;
begin
  inherited Clear;
  FCubeDefinition := nil;
  FCells := nil;
  FCatalog := nil;
end;

function TcxPivotGridOLAPDataSource.CreateDrillDownDataSet(
  ACells: TList; AFieldList: TcxObjectList): TADOQuery;
begin
  Result := TADOQuery.Create(Self);
  {if VarIsStr(TcxPivotGridCrossCell(ACells[0]).SummaryCells[0].Sum) and
    (TcxPivotGridCrossCell(ACells[0]).SummaryCells[0].Sum <> '') then}
  if not TcxPivotGridCrossCell(ACells[0]).IsEmpty then
  begin
    Result.SQL.Text := GetCommandText(TcxPivotGridCrossCell(ACells[0]), AFieldList);
    Result.ConnectionString := ConnectionString;
    try
      Result.Open;
    except
    end;
  end;
end;

function TcxPivotGridOLAPDataSource.CreateDrillDownDataSource(
  ACells: TList; AFieldList: TcxObjectList): TcxPivotGridCrossCellDataSource;
begin
  Result := TcxPivotGridOLAPDrillDownDataSource.CreateEx(ACells);
  (Result as TcxPivotGridOLAPDrillDownDataSource).FDataSet :=
    CreateDrillDownDataSet(ACells, AFieldList);
end;

function TcxPivotGridOLAPDataSource.CreateInternalField(AList: TcxObjectList;
  const ADimension: Dimension; const AHierarchy: IUnknown; const ALevel: Level; 
  const ADisplayName, AUniqueName: Widestring): TcxPivotGridOLAPField;
begin
  Result := TcxPivotGridOLAPField.Create;
  Result.DimensionName := ADimension.Name;
  Result.DimensionUniqueName := ADimension.UniqueName;
  if Supports(AHierarchy, Hierarchy) then
  begin
    Result.HierarchyName := (AHierarchy as Hierarchy).Name;
    Result.HierarchyUniqueName := (AHierarchy as Hierarchy).UniqueName;
  end;
  Result.Caption := ADisplayName;
  Result.IsMeasure := AList = FMeasures;
  Result.UniqueName := AUniqueName;
  if not (csDesigning in ComponentState) then
  begin
    Result.Hierarchy := AHierarchy;
    Result.Dimension := ADimension;
    Result.Level := ALevel;
  end;
  AList.Add(Result);
end;

procedure TcxPivotGridOLAPDataSource.CreateMembersForExpanding(
  AField: TcxPivotGridField; AHasChildren: Boolean; AMember: TcxPivotGridGroupItem);

  procedure AddGroupItem(AnOLAPMember: Member; I: Integer);
  var
    AGroupItem: TcxPivotGridGroupItem;
    S: string;
  begin
     AGroupItem := AMember.AddChild(AMember.ItemCount, I, AField);
     S := AnOLAPMember.UniqueName;
     AGroupItem.InitializeValue(AnOLAPMember.Caption, AnOLAPMember.UniqueName);
     AGroupItem.HasChildren := AHasChildren;
  end;

var
  I, AIndex: Integer;
begin
  if AField = nil then Exit;
  AIndex := 0;
  for I := 0 to Cells.Axes[0].Positions.Count - 1 do
    if (I = 0) or (Cells.Axes[0].Positions[I].Members[0].UniqueName <>
      Cells.Axes[0].Positions[I - 1].Members[0].UniqueName) then
  begin
    AddGroupItem(Cells.Axes[0].Positions[I].Members[0], AIndex);
    Inc(AIndex);
  end;
end;

procedure TcxPivotGridOLAPDataSource.CreateMembers(
  AField: TcxPivotGridField; AParents: TList; AHasChildren: Boolean);
var
  AMember: Member;
  APrevMember: WideString;
  APosition: Position;
  ALevel, AxesIndex, ALevelDepth, I, ACount: Integer;
  APrevParent, AParent, AGroupItem: TcxPivotGridGroupItem;

  procedure AddGroupItem;
  begin
     if APrevMember = AMember.UniqueName then Exit;
     AGroupItem := AParent.AddChild(AParent.ItemCount, I - 1, AField);
     AGroupItem.InitializeValue(AMember.Caption, AMember.UniqueName);
     AGroupItem.HasChildren := AHasChildren;
     APrevMember := AMember.UniqueName;
  end;

begin
  if AField = nil then Exit;
  AxesIndex := 0;
  if AField.Area <> faColumn then
    AxesIndex := 1;
  APrevMember := '';
  APrevParent := nil;
  if Cells.State = 0 then Exit;
  I := 0;
  ACount := Cells.Axes[AxesIndex].Positions.Count;
  while I < ACount do
  begin
    APosition := Cells.Axes[AxesIndex].Positions[I];
    Inc(I);
    if not FindMemberParent(APosition, AParents, AParent) then Continue;
    if AParent.IsHierarchy then
    begin
      ALevel := APosition.Members.Count - 1;
     if AField.Area = faColumn then
       Dec(ALevel);
      APrevMember := '';
      ALevelDepth := APosition.Members[ALevel].LevelDepth;
      while I < ACount do
      begin
        repeat
          APosition := Cells.Axes[AxesIndex].Positions[I];
          AMember := APosition.Members[ALevel];
          Inc(I);
        until (I = ACount) or (AField.Area <> faColumn) or (AMember.LevelDepth <> ALevelDepth);
        if AMember.LevelDepth > ALevelDepth then
          AddGroupItem
        else
        begin
          Dec(I);
          Break;
        end;
      end;
    end
    else
    begin
      if AParent <> APrevParent then
        APrevMember := '';
      APrevParent := AParent;
      AMember := APosition.Members[AParent.Level + 1];
      if (AParent.Level <> - 1) or (I <> 1) then
        AddGroupItem
      else
        APrevMember := AMember.UniqueName;
    end;
  end;
end;

procedure TcxPivotGridOLAPDataSource.ExecuteQuery(AQuery: WideString);
begin
  if AQuery = '' then Exit;
  if Cells.State <> 0 then
    Cells.Close;
  Cells.Open(AQuery, Connection.ConnectionObject);
end;

procedure TcxPivotGridOLAPDataSource.ExtractProviderVersion(
  const AVersion: string);
var
  ACode: Integer;
begin
  FVersion := 0;
  if Pos('.', AVersion) > 0 then
  begin
    Val(Copy(AVersion, 1, Pos('.', AVersion) - 1), FVersion, ACode);
    if ACode <> 0 then
      FVersion := 0;
  end;
  if FVersion > 10 then
    EcxPivotGrid.CreateFmt(scxUnsupportedProviderVersion, [FVersion]);
end;

procedure TcxPivotGridOLAPDataSource.ExtractStructure(
  AddItemProc: TcxPivotGridAddOLAPStructureItemProc; AUniqueNames: TStringList);
var
  I: Integer;
  AGroup, AParent, AHierarchy: Pointer;
  APrevDimensionName, APrevDimensionUniqueName: WideString;
begin
  if (FFields.Count + FMeasures.Count = 0) then Exit;
//  AParent := AddItemProc(nil, FCube, AUniqueNames.Add(FCube), -1);
  AParent := nil;
  AGroup := AddItemProc(AParent, scxMeasures, AUniqueNames.Add(FCube), 0);
  for I := 0 to FMeasures.Count - 1 do
    with Measures[I] do
      AddItemProc(AGroup, Caption, AUniqueNames.Add(UniqueName), 0);
  APrevDimensionUniqueName := '';
  I := 0;
  AHierarchy := nil;
  while I < FFields.Count do
  begin
    if APrevDimensionUniqueName <> Fields[I].DimensionUniqueName then
    begin
      APrevDimensionName := Fields[I].DimensionName;
      APrevDimensionUniqueName := Fields[I].DimensionUniqueName;
      AGroup := AddItemProc(AParent, APrevDimensionName,
        AUniqueNames.Add(APrevDimensionUniqueName), 1);
    end;
    if Fields[I].GroupIndex = 0 then
      AHierarchy := AddItemProc(AGroup, Fields[I].HierarchyName,
        AUniqueNames.Add(Fields[I].HierarchyUniqueName), 3)
    else
      if Fields[I].GroupIndex < 0 then
        AHierarchy := AGroup;
    AddItemProc(AHierarchy, Fields[I].Caption, AUniqueNames.Add(Fields[I].UniqueName), 2);
    Inc(I);
  end;
  APrevDimensionUniqueName := '';
end;

function TcxPivotGridOLAPDataSource.FindMemberParent(
  APosition: Position; AParents: TList; var AParent: TcxPivotGridGroupItem): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to AParents.Count - 1 do
  begin
    AParent := TcxPivotGridGroupItem(AParents[I]);
    Result := IsMemberEqualGroup(APosition, AParent.Level, AParent);
    if Result then Break; 
  end;
end;

function TcxPivotGridOLAPDataSource.GetIsActive: Boolean;
begin
  Result := (FConnection.Connected or FTerminated) and inherited GetIsActive;
end;

function TcxPivotGridOLAPDataSource.GetIsTerminated: Boolean;
begin
  Result := FTerminated;
end;

procedure TcxPivotGridOLAPDataSource.Initialize;
var
  I: Integer;
begin
  inherited Initialize;
  ExtractProviderVersion(VarToStr(Connection.Properties.Item['Provider Version'].Value));
  FCatalog := CoCatalog.Create();
  FCatalog._Set_ActiveConnection(Connection.ConnectionObject);
  if not IsCubeNameAssigned then
    FCube := '';  
  for I := 0 to Catalog.CubeDefs.Count - 1 do
  begin
    FCubeDefinition := Catalog.CubeDefs[I] as CubeDef;
    if ((Cube = '') and (Catalog.CubeDefs.Count = 1)) or (FCubeDefinition.Name = Cube) then
    begin
      FCells := CoCellset.Create();
      FCells._Set_ActiveConnection(Connection.ConnectionObject);
      FCube := FCubeDefinition.Name;
      AddDimensions(CubeDefinition.Dimensions);
      Break;
    end
    else
      FCubeDefinition := nil;
  end;
  if CubeDefinition = nil then
  begin
    Active := False; 
    raise EcxPivotGrid.Create(scxInvalidProviderVersion);
  end
  else
    if csDesigning in ComponentState then
      TerminateConnection;
end;

procedure TcxPivotGridOLAPDataSource.InitializeCrossCells(
  ARowsGroup, AColumnsGroup: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);

  function IsDataValid: Boolean;
  begin
    Result := (ADataFields.Count <> 0) and (Cells.Axes.Count <> 0) and 
      (Cells.Axes[0].Positions.Count > 0);
    if Result and (Cells.Axes.Count = 2) then
      Result := (Cells.Axes[1].Positions.Count > 0)
  end;

var
  APosition, AValues, ANativeValues: Variant;
  ARows, AColumns: TList;
  APositions: Positions;
  AColumn, ARow: TcxPivotGridGroupItem;
  I, J, AValueIndex, ALevel, ARowLevel, AIndex: Integer;
  AIsValuesInitialized: Boolean;
begin
  if not IsDataValid then Exit;
  ARows := CreateMembersFromGroup(ARowsGroup);
  try
    AColumns := CreateMembersFromGroup(AColumnsGroup);
    try
      ALevel := -1;
      ARowLevel := -1;
      if Cells.Axes[0].Positions.Count > 0 then
        ALevel := Cells.Axes[0].Positions.Item[0].Members.Count - 2;
      if Cells.Axes.Count > 1 then
        ARowLevel := Cells.Axes[1].Positions.Item[0].Members.Count - 1;
      AValues := VarArrayCreate([0, ADataFields.Count - 1], varVariant);
      ANativeValues := VarArrayCreate([0, ADataFields.Count - 1], varVariant);
      APosition := VarArrayCreate([0, Cells.Axes.Count - 1], varVariant);
      //
      ArrangeGroupsByMembers(ARows, 1, ARowLevel);
      ArrangeGroupsByMembers(AColumns, 0, ALevel);
      //
      APositions := Cells.Axes[0].Positions;
      for I := 0 to AColumns.Count - 1 do
      begin
        AColumn := TcxPivotGridGroupItem(AColumns.List^[I]);
        if AColumn.MemberIndex = - 1 then Continue;
        for J := 0 to ARows.Count - 1 do
        begin
          ARow := TcxPivotGridGroupItem(ARows.List^[J]);
          if ARow.MemberIndex >= 0 then
            APosition[1] := ARow.MemberIndex
          else
            if ARowLevel >= 0 then Continue;
          AIndex := AColumn.MemberIndex;
          AIsValuesInitialized := False;
          for AValueIndex := 0 to ADataFields.Count - 1 do
          begin
            AValues[AValueIndex] := Null;
            ANativeValues[AValueIndex] := Null;
            if (AIndex >= APositions.Count) or not SameText(
              ADataFields[AValueIndex].Link.Caption, APositions[AIndex].Members[ALevel + 1].Caption) then Continue;
            APosition[0] := AIndex;
            AValues[AValueIndex] := Cells.Item[PSafeArray(TVarData(APosition).VArray)].FormattedValue;
            ANativeValues[AValueIndex] := Cells.Item[PSafeArray(TVarData(APosition).VArray)].Value;
            if VarIsEmpty(AValues[AValueIndex]) then
              AValues[AValueIndex] := Null
            else
              AIsValuesInitialized := True;
            Inc(AIndex);
          end;
          if AIsValuesInitialized then
            InitializeCrossCellValues(ARow.GetCellByCrossItem(AColumn), AValues, ANativeValues)
          else
            InitializeCrossCellValues(ARow.GetCellByCrossItem(AColumn), Null, Null);
        end;
      end;
    finally
      AColumns.Free;
    end;
  finally
    ARows.Free;
  end;
end;

procedure TcxPivotGridOLAPDataSource.InitializeCrossCellsForExpanding(
  ADataBuilder: TcxPivotGridDataBuilder; AnExpandingItem,
  ACrossGroup: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);

  procedure FillCrossCellsForExpandedItem(AnItem: TcxPivotGridGroupItem);
  var
    APosition, ANativeValues, AValue, ANativeValue: Variant;

    procedure ResetNativeValues;
    var
      I: Integer;
    begin
      for I := 0 to ADataFields.Count - 1 do
        ANativeValues[I] := Null;
    end;

    procedure SecondLevelProcessing(AFirstItem, ASecondItem: TcxPivotGridGroupItem;
      APositionIndex, AFirstItemChildIndex: Integer);
    var
      ASecondItemChildIndex, ADataFieldIndex, I: Integer;
      ASecondLevelName: string;
    begin
      ASecondLevelName := Cells.Axes[0].Positions[APositionIndex].Members[1].UniqueName;
      ASecondItemChildIndex := 0;
      while ASecondItemChildIndex < ASecondItem.ItemCount do
      begin
        if CompareStr(ASecondLevelName, ASecondItem.Items[ASecondItemChildIndex].UniqueName) = 0 then
        begin
          ADataFieldIndex := 0;
          for I := 0 to ADataFields.Count - 1 do
          begin
            ADataFieldIndex := I;
            AValue := Null;
            ANativeValue := Null;
            if (Cells.Axes[0].Positions[APositionIndex].Members[
              Cells.Axes[0].Positions[APositionIndex].Members.Count - 1].UniqueName =
              ADataFields[ADataFieldIndex].UniqueName) then
            begin
              APosition[0] := APositionIndex;
              AValue := Cells.Item[PSafeArray(TVarData(APosition).VArray)].FormattedValue;
              ANativeValue := Cells.Item[PSafeArray(TVarData(APosition).VArray)].Value;
              if VarIsEmpty(AValue) then
                AValue := Null;
              Break;
            end;
          end;

          InitializeCrossCellValue(
            AFirstItem.Items[AFirstItemChildIndex].GetCellByCrossItem(
            ASecondItem.Items[ASecondItemChildIndex]), AValue, ANativeValue, ANativeValues, ADataFieldIndex);
          Break;
        end;
        Inc(ASecondItemChildIndex);
      end;
    end;

  var
    AFirstItemChildIndex, APositionIndex, I: Integer;
    AFirstItem, ASecondItem: TcxPivotGridGroupItem;
    AFirstLevelName: string;

    function CompareWithFirstMember(AnItem: TcxPivotGridGroupItem): Boolean;
    begin
      Result := CompareStr(AFirstLevelName, AnItem.UniqueName) = 0;
    end;

  begin
    ANativeValues := VarArrayCreate([0, ADataFields.Count - 1], varVariant);
    APosition := VarArrayCreate([0, 0], varVariant);
    ResetNativeValues;

    if IsNotLastVisibleOLAPHierarchyItem(AnExpandingItem) and not
      IsNotLastVisibleOLAPHierarchyItem(AnItem) then
    begin
      AFirstItem := AnItem;
      ASecondItem := AnExpandingItem;
    end
    else
    begin
      AFirstItem := AnExpandingItem;
      ASecondItem := AnItem;
    end;

    AFirstItemChildIndex := 0;
    for APositionIndex := 0 to Cells.Axes[0].Positions.Count - 1 do
    begin
      AFirstLevelName := Cells.Axes[0].Positions[APositionIndex].Members[0].UniqueName;
      if CompareWithFirstMember(AFirstItem.Items[AFirstItemChildIndex]) then
        SecondLevelProcessing(AFirstItem, ASecondItem, APositionIndex, AFirstItemChildIndex)
      else
      begin
        Inc(AFirstItemChildIndex);
        if (AFirstItemChildIndex < AFirstItem.ItemCount) and
          CompareWithFirstMember(AFirstItem.Items[AFirstItemChildIndex]) then
          SecondLevelProcessing(AFirstItem, ASecondItem, APositionIndex, AFirstItemChildIndex)
        else
          for I := 0 to AFirstItem.ItemCount - 1 do
          begin
            AFirstItemChildIndex := I;
            if CompareWithFirstMember(AFirstItem.Items[AFirstItemChildIndex]) then
            begin
              SecondLevelProcessing(AFirstItem, ASecondItem, APositionIndex, AFirstItemChildIndex);
              Break;
            end;
          end;
      end;
    end;
  end;

  function GetNonExpandedFields(AnItem: TcxPivotGridGroupItem): TcxPivotGridFields;
  begin
    Result := TcxPivotGridFields.Create;
    if not IsNotLastVisibleOLAPHierarchyItem(AnExpandingItem) then
      Result.Add(AnExpandingItem.Items[0].Field);
    if not IsNotLastVisibleOLAPHierarchyItem(AnItem) then
      Result.Add(AnItem.Items[0].Field);
  end;

  procedure InitializeCrossCellsForExpandedItem(AnItem: TcxPivotGridGroupItem);
  var
    I: Integer;
    AnExpandedItems: TList;
    AFields: TcxPivotGridFields;
  begin
    AnExpandedItems := TList.Create;
    try
      ExpandedItemWithParentsToList(AnExpandingItem, AnExpandedItems);
      ExpandedItemWithParentsToList(AnItem, AnExpandedItems);
      AFields := GetNonExpandedFields(AnItem);
      try
        with TcxOLAPDataQueryBuilder.Create(Version) do
        try
          ExecuteQuery(GetExpandQueryString(CubeDefinition.Name, AnExpandedItems,
            AFields, ADataFields, ADataBuilder.FilteredFields));
          FillCrossCellsForExpandedItem(AnItem);
        finally
          Free;
        end;
      finally
        AFields.Free;
      end;
    finally
      AnExpandedItems.Free;
    end;

    for I := 0 to AnItem.ItemCount - 1 do
    begin
      TcxPivotGridGroupItemAccess(AnItem.Items[I]).CheckExpanding;
      if AnItem.Items[I].Expanded then
        InitializeCrossCellsForExpandedItem(AnItem.Items[I]);
    end;
  end;

begin
  if (AnExpandingItem.ItemCount > 0) and (ACrossGroup.ItemCount > 0) then
    InitializeCrossCellsForExpandedItem(ACrossGroup);
end;

procedure TcxPivotGridOLAPDataSource.InitializeGrandTotal(
  ADataBuilder: TcxPivotGridDataBuilder; AMember: TcxPivotGridGroupItem;
  ADataFields: TcxPivotGridFields);
var
  APositionIndex, AnItemChildIndex, ADataFieldIndex: Integer;
  APosition, AValues, ANativeValues: Variant;
  AreDataFieldsEmpty: Boolean;
  ARow, AColumn: TcxPivotGridGroupItem;
begin
  AValues := VarArrayCreate([0, ADataFields.Count - 1], varVariant);
  ANativeValues := VarArrayCreate([0, ADataFields.Count - 1], varVariant);
  APosition := VarArrayCreate([0, 0], varVariant);

  if TcxPivotGridGroupItemAccess(AMember).IsRow then
  begin
    AColumn := ADataBuilder.Columns;
    ARow := nil;
  end
  else
  begin
    AColumn := nil;
    ARow := ADataBuilder.Rows;
  end;

  APositionIndex := 0;
  for AnItemChildIndex := 0 to AMember.ItemCount - 1 do
    if (APositionIndex < Cells.Axes[0].Positions.Count) and
      (Cells.Axes[0].Positions[APositionIndex].Members[0].UniqueName =
      AMember.Items[AnItemChildIndex].UniqueName) then
    begin
      AreDataFieldsEmpty := True;
      for ADataFieldIndex := 0 to ADataFields.Count - 1 do
      begin
        AValues[ADataFieldIndex] := Null;
        ANativeValues[ADataFieldIndex] := Null;
        if (APositionIndex < Cells.Axes[0].Positions.Count) and
          (Cells.Axes[0].Positions[APositionIndex].Members[
          Cells.Axes[0].Positions[APositionIndex].Members.Count - 1].UniqueName =
          ADataFields[ADataFieldIndex].UniqueName) then
        begin
          APosition[0] := APositionIndex;
          AValues[ADataFieldIndex] := Cells.Item[PSafeArray(TVarData(APosition).VArray)].FormattedValue;
          ANativeValues[ADataFieldIndex] := Cells.Item[PSafeArray(TVarData(APosition).VArray)].Value;
          Inc(APositionIndex);
        end;
        if VarIsEmpty(AValues[ADataFieldIndex]) then
          AValues[ADataFieldIndex] := Null
        else
          AreDataFieldsEmpty := False;
      end;

      if TcxPivotGridGroupItemAccess(AMember).IsRow then
        ARow := AMember.Items[AnItemChildIndex]
      else
        AColumn := AMember.Items[AnItemChildIndex];
      if not AreDataFieldsEmpty then
        InitializeCrossCellValues(ARow.GetCellByCrossItem(AColumn), AValues, ANativeValues)
      else
        InitializeCrossCellValues(ARow.GetCellByCrossItem(AColumn), Null, Null);
    end;
end;

procedure TcxPivotGridOLAPDataSource.InitializeMembersAndTotalsForExpanding(
  ADataBuilder: TcxPivotGridDataBuilder; AField: TcxPivotGridField;
  AMember: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);
var
  AHasChildren: Boolean;
  AMembers: TList;
  AFields: TcxPivotGridFields;
begin
  if AMember.UniqueName = '' then Exit;
  with TcxOLAPDataQueryBuilder.Create(Version) do
  try
    AMembers := TList.Create;
    try
      ExpandedItemWithParentsToList(AMember, AMembers);
      AFields := TcxPivotGridFields.Create;
      try
        if not IsNotLastVisibleOLAPHierarchyItem(AMember) then
          if TcxPivotGridGroupItemAccess(AMember).IsRow then
            AFields.Add(ADataBuilder.RowFields[AMember.Level + 1])
          else
            AFields.Add(ADataBuilder.ColumnFields[AMember.Level + 1]);
        ExecuteQuery(GetExpandQueryString(CubeDefinition.Name,
          AMembers, AFields, ADataFields, ADataBuilder.FilteredFields));
      finally
        AFields.Free;
      end;
    finally
      AMembers.Free;
    end;

    AHasChildren := (AField.Area = faColumn) and (AField.VisibleIndex < (ADataBuilder.ColumnFields.Count - 1))
      or (AField.Area = faRow) and (AField.VisibleIndex < (ADataBuilder.RowFields.Count - 1));
    CreateMembersForExpanding(AField, AHasChildren, AMember);

    InitializeGrandTotal(ADataBuilder, AMember, ADataFields);
  finally
    Free;
  end;
end;

procedure TcxPivotGridOLAPDataSource.InitializeMembers(
  AField: TcxPivotGridOLAPField; AMembers: TcxPivotGridVariantList);
var
  AIndex: Integer;
  ALevel: Level;
begin
  if AField = nil then Exit;
  ALevel := AField.Level as Level;
  for AIndex := 0 to ALevel.Members.Count - 1 do
    AMembers.Add(ALevel.Members.Item[AIndex].Caption);
end;

procedure TcxPivotGridOLAPDataSource.InitializeLayout(
  ARowFields, AColumnFields, ADataFields, AFilterFields: TcxPivotGridFields);
begin
  with TcxOLAPDataQueryBuilder.Create(Version) do
  try
    ExecuteQuery(GetQueryString(CubeDefinition.Name, AColumnFields,
      ARowFields, ADataFields, AFilterFields));
  finally
    Free;
  end;
end;

procedure TcxPivotGridOLAPDataSource.InitializeTotals(ADimensionFields, ADataFields,
  AFilterFields: TcxPivotGridFields); 
begin
  with TcxOLAPDataQueryBuilder.Create(Version) do
  try
    ExecuteQuery(GetTotalsQueryString(CubeDefinition.Name, ADimensionFields,
      ADataFields, AFilterFields));
  finally
    Free;
  end;
end;

function TcxPivotGridOLAPDataSource.IsMemberEqualGroup(
  APosition: Position; ALevel: Integer; AGroup: TcxPivotGridGroupItem): Boolean;
begin
  if AGroup.IsHierarchy then
    ALevel := Min(ALevel, APosition.Members.Count - 1 - Byte(AGroup.Field.Area = faColumn));
  Result :=  (AGroup.UniqueName = '') and ((ALevel < 0) or
    ((ALevel = 0) and SameText(APosition.Members[ALevel].Caption, scxOLAPTotalCaption)));
  if Result then Exit;
  Result := False;
  while (ALevel >= 0) and (AGroup <> nil) do
  begin
    if APosition.Members[ALevel].UniqueName <> AGroup.UniqueName then Exit;
    Dec(ALevel);
    AGroup := AGroup.Parent;
  end;
  Result := True;
end;

function TcxPivotGridOLAPDataSource.IsValueVisible(
  AFilter: TcxPivotGridFieldFilter; const AValue: WideString): Boolean;
begin
  Result := not AFilter.HasFilter or AFilter.Contains(AValue);
end;

procedure TcxPivotGridOLAPDataSource.PopulateFilteredUniqueNames(AField: TcxPivotGridOLAPField;
  AFilter: TcxPivotGridFieldFilter; var AUniqueValues: TStringList);

  function ExtractPreviousUniqueName(const AUniqueName: string): string;
  var
    C: Integer;
  begin
    Result := AUniqueName;
    C := Length(AUniqueName);
    while Result[C] <> '.' do Dec(C);
    SetLength(Result, C - 1);
  end;

var
  AIndex: Integer;
  ALevel: Level;
  AMember: Member;
  AValues: TStringList;
begin
  if not AFilter.HasFilter and (AUniqueValues = nil) then Exit;
  ALevel := AField.Level as Level;
  if AUniqueValues <> nil then
    AUniqueValues.Sort;
  AValues := TStringList.Create;
  try
    for AIndex := 0 to ALevel.Members.Count - 1 do
    begin
      AMember := ALevel.Members.Item[AIndex];
      if IsValueVisible(AFilter, AMember.Caption) and
        ((AUniqueValues = nil) or (AUniqueValues.IndexOf(AMember.UniqueName) <> -1)) then
        AValues.Add(ExtractPreviousUniqueName(AMember.UniqueName));
      AMember := nil;
    end;
    FreeAndNil(AUniqueValues);
  finally
    AUniqueValues := AValues;
  end;
end;

procedure TcxPivotGridOLAPDataSource.PopulateFilteredValues(
  AField: TcxPivotGridOLAPField; AFilter: TcxPivotGridFieldFilter;
  AValues: TInterfaceList; AUniqueValues: TStringList);
var
  AIndex: Integer;
  ALevel: Level;
  AMember: Member;
begin
  ALevel := AField.Level as Level;
  if AUniqueValues <> nil then
    AUniqueValues.Sort;
  for AIndex := 0 to ALevel.Members.Count - 1 do
  begin
    AMember := ALevel.Members.Item[AIndex];
    if IsValueVisible(AFilter, AMember.Caption) and
      ((AUniqueValues = nil) or (AUniqueValues.IndexOf(AMember.UniqueName) <> -1)) then
      AValues.Add(AMember);
    AMember := nil;
  end;
end;

procedure TcxPivotGridOLAPDataSource.ReplaceTotals(ADataBuilder: TcxPivotGridDataBuilder;
  AGroupItem: TcxPivotGridGroupItem; ADataFields: TcxPivotGridFields);
var
  APositionIndex, AIndex, ADataFieldIndex, ACount: Integer;
  APosition, AValues, ANativeValues: Variant;
  AreDataFieldsEmpty: Boolean;
  ARow, AColumn: TcxPivotGridGroupItem;
begin
  AValues := VarArrayCreate([0, ADataFields.Count - 1], varVariant);
  ANativeValues := VarArrayCreate([0, ADataFields.Count - 1], varVariant);
  APosition := VarArrayCreate([0, 0], varVariant);

  APositionIndex := 0;
  if AGroupItem = nil then
    ACount := 1
  else
    ACount := AGroupItem.ItemCount;
  for AIndex := 0 to ACount - 1 do
  begin
    AreDataFieldsEmpty := True;
    if (AGroupItem = nil) or (APositionIndex < Cells.Axes[0].Positions.Count) and
      (Cells.Axes[0].Positions[APositionIndex].Members[0].UniqueName =
      AGroupItem.Items[AIndex].UniqueName) then
    begin
      for ADataFieldIndex := 0 to ADataFields.Count - 1 do
      begin
        AValues[ADataFieldIndex] := Null;
        ANativeValues[ADataFieldIndex] := Null;
        if (APositionIndex < Cells.Axes[0].Positions.Count) and
          (Cells.Axes[0].Positions[APositionIndex].Members[
          Cells.Axes[0].Positions[APositionIndex].Members.Count - 1].UniqueName =
          ADataFields[ADataFieldIndex].UniqueName) then
        begin
          APosition[0] := APositionIndex;
          AValues[ADataFieldIndex] := Cells.Item[PSafeArray(TVarData(APosition).VArray)].FormattedValue;
          ANativeValues[ADataFieldIndex] := Cells.Item[PSafeArray(TVarData(APosition).VArray)].Value;
          Inc(APositionIndex);
        end;
        if VarIsEmpty(AValues[ADataFieldIndex]) then
          AValues[ADataFieldIndex] := Null
        else
          AreDataFieldsEmpty := False;
      end;
    end;

    if AGroupItem = nil then
    begin
      AColumn := ADataBuilder.Columns;
      ARow := ADataBuilder.Rows;
    end
    else
      if TcxPivotGridGroupItemAccess(AGroupItem).IsRow then
      begin
        AColumn := ADataBuilder.Columns;
        ARow := AGroupItem.Items[AIndex];
      end
      else
      begin
        AColumn := AGroupItem.Items[AIndex];
        ARow := ADataBuilder.Rows;
      end;

    if not AreDataFieldsEmpty then
      InitializeCrossCellValues(AColumn.GetCellByCrossItem(ARow), AValues, ANativeValues)
    else
      ZeroCrossCellValues(ARow.GetCellByCrossItem(AColumn));
  end;
end;

procedure TcxPivotGridOLAPDataSource.TerminateConnection;
begin
  if Connection = nil then Exit;
  FTerminated := Connection.Connected;
  if FTerminated then
  begin
    FCubeDefinition := nil;
    if FCatalog <> nil then
    begin
      FCatalog._Set_ActiveConnection(nil);
      FCatalog := nil;
    end;
    Connection.Close;
    Connection.ConnectionObject := nil;
  end;
end;

procedure TcxPivotGridOLAPDataSource.ExpandedItemWithParentsToList(
  AnItem: TcxPivotGridGroupItem; AList: TList);
var
  APreviousItem: TcxPivotGridGroupItem;
begin
  APreviousItem := nil;
  while AnItem.UniqueName <> '' do
  begin
    if (APreviousItem = nil) or
      (APreviousItem.Field.Group <> AnItem.Field.Group) then
      AList.Add(AnItem);
    APreviousItem := AnItem;
    AnItem := AnItem.Parent;
  end;
end;

function TcxPivotGridOLAPDataSource.GetActive: Boolean;
begin
  Result := IsActive;
end;

function TcxPivotGridOLAPDataSource.GetCommandText(ACell: TcxPivotGridCrossCell;
  AFieldList: TcxObjectList): string;

  function ReturnDefaultFields: Boolean;
  const
    DataSourceStr = ';Data Source=';
  var
    AConnectionString: string;
    APos: Integer;
  begin
    Result := False;
    AConnectionString := ConnectionString;
    APos := Pos(DataSourceStr, AConnectionString);
    if APos <> 0 then
    begin
      Delete(AConnectionString, 1, APos + Length(DataSourceStr) - 1);
      APos := Pos(';', AConnectionString);
      if APos <> 0 then
        AConnectionString := Copy(AConnectionString, 1, APos);
      Result := (Pos(':\', AConnectionString) <> 0) or
        (Pos('\\', AConnectionString) <> 0);
    end;
  end;

begin
  with TcxOLAPDataQueryBuilder.Create(Version) do
  try
    Result := GetDrillDownQueryString(CubeDefinition.Name, ACell, AFieldList,
      ReturnDefaultFields);
  finally
    Free;
  end;
end;

function TcxPivotGridOLAPDataSource.GetConnectionString: WideString;
begin
  Result := FConnection.ConnectionString;
end;

procedure TcxPivotGridOLAPDataSource.SetActive(AValue: Boolean);
begin
  if ConnectionString = '' then Exit;
  try
    try
      if not AValue then
      begin
        TerminateConnection;
        FTerminated := False;
      end;
      FConnection.Connected := AValue;
    except
      AValue := False;
      raise;
    end;
  finally
    inherited Active := AValue;
  end;
end;

procedure TcxPivotGridOLAPDataSource.SetConnectionString(const AValue: WideString);
begin
  Active := False;
  FConnection.ConnectionString := AValue;
end;

procedure TcxPivotGridOLAPDataSource.SetCube(const AValue: WideString);
begin
  FCube := AValue;
  if Active then
    Changed;
  FIsCubeNameAssigned := FCube <> '';
end;

end.


