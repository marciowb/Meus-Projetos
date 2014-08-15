
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector registration                               }
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

unit dxInsReg;

interface

{$I dxInsVer.inc}

uses
  Classes;

const
  InspectorRows: TStringList = Nil;
  DBInspectorRows: TStringList = Nil;

procedure AddInspectorRows(ARows : array of TPersistentClass);
procedure AddDBInspectorRows(ARows : array of TPersistentClass);

procedure Register;

implementation

uses
  Windows, TypInfo, Forms, dxDBInEd, dxInspEd, dxInspct, dxDBInsp,
  dxRegEd, StdCtrls, dxCntner{$IFNDEF DELPHI6}, DsgnIntf{$ELSE}, DesignIntf, DesignEditors{$ENDIF};

const
  VerInfoCount = 4;
  dxInsVersion = '2.54';
  stVerInfo1 = 'ExpressInspector Suite ' + dxInsVersion;
  stVerInfo2 = 'http://www.devexpress.com';
  stVerInfo3 = 'Developer Express Inc.';

type
  { TdxDBInspectorEditor }
  TdxDBInspectorEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { TdxInspectorEditor }
  TdxInspectorEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { TdxDBInspectorRowFieldProperty }
  TdxDBInspectorRowFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TdxRegistryPathProperty }
  TdxRegistryPathProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  {$IFDEF DELPHI6}
  { TdxInspectorSelectionEditor }

  TdxInspectorSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
  {$ENDIF}

{ TdxDBInspectorEditor }
procedure TdxDBInspectorEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: ShowdxDBInspectorEditor(TdxDBInspector(Component), Pointer(Designer));
  end;
end;

function TdxDBInspectorEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'dxDBInspector editor...';
    1: Result := '-';
    2: Result := stVerInfo1;
    3: Result := stVerInfo2;
    4: Result := stVerInfo3;
  end;
end;

function TdxDBInspectorEditor.GetVerbCount: Integer;
begin
  Result := 1 + VerInfoCount;
end;

{ TdxInspectorEditor }
procedure TdxInspectorEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0 : ShowdxInspectorEditor(TdxInspector(Component), Pointer(Designer));
  end;
end;

function TdxInspectorEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'dxInspector editor...';
    1: Result := '-';
    2: Result := stVerInfo1;
    3: Result := stVerInfo2;
    4: Result := stVerInfo3;
  end;
end;

function TdxInspectorEditor.GetVerbCount: Integer;
begin
  Result := 1 + VerInfoCount;
end;

{ TdxDBInspectorRowFieldProperty }
function TdxDBInspectorRowFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBInspectorRowFieldProperty.GetValueList(List: TStrings);
var
  DBInspector: TdxDBInspector;
begin
  if TdxInspectorRow(GetComponent(0)).Inspector is TdxDBInspector then
    DBInspector := TdxDBInspector(TdxInspectorRow(GetComponent(0)).Inspector)
  else
    DBInspector := nil;
  if (DBInspector.DataSource <> nil) and (DBInspector.DataSource.DataSet <> nil) then
    DBInspector.DataSource.DataSet.GetFieldNames(List);
end;

procedure TdxDBInspectorRowFieldProperty.GetValues(Proc: TGetStrProc);
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

procedure AddInspectorRows(ARows : array of TPersistentClass);
var
  i : Integer;
begin
  if InspectorRows = nil then
     InspectorRows := TStringList.Create;
  for i := Low(ARows) to High(ARows) do
  begin
    if InspectorRows.IndexOf(ARows[i].ClassName) = -1 then
      InspectorRows.Add(ARows[i].ClassName);
  end;
end;

procedure AddDBInspectorRows(ARows : array of TPersistentClass);
var
  i : Integer;
begin
  if DBInspectorRows = nil then
     DBInspectorRows := TStringList.Create;
  for i := Low(ARows) to High(ARows) do
  begin
    if DBInspectorRows.IndexOf(ARows[i].ClassName) = -1 then
      DBInspectorRows.Add(ARows[i].ClassName);
  end;
end;

{ TdxRegistryPathProperty }

function TdxRegistryPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure TdxRegistryPathProperty.Edit;
var
  S: string;
begin
  S := GetValue;
  if dxGetRegistryPath(S) then SetValue(S);
end;

{$IFDEF DELPHI6}
{ TdxInspectorSelectionEditor }

procedure TdxInspectorSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  Proc('dxExEdtr');
end;
{$ENDIF}

procedure Register;
begin
  RegisterComponents('Dev Express', [TdxDBInspector, TdxInspector]);
  RegisterComponentEditor(TdxDBInspector, TdxDBInspectorEditor);
  RegisterComponentEditor(TdxInspector, TdxInspectorEditor);
  RegisterPropertyEditor(TypeInfo(string), TdxInspectorRow, 'FieldName', TdxDBInspectorRowFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxInspector, 'RegistryPath', TdxRegistryPathProperty);
  RegisterClasses([TdxInspectorDBRow, TdxInspectorTextRow, TdxInspectorComplexRow]);
  RegisterNoIcon([TdxInspectorDBRow, TdxInspectorTextRow, TdxInspectorComplexRow]);
  // Hide properties in Complex Row
  RegisterPropertyEditor(TypeInfo(TAlignment), TdxInspectorComplexRow, 'Alignment', nil);
  RegisterPropertyEditor(TypeInfo(TEditCharCase), TdxInspectorComplexRow, 'CharCase', nil);
  RegisterPropertyEditor(TypeInfo(Integer), TdxInspectorComplexRow, 'MaxLength', nil);
  RegisterPropertyEditor(TypeInfo(Char), TdxInspectorComplexRow, 'PasswordChar', nil);
  RegisterPropertyEditor(TypeInfo(Boolean), TdxInspectorComplexRow, 'ReadOnly', nil);
  RegisterPropertyEditor(TypeInfo(string), TdxInspectorComplexRow, 'Text', nil);
  RegisterPropertyEditor(TypeInfo(TNotifyEvent), TdxInspectorComplexRow, 'OnChange', nil);
  RegisterPropertyEditor(TypeInfo(TdxEditValidateEvent), TdxInspectorComplexRow, 'OnValidate', nil);
 {$IFDEF DELPHI6}
  RegisterSelectionEditor(TCustomdxInspectorControl, TdxInspectorSelectionEditor);
 {$ENDIF}
end;

initialization
  AddDBInspectorRows([TdxInspectorDBRow, TdxInspectorComplexRow]);
  AddInspectorRows([TdxInspectorTextRow, TdxInspectorComplexRow]);

finalization
  if DBInspectorRows <> nil then
  begin
    DBInspectorRows.Free;
    DBInspectorRows := Nil;
  end;
  if InspectorRows <> nil then
  begin
    InspectorRows.Free;
    InspectorRows := Nil;
  end;
  ResetDefaultRowClasses;

end.
