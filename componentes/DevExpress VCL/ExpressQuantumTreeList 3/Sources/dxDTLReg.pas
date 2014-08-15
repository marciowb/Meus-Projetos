
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressDBTreeListControl Suite registration                 }
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

unit dxDTLReg;

interface

{$I dxTLVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, dxTL, dxDBCtrl, dxDBTL, dxDBTLCl;

procedure Register;
procedure AddDBTreeListColumns(AColumns: array of TPersistentClass);

const
  dxDTLVersion = '3.54';
  DBTreeListColumns: TStringList = nil;

implementation

uses
  TypInfo{$IFNDEF DELPHI3}, DBTables{$ENDIF}, dxDBTLEd, dxGrImEd{$IFNDEF DELPHI6},
  DsgnIntf{$ELSE}, DesignIntf, DesignEditors, VCLEditors{$ENDIF}, MaskProp;

const
  nExtColumns = 16;
  ExtendedColumns: array [0..nExtColumns - 1] of TPersistentClass =(
        TdxDBTreeListButtonColumn,
        TdxDBTreeListDateColumn,
        TdxDBTreeListCheckColumn,
        TdxDBTreeListImageColumn,
        TdxDBTreeListSpinColumn,
        TdxDBTreeListLookupColumn,
        TdxDBTreeListPickColumn,
        TdxDBTreeListCalcColumn,
        TdxDBTreeListBlobColumn,
        TdxDBTreeListHyperLinkColumn,
        TdxDBTreeListTimeColumn,
        TdxDBTreeListCurrencyColumn,
        TdxDBTreeListMemoColumn,
        TdxDBTreeListGraphicColumn,
        TdxDBTreeListMRUColumn,
        TdxDBTreeListWrapperColumn);

type

{TdxDBTreeListEditor}
TdxDBTreeListEditor = class(TComponentEditor)
public
  procedure Edit; override;
  procedure ExecuteVerb(Index: Integer); override;
  function GetVerb(Index: Integer): string; override;
  function GetVerbCount: Integer; override;
end;

{TdxDBTreeListRootValueProperty}
TdxDBTreeListRootValueProperty = class(TPropertyEditor)
  function GetValue: string; override;
  procedure SetValue(const Value: string); override;
end;

{TdxDBTreeListFieldProperty}
TdxDBTreeListFieldProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValueList(List: TStrings);
  procedure GetValues(Proc: TGetStrProc); override;
end;

{TdxDBTreeListBandsProperty}
TdxDBTreeListBandsProperty = class(TClassProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure Edit; override;
end;

{TdxDBTreeListImageColumnProperty}
TdxDBTreeListImageColumnProperty = class(TPropertyEditor)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure Edit; override;
  function GetValue: string; override;
end;

{TdxDBTreeListEditor}
procedure TdxDBTreeListEditor.Edit;
begin
  if GetVerbCount > 1 then ExecuteVerb(1);
end;

procedure TdxDBTreeListEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowdxDBTreeListEditor(TdxDBTreeList(Component), Pointer(Designer), 0, TdxDBTreeList(Component).Owner); // bands
    1: ShowdxDBTreeListEditor(TdxDBTreeList(Component), Pointer(Designer), 1, TdxDBTreeList(Component).Owner); // columns
  end;
end;

function TdxDBTreeListEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Bands...';
    1: Result := 'Columns...';
    2: Result := '-';
    3: Result := 'www.devexpress.com';
    4: Result := 'ExpressQuantumDBTreeList ' + dxDTLVersion;
  end;
end;

function TdxDBTreeListEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

{TdxDBTreeListRootValueProperty}
function TdxDBTreeListRootValueProperty.GetValue: string;
begin
  with GetComponent(0) as TdxDBTreeList do
    if RootValue = '' then Result := '(Null)'
    else Result := RootValue;
end;

procedure TdxDBTreeListRootValueProperty.SetValue(const Value: string);
var
  I: Integer;
begin
  for I := 0 to PropCount - 1 do
    with GetComponent(I) as TdxDBTreeList do
      RootValue := Value;
  Modified;
end;

{TdxDBTreeListFieldProperty}
function TdxDBTreeListFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBTreeListFieldProperty.GetValues(Proc: TGetStrProc);
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

procedure TdxDBTreeListFieldProperty.GetValueList(List: TStrings);
begin
  with GetComponent(0) as TCustomdxDBTreeListControl do
    if (DataSource <> nil) and (DataSource.DataSet <> nil) then
      DataSource.DataSet.GetFieldNames(List);
end;

{TdxDBTreeListBandsProperty}
function TdxDBTreeListBandsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TdxDBTreeListBandsProperty.Edit;
begin
  ShowdxDBTreeListEditor(TdxDBTreeList(GetComponent(0)), Pointer(Designer), 0, TdxDBTreeList(GetComponent(0)).Owner); // bands
end;

{TdxDBTreeListImageColumnProperty}
function TdxDBTreeListImageColumnProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TdxDBTreeListImageColumnProperty.Edit;
begin
 if ShowImagesValuesEditor(TdxDBTreeListImageColumn(GetComponent(0))) then
    Designer.Modified;
end;

function TdxDBTreeListImageColumnProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

procedure Register;
var
  I: Integer;
begin
  RegisterComponents('Dev Express', [TdxDBTreeList]);
  RegisterNoIcon([TdxDBTreeListColumn, TdxDBTreeListMaskColumn]);
  RegisterComponentEditor(TdxDBTreeList, TdxDBTreeListEditor);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBTreeList, 'RootValue', TdxDBTreeListRootValueProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBTreeList, 'KeyField', TdxDBTreeListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBTreeList, 'ParentField', TdxDBTreeListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBTreeList, 'PreviewFieldName', TdxDBTreeListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBTreeList, 'ImageIndexFieldName', TdxDBTreeListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBTreeList, 'StateIndexFieldName', TdxDBTreeListFieldProperty);
  RegisterPropertyEditor(TypeInfo(TdxTreeListBands), TCustomdxDBTreeList, 'Bands', TdxDBTreeListBandsProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeListMaskColumn, 'EditMask', TMaskProperty);
  // Extended Columns
  RegisterClasses(ExtendedColumns);
  for I := Low(ExtendedColumns) to High(ExtendedColumns) do
     RegisterNoIcon([TComponentClass(ExtendedColumns[I])]);

  RegisterPropertyEditor(TypeInfo(TStrings), TdxDBTreeListImageColumn, 'ImageIndexes', TdxDBTreeListImageColumnProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxDBTreeListImageColumn, 'Values', TdxDBTreeListImageColumnProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxDBTreeListImageColumn, 'Descriptions', TdxDBTreeListImageColumnProperty);
  {$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxDBTreeListButtonColumn, 'ClickKey', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxDBTreeListHyperLinkColumn, 'StartKey', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxDBTreeListLookupColumn, 'ClearKey', TShortCutProperty);
  {$ENDIF}
end;

procedure AddDBTreeListColumns(AColumns: array of TPersistentClass);
var
  I: Integer;
begin
  if DBTreeListColumns = nil then
    DBTreeListColumns := TStringList.Create;
  for I := Low(AColumns) to High(AColumns) do
  begin
    if DBTreeListColumns.IndexOf(AColumns[I].ClassName) = -1 then
      DBTreeListColumns.Add(AColumns[I].ClassName);
  end;
end;

initialization
  AddDBTreeListColumns([TdxDBTreeListColumn, TdxDBTreeListMaskColumn]);
  // Extended Columns
  Classes.RegisterClasses(ExtendedColumns);
  AddDBTreeListColumns(ExtendedColumns);

finalization
  if DBTreeListColumns <> nil then
  begin
    DBTreeListColumns.Free;
    DBTreeListColumns := nil;
  end;

end.
