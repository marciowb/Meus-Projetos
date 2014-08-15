
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express standalone editors registration                     }
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

unit dxEdLReg;

interface

{$I dxEdLVer.inc}

procedure Register;

const
  dxEdLVersion = '3.54';

implementation

uses
  Windows, Messages, SysUtils, Classes, dxEdLib, dxEditor, dxExEdtr, dxDBELib,
  dxImgEd, dxGrDate, dxCntner, DB, TypInfo{$IFNDEF DELPHI6}, DsgnIntf{$ELSE},
  DesignIntf, DesignEditors{$ENDIF}, MaskProp;

type
  { TdxDateTimeProperty }
  TdxDateTimeProperty = class(TDateTimeProperty)
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  { TdxImageEditProperty }
  TdxImageEditProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

  { TdxInplaceEditEditor }
  TdxInplaceEditEditor = class(TDefaultEditor{TComponentEditor})
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  { TdxDataFieldProperty }
  TdxDataFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetDataSourcePropName: string; virtual;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TdxListFieldProperty }
  
  TdxListFieldProperty = class(TdxDataFieldProperty)
  public
    function GetDataSourcePropName: string; override;
  end;

{ TdxDateTimeProperty }

function TdxDateTimeProperty.GetValue: string;
begin
  Result := DateTimeToText(GetFloatValue);
end;

procedure TdxDateTimeProperty.SetValue(const Value: string);
var
  DT: TDateTime;
begin
  if not TextToDateEx(Value, DT) then
    DT := NullDate;
  SetFloatValue(DT);
end;

{ TdxImageEditProperty }

function TdxImageEditProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TdxImageEditProperty.Edit;
begin
 if ShowImagesValuesEditor(TdxImageEdit(GetComponent(0))) then
   Designer.Modified;
end;

function TdxImageEditProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

{ TdxInplaceEditEditor }

procedure TdxInplaceEditEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: begin
         TdxInplaceEdit(Component).RestoreDefaults;
         Designer.Modified;
       end;
    1: begin
         TdxInplaceEdit(Component).Style.RestoreDefaults;
         Designer.Modified;
       end;
  end;
end;

function TdxInplaceEditEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Restore Defaults';
    1: Result := 'Restore Style Defaults';
    2: Result := '-';
    3: Result := 'www.devexpress.com';
    4: Result := 'ExpressEditorsLibrary ' + dxEdLVersion;
  end;
end;

function TdxInplaceEditEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

{ TdxDataFieldProperty }

function GetPropertyValue(Instance: TPersistent; const PropName: string): TPersistent;
var
  PropInfo: PPropInfo;
begin
  Result := nil;
  PropInfo := TypInfo.GetPropInfo(Instance.ClassInfo, PropName);
  if (PropInfo <> nil) and (PropInfo^.PropType^.Kind = tkClass) then
    Result := TObject(GetOrdProp(Instance, PropInfo)) as TPersistent;
end;

function TdxDataFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

function TdxDataFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'DataSource';
end;

procedure TdxDataFieldProperty.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
begin
  DataSource := GetPropertyValue(GetComponent(0), GetDataSourcePropName) as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    DataSource.DataSet.GetFieldNames(List);
end;

procedure TdxDataFieldProperty.GetValues(Proc: TGetStrProc);
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

{ TdxListFieldProperty }

function TdxListFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'ListSource';
end;

procedure Register;
begin
  // Text
  RegisterComponents('Express Editors', [TdxEdit, TdxMaskEdit, TdxMemo, TdxDateEdit,
    TdxButtonEdit, TdxCheckEdit, TdxImageEdit, TdxSpinEdit, TdxPickEdit,
    TdxCalcEdit, TdxHyperLinkEdit, TdxTimeEdit, TdxCurrencyEdit, TdxGraphicEdit,
    TdxBlobEdit, TdxMRUEdit, TdxPopupEdit, TdxLookupEdit]);
  // DB
  RegisterComponents('Express DBEditors', [TdxDBEdit, TdxDBMaskEdit, TdxDBMemo, TdxDBDateEdit,
    TdxDBButtonEdit, TdxDBCheckEdit, TdxDBImageEdit, TdxDBSpinEdit, TdxDBPickEdit,
    TdxDBCalcEdit, TdxDBHyperLinkEdit, TdxDBTimeEdit, TdxDBCurrencyEdit, TdxDBGraphicEdit,
    TdxDBBlobEdit, TdxDBMRUEdit, TdxDBPopupEdit, TdxDBLookupEdit]);
  // Other  
  RegisterComponents('Express Editors', [TdxEditStyleController, TdxCheckEditStyleController]);

  RegisterPropertyEditor(TypeInfo(TDateTime), TdxDateEdit, 'Date', TdxDateTimeProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxInplaceImageEdit, 'ImageIndexes', TdxImageEditProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxInplaceImageEdit, 'Values', TdxImageEditProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxInplaceImageEdit, 'Descriptions', TdxImageEditProperty);

  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBLookupEdit, 'KeyFieldName', TdxListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxDBLookupEdit, 'ListFieldName', TdxListFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxInplaceMaskEdit, 'EditMask', TMaskProperty);

  RegisterComponentEditor(TdxInplaceEdit, TdxInplaceEditEditor);
end;

end.
