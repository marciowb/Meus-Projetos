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

unit cxGridReg;

{$I cxVer.inc}
{$DEFINE CHARTVIEW}

interface

const
  cxGridProductName  = 'ExpressQuantumGrid Suite';
  cxGridMajorVersion = '5';
  cxGridVersion = '5.54';

procedure Register;

implementation

uses
  Windows,
  DesignEditors, DesignIntf, DesignMenus, VCLEditors, Types,
{$IFNDEF NONDB}
  DB, cxDBData, cxDBExtLookupComboBox, cxGridDBBandedTableView,
  cxGridDBCardView, cxGridDBDataDefinitions, cxGridDBTableView,
{$IFDEF CHARTVIEW}
  cxGridDBChartView,
{$ENDIF}
{$ENDIF}
  cxGridImportDialog,
  Classes, Controls, ExtCtrls, Graphics, Menus, SysUtils, TypInfo,
  dxCore, cxControls, cxCustomData, cxDataStorage, cxEdit, cxEditPropEditors,
  cxEditRepositoryEditor, cxEditRepositoryItems, cxGrid, cxGridBandedTableView,
  cxGridCardView, cxGridCommon, cxGridCustomTableView, cxGridCustomView,
  cxGridEditor, cxGridLevel, cxGridStrs, cxGridStructureNavigator,
  cxGridTableView, cxImageComboBox, cxImageComboBoxItemsEditor, dxCoreReg, cxLibraryReg,
  cxPropEditors, cxStyles, cxBandedTableViewEditor, cxCardViewEditor,
{$IFDEF CHARTVIEW}
  cxGridChartView, cxChartViewEditor,
{$ENDIF}
  cxGridPredefinedStyles, cxGridStyleSheetsPreview;

const
  UnitNamePrefix = '';

  GridEditorVerbs: array [0..4] of string = (
    'Editor...',
    'Import...',
    '-',
    cxGridProductName + ' ' + cxGridVersion,
    dxCompanyURL
  );

type
  TcxCustomGridViewAccess = class(TcxCustomGridView);

{ TGridEditor }

type
  TGridEditor = class(TComponentEditor)
  private
  {$IFNDEF NONDB}
    FDataSourceNames: TStringList;
    function GetDataSource: TDataSource;
  {$ENDIF}
    function GetGrid: TcxCustomGrid;
  {$IFNDEF NONDB}
    function GetGridView: TcxCustomGridView;
    procedure DataSourceClick(Sender: TObject);
    procedure GetDataSourceName(const S: string);
  {$ENDIF}
  protected
  {$IFNDEF NONDB}
    function CanLinkToDataSource: Boolean;
    procedure GetDataSourceNames;
    function IsSingleDataSource: Boolean;
    procedure LinkToDataSource(AIndex: Integer);
  {$ENDIF}

  {$IFNDEF NONDB}
    property DataSource: TDataSource read GetDataSource;
    property GridView: TcxCustomGridView read GetGridView;
  {$ENDIF}
    property Grid: TcxCustomGrid read GetGrid;
  public
  {$IFNDEF NONDB}
    destructor Destroy; override;
  {$ENDIF}
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  {$IFNDEF NONDB}
    procedure PrepareItem(Index: Integer;
      const AItem: {$IFDEF DELPHI6}DesignMenus.IMenuItem{$ELSE}TMenuItem{$ENDIF}); override;
  {$ENDIF}
  end;

{$IFNDEF NONDB}
destructor TGridEditor.Destroy;
begin
  FDataSourceNames.Free;
  inherited;
end;

function TGridEditor.GetDataSource: TDataSource;
begin
  Result := TcxDBDataController(GridView.DataController).DataSource;
end;
{$ENDIF}

function TGridEditor.GetGrid: TcxCustomGrid;
begin
  Result := TcxCustomGrid(Component);
end;

{$IFNDEF NONDB}

function TGridEditor.GetGridView: TcxCustomGridView;
begin
  with Grid do
    if (Levels.Count = 1) and (Levels[0].GridView <> nil) and
      (Levels[0].GridView.DataController is TcxDBDataController) then
      Result := Levels[0].GridView
    else
      Result := nil;
end;

procedure TGridEditor.DataSourceClick(Sender: TObject);
begin
  LinkToDataSource((Sender as TMenuItem).MenuIndex);
end;

procedure TGridEditor.GetDataSourceName(const S: string);
begin
  FDataSourceNames.Add(S);
end;

function TGridEditor.CanLinkToDataSource: Boolean;
begin
  Result := (FDataSourceNames.Count <> 0) and (GridView <> nil);
end;

procedure TGridEditor.GetDataSourceNames;
begin
  if FDataSourceNames = nil then
    FDataSourceNames := TStringList.Create
  else
    FDataSourceNames.Clear;
  Designer.GetComponentNames(GetTypeData(TypeInfo(TDataSource)), GetDataSourceName);
  FDataSourceNames.Sort;
end;

function TGridEditor.IsSingleDataSource: Boolean;
begin
  Result := FDataSourceNames.Count = 1;
end;

procedure TGridEditor.LinkToDataSource(AIndex: Integer);
var
  ADataSource: TDataSource;
begin
  ADataSource := TDataSource(Designer.GetComponent(FDataSourceNames[AIndex]));
  if GridView is TcxCustomGridTableView then
    TcxCustomGridTableView(GridView).ClearItems;
  TcxDBDataController(GridView.DataController).DataSource := ADataSource;
  if GridView is TcxCustomGridTableView then
    TcxGridDBDataController(GridView.DataController).CreateAllItems;
  Designer.Modified;
end;

{$ENDIF}

procedure TGridEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
{$IFNDEF NONDB}
  if (Index >= 1) and CanLinkToDataSource then
    if Index = 1 then
    begin
      if IsSingleDataSource then
        LinkToDataSource(0);
      Exit;
    end
    else
      Dec(Index);
{$ENDIF}
  case Index of
    0: ShowGridEditor(Designer, Grid);
    1: ShowGridImportDialog(Designer, Grid);
  end;
end;

function TGridEditor.GetVerb(Index: Integer): string;
begin
{$IFNDEF NONDB}
  if (Index >= 1) and CanLinkToDataSource then
    if Index = 1 then
    begin
      Result := 'Link to DataSource';
      Exit;
    end
    else
      Dec(Index);
{$ENDIF}
  if (Index >= 0) and (Index <= High(GridEditorVerbs)) then
    Result := GridEditorVerbs[Index];
end;

function TGridEditor.GetVerbCount: Integer;
begin
  Result := Length(GridEditorVerbs);
{$IFNDEF NONDB}
  GetDataSourceNames;
  if CanLinkToDataSource then Inc(Result);
{$ENDIF}
end;

{$IFNDEF NONDB}
procedure TGridEditor.PrepareItem(Index: Integer;
  const AItem: {$IFDEF DELPHI6}DesignMenus.IMenuItem{$ELSE}TMenuItem{$ENDIF});
var
  I: Integer;

  function GetItemChecked(AIndex: Integer): Boolean;
  begin
    Result := Designer.GetComponent(FDataSourceNames[AIndex]) = DataSource;
  end;

{$IFNDEF DELPHI6}

  function CreateMenuItem(const ACaption: string; AChecked: Boolean;
    AOnClick: TNotifyEvent): TMenuItem;
  begin
    Result := TMenuItem.Create(AItem.Owner);
    with Result do
    begin
      Caption := ACaption;
      Checked := AChecked;
      OnClick := AOnClick;
    end;
  end;

{$ENDIF}

begin
  inherited;
  if (Index = 1) and CanLinkToDataSource then
    if IsSingleDataSource then
    begin
      AItem.Caption := 'Link to ' + FDataSourceNames[0];
      AItem.Checked := GetItemChecked(0);
    end
    else
      for I := 0 to FDataSourceNames.Count - 1 do
      {$IFDEF DELPHI6}
        AItem.AddItem(FDataSourceNames[I], 0, GetItemChecked(I), True, DataSourceClick);
      {$ELSE}
        AItem.Add(CreateMenuItem(FDataSourceNames[I], GetItemChecked(I), DataSourceClick));
      {$ENDIF}
end;
{$ENDIF}

{ TGridViewRepositoryEditor }

type
  TGridViewRepositoryEditor = class(TComponentEditor)
  private
    function GetGridViewRepository: TcxGridViewRepository;
  protected
    property GridViewRepository: TcxGridViewRepository read GetGridViewRepository;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

function TGridViewRepositoryEditor.GetGridViewRepository: TcxGridViewRepository;
begin
  Result := TcxGridViewRepository(Component);
end;

procedure TGridViewRepositoryEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  case Index of
    //0: GridViewRepository.CreateItem(TcxGridDBTableView).Name := Designer.UniqueName('cxGridDBTableView');
    0: ShowViewRepositoryEditor(Designer, GridViewRepository);
  end;
end;

function TGridViewRepositoryEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    //0: Result := 'Create TcxGridDBTableView';
    0: Result := 'Editor...';
    1: Result := '-';
    2: Result := cxGridProductName + ' ' + cxGridVersion;
    3: Result := dxCompanyURL;
  end;
end;

function TGridViewRepositoryEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

{ TcxGridRootLevelStylesEventsProperty }

type
  TcxGridRootLevelStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridRootLevelStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGrid(GetComponent(0)).RootLevelStyles;
end;

{ TcxGridTableItemPropertiesEventsProperty }

type
  TcxGridTableItemPropertiesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridTableItemPropertiesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridTableItem(GetComponent(0)).Properties;
end;

{ TcxGridTableItemStylesEventsProperty }

type
  TcxGridTableItemStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridTableItemStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridTableItem(GetComponent(0)).Styles;
end;

{ TcxGridDataControllerEventsProperty }

type
  TcxGridDataControllerEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridDataControllerEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridView(GetComponent(0)).DataController;
end;

{ TcxGridViewStylesEventsProperty }

type
  TcxGridViewStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridViewStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridViewAccess(GetComponent(0)).Styles;
end;

{ TcxGridViewNavigatorButtonsEventsProperty }

type
  TcxGridViewNavigatorButtonsEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridViewNavigatorButtonsEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomGridTableView(GetComponent(0)).NavigatorButtons;
end;

{ TcxGridLevelStylesEventsProperty }

type
  TcxGridLevelStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridLevelStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxGridLevel(GetComponent(0)).Styles;
end;

{ TcxGridBandStylesEventsProperty }

type
  TcxGridBandStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridBandStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxGridBand(GetComponent(0)).Styles;
end;

{$IFDEF CHARTVIEW}

{ TcxGridChartSeriesStylesEventsProperty }

type
  TcxGridChartSeriesStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridChartSeriesStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxGridChartSeries(GetComponent(0)).Styles;
end;

{ TcxGridChartBarDiagramEventsProperty }

type
  TcxGridChartBarDiagramEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridChartBarDiagramEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxGridChartView(GetComponent(0)).DiagramBar;
end;

{ TcxGridChartColumnDiagramEventsProperty }

type
  TcxGridChartColumnDiagramEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

function TcxGridChartColumnDiagramEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxGridChartView(GetComponent(0)).DiagramColumn;
end;

{$ENDIF}

(*{ TcxGridOptionsProperty }

type
  TcxGridOptionsProperty = class(TComponentProperty)
  public
    function AllEqual: Boolean; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetProperties(Proc: TGetPropProc); override;
    function GetValue: string; override;
  end;

function TcxGridOptionsProperty.AllEqual: Boolean;
begin
  Result := {inherited AllEqual;//}True;
end;

function TcxGridOptionsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := {inherited GetAttributes;//}[paMultiSelect, paSubProperties, paReadOnly, paVolatileSubProperties];
  {Result := inherited GetAttributes - [paValueList, paSortList, paRevertable] +
    [paReadOnly];}
end;

procedure TcxGridOptionsProperty.GetProperties(Proc: TGetPropProc);
var
  I: Integer;
  J: Integer;
  Components: IDesignerSelections;
begin
  inherited;
  {Components := TDesignerSelections.Create;
  for I := 0 to PropCount - 1 do
  begin
    J := GetOrdValueAt(I);
    if J <> 0 then
      Components.Add(TComponent(GetOrdValueAt(I)));
  end;
  if Components.Count > 0 then
    GetComponentProperties(Components, tkAny, Designer, Proc);}
end;

function TcxGridOptionsProperty.GetValue: string;
begin
  Result := '[Options]';
end;*)

{ TcxGridLevelGridViewProperty }

type
  TcxGridLevelGridViewProperty = class(TComponentProperty)
  private
    FComponentNames: TStringList;
    function GetLevel: TcxGridLevel;
    procedure AddComponentName(const S: string);
  protected
    property Level: TcxGridLevel read GetLevel;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TcxGridLevelGridViewProperty.GetLevel: TcxGridLevel;
begin
  Result := TcxGridLevel(GetComponent(0));
end;

procedure TcxGridLevelGridViewProperty.AddComponentName(const S: string);
begin
  FComponentNames.Add(S);
end;

function TcxGridLevelGridViewProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes - [paMultiSelect];
end;

procedure TcxGridLevelGridViewProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  AGridView: TcxCustomGridView;
begin
  FComponentNames := TStringList.Create;
  try
    Designer.GetComponentNames(GetTypeData(GetPropType), AddComponentName);
    for I := 0 to FComponentNames.Count - 1 do
    begin
      AGridView := Designer.GetComponent(FComponentNames[I]) as TcxCustomGridView;
      if (AGridView.Repository <> nil) or (AGridView.StorageControl = Level.Control) then
        Proc(FComponentNames[I]);
    end;
  finally
    FComponentNames.Free;
  end;
end;

{ TcxCustomGridTableItemPropertiesProperty }

type
  TcxCustomGridTableItemPropertiesProperty = class(TClassProperty)
  protected
    function HasSubProperties: Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

function TcxCustomGridTableItemPropertiesProperty.HasSubProperties: Boolean;
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
  begin
    Result := TcxCustomGridTableItem(GetComponent(I)).Properties <> nil;
    if not Result then Exit;
  end;
  Result := True;
end;

function TcxCustomGridTableItemPropertiesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if not HasSubProperties then
    Exclude(Result, paSubProperties);
  Result := Result - [paReadOnly] +
    [paValueList, paSortList, paRevertable{$IFDEF DELPHI6}, paVolatileSubProperties{$ENDIF}];
end;

function TcxCustomGridTableItemPropertiesProperty.GetValue: string;
begin
  if HasSubProperties then
    Result := GetRegisteredEditProperties.GetDescriptionByClass(
      TcxCustomGridTableItem(GetComponent(0)).Properties.ClassType)
  else
    Result := '';
end;

procedure TcxCustomGridTableItemPropertiesProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to GetRegisteredEditProperties.Count - 1 do
    Proc(GetRegisteredEditProperties.Descriptions[I]);
end;

procedure TcxCustomGridTableItemPropertiesProperty.SetValue(const Value: string);
var
  APropertiesClass: TcxCustomEditPropertiesClass;
  I: Integer;
begin
  APropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByClassName(Value));
  if APropertiesClass = nil then
    APropertiesClass := TcxCustomEditPropertiesClass(GetRegisteredEditProperties.FindByDescription(Value));
{$IFNDEF DELPHI7}
  if GetValue <> Value then
    ObjectInspectorCollapseProperty;
{$ENDIF}
  for I := 0 to PropCount - 1 do
    TcxCustomGridTableItem(GetComponent(I)).PropertiesClass := APropertiesClass;
  Modified;
end;

{$IFNDEF NONDB}

type
  TcxDBDataSummaryItemFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

function TcxDBDataSummaryItemFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := (GetComponent(0) as TcxDBDataSummaryItem).DataController.DataSource;
end;

type
  TcxGridItemDBDataBindingFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

function TcxGridItemDBDataBindingFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := TcxGridItemDBDataBinding(GetComponent(0)).DataController.DataSource;
end;

type
  TMasterKeyFieldNamesProperty = class(TFieldNameProperty)
    function GetDataSource: TDataSource; override;
  end;

function TMasterKeyFieldNamesProperty.GetDataSource: TDataSource;
var
  AIDataController: IcxCustomGridDataController;
  AParentLevel: TcxGridLevel;
begin
  Result := nil;
  if Supports(GetComponent(0), IcxCustomGridDataController, AIDataController) then
  begin
    AParentLevel := AIDataController.GridView.Level as TcxGridLevel;
    if AParentLevel <> nil then
      AParentLevel := AParentLevel.Parent;
    if (AParentLevel <> nil) and (AParentLevel.GridView <> nil) and
      (AParentLevel.GridView.DataController is TcxDBDataController) then
      Result := TcxDBDataController(AParentLevel.GridView.DataController).DataSource;
  end;
end;

{$IFDEF CHARTVIEW}

type
  TcxGridDBChartItemDataBindingFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
    procedure GetValueList(AList: TStrings); override;
  end;

function TcxGridDBChartItemDataBindingFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := TcxGridDBChartItemDataBinding(GetComponent(0)).DataController.DataSource;
end;

procedure TcxGridDBChartItemDataBindingFieldNameProperty.GetValueList(AList: TStrings);
var
  I, J: Integer;
  AField: TField;
  AValueTypeClass: TcxValueTypeClass;
begin
  inherited;
  for I := AList.Count - 1 downto 0 do
  begin
    AField := GetDataSource.DataSet.FindField(AList[I]);
    if AField = nil then
      AList.Delete(I)
    else
    begin
      AValueTypeClass := GetValueTypeClassByField(AField);
      for J := 0 to PropCount - 1 do
        if not (GetComponent(J) as TcxGridDBChartItemDataBinding).IsValueTypeClassValid(AValueTypeClass) then
        begin
          AList.Delete(I);
          Break;
        end;
    end;
  end;
end;

{$ENDIF}

{$ENDIF}

{ TcxCustomGridBandIndexProperty }

const
  sNoBand = '<none>';
  sIndexCaptionSeparator = ' - ';

type
  TcxCustomGridBandIndexProperty = class(TIntegerProperty)
  private
    function GetGridView: TcxGridBandedTableView;
  protected
    function GetGridViewForComponent(AIndex: Integer): TcxGridBandedTableView; virtual; abstract;
    function GetValueForBandIndex(AIndex: Integer): string;
    function IsSameGridView: Boolean;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    property GridView: TcxGridBandedTableView read GetGridView;
  end;

function TcxCustomGridBandIndexProperty.GetGridView: TcxGridBandedTableView;
begin
  Result := GetGridViewForComponent(0);
end;

function TcxCustomGridBandIndexProperty.GetValueForBandIndex(AIndex: Integer): string;
begin
  if AIndex = -1 then
    Result := sNoBand
  else
  begin
    Result := IntToStr(AIndex);
    if GridView.Bands[AIndex].Caption <> '' then
      Result := Result + sIndexCaptionSeparator + GridView.Bands[AIndex].Caption;
  end;    
end;

function TcxCustomGridBandIndexProperty.IsSameGridView: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to PropCount - 1 do
  begin
    Result := GetGridViewForComponent(I) = GridView;
    if not Result then Break;
  end;
end;

function TcxCustomGridBandIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes;
  if IsSameGridView then Include(Result, paValueList);
end;

function TcxCustomGridBandIndexProperty.GetValue: string;
begin
  if IsSameGridView or (GetOrdValue = -1) then
    Result := GetValueForBandIndex(GetOrdValue)
  else
    Result := inherited GetValue;
end;

procedure TcxCustomGridBandIndexProperty.GetValues(Proc: TGetStrProc);
begin
  Proc(GetValueForBandIndex(-1));
end;

procedure TcxCustomGridBandIndexProperty.SetValue(const Value: string);
var
  P: Integer;
begin
  if Value = sNoBand then
    SetOrdValue(-1)
  else
  begin
    P := Pos(sIndexCaptionSeparator, Value);
    if P = 0 then
      inherited SetValue(Value)
    else
      inherited SetValue(Copy(Value, 1, P - 1));
  end;
end;

{ TcxGridBandedColumnBandIndexProperty }

type
  TcxGridBandedColumnBandIndexProperty = class(TcxCustomGridBandIndexProperty)
  protected
    function GetGridViewForComponent(AIndex: Integer): TcxGridBandedTableView; override;
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TcxGridBandedColumnBandIndexProperty.GetGridViewForComponent(AIndex: Integer): TcxGridBandedTableView;
begin
  Result := TcxGridBandedColumnPosition(GetComponent(AIndex)).GridView;
end;

procedure TcxGridBandedColumnBandIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  inherited;
  for I := 0 to GridView.Bands.BottomItemCount - 1 do
    Proc(GetValueForBandIndex(GridView.Bands.BottomItems[I].Index));
end;

{ TcxGridBandBandIndexProperty }

type
  TcxGridBandBandIndexProperty = class(TcxCustomGridBandIndexProperty)
  protected
    function GetGridViewForComponent(AIndex: Integer): TcxGridBandedTableView; override;
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TcxGridBandBandIndexProperty.GetGridViewForComponent(AIndex: Integer): TcxGridBandedTableView;
begin
  Result := TcxGridBandPosition(GetComponent(AIndex)).GridView;
end;

procedure TcxGridBandBandIndexProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;

  function IsBandSelected(ABandIndex: Integer): Boolean;
  var
    ABand: TcxGridBand;
    I: Integer;
  begin
    ABand := GridView.Bands[ABandIndex];
    for I := 0 to PropCount - 1 do
    begin
      Result := TcxGridBandPosition(GetComponent(I)).Band = ABand;
      if Result then Exit;
    end;
    Result := False;
  end;

begin
  inherited;
  for I := 0 to GridView.Bands.Count - 1 do
    if not IsBandSelected(I) then
      Proc(GetValueForBandIndex(I));
end;

{ TcxCustomGridTableItemProperty }

type
  TcxCustomGridTableItemProperty = class(TComponentProperty)
  protected
    function GetGridView: TcxCustomGridView;
    procedure GetGridViewItemNames(AGridView: TcxCustomGridView; Proc: TGetStrProc); virtual;
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; virtual; abstract;
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure TcxCustomGridTableItemProperty.GetValues(Proc: TGetStrProc);
var
  AGridView: TcxCustomGridView;
begin
  AGridView := GetGridView;
  if AGridView <> nil then
    GetGridViewItemNames(AGridView, Proc);
end;

function TcxCustomGridTableItemProperty.GetGridView: TcxCustomGridView;
var
  I: Integer;
begin
  Result := InternalGetGridView(GetComponent(0));
  for I := 1 to PropCount - 1 do
    if InternalGetGridView(GetComponent(I)) <> Result then
    begin
      Result := nil;
      Break;
    end;
end;

procedure TcxCustomGridTableItemProperty.GetGridViewItemNames(AGridView: TcxCustomGridView;
  Proc: TGetStrProc);
var
  I: Integer;
begin
  if AGridView is TcxCustomGridTableView then
    with AGridView as TcxCustomGridTableView do
      for I := 0 to ItemCount - 1 do
        Proc(Designer.GetComponentName(Items[I]));
end;

{ TcxGridIncSearchItemProperty }

type
  TcxGridIncSearchItemProperty = class(TcxCustomGridTableItemProperty)
  protected
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; override;
  end;

function TcxGridIncSearchItemProperty.InternalGetGridView(APersistent: TPersistent):
  TcxCustomGridView;
begin
  Result := TcxCustomGridTableOptionsBehavior(APersistent).GridView;
end;

{ TcxGridPreviewColumnProperty }

type
  TcxGridPreviewColumnProperty = class(TcxCustomGridTableItemProperty)
  protected
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; override;
  end;

function TcxGridPreviewColumnProperty.InternalGetGridView(APersistent: TPersistent):
  TcxCustomGridView;
begin
  Result := TcxGridPreview(APersistent).GridView;
end;

{ TcxGridTableSummaryItemColumnProperty }

type
  TcxGridTableSummaryItemColumnProperty = class(TcxCustomGridTableItemProperty)
  protected
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; override;
  end;

function TcxGridTableSummaryItemColumnProperty.InternalGetGridView(APersistent: TPersistent):
  TcxCustomGridView;
begin
  Result := (TcxCustomDataSummaryItem(APersistent).DataController as
    IcxCustomGridDataController).GridView;
end;

{$IFDEF CHARTVIEW}

{ TcxGridChartItemValueTypeProperty }

type
  TcxGridChartItemValueTypeProperty = class(TcxValueTypeProperty)
  protected
    function IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean; override;
  end;

function TcxGridChartItemValueTypeProperty.IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean;
var
  I: Integer;
begin
  Result := inherited IsValueTypeClassValid(AValueTypeClass);
  if Result then
    for I := 0 to PropCount - 1 do
    begin
      Result := (GetComponent(I) as TcxGridChartItemDataBinding).IsValueTypeClassValid(AValueTypeClass);
      if not Result then Break;
    end;
end;

{ TcxGridChartActiveDiagramProperty }

type
  TcxGridChartActiveDiagramProperty = class(TPropertyEditor)
  private
    function GetGridView: TcxGridChartView;
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
    property GridView: TcxGridChartView read GetGridView;
  end;

function TcxGridChartActiveDiagramProperty.GetGridView: TcxGridChartView;
begin
  Result := GetComponent(0) as TcxGridChartView;
end;

function TcxGridChartActiveDiagramProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

function TcxGridChartActiveDiagramProperty.GetValue: string;
begin
  Result := GridView.ActiveDiagram.DisplayText;
end;

procedure TcxGridChartActiveDiagramProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to GridView.DiagramCount - 1 do
    Proc(GridView.Diagrams[I].DisplayText);
end;

procedure TcxGridChartActiveDiagramProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  for I := 0 to GridView.DiagramCount - 1 do
    if GridView.Diagrams[I].DisplayText = Value then
    begin
      GridView.Diagrams[I].Active := True;
      Modified;
      Break;
    end;
end;

{$ENDIF}

{$IFNDEF NONDB}

{ Ext Lookup }

type
  TcxExtLookupComboBoxPropertiesFieldNameProperty = class(TFieldNameProperty)
  public
    function GetDataSource: TDataSource; override;
  end;

  TcxExtLookupComboBoxPropertiesItemColumnProperty = class(TcxCustomGridTableItemProperty)
  protected
    function InternalGetGridView(APersistent: TPersistent): TcxCustomGridView; override;
  end;

  TcxExtLookupComboBoxPropertiesViewProperty = class(TComponentProperty)
  private
    FProc: TGetStrProc;
    procedure CheckComponent(const Value: string);
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TcxExtLookupComboBoxPropertiesFieldNameProperty.GetDataSource: TDataSource;
var
  AProperties: TcxExtLookupComboBoxProperties;
begin
  AProperties := GetComponent(0) as TcxExtLookupComboBoxProperties;
  if AProperties.DataController <> nil then
    Result := AProperties.DataController.DataSource
  else
    Result := nil;
end;

function TcxExtLookupComboBoxPropertiesItemColumnProperty.InternalGetGridView(APersistent: TPersistent): TcxCustomGridView;
var
  AProperties: TcxExtLookupComboBoxProperties;
begin
  AProperties := APersistent as TcxExtLookupComboBoxProperties;
  Result := AProperties.View;
end;

procedure TcxExtLookupComboBoxPropertiesViewProperty.GetValues(Proc: TGetStrProc);
begin
  FProc := Proc;
  inherited GetValues(CheckComponent);
end;

procedure TcxExtLookupComboBoxPropertiesViewProperty.CheckComponent(const Value: string);
var
  AView: TcxCustomGridTableView;
begin
  AView := TcxCustomGridTableView(Designer.GetComponent(Value));
  if (AView <> nil) and TcxExtLookupComboBoxProperties.IsViewSupported(AView) then
    FProc(Value);
end;

{$ENDIF}

{$IFDEF DELPHI6}

type
  TcxGridSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxGridLevelSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxCustomTableViewSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxCustomDBTableViewSelectionEditor = class(TcxCustomTableViewSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

  TcxCustomGridTableItemSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure TcxGridSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc(UnitNamePrefix + 'cxStyles');
end;

procedure TcxGridLevelSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc(UnitNamePrefix + 'cxStyles');
end;

procedure TcxCustomTableViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc(UnitNamePrefix + 'cxStyles');
  Proc('cxCustomData');
  Proc(UnitNamePrefix + 'cxGraphics');
  Proc('cxFilter');
  Proc('cxData');
  Proc('cxDataStorage');
  Proc(UnitNamePrefix + 'cxEdit');
end;

procedure TcxCustomDBTableViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited RequiresUnits(Proc);
  Proc('DB');
  Proc('cxDBData');
end;

procedure TcxCustomGridTableItemSelectionEditor.RequiresUnits(Proc: TGetStrProc);
var
  I: Integer;
  AComponent: TComponent;
  AItem: TcxCustomGridTableItem;
begin
  for I := 0 to Designer.Root.ComponentCount - 1 do
  begin
    AComponent := Designer.Root.Components[I];
    if AComponent is TcxCustomGridTableItem then
    begin
      AItem := TcxCustomGridTableItem(AComponent);
      if AItem.Properties <> nil then
        Proc(GetTypeData(PTypeInfo(AItem.Properties.ClassType.ClassInfo)).UnitName);
    end;
  end;
end;

{$IFDEF CHARTVIEW}

{ TcxGridChartViewSelectionEditor }

type
  TcxGridChartViewSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure TcxGridChartViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('cxStyles');
  Proc('cxCustomData');
  Proc('cxGraphics');
end;

{$IFNDEF NONDB}

{ TcxGridDBChartViewSelectionEditor }

type
  TcxGridDBChartViewSelectionEditor = class(TcxGridChartViewSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure TcxGridDBChartViewSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('DB');
  Proc('cxDBData');
end;

{$ENDIF}

{$ENDIF}

{$ENDIF}

type

{ TcxImageComboBoxItemsProperty }
  
  TcxImageComboBoxItemsProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TcxImageComboBoxItemsProperty.Edit;
var
  S: string;
  AProperties: TcxImageComboBoxProperties;
begin
  S := 'Properties' + '.' + GetName;
  AProperties := TcxImageComboBoxProperties(GetComponent(0));
  if (AProperties.Owner <> nil) and (AProperties.Owner is TComponent) then
    S := TComponent(AProperties.Owner).Name + '.' + S;
  with TfmImageComboBoxItemsEditor.Create(
    AProperties.Items, AProperties.Images, AProperties.LargeImages) do
  try
    Caption := S;
    if ShowModal = mrOk then
      Self.Designer.Modified;
  finally
    Free;
  end;
end;

function TcxImageComboBoxItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TcxImageComboBoxItemsProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}  

  RegisterComponentEditor(TcxGrid, TGridEditor);
  RegisterComponentEditor(TcxGridViewRepository, TGridViewRepositoryEditor);

  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGrid, 'RootLevelStylesEvents',
    TcxGridRootLevelStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridTableItem, 'PropertiesEvents',
    TcxGridTableItemPropertiesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridTableItem, 'StylesEvents',
    TcxGridTableItemStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridView, 'DataControllerEvents',
    TcxGridDataControllerEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridView, 'StylesEvents',
    TcxGridViewStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomGridTableView, 'NavigatorButtonsEvents',
    TcxGridViewNavigatorButtonsEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxGridLevel, 'StylesEvents',
    TcxGridLevelStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxGridBand, 'StylesEvents',
    TcxGridBandStylesEventsProperty);
{$IFDEF CHARTVIEW}
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxGridChartSeries, 'StylesEvents',
    TcxGridChartSeriesStylesEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxGridChartView, 'DiagramBarEvents',
    TcxGridChartBarDiagramEventsProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxGridChartView, 'DiagramColumnEvents',
    TcxGridChartColumnDiagramEventsProperty);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(TcxCustomGridView), TcxGridLevel, 'GridView',
    TcxGridLevelGridViewProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxCustomGridTableItem, 'PropertiesClassName', nil);
  RegisterPropertyEditor(TypeInfo(TcxCustomEditProperties), TcxCustomGridTableItem,
    'Properties', TcxCustomGridTableItemPropertiesProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxGridItemDataBinding, 'ValueType',
    TcxValueTypeProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TcxCustomGridView, 'PopupMenu',
    TcxControlPopupMenuProperty);
  RegisterPropertyEditor(TypeInfo(Boolean), TcxCustomGridTableOptionsSelection, 'HideFocusRect', nil);
  RegisterPropertyEditor(TypeInfo(TAlignment), TcxGridBand, 'Alignment', nil);
  RegisterPropertyEditor(TypeInfo(Integer), TcxGridBandedColumnPosition, 'BandIndex',
    TcxGridBandedColumnBandIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TcxGridBandPosition, 'BandIndex',
    TcxGridBandBandIndexProperty);
{$IFDEF CHARTVIEW}
  RegisterPropertyEditor(TypeInfo(string), TcxGridChartItemDataBinding, 'ValueType',
    TcxGridChartItemValueTypeProperty);
  RegisterPropertyEditor(TypeInfo(TcxGridChartDiagram), TcxGridChartView, 'ActiveDiagram',
    TcxGridChartActiveDiagramProperty);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxCustomGridTableOptionsBehavior,
    'IncSearchItem', TcxGridIncSearchItemProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridPreview,
    'Column', TcxGridPreviewColumnProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridTableSummaryItem,
    'Column', TcxGridTableSummaryItemColumnProperty);
{$IFNDEF NONDB}
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridDBTableSummaryItem,
    'Column', TcxGridTableSummaryItemColumnProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridDBBandedTableSummaryItem,
    'Column', TcxGridTableSummaryItemColumnProperty);
{$ENDIF}
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxGridTableSummaryGroupItemLink,
    'Column', TcxGridTableSummaryItemColumnProperty);

{$IFNDEF NONDB}
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataController, 'DetailKeyFieldNames', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataController, 'KeyFieldNames', TFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataController, 'MasterKeyFieldNames', TMasterKeyFieldNamesProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBDataSummaryItem, 'FieldName', TcxDBDataSummaryItemFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxGridItemDBDataBinding, 'FieldName', TcxGridItemDBDataBindingFieldNameProperty);
{$IFDEF CHARTVIEW}
  RegisterPropertyEditor(TypeInfo(string), TcxGridDBChartItemDataBinding, 'FieldName', TcxGridDBChartItemDataBindingFieldNameProperty);
{$ENDIF}  
{$ENDIF}

  RegisterNoIcon([TcxGridLevel,
    TcxGridTableView, {$IFNDEF NONDB}TcxGridDBTableView,{$ENDIF}
    TcxGridBandedTableView, {$IFNDEF NONDB}TcxGridDBBandedTableView,{$ENDIF}
  {$IFDEF CHARTVIEW}
    TcxGridChartView, {$IFNDEF NONDB}TcxGridDBChartView,{$ENDIF}
  {$ENDIF}
    TcxGridCardView{$IFNDEF NONDB}, TcxGridDBCardView{$ENDIF}]);
  RegisterNoIcon([
    TcxGridColumn, {$IFNDEF NONDB}TcxGridDBColumn,{$ENDIF}
    TcxGridBandedColumn, {$IFNDEF NONDB}TcxGridDBBandedColumn,{$ENDIF}
  {$IFDEF CHARTVIEW}
    TcxGridChartSeries, {$IFNDEF NONDB}TcxGridDBChartSeries,{$ENDIF}
  {$ENDIF}
    TcxGridCardViewRow{$IFNDEF NONDB}, TcxGridDBCardViewRow{$ENDIF}]);
  RegisterNoIcon([TcxGridTableViewStyleSheet, TcxGridBandedTableViewStyleSheet, TcxGridCardViewStyleSheet]);
  RegisterComponents(dxCoreLibraryProductPage, [TcxGrid, TcxGridViewRepository]);
{$IFNDEF NONDB}
  // Ext Lookup
  RegisterComponents(cxEditorsLibraryProductPage, [TcxExtLookupComboBox]);
  RegisterComponents(cxEditorsDBLibraryProductPage, [TcxDBExtLookupComboBox]);
  RegisterEditRepositoryItem(TcxEditRepositoryExtLookupComboBoxItem, cxSEditRepositoryExtLookupComboBoxItem);
  RegisterPropertyEditor(TypeInfo(string), TcxExtLookupComboBoxProperties, 'KeyFieldNames', TcxExtLookupComboBoxPropertiesFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableItem), TcxExtLookupComboBoxProperties, 'ListFieldItem', TcxExtLookupComboBoxPropertiesItemColumnProperty);
  RegisterPropertyEditor(TypeInfo(TcxCustomGridTableView), TcxExtLookupComboBoxProperties, 'View', TcxExtLookupComboBoxPropertiesViewProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TcxExtLookupComboBoxProperties, 'ClearKey', TShortCutProperty);
{$ENDIF}

{$IFDEF DELPHI6}
  RegisterSelectionEditor(TcxCustomGrid, TcxGridSelectionEditor);
  RegisterSelectionEditor(TcxGridLevel, TcxGridLevelSelectionEditor);
  RegisterSelectionEditor(TcxCustomGridTableView, TcxCustomTableViewSelectionEditor);
{$IFDEF CHARTVIEW}
  RegisterSelectionEditor(TcxGridChartView, TcxGridChartViewSelectionEditor);
{$ENDIF}
{$IFNDEF NONDB}
  RegisterSelectionEditor(TcxGridDBTableView, TcxCustomDBTableViewSelectionEditor);
  RegisterSelectionEditor(TcxGridDBBandedTableView, TcxCustomDBTableViewSelectionEditor);
  RegisterSelectionEditor(TcxGridDBCardView, TcxCustomDBTableViewSelectionEditor);
{$IFDEF CHARTVIEW}
  RegisterSelectionEditor(TcxGridDBChartView, TcxGridDBChartViewSelectionEditor);
{$ENDIF}
{$ENDIF}
  RegisterSelectionEditor(TcxCustomGridTableItem, TcxCustomGridTableItemSelectionEditor);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(TcxImageComboBoxItems),
    TcxImageComboBoxProperties, 'Items', TcxImageComboBoxItemsProperty);

end;

initialization
{$IFDEF DELPHI6}
  StartClassGroup(TControl);
  GroupDescendentsWith(TcxGrid, TControl);
  GroupDescendentsWith(TcxGridViewRepository, TControl);
  GroupDescendentsWith(TcxGridLevel, TControl);
  GroupDescendentsWith(TcxCustomGridView, TControl);
  GroupDescendentsWith(TcxCustomGridTableItem, TControl);
  GroupDescendentsWith(TcxGridItemDataBinding, TControl);
{$IFDEF CHARTVIEW}
  GroupDescendentsWith(TcxGridChartSeries, TControl);
{$ENDIF}
{$ENDIF}
  RegisterStyleSheetClass(TcxGridTableViewStyleSheet);
  RegisterStyleSheetClass(TcxGridBandedTableViewStyleSheet);
  RegisterStyleSheetClass(TcxGridCardViewStyleSheet);

finalization
  UnregisterStyleSheetClass(TcxGridCardViewStyleSheet);
  UnregisterStyleSheetClass(TcxGridBandedTableViewStyleSheet);
  UnregisterStyleSheetClass(TcxGridTableViewStyleSheet);

end.
