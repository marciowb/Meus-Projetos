
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMasterView registering unit                          }
{                                                                   }
{       Copyright (c) 1999-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSMASTERVIEW AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM      }
{   ONLY.                                                           }
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

unit dxMasterViewReg;

{$I cxVer.inc}

interface

procedure Register;

implementation

uses
  Classes, SysUtils,{$IFDEF DELPHI6} DesignIntf, DesignEditors,{$ELSE} DsgnIntf,{$ENDIF}
  TypInfo, dxMasterView, dxMasterViewColumns, dxMasterViewDesigner,
  dxMasterViewImageColumnEditor, dxRegEd;

const
  dxMasterViewVersion = '1.54';
  
{ TdxMVFieldNameProperty }

type
  TdxMVFieldNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TdxMVFieldNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TdxMVFieldNameProperty.GetValues(Proc: TGetStrProc);
var
  Values: TStringList;
  Level: TdxMasterViewLevel;
  I: Integer;
begin
  Values := TStringList.Create;
  try
    if GetComponent(0) is TdxMasterViewLevel then
    begin
      Level := TdxMasterViewLevel(GetComponent(0));
      if GetName = 'MasterKey' then Level := Level.Parent;
    end
    else
      Level := TdxMasterViewColumn(GetComponent(0)).Level;
    if Level.DataSet <> nil then
      with Level.DataSet do
      begin
        GetFieldNames(Values);
        for I := 0 to Values.Count - 1 do Proc(Values[I]);
      end;
  finally
    Values.Free;
  end;
end;

{ TdxMVComponentEditor }

type
  TdxMVComponentEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TdxMVComponentEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: dxMVDesigner.Show(TdxMasterView(Component), Designer);
  end;
end;

function TdxMVComponentEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Designer...';
    1: Result := '-';
    2: Result := 'ExpressMasterView ' + dxMasterViewVersion;
    3: Result := 'Developer Express Inc.';
  else
    Result := '';
  end;  
end;

function TdxMVComponentEditor.GetVerbCount: Integer;
begin
  Result := 1 + 3;
end;

{ TdxMVImageComboItemsProperty }

type
  TDummyImageColumnItems = class(TdxMasterViewImageColumnItems);

  TdxMVImageComboItemsProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

procedure TdxMVImageComboItemsProperty.Edit;
begin
  if EditImageColumnItems(TdxMasterViewImageColumn(GetComponent(0))) then
    Modified;
end;

function TdxMVImageComboItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TdxMVImageComboItemsProperty.GetValue: string;
begin
  Result := Format('(%s)', [TdxMasterViewImageColumnItems.ClassName]);
end;

{ TdxMVStyleProperty }

type
  TdxMVStyleProperty = class(TComponentProperty)
  public
    procedure Edit; override;
  end;

procedure TdxMVStyleProperty.Edit;
begin
  if (Value <> '') and (Designer.GetComponent(Value) <> nil) then
    Designer.SelectComponent(Designer.GetComponent(Value));
end;

{ TdxMVRegistryPathProperty }

type
  TdxMVRegistryPathProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure TdxMVRegistryPathProperty.Edit;
var
  Control: TdxMasterView;
  S: string;
begin
  Control := TdxMasterView(GetComponent(0));
  S := Control.RegistryPath;
  if dxGetRegistryPath(S) then
  begin
    Control.RegistryPath := S;
    Designer.Modified;
  end;
end;

function TdxMVRegistryPathProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TdxMasterViewStyle), nil,
    '', TdxMVStyleProperty);

  RegisterPropertyEditor(TypeInfo(string), TdxMasterViewColumn,
    'FieldName', TdxMVFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxMasterViewColumn,
    'SummaryFieldName', TdxMVFieldNameProperty);

  RegisterPropertyEditor(TypeInfo(TdxMasterViewImageColumnItems),
    TdxMasterViewImageColumn, 'Items', TdxMVImageComboItemsProperty);

  RegisterPropertyEditor(TypeInfo(string), TdxMasterViewLevel,
    'DetailKey', TdxMVFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxMasterViewLevel,
    'ID', TdxMVFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxMasterViewLevel,
    'MasterKey', TdxMVFieldNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxMasterViewLevel,
    'PreviewFieldName', TdxMVFieldNameProperty);

  RegisterPropertyEditor(TypeInfo(string), TdxMasterView, 'RegistryPath',
    TdxMVRegistryPathProperty);

  RegisterComponentEditor(TdxMasterView, TdxMVComponentEditor);

  RegisterNoIcon([TdxMasterViewStyle, TdxMasterViewLevel, TdxMasterViewColumn,
    TdxMasterViewCheckColumn, TdxMasterViewImageColumn, TdxMasterViewGraphicColumn]);
  RegisterComponents('ExpressMasterView', [TdxMasterView]);
end;

initialization
  dxMVDesigner := TdxMVRealDesigner.Create;

finalization
  dxMVDesigner.Free;
  dxMVDesigner := nil;

end.
