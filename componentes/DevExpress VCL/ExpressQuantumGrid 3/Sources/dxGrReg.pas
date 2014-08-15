
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid Suite registration                       }
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

unit dxGrReg;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, dxTL, dxDBGrid, dxDBCtrl;

procedure Register;
procedure AddADBGroupListColumns(AColumns: array of TPersistentClass);

const
  dxGrVersion = '3.54';
  ADBGroupListColumns: TStringList = nil;

implementation

uses
  TypInfo{$IFNDEF DELPHI3}, DBTables{$ENDIF}, dxGrEdtr,
  dxLayout, dxGLayEd, dxWizard{$IFNDEF DELPHI6}, DsgnIntf{$ELSE},
  DesignIntf, DesignEditors{$ENDIF}, MaskProp;

type
  {TdxDBGridEditor}
  TdxDBGridEditor = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  {TdxDBColumnFieldProperty}
  TdxDBColumnFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {TdxDBColumnSummaryFieldProperty}
  TdxDBColumnSummaryFieldProperty = class(TdxDBColumnFieldProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  {TdxDBGridSummaryItemFieldProperty}
  TdxDBGridSummaryItemFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {TdxDBGridSummaryItemColumnNameProperty}
  TdxDBGridSummaryItemColumnNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {TdxDBColumnSummaryGroupNameProperty}
  TdxDBColumnSummaryGroupNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {TdxDBGridFieldProperty}
  TdxDBGridFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings);
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {TdxDBGridSummaryGroupsProperty}
  TdxDBGridSummaryGroupsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {TdxDBGridBandsProperty}
  TdxDBGridBandsProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {TdxDBGridLayoutListEditor}
  TdxDBGridLayoutListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TdxDBGridEditor }

procedure TdxDBGridEditor.Edit;
begin
  if GetVerbCount > 1 then ExecuteVerb(3);
end;

procedure TdxDBGridEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: begin
         // hide columns editor
         if TdxDBGrid(Component).Designer <> nil then TdxDBGrid(Component).Designer.Free;
         ShowdxDBGridWizard(TdxDBGrid(Component), Pointer(Designer), TdxDBGrid(Component).Owner);
       end;
    2: ShowdxDBGridEditor(TdxDBGrid(Component), Pointer(Designer), 0, TdxDBGrid(Component).Owner); // bands
    3: ShowdxDBGridEditor(TdxDBGrid(Component), Pointer(Designer), 1, TdxDBGrid(Component).Owner); // columns
    4: ShowdxDBGridEditor(TdxDBGrid(Component), Pointer(Designer), 2, TdxDBGrid(Component).Owner); // summary
  end;
end;

function TdxDBGridEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'QuantumWizard...';
    1: Result := '-';
    2: Result := 'Bands...';
    3: Result := 'Columns...';
    4: Result := 'Summary...';
    5: Result := '-';
    6: Result := 'www.devexpress.com';
    7: Result := 'ExpressQuantumGrid ' + dxGrVersion;
  end;
end;

function TdxDBGridEditor.GetVerbCount: Integer;
begin
  Result := 5 + 3;
end;

{TdxDBColumnFieldProperty}
function TdxDBColumnFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBColumnFieldProperty.GetValueList(List: TStrings);
var
  ADBControl: TCustomdxDBTreeListControl;
begin
  ADBControl := TdxDBTreeListColumn(GetComponent(0)).ATreeList;
  if (ADBControl.DataSource <> nil)
   and (ADBControl.DataSource.DataSet <> nil) then
      ADBControl.DataSource.DataSet.GetFieldNames(List);
end;

procedure TdxDBColumnFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{TdxDBGridFieldProperty}
function TdxDBGridFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBGridFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

procedure TdxDBGridFieldProperty.GetValueList(List: TStrings);
var
  ADBdxGrid : TCustomdxDBTreeListControl;
begin
  ADBdxGrid := GetComponent(0) as TCustomdxDBTreeListControl;
  if (ADBdxGrid.DataSource <> nil) and
     (ADBdxGrid.DataSource.DataSet <> nil) then
      ADBdxGrid.DataSource.DataSet.GetFieldNames(List);
end;

{TdxDBColumnSummaryFieldProperty}
procedure TdxDBColumnSummaryFieldProperty.GetValueList(List: TStrings);
var
  ADBControl: TCustomdxDBTreeListControl;
  ADataSet: TDataSet;
  i: Integer;
begin
  ADBControl := TdxDBTreeListColumn(GetComponent(0)).ATreeList;
  if (ADBControl.DataSource <> nil)
   and (ADBControl.DataSource.DataSet <> nil) then
   Begin
     ADataSet := ADBControl.DataSource.DataSet;
     for i := 0 to ADataSet.FieldCount - 1 do
       if (ADataSet.Fields[i] is TNumericField) or
        (ADataSet.Fields[i].DataType in [ftDate, ftTime, ftDateTime]) then
        List.Add(ADataSet.Fields[i].FieldName);
   End;
end;

{TdxDBGridSummaryItemFieldProperty}
function TdxDBGridSummaryItemFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBGridSummaryItemFieldProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
  ADBGrid: TCustomdxDBGrid;
  ADataSet: TDataSet;
begin
  Values := TStringList.Create;
  try
    // GetValueList(Values);
    if (TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems <> nil) and
      (TdxDBGridSummaryItems(TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems).SummaryGroup <> nil) and
      (TdxDBGridSummaryItems(TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems).SummaryGroup.GetSummaryGroups <> nil) then
      ADBGrid := TdxDBGridSummaryItems(TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems).SummaryGroup.GetSummaryGroups.DBTreeListControl as TCustomdxDBGrid
    else ADBGrid := nil;
    if (ADBGrid <> nil) and (ADBGrid.DataSource <> nil) and (ADBGrid.DataSource.DataSet <> nil) then
    begin
      ADataSet := ADBGrid.DataSource.DataSet;
      for I := 0 to ADataSet.FieldCount - 1 do
        if (ADataSet.Fields[I] is TNumericField) or
          (ADataSet.Fields[I].DataType in [ftDate, ftTime, ftDateTime]) then
          Values.Add(ADataSet.Fields[I].FieldName);
    end;
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{TdxDBGridSummaryItemColumnNameProperty}
function TdxDBGridSummaryItemColumnNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBGridSummaryItemColumnNameProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
  ADBGrid: TCustomdxDBGrid;
begin
  Values := TStringList.Create;
  try
    // GetValueList(Values);
    if (TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems <> nil) and
      (TdxDBGridSummaryItems(TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems).SummaryGroup <> nil) and
      (TdxDBGridSummaryItems(TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems).SummaryGroup.GetSummaryGroups <> nil) then
      ADBGrid := TdxDBGridSummaryItems(TdxDBGridSummaryItem(GetComponent(0)).GetSummaryItems).SummaryGroup.GetSummaryGroups.DBTreeListControl as TCustomdxDBGrid
    else ADBGrid := nil;
    if (ADBGrid <> nil) then
    begin
      for I := 0 to ADBGrid.ColumnCount - 1 do
        Values.Add(ADBGrid.Columns[I].Name);
    end;
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{TdxDBColumnSummaryGroupNameProperty}
function TdxDBColumnSummaryGroupNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBColumnSummaryGroupNameProperty.GetValues(Proc: TGetStrProc);
var
  Values: TStringList;
  ADBGrid: TCustomdxDBGrid;
  I: Integer;
begin
  Values := TStringList.Create;
  try
    ADBGrid := TdxDBTreeListColumn(GetComponent(0)).ATreeList as TCustomdxDBGrid;
    if ADBGrid <> nil then
    with ADBGrid do
      for I := 0 to SummaryGroups.Count - 1 do
        Values.Add(SummaryGroups[I].Name);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{TdxDBGridSummaryGroupsProperty}
function TdxDBGridSummaryGroupsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TdxDBGridSummaryGroupsProperty.Edit;
begin
  ShowdxDBGridEditor(TdxDBGrid(GetComponent(0)), Pointer(Designer), 2, TdxDBGrid(GetComponent(0)).Owner); // summary
end;

{TdxDBGridBandsProperty}
function TdxDBGridBandsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TdxDBGridBandsProperty.Edit;
begin
  ShowdxDBGridEditor(TdxDBGrid(GetComponent(0)), Pointer(Designer), 0, TdxDBGrid(GetComponent(0)).Owner); // bands
end;

{TdxDBGridLayoutListEditor}
procedure TdxDBGridLayoutListEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
  0: ShowDBGridLayoutListEditor(TdxDBGridLayoutList(Component), Pointer(Designer));
  end;
end;

function TdxDBGridLayoutListEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Editor...';
  end;
end;

function TdxDBGridLayoutListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Register;
begin
  RegisterComponents('Dev Express', [TdxDBGrid]);
  RegisterNoIcon([TdxDBGridColumn, TdxDBGridMaskColumn]);

  RegisterComponentEditor(TdxDBGrid, TdxDBGridEditor);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeListColumn, 'FieldName', TdxDBColumnFieldProperty); // SHARED
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeListColumn, 'SummaryField', TdxDBColumnSummaryFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeListColumn, 'SummaryFooterField', TdxDBColumnSummaryFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeListColumn, 'SummaryGroupName', TdxDBColumnSummaryGroupNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBGridSummaryItem, 'SummaryField', TdxDBGridSummaryItemFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBGridSummaryItem, 'ColumnName', TdxDBGridSummaryItemColumnNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomDxDBGrid, 'KeyField', TdxDBGridFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomDxDBGrid, 'PreviewFieldName', TdxDBGridFieldProperty);
  RegisterPropertyEditor(TypeInfo(TdxDBGridSummaryGroups), TCustomdxDBGrid, 'SummaryGroups', TdxDBGridSummaryGroupsProperty);
  RegisterPropertyEditor(TypeInfo(TdxTreeListBands), TCustomdxDBGrid, 'Bands', TdxDBGridBandsProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBGridMaskColumn, 'EditMask', TMaskProperty);
  // New Options
  RegisterPropertyEditor(TypeInfo(TdxDBGridOptions), TCustomDxDBGrid, 'Options', nil);
  RegisterPropertyEditor(TypeInfo(TdxDBGridOptionsEx), TCustomDxDBGrid, 'OptionsEx', nil);
  RegisterPropertyEditor(TypeInfo(Boolean), TCustomDxDBGrid, 'PartialLoad', nil);
  RegisterPropertyEditor(TypeInfo(Boolean), TCustomDxDBGrid, 'UseBookmarks', nil);
  // layout
  RegisterNoIcon([TdxDBGridLayout, TdxDBGridWrapper]);
  RegisterComponents('Dev Express', [TdxDBGridLayoutList]);
  RegisterComponentEditor(TdxDBGridLayoutList, TdxDBGridLayoutListEditor);
end;

procedure AddADBGroupListColumns(AColumns: array of TPersistentClass);
var
  I: Integer;
begin
  if ADBGroupListColumns = nil then
    ADBGroupListColumns := TStringList.Create;
  for I := Low(AColumns) to High(AColumns) do
  begin
    if ADBGroupListColumns.IndexOf(AColumns[I].ClassName) = -1 then
      ADBGroupListColumns.Add(AColumns[I].ClassName);
  end;
end;

initialization
  AddADBGroupListColumns([TdxDBGridColumn, TdxDBGridMaskColumn]);

finalization
  if ADBGroupListColumns <> nil then
  begin
    ADBGroupListColumns.Free;
    ADBGroupListColumns := nil;
  end;

end.
