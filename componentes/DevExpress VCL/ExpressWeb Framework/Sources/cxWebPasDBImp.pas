{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Pascal script DB importers                                  }
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
unit cxWebPasDBImp;

interface

uses
  Classes, ifps3, ifpscomp, ifps3common, ifps3utl, ifpiclass, ifpiclassruntime,
  cxWebPasImpFactory, cxWebPasImp;

type
  TcxWebCustomDataBindingImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDataBindingImporter = class(TcxWebCustomDataBindingImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomWebDataFieldsImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomWebDataFieldImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomWebDataSourceImporter = class(TcxWebComponentImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxStdWebDataFieldsImporter = class(TcxCustomWebDataFieldsImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxStdWebDataFieldImporter = class(TcxCustomWebDataFieldImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxStdWebDataSourceImporter = class(TcxCustomWebDataSourceImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomWebDataControllerFieldsImporter = class(TcxCustomWebDataFieldsImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomWebDataControllerFieldImporter = class(TcxCustomWebDataFieldImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxExtWebDataSourceImporter = class(TcxCustomWebDataSourceImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDataControllerFieldsImporter = class(TcxCustomWebDataControllerFieldsImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDataControllerFieldImporter = class(TcxCustomWebDataControllerFieldImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDataSourceImporter = class(TcxExtWebDataSourceImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBDataControllerFieldsImporter = class(TcxCustomWebDataControllerFieldsImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBDataControllerFieldImporter = class(TcxCustomWebDataControllerFieldImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBDataSourceImporter = class(TcxExtWebDataSourceImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBCalendarImporter = class(TcxWebCalendarImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBLabelImporter = class(TcxWebLabelImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBEditImporter = class(TcxWebEditImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBMemoImporter = class(TcxWebMemoImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBListBoxImporter = class(TcxWebListBoxImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBComboBoxImporter = class(TcxWebComboBoxImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBCheckBoxImporter = class(TcxWebCheckBoxImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBRadioGroupImporter = class(TcxWebRadioGroupImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBImageImporter = class(TcxWebImageImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBDateEditImporter = class(TcxWebDateEditImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBDataNavigatorImporter = class(TcxCustomWebDataNavigatorImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebGridDataBindingImporter = class(TcxWebCustomDataBindingImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBGridImporter = class(TcxWebControlImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxCustomWebDBLookupDataBindingImporter = class(TcxWebDataBindingImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebLookupDataBindingImporter = class(TcxCustomWebDBLookupDataBindingImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBLookupImporter = class(TcxWebDBComboBoxImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebExtLookupDataBindingImporter = class(TcxCustomWebDBLookupDataBindingImporter)
  protected
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebExtDBLookupImporter = class(TcxWebDBLookupImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBTableImporter = class(TcxWebTableImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebTableColumnDataBindingImporter = class(TcxPascalScriptImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBTableColumnsImporter = class(TcxWebTableColumnsImporter)
  protected
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
    class procedure DeclareClassMembers(ACTClass: TIFPSCompileTimeClass); override;
    class procedure RegisterClassMembers(ARTClass: TIFPSRuntimeClass); override;
  public
    class function ObjectClass: TClass; override;
  end;

  TcxWebDBTableColumnImporter = class(TcxWebTableColumnImporter)
  protected
    class procedure DeclareTypes(ACompiler: TIFPSPascalCompiler); override;
    class procedure EnumDependentClasses(Proc: TClassEnumProc; AObject: TObject); override;
  public
    class function ObjectClass: TClass; override;
  end;
  
implementation

uses SysUtils, DB,
  cxWebData, cxWebDataCtrls, cxWebExtData, cxWebGrids, cxWebDBGrid, cxWebImgList,
  cxWebMenus, cxWebDBLookup, cxWebDBTable;

{ TcxWebCustomDataBindingImporter }

class procedure TcxWebCustomDataBindingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Component', scxComponentType, iptR);
end;

class procedure TcxWebCustomDataBindingImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataSource, AObject);
end;

class function TcxWebCustomDataBindingImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDataBinding;
end;

procedure TcxCustomWebDataBindingComponent_R(ASelf: TcxCustomWebDataBinding; var AValue: TComponent);
begin
  AValue := ASelf.Component;
end;

class procedure TcxWebCustomDataBindingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxCustomWebDataBindingComponent_R, nil, UpperCase('Component'));
end;

{ TcxWebDataBindingImporter }

class procedure TcxWebDataBindingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('Field', 'TcxCustomWebDataField', iptR);
    RegisterProperty('FieldIndex', scxIntegerType, iptR);
  end;
end;

class procedure TcxWebDataBindingImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataField, AObject);
end;

class function TcxWebDataBindingImporter.ObjectClass: TClass;
begin
  Result := TcxWebDataBinding;
end;

procedure TcxWebDataBindingImporterField_R(ASelf: TcxWebDataBinding; var AValue: TcxCustomWebDataField);
begin
  AValue := ASelf.Field;
end;

procedure TcxWebDataBindingImporterFieldIndex_R(ASelf: TcxWebDataBinding; var AValue: Integer);
begin
  AValue := ASelf.FieldIndex;
end;

class procedure TcxWebDataBindingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebDataBindingImporterField_R, nil, UpperCase('Field'));
    RegisterPropertyHelper(@TcxWebDataBindingImporterFieldIndex_R, nil, UpperCase('FieldIndex'));
  end;
end;

{ TcxCustomWebDataFieldsImporter }

class procedure TcxCustomWebDataFieldsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxCustomWebDataField' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxCustomWebDataFieldsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataField, AObject);
end;

class function TcxCustomWebDataFieldsImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDataFields;
end;

procedure TcxCustomWebDataFieldsItems_R(ASelf: TcxCustomWebDataFields; var AValue: TcxCustomWebDataField; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxCustomWebDataFieldsItems_W(ASelf: TcxCustomWebDataFields; AValue: TcxCustomWebDataField; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxCustomWebDataFieldsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxCustomWebDataFieldsItems_R, @TcxCustomWebDataFieldsItems_W, UpperCase('Items'));
end;

{ TcxCustomWebDataField }

class procedure TcxCustomWebDataFieldImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataFields, AObject);
end;

class function TcxCustomWebDataFieldImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDataField;
end;

{ TcxCustomWebDataSourceImporter }

class procedure TcxCustomWebDataSourceImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebDataSortOrder', '(wsoNone, wsoAscending, wsoDescending)');
  ACompiler.AddTypeS('TcxWebDataSourceState', '(browsing, editing, inserting)');
end;

class procedure TcxCustomWebDataSourceImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function CheckRowIndex(ARowIndex: Integer): Boolean;');
    RegisterMethod('function FieldByName(const Name: string): TcxCustomWebDataField;');
    RegisterMethod('function GetRowDisplayText(RowIndex: Integer; ItemIndex: Integer): string;');
    RegisterMethod('function GetRowValue(RowIndex: Integer; ItemIndex: Integer): Variant;');
    RegisterMethod('function GetRowExpanded(RowIndex: Integer): Boolean;');
    RegisterMethod('function GetRowLevel(RowIndex: Integer): Integer;');
    RegisterMethod('function GetRowRecord(RowIndex: Integer): Integer;');
    RegisterMethod('function GetGroupingItemCount: Integer;');
    RegisterMethod('function GetSortingItemCount: Integer;');
    RegisterMethod('function GetItemGroupIndex(ItemIndex: Integer): Integer;');
    RegisterMethod('function GetItemSortOrder(ItemIndex: Integer): TcxWebDataSortOrder;');
    RegisterMethod('function GetGroupingItemIndex(Item: Integer): Integer;');
    RegisterMethod('function GetSortingItemIndex(Item: Integer): Integer;');
    RegisterMethod('procedure ClearGrouping;');
    RegisterMethod('procedure ClearSorting;');
    RegisterMethod('procedure FullCollapse;');
    RegisterMethod('procedure FullExpand;');
    RegisterMethod('procedure CancelEdit;');
    RegisterMethod('procedure DeleteRecord(ARowIndex: Integer);');
    RegisterMethod('procedure InsertRecord(ARowIndex: Integer);');
    RegisterMethod('procedure EditRecord(ARowIndex: Integer);');
    RegisterMethod('procedure Expand(ARowIndex: Integer; AExpanded, ARecursive: Boolean);');
    RegisterMethod('procedure Group(GroupField, GroupIndex: Integer);');
    RegisterMethod('procedure PostEdit(APriorControlName: string);');
    RegisterMethod('procedure SetEditValue(AItemIndex: Integer; AValue: Variant; AType: TcxWebDataTypes);');
    RegisterMethod('procedure Sort(SortIndex: Integer; SortOrder: TcxWebDataSortOrder);');
    RegisterMethod('procedure UnGroup(UnGroupIndex: Integer);');
    RegisterMethod('procedure Refresh;');

    RegisterProperty('DisplayTexts', scxStringType + ' ' + scxIntegerType + ' ' + scxIntegerType, iptR);
    RegisterProperty('FocusedRowIndex', scxIntegerType, iptRW);
    RegisterProperty('RecordCount', scxIntegerType, iptR);
    RegisterProperty('RowCount', scxIntegerType, iptR);
    RegisterProperty('Values', scxVariantType + ' ' + scxIntegerType + ' ' + scxIntegerType, iptRW);
    RegisterProperty('AllowExpanding', scxBooleanType, iptR);
    RegisterProperty('AllowGrouping', scxBooleanType, iptR);
    RegisterProperty('AllowSorting', scxBooleanType, iptR);
    RegisterProperty('Fields', 'TcxCustomWebDataFields', iptRW);
    RegisterProperty('FullName', scxStringType, iptR);
    RegisterProperty('State', 'TcxWebDataSourceState', iptR);
  end;
end;

class procedure TcxCustomWebDataSourceImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataField, AObject);
  Proc(TcxCustomWebDataFields, AObject);
end;

class function TcxCustomWebDataSourceImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDataSource;
end;

procedure TcxCustomWebDataSourceDisplayTexts_R(ASelf: TcxCustomWebDataSource; var AValue: string; Index1, Index2: Integer);
begin
  AValue := ASelf.DisplayTexts[Index1, Index2];
end;

procedure TcxCustomWebDataSourceFocusedRowIndex_R(ASelf: TcxCustomWebDataSource; var AValue: Integer);
begin
  AValue := ASelf.FocusedRowIndex;
end;

procedure TcxCustomWebDataSourceFocusedRowIndex_W(ASelf: TcxCustomWebDataSource; AValue: Integer);
begin
  ASelf.FocusedRowIndex := AValue;
end;

procedure TcxCustomWebDataSourceRecordCount_R(ASelf: TcxCustomWebDataSource; var AValue: Integer);
begin
  AValue := ASelf.RecordCount;
end;

procedure TcxCustomWebDataSourceRowCount_R(ASelf: TcxCustomWebDataSource; var AValue: Integer);
begin
  AValue := ASelf.RowCount;
end;

procedure TcxCustomWebDataSourceValues_R(ASelf: TcxCustomWebDataSource; var AValue: Variant; Index1, Index2: Integer);
begin
  AValue := ASelf.Values[Index1, Index2];
end;

procedure TcxCustomWebDataSourceValues_W(ASelf: TcxCustomWebDataSource; AValue: Variant; Index1, Index2: Integer);
begin
  ASelf.Values[Index1, Index2] := AValue;
end;

procedure TcxCustomWebDataSourceAllowExpanding_R(ASelf: TcxCustomWebDataSource; var AValue: Boolean);
begin
  AValue := ASelf.AllowExpanding;
end;

procedure TcxCustomWebDataSourceAllowGrouping_R(ASelf: TcxCustomWebDataSource; var AValue: Boolean);
begin
  AValue := ASelf.AllowGrouping;
end;

procedure TcxCustomWebDataSourceAllowSorting_R(ASelf: TcxCustomWebDataSource; var AValue: Boolean);
begin
  AValue := ASelf.AllowSorting;
end;

procedure TcxCustomWebDataSourceFields_R(ASelf: TcxCustomWebDataSource; var AValue: TcxCustomWebDataFields);
begin
  AValue := ASelf.Fields;
end;

procedure TcxCustomWebDataSourceFields_W(ASelf: TcxCustomWebDataSource; AValue: TcxCustomWebDataFields);
begin
  ASelf.Fields := AValue;
end;

procedure TcxCustomWebDataSourceFullName_R(ASelf: TcxCustomWebDataSource; var AValue: string);
begin
  AValue := ASelf.FullName;
end;

procedure TcxCustomWebDataSourceState_R(ASelf: TcxCustomWebDataSource; var AValue: TcxWebDataSourceState);
begin
  AValue := ASelf.State;
end;

class procedure TcxCustomWebDataSourceImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxCustomWebDataSource.CheckRowIndex, UpperCase('CheckRowIndex'));
    RegisterMethod(@TcxCustomWebDataSource.FieldByName, UpperCase('FieldByName'));
    RegisterMethod(@TcxCustomWebDataSource.GetRowDisplayText, UpperCase('GetRowDisplayText'));
    RegisterMethod(@TcxCustomWebDataSource.GetRowValue, UpperCase('GetRowValue'));
    RegisterMethod(@TcxCustomWebDataSource.GetRowExpanded, UpperCase('GetRowExpanded'));
    RegisterMethod(@TcxCustomWebDataSource.GetRowLevel, UpperCase('GetRowLevel'));
    RegisterMethod(@TcxCustomWebDataSource.GetRowRecord, UpperCase('GetRowRecord'));
    RegisterMethod(@TcxCustomWebDataSource.GetGroupingItemCount, UpperCase('GetGroupingItemCount'));
    RegisterMethod(@TcxCustomWebDataSource.GetSortingItemCount, UpperCase('GetSortingItemCount'));
    RegisterMethod(@TcxCustomWebDataSource.GetItemGroupIndex, UpperCase('GetItemGroupIndex'));
    RegisterMethod(@TcxCustomWebDataSource.GetItemSortOrder, UpperCase('GetItemSortOrder'));
    RegisterMethod(@TcxCustomWebDataSource.GetGroupingItemIndex, UpperCase('GetGroupingItemIndex'));
    RegisterMethod(@TcxCustomWebDataSource.GetSortingItemIndex, UpperCase('GetSortingItemIndex'));
    RegisterMethod(@TcxCustomWebDataSource.ClearGrouping, UpperCase('ClearGrouping'));
    RegisterMethod(@TcxCustomWebDataSource.ClearSorting, UpperCase('ClearSorting'));
    RegisterMethod(@TcxCustomWebDataSource.FullCollapse, UpperCase('FullCollapse'));
    RegisterMethod(@TcxCustomWebDataSource.FullExpand, UpperCase('FullExpand'));
    RegisterMethod(@TcxCustomWebDataSource.CancelEdit, UpperCase('CancelEdit'));
    RegisterMethod(@TcxCustomWebDataSource.DeleteRecord, UpperCase('DeleteRecord'));
    RegisterMethod(@TcxCustomWebDataSource.InsertRecord, UpperCase('InsertRecord'));
    RegisterMethod(@TcxCustomWebDataSource.EditRecord, UpperCase('EditRecord'));
    RegisterMethod(@TcxCustomWebDataSource.Expand, UpperCase('Expand'));
    RegisterMethod(@TcxCustomWebDataSource.Group, UpperCase('Group'));
    RegisterMethod(@TcxCustomWebDataSource.PostEdit, UpperCase('PostEdit'));
    RegisterMethod(@TcxCustomWebDataSource.SetEditValue, UpperCase('SetEditValue'));
    RegisterMethod(@TcxCustomWebDataSource.Sort, UpperCase('Sort'));
    RegisterMethod(@TcxCustomWebDataSource.UnGroup, UpperCase('UnGroup'));
    RegisterMethod(@TcxCustomWebDataSource.Refresh, UpperCase('Refresh'));

    RegisterPropertyHelper(@TcxCustomWebDataSourceDisplayTexts_R, nil, UpperCase('DisplayTexts'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceFocusedRowIndex_R, @TcxCustomWebDataSourceFocusedRowIndex_W, UpperCase('FocusedRowIndex'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceRecordCount_R, nil, UpperCase('RecordCount'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceRowCount_R, nil, UpperCase('RowCount'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceValues_R, @TcxCustomWebDataSourceValues_W, UpperCase('Values'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceAllowExpanding_R, nil, UpperCase('AllowExpanding'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceAllowGrouping_R, nil, UpperCase('AllowGrouping'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceAllowSorting_R, nil, UpperCase('AllowSorting'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceFields_R, @TcxCustomWebDataSourceFields_W, UpperCase('Fields'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceFullName_R, nil, UpperCase('FullName'));
    RegisterPropertyHelper(@TcxCustomWebDataSourceState_R, nil, UpperCase('State'));
  end;
end;

{ TcxStdWebDataFieldsImporter }

class procedure TcxStdWebDataFieldsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxStdWebDataField' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxStdWebDataFieldsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxStdWebDataField, AObject);
end;

class function TcxStdWebDataFieldsImporter.ObjectClass: TClass;
begin
  Result := TcxStdWebDataFields;
end;

procedure TcxStdWebDataFieldsItems_R(ASelf: TcxStdWebDataFields; var AValue: TcxStdWebDataField; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxStdWebDataFieldsItems_W(ASelf: TcxStdWebDataFields; AValue: TcxStdWebDataField; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxStdWebDataFieldsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxStdWebDataFieldsItems_R, @TcxStdWebDataFieldsItems_W, UpperCase('Items'));
end;

{ TcxStdWebDataFieldImporter }

class procedure TcxStdWebDataFieldImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('DataSet', 'TDataSet', iptR);
    RegisterProperty('FieldName', scxStringType, iptRW);
  end;
end;

class procedure TcxStdWebDataFieldImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TDataSet, AObject);
  Proc(TcxStdWebDataFields, AObject);
end;

class function TcxStdWebDataFieldImporter.ObjectClass: TClass;
begin
  Result := TcxStdWebDataField;
end;

procedure TcxStdWebDataFieldDataSet_R(ASelf: TcxStdWebDataField; var AValue: TDataSet);
begin
  AValue := ASelf.DataSet;
end;

procedure TcxStdWebDataFieldFieldName_R(ASelf: TcxStdWebDataField; var AValue: string);
begin
  AValue := ASelf.FieldName;
end;

procedure TcxStdWebDataFieldFieldName_W(ASelf: TcxStdWebDataField; AValue: string);
begin
  ASelf.FieldName := AValue;
end;

class procedure TcxStdWebDataFieldImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxStdWebDataFieldDataSet_R, nil, UpperCase('DataSet'));
    RegisterPropertyHelper(@TcxStdWebDataFieldFieldName_R, @TcxStdWebDataFieldFieldName_W, UpperCase('FieldName'));
  end;
end;

{ TcxStdWebDataSourceImporter }

class procedure TcxStdWebDataSourceImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Fields', 'TcxStdWebDataFields', iptRW);
end;

class procedure TcxStdWebDataSourceImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxStdWebDataFields, AObject);
  Proc(TDataSet, AObject);
end;

class function TcxStdWebDataSourceImporter.ObjectClass: TClass;
begin
  Result := TcxStdWebDataSource;
end;

procedure TcxStdWebDataSourceFields_R(ASelf: TcxStdWebDataSource; var AValue: TcxStdWebDataFields);
begin
  AValue := ASelf.Fields;
end;

procedure TcxStdWebDataSourceFields_W(ASelf: TcxStdWebDataSource; AValue: TcxStdWebDataFields);
begin
  ASelf.Fields := AValue;
end;

class procedure TcxStdWebDataSourceImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxStdWebDataSourceFields_R, @TcxStdWebDataSourceFields_W, UpperCase('Fields'));
end;

{ TcxCustomWebDataControllerFieldsImporter }

class procedure TcxCustomWebDataControllerFieldsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxCustomWebDataControllerField' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxCustomWebDataControllerFieldsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataControllerField, AObject);
end;

class function TcxCustomWebDataControllerFieldsImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDataControllerFields;
end;

procedure TcxCustomWebDataControllerFieldsItems_R(ASelf: TcxCustomWebDataControllerFields;
  var AValue: TcxCustomWebDataControllerField; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxCustomWebDataControllerFieldsItems_W(ASelf: TcxCustomWebDataControllerFields;
  AValue: TcxCustomWebDataControllerField; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxCustomWebDataControllerFieldsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxCustomWebDataControllerFieldsItems_R,
    @TcxCustomWebDataControllerFieldsItems_W, UpperCase('Items'));
end;

{ TcxCustomWebDataControllerFieldImporter }

class procedure TcxCustomWebDataControllerFieldImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebDataSortOrder', '(wsoNone, wsoAscending, wsoDescending)');
end;

class procedure TcxCustomWebDataControllerFieldImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataControllerFields, AObject);
end;

class function TcxCustomWebDataControllerFieldImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDataControllerField;
end;

{ TcxWebDataControllerFieldsImporter }

class procedure TcxWebDataControllerFieldsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxWebDataControllerField' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxWebDataControllerFieldsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataControllerField, AObject);
end;

class function TcxWebDataControllerFieldsImporter.ObjectClass: TClass;
begin
  Result := TcxWebDataControllerFields;
end;

procedure TcxWebDataControllerFieldsItems_R(ASelf: TcxWebDataControllerFields;
  var AValue: TcxWebDataControllerField; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebDataControllerFieldsItems_W(ASelf: TcxWebDataControllerFields;
  AValue: TcxWebDataControllerField; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebDataControllerFieldsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebDataControllerFieldsItems_R,
    @TcxWebDataControllerFieldsItems_W, UpperCase('Items'));
end;

{ TcxWebDataControllerFieldImporter }

class procedure TcxWebDataControllerFieldImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxValueType', '(StringType, WideStringType, SmallintType,' +
                     ' IntegerType, WordType, BooleanType, FloatType, CurrencyType,' +
                     ' DateTimeType, FMTBcdType, LargeIntType, VariantType, ObjectType)');
end;

class procedure TcxWebDataControllerFieldImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataControllerFields, AObject);
end;

class function TcxWebDataControllerFieldImporter.ObjectClass: TClass;
begin
  Result := TcxWebDataControllerField;
end;

{ TcxWebDBDataControllerFieldsImporter }

class procedure TcxWebDBDataControllerFieldsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxWebDBDataControllerField' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxWebDBDataControllerFieldsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDBDataControllerField, AObject);
end;

class function TcxWebDBDataControllerFieldsImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBDataControllerFields;
end;

procedure TcxWebDBDataControllerFieldsItems_R(ASelf: TcxWebDBDataControllerFields;
  var AValue: TcxWebDBDataControllerField; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebDBDataControllerFieldsItems_W(ASelf: TcxWebDBDataControllerFields;
  AValue: TcxWebDBDataControllerField; Index: Integer);
begin
  ASelf.Items[Index] := AValue;
end;

class procedure TcxWebDBDataControllerFieldsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebDBDataControllerFieldsItems_R,
    @TcxWebDBDataControllerFieldsItems_W, UpperCase('Items'));
end;

{ TcxWebDBDataControllerFieldImporter }

class procedure TcxWebDBDataControllerFieldImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('DataSet', 'TDataSet', iptR);
end;

class procedure TcxWebDBDataControllerFieldImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDBDataControllerFields, AObject);
  Proc(TDataSet, AObject);
end;

class function TcxWebDBDataControllerFieldImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBDataControllerField;
end;

procedure TcxWebDBDataControllerFieldDataset_R(ASelf: TcxWebDBDataControllerField; var AValue: TDataSet);
begin
  AValue := ASelf.DataSet;
end;

class procedure TcxWebDBDataControllerFieldImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebDBDataControllerFieldDataset_R, nil, UpperCase('DataSet'));
end;

{ TcxExtWebDataSourceImporter }

class procedure TcxExtWebDataSourceImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Fields', 'TcxCustomWebDataControllerFields', iptRW);
end;

class procedure TcxExtWebDataSourceImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataControllerFields, AObject);
end;

class function TcxExtWebDataSourceImporter.ObjectClass: TClass;
begin
  Result := TcxExtWebDataSource;
end;

procedure TcxExtWebDataSourceFields_R(ASelf: TcxExtWebDataSource; var AValue: TcxCustomWebDataControllerFields);
begin
  AValue := ASelf.Fields;
end;

procedure TcxExtWebDataSourceFields_W(ASelf: TcxExtWebDataSource; AValue: TcxCustomWebDataControllerFields);
begin
  ASelf.Fields := AValue;
end;

class procedure TcxExtWebDataSourceImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxExtWebDataSourceFields_R, @TcxExtWebDataSourceFields_W, UpperCase('Fields'));
end;

{ TcxWebDataSourceImporter }

class procedure TcxWebDataSourceImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('procedure LoadFromStream(AStream: TStream);');
    RegisterMethod('procedure SaveToStream(AStream: TStream);');
  end;
end;

class procedure TcxWebDataSourceImporter.EnumDependentClasses(Proc: TClassEnumProc;
  AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataControllerFields, AObject);
end;

class function TcxWebDataSourceImporter.ObjectClass: TClass;
begin
  Result := TcxWebDataSource;
end;

class procedure TcxWebDataSourceImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebDataSource.LoadFromStream, UpperCase('LoadFromStream'));
    RegisterMethod(@TcxWebDataSource.SaveToStream, UpperCase('SaveToStream'));
  end;
end;

{ TcxWebDBDataSourceImporter }

class procedure TcxWebDBDataSourceImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Fields', 'TcxWebDBDataControllerFields', iptRW);
end;

class procedure TcxWebDBDataSourceImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDBDataControllerFields, AObject);
  Proc(TDataSet, AObject);
end;

class function TcxWebDBDataSourceImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBDataSource;
end;

procedure TcxWebDBDataSourceFields_R(ASelf: TcxWebDBDataSource; var AValue: TcxWebDBDataControllerFields);
begin
  AValue := ASelf.Fields;
end;

procedure TcxWebDBDataSourceFields_W(ASelf: TcxWebDBDataSource; AValue: TcxWebDBDataControllerFields);
begin
  ASelf.Fields := AValue;
end;

class procedure TcxWebDBDataSourceImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebDBDataSourceFields_R, @TcxWebDBDataSourceFields_W, UpperCase('Fields'));
end;

{ TcxWebDBCalendarImporter }

class procedure TcxWebDBCalendarImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBCalendarImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBCalendar;
end;

{ TcxWebDBLabelImporter }

class procedure TcxWebDBLabelImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBLabelImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBLabel;
end;

{ TcxWebDBEditImporter }

class procedure TcxWebDBEditImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBEditImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBEdit;
end;

{ TcxWebDBMemoImporter }

class procedure TcxWebDBMemoImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBMemoImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBMemo;
end;

{ TcxWebDBListBoxImporter }

class procedure TcxWebDBListBoxImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBListBoxImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBListBox;
end;

{ TcxWebDBComboBoxImporter }

class procedure TcxWebDBComboBoxImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBComboBoxImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBComboBox;
end;

{ TcxWebDBCheckBoxImporter }

class procedure TcxWebDBCheckBoxImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebCheckBoxUndefinedValueState', '(uvsChecked, uvsUnchecked)');
end;

class procedure TcxWebDBCheckBoxImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBCheckBoxImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBCheckBox;
end;

{ TcxWebDBRadioGroupImporter }

class procedure TcxWebDBRadioGroupImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBRadioGroupImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBRadioGroup;
end;

{ TcxWebDBImageImporter }

class procedure TcxWebDBImageImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBImageImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBImage;
end;

{ TcxWebDBDateEditImporter }

class procedure TcxWebDBDateEditImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBDateEditImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBDateEdit;
end;

{ TcxWebDBDataNavigatorImporter }

class procedure TcxWebDBDataNavigatorImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDataBinding, AObject);
end;

class function TcxWebDBDataNavigatorImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBDataNavigator;
end;

{ TcxWebDBGridImporter }

class procedure TcxWebDBGridImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxIndicatorType', '(itCursor, itDataOp)');
end;

class procedure TcxWebDBGridImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebGridDataBinding, AObject);
  Proc(TcxWebPopupMenu, AObject);
  Proc(TcxWebImageList, AObject);
  Proc(TcxWebGridImageIndexes, AObject);
end;

class function TcxWebDBGridImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBGrid;
end;

{ TcxWebGridDataBindingImporter }

class procedure TcxWebGridDataBindingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('WebDBGrid', 'TcxWebDBGrid', iptR);
end;

class procedure TcxWebGridDataBindingImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDBGrid, AObject);
end;

class function TcxWebGridDataBindingImporter.ObjectClass: TClass;
begin
  Result := TcxWebGridDataBinding;
end;

procedure TcxWebGridDataBindingWebDBGrid_R(ASelf: TcxWebGridDataBinding; var AValue: TcxWebDBGrid);
begin
  AValue := ASelf.WebDBGrid;
end;

class procedure TcxWebGridDataBindingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebGridDataBindingWebDBGrid_R, nil, UpperCase('WebDBGrid'));
end;

{ TcxWebDBLookupImporter }

class procedure TcxWebDBLookupImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebLookupDataBinding, AObject);
end;

class function TcxWebDBLookupImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBLookup;
end;

{ TcxCustomWebDBLookupDataBindingImporter }

class procedure TcxCustomWebDBLookupDataBindingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function KeyField: TcxCustomWebDataField;');
    RegisterMethod('function KeyFieldIndex: Integer;');
  end;
end;

class procedure TcxCustomWebDBLookupDataBindingImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataField, AObject);
  Proc(TcxCustomWebDataSource, AObject);
end;

class function TcxCustomWebDBLookupDataBindingImporter.ObjectClass: TClass;
begin
  Result := TcxCustomWebDBLookupDataBinding;
end;

class procedure TcxCustomWebDBLookupDataBindingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxCustomWebDBLookupDataBinding.KeyField, UpperCase('KeyField'));
    RegisterMethod(@TcxCustomWebDBLookupDataBinding.KeyFieldIndex, UpperCase('KeyFieldIndex'));
  end;
end;

{ TcxWebLookupDataBindingImporter }

class procedure TcxWebLookupDataBindingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function ListField: TcxCustomWebDataField;');
    RegisterMethod('function ListFieldIndex: Integer;');
  end;
end;

class function TcxWebLookupDataBindingImporter.ObjectClass: TClass;
begin
  Result := TcxWebLookupDataBinding;
end;

class procedure TcxWebLookupDataBindingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebLookupDataBinding.ListField, UpperCase('ListField'));
    RegisterMethod(@TcxWebLookupDataBinding.ListFieldIndex, UpperCase('ListFieldIndex'));
  end;
end;

{ TcxWebExtLookupDataBindingImporter }

class procedure TcxWebExtLookupDataBindingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function ListField: TcxCustomWebDataField;');
    RegisterProperty('ListFieldCount', scxIntegerType, iptR);
    RegisterProperty('ListFields', 'TcxCustomWebDataField' + ' ' + scxIntegerType, iptR);
  end;
end;

class function TcxWebExtLookupDataBindingImporter.ObjectClass: TClass;
begin
  Result := TcxWebExtLookupDataBinding;
end;

procedure TcxWebLookupDataBindingListFieldCount_R(ASelf: TcxWebExtLookupDataBinding; var AValue: Integer);
begin
  AValue := ASelf.ListFieldCount;
end;

procedure TcxWebLookupDataBindingListFields_R(ASelf: TcxWebExtLookupDataBinding; var AValue: TcxCustomWebDataField; Index: Integer);
begin
  AValue := ASelf.ListFields[Index];
end;

class procedure TcxWebExtLookupDataBindingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebLookupDataBinding.ListField, UpperCase('ListField'));
    RegisterPropertyHelper(@TcxWebLookupDataBindingListFieldCount_R, nil, UpperCase('ListFieldCount'));
    RegisterPropertyHelper(@TcxWebLookupDataBindingListFields_R, nil, UpperCase('ListFields'));
  end;
end;

{ TcxWebExtDBLookupImporter }

class procedure TcxWebExtDBLookupImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebExtLookupDataBinding, AObject);
  Proc(TcxWebImageList, AObject);  
end;

class function TcxWebExtDBLookupImporter.ObjectClass: TClass;
begin
  Result := TcxWebExtDBLookup;
end;

{ TcxWebDBTableImporter }

class procedure TcxWebDBTableImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterMethod('function DataSource: TcxCustomWebDataSource;');
    RegisterMethod('function GetFieldValue(ARecIndex: Integer; AFieldName: string): Variant;');
    RegisterMethod('function GetFieldDisplayText(ARecIndex: Integer; AFieldName: string): string;');
  end;
end;

class procedure TcxWebDBTableImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebTableDataBinding, AObject);
  Proc(TcxWebDBTableColumns, AObject);
  Proc(TcxCustomWebDataSource, AObject);
end;

class function TcxWebDBTableImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBTable;
end;

class procedure TcxWebDBTableImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterMethod(@TcxWebDBTable.DataSource, ('DataSource'));
    RegisterMethod(@TcxWebDBTable.GetFieldValue, UpperCase('GetFieldValue'));
    RegisterMethod(@TcxWebDBTable.GetFieldDisplayText, UpperCase('GetFieldDisplayText'));
  end;
end;

{ TcxWebDBTableColumnsImporter }

class procedure TcxWebDBTableColumnsImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  ACTClass.RegisterProperty('Items', 'TcxWebDBTableColumn' + ' ' + scxIntegerType, iptRW);
end;

class procedure TcxWebDBTableColumnsImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDBTableColumn, AObject);
end;

class function TcxWebDBTableColumnsImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBTableColumns;
end;

procedure TcxWebDBTableColumnsItems_R(ASelf: TcxWebDBTableColumns; var AVAlue: TcxWebDBTableColumn; Index: Integer);
begin
  AValue := ASelf.Items[Index];
end;

procedure TcxWebDBTableColumnsItems_W(ASelf: TcxWebDBTableColumns; AVAlue: TcxWebDBTableColumn; Index: Integer);
begin
  ASelf.Items[Index] := AVAlue;
end;

class procedure TcxWebDBTableColumnsImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  ARTClass.RegisterPropertyHelper(@TcxWebDBTableColumnsItems_R, @TcxWebDBTableColumnsItems_W, UpperCase('Items'));
end;

{ TcxWebDBTableColumnImporter }

class procedure TcxWebDBTableColumnImporter.DeclareTypes(
  ACompiler: TIFPSPascalCompiler);
begin
  inherited;
  ACompiler.AddTypeS('TcxWebDataSortOrder', '(wsoNone, wsoAscending, wsoDescending)');
end;

class procedure TcxWebDBTableColumnImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxWebDBTableColumns, AObject);
  Proc(TcxWebTableColumnDataBinding, AObject);
end;

class function TcxWebDBTableColumnImporter.ObjectClass: TClass;
begin
  Result := TcxWebDBTableColumn;
end;

{ TcxWebTableColumnDataBindingImporter }

class procedure TcxWebTableColumnDataBindingImporter.DeclareClassMembers(
  ACTClass: TIFPSCompileTimeClass);
begin
  inherited;
  with ACTClass do
  begin
    RegisterProperty('DataSource', 'TcxCustomWebDataSource', iptR);
    RegisterProperty('FieldIndex', scxIntegerType, iptR);
    RegisterProperty('DBColumn', 'TcxWebDBTableColumn', iptR);
  end;
end;

class procedure TcxWebTableColumnDataBindingImporter.EnumDependentClasses(
  Proc: TClassEnumProc; AObject: TObject);
begin
  inherited;
  Proc(TcxCustomWebDataSource, AObject);
  Proc(TcxWebDBTableColumn, AObject);  
end;

class function TcxWebTableColumnDataBindingImporter.ObjectClass: TClass;
begin
  Result := TcxWebTableColumnDataBinding;
end;

procedure TcxWebTableColumnDataBindingDataSource_R(ASelf: TcxWebTableColumnDataBinding; var AValue: TcxCustomWebDataSource);
begin
  AValue := ASelf.DataSource;
end;

procedure TcxWebTableColumnDataBindingFieldIndex_R(ASelf: TcxWebTableColumnDataBinding; var AValue: Integer);
begin
  AValue := ASelf.FieldIndex;
end;

procedure TcxWebTableColumnDataBindingDBColumn_R(ASelf: TcxWebTableColumnDataBinding; var AValue: TcxWebDBTableColumn);
begin
  AValue := ASelf.DBColumn;
end;

class procedure TcxWebTableColumnDataBindingImporter.RegisterClassMembers(
  ARTClass: TIFPSRuntimeClass);
begin
  inherited;
  with ARTClass do
  begin
    RegisterPropertyHelper(@TcxWebTableColumnDataBindingDataSource_R, nil, UpperCase('DataSource'));
    RegisterPropertyHelper(@TcxWebTableColumnDataBindingFieldIndex_R, nil, UpperCase('FieldIndex'));
    RegisterPropertyHelper(@TcxWebTableColumnDataBindingDBColumn_R, nil, UpperCase('DBColumn'));
  end;
end;

initialization
  cxPasScriptImpFactory.RegisterImporter(TcxWebCustomDataBindingImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDataBindingImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomWebDataFieldsImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomWebDataFieldImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomWebDataSourceImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxStdWebDataFieldsImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxStdWebDataFieldImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxStdWebDataSourceImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomWebDataControllerFieldsImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomWebDataControllerFieldImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxExtWebDataSourceImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDataControllerFieldsImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDataControllerFieldImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDataSourceImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBDataControllerFieldsImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBDataControllerFieldImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBDataSourceImporter, 'WebDB');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBLabelImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBCalendarImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBEditImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBMemoImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBListBoxImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBComboBoxImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBCheckBoxImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBRadioGroupImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBImageImporter, 'WebDBControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBDateEditImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBDataNavigatorImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBGridImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebGridDataBindingImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxCustomWebDBLookupDataBindingImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebLookupDataBindingImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBLookupImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebExtLookupDataBindingImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebExtDBLookupImporter, 'WebDBAdvControls');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBTableImporter, 'WebDBTable');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBTableColumnsImporter, 'WebDBTable');
  cxPasScriptImpFactory.RegisterImporter(TcxWebDBTableColumnImporter, 'WebDBTable');
  cxPasScriptImpFactory.RegisterImporter(TcxWebTableColumnDataBindingImporter, 'WebDBTable');

end.
