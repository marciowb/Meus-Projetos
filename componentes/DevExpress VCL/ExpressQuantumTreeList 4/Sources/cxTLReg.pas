
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
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

unit cxTLReg;

{$I cxVer.inc}

interface
uses
  Classes, SysUtils, TypInfo,
{$IFDEF DELPHI6}
  Types, DesignIntf, DesignEditors, VCLEditors, 
{$ELSE}
  DsgnWnds, DsgnIntf,
{$ENDIF}
{$IFNDEF DELPHI5}
  cxInplaceContainer,
{$ENDIF}
  cxImportDialog, cxTLConverter, cxdxTLConverter,
  Forms, DB, cxDesignWindows, cxPropEditors, cxClasses, cxControls,
  cxEditPropEditors, cxEdit, cxStyles,
  cxTL, cxTLData, cxDBTL, cxTLStrs, cxTLIntf, cxTLDsgnEdtrs,
  cxTLItemsEdtr, cxTLPredefinedStyles, cxTLStyleSheetPreview, dxCore, cxExportTL4Link;

procedure Register;

implementation

uses
  dxCoreReg, cxLibraryReg;

type
  TcxTreeListAccess = class(TcxCustomTreeListControl);
  TcxDBTreeListAccess = class(TcxCustomDBTreeList);

  TcxColumnAccess = class(TcxTreeListColumn);

  { TcxTreeListComponentEditor }

  TcxTreeListComponentEditor = class(TdxComponentEditor)
  protected
    FItems: TStringList;
    procedure ItemsNeeded; virtual;
  protected
    function GetProductMajorVersion: string; override;
    function GetProductName: string; override;
    function InternalGetVerb(AIndex: Integer): string; override;
    function InternalGetVerbCount: Integer; override;
    procedure InternalExecuteVerb(AIndex: Integer); override;
  public
    destructor Destroy; override;
  end;

  { TcxstStylesEventsProperty }

  TcxTreeListStylesEventsProperty = class(TcxNestedEventProperty)
  protected
    function GetInstance: TPersistent; override;
  end;

  { TcxDBTreeListFieldNameProperty }

  TcxDBTreeListFieldNameProperty = class(TFieldNameProperty)
  protected
    function GetTreeList: TcxDBTreeListAccess;
  public
    function GetDataSource: TDataSource; override;
  end;

  { TcxTreeListColumnProperty }

  TcxTreeListColumnProperty = class(TComponentProperty)
  protected
    function GetTreeList: TcxTreeListAccess;
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

const
  UnitNamePrefix       =  '' ;
  ImportStr            = 'Import...';
  ComponentDescription = 'ExpressQuantumTreeList';
  InternetAddress      = 'www.devexpress.com';

procedure ShowItemsDesigner(AEditor: TcxTreeListComponentEditor; ASheetIndex: Integer);
var
  ADesigner: TcxTreeListBandColumnDesigner;
begin
  ADesigner := TcxTreeListBandColumnDesigner(ShowFormEditorClass(AEditor.Designer,
    AEditor.Component, TcxTreeListBandColumnDesigner));
  ADesigner.SetVisibleSheetIndex(ASheetIndex);
end;

function cxDoGetTreeList(ASubClass: TObject): TObject;
var
  AIntf: IcxTreeListSubClass;
begin
  if Supports(ASubClass, IcxTreeListSubClass, AIntf) then
    Result := AIntf.GetControl
  else
    raise EAbort.Create('');
end;

{ TcxTreeListComponentEditor }

destructor TcxTreeListComponentEditor.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TcxTreeListComponentEditor.ItemsNeeded;
var
  AIntf: IcxTreeListDesignTimeOperations;
begin
  if FItems = nil then
    FItems := TStringList.Create()
  else
    FItems.Clear;
  if Supports(Component, IcxTreeListDesignTimeOperations, AIntf) then
  begin
    if AIntf.SupportsBandColumnEditor then
    begin
      FItems.Add(scxStr(@scxColumns));
      FItems.Add(scxStr(@scxBands));
    end;
    if AIntf.SupportsItemsEditor then
      FItems.Add(scxStr(@scxItems))
    else
      if AIntf.SupportsCreateAllItems then
      begin
        FItems.Add(scxStr(@scxCreateAllItems));
        FItems.Add(scxStr(@scxDeleteAllItems));
      end;
    FItems.Add(ImportStr);
  end;
end;

function TcxTreeListComponentEditor.GetProductMajorVersion: string;
begin
  Result := cxTLMajorVersion;
end;

function TcxTreeListComponentEditor.GetProductName: string;
begin
  Result := ComponentDescription;
end;

function TcxTreeListComponentEditor.InternalGetVerb(AIndex: Integer): string;
begin
  Result := FItems[AIndex]
end;

function TcxTreeListComponentEditor.InternalGetVerbCount: Integer;
begin
  ItemsNeeded;
  Result := FItems.Count;
end;

procedure TcxTreeListComponentEditor.InternalExecuteVerb(AIndex: Integer);
var
  AIntf: IcxTreeListDesignTimeOperations;
const
  Invert: array[Boolean] of Byte = (1, 0);
begin
  if FItems.IndexOf(ImportStr) = AIndex then
  begin
    if Component is TcxDBTreeList then
      ShowImportDialog(Designer, Component, cxDBTLGroupConverterName)
    else if Component is TcxTreeList then
      ShowImportDialog(Designer, Component, cxTLGroupConverterName);
    Exit;
  end;
  if Supports(Component, IcxTreeListDesignTimeOperations, AIntf) then
  begin
    if Component is TcxCustomTreeListControl then
    begin
      if AIndex in [0..1] then
      begin
        if AIntf.SupportsBandColumnEditor then
          ShowItemsDesigner(Self, Invert[AIndex = 1]);
      end
      else
        if AIntf.SupportsItemsEditor and (AIndex = 2) then
          cxShowTreeListItemsEditor(TcxTreeList(Component))
        else
          if AIntf.SupportsCreateAllItems then
          begin
            if AIndex = 2 then
            begin
              AIntf.CreateAllItems;
              SetColumnsUniqueName(TcxCustomTreeListControl(Component));
            end
            else
              AIntf.DeleteAllColumns;
            Designer.Modified;
          end;
    end;
  end;
end;

{ TcxTreeListStylesEventsProperty }

function TcxTreeListStylesEventsProperty.GetInstance: TPersistent;
begin
  Result := TcxCustomTreeListControl(GetComponent(0)).Styles;
end;

 { TcxDBTreeListFieldNameProperty }

function TcxDBTreeListFieldNameProperty.GetDataSource: TDataSource;
begin
  Result := GetTreeList.DataController.DataSource;
end;

function TcxDBTreeListFieldNameProperty.GetTreeList: TcxDBTreeListAccess;
begin
  Result := TcxDBTreeListAccess(cxDoGetTreeList(GetComponent(0)));
end;

{ TcxTreeListColumnProperty }

function TcxTreeListColumnProperty.GetTreeList: TcxTreeListAccess;
begin
  Result := TcxTreeListAccess(cxDoGetTreeList(GetComponent(0)))
end;

procedure TcxTreeListColumnProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  with GetTreeList do 
  begin
    for I := 0 to ColumnCount - 1 do
      Proc(Columns[I].Name)
  end;
end;

{$IFDEF DELPHI6}

type
  TcxTreeListSelectionEditor = class(TSelectionEditor)
  protected
    ComponentsList: TStringList;
  public
    procedure AddComponent(const Name: string);
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure TcxTreeListSelectionEditor.AddComponent(const Name: string);
begin
  ComponentsList.Add(Name);
end;

procedure TcxTreeListSelectionEditor.RequiresUnits(Proc: TGetStrProc);

  procedure AddColumnUnitName(AProperties: TcxCustomEditProperties);
  begin
    if AProperties <> nil then
      Proc(UnitNamePrefix + dxShortStringToString(GetTypeData(PTypeinfo(AProperties.ClassType.ClassInfo))^.UnitName));
  end;

var
  AComponent: TComponent;
  I: Integer;
begin
  inherited RequiresUnits(Proc);
  Proc(UnitNamePrefix + 'cxGraphics');
  Proc(UnitNamePrefix + 'cxCustomData');
  Proc(UnitNamePrefix + 'cxStyles');
  Proc(UnitNamePrefix + 'cxTL');
  ComponentsList := TStringList.Create;
  try
    Designer.GetComponentNames(GetTypeData(PTypeInfo(TcxTreeListColumn.ClassInfo)), AddComponent);
    for I := 0 to ComponentsList.Count - 1 do
    begin
      AComponent := Designer.GetComponent(ComponentsList[I]);
      if AComponent is TcxTreeListColumn then
      begin
        AddColumnUnitName(TcxTreeListColumn(AComponent).Properties);
        AddColumnUnitName(TcxColumnAccess(AComponent).PropertiesValue);
      end;
    end;
  finally
    ComponentsList.Free;
  end;
end;

{$ENDIF}

type
  TcxDesignSelectionListener = class(TcxIUnknownObject{$IFDEF DELPHI6}, IDesignNotification{$ENDIF})
  protected
    Listeners: TList;
    // IDesignNotification
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure AddListener(AListener: TObject; AddListener: Boolean);
  end;

constructor TcxDesignSelectionListener.Create;
begin
  Listeners := TList.Create;
{$IFDEF DELPHI6}
  RegisterDesignNotification(Self);
{$ENDIF}
  DesignerNavigatorProc := AddListener;
end;

destructor TcxDesignSelectionListener.Destroy;
begin
  DesignerNavigatorProc := nil;
  Listeners.Clear;
{$IFDEF DELPHI6}
  UnRegisterDesignNotification(Self);
{$ENDIF}
  FreeAndNil(Listeners);
  inherited Destroy;
end;

procedure TcxDesignSelectionListener.AddListener(
  AListener: TObject; AddListener: Boolean);
begin
  Listeners.Remove(AListener);
  if AddListener then
    Listeners.Add(AListener);
end;

procedure TcxDesignSelectionListener.ItemDeleted(
  const ADesigner: IDesigner; AItem: TPersistent);
begin
end;

procedure TcxDesignSelectionListener.ItemInserted(
  const ADesigner: IDesigner; AItem: TPersistent);
begin
end;

procedure TcxDesignSelectionListener.ItemsModified(
  const ADesigner: IDesigner);
begin
end;

procedure TcxDesignSelectionListener.SelectionChanged(
  const ADesigner: IDesigner; const ASelection: IDesignerSelections);
var
  I: Integer;
begin
  for I := 0 to Listeners.Count - 1 do
    TcxCustomTreeListControl(Listeners[I]).Invalidate;
end;

procedure TcxDesignSelectionListener.DesignerOpened(
  const ADesigner: IDesigner; AResurrecting: Boolean);
begin
end;

procedure TcxDesignSelectionListener.DesignerClosed(
  const ADesigner: IDesigner; AGoingDormant: Boolean);
begin
end;

procedure Register;
begin
{$IFDEF DELPHI9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}  

  RegisterComponents(dxCoreLibraryProductPage, [TcxTreeList, TcxDBTreeList, TcxVirtualTreeList]);
  RegisterClasses([TcxTreeListColumn, TcxDBTreeListColumn, TcxTreeListBands, TcxTreeListBand, TcxTreeListStyleSheet]);
  RegisterNoIcon([TcxTreeListColumn, TcxDBTreeListColumn, TcxTreeListStyleSheet]);
  RegisterComponentEditor(TcxCustomTreeListControl, TcxTreeListComponentEditor);
  RegisterPropertyEditor(TypeInfo(TcxTreeListColumn), TcxTreeListPreview,
    'Column', TcxTreeListColumnProperty);
  RegisterPropertyEditor(TypeInfo(TcxTreeListColumn), TcxTreeListOptionsView,
    'CategorizedColumn', TcxTreeListColumnProperty);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TcxCustomTreeListControl,
    'StylesEvents', TcxTreeListStylesEventsProperty);

  RegisterPropertyEditor(TypeInfo(string), TcxDBItemDataBinding,
    'FieldName', TcxDBTreeListFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBTreeListColumnSummaryFooter,
    'FieldName', TcxDBTreeListFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBTreeListDataController,
    'KeyField', TcxDBTreeListFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBTreeListDataController,
    'ParentField', TcxDBTreeListFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBTreeListDataController,
    'ImageIndexFieldName', TcxDBTreeListFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TcxDBTreeListDataController,
    'StateIndexFieldName', TcxDBTreeListFieldNameProperty);
{$IFDEF DELPHI6}
  RegisterSelectionEditor(TcxCustomTreeListControl, TcxTreeListSelectionEditor);
{$ENDIF}
end;

var
  DesignSelectionListener: TcxDesignSelectionListener;

initialization
  DesignSelectionListener := TcxDesignSelectionListener.Create;
  RegisterStyleSheetClass(TcxTreeListStyleSheet);

finalization
  UnRegisterStyleSheetClass(TcxTreeListStyleSheet);
  DesignSelectionListener.Free;

end.
