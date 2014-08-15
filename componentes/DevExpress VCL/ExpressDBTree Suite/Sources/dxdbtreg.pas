{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express data-aware tree view registration                   }
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

unit dxdbtreg;

{$I cxVer.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,

  {$IFDEF DELPHI6}
  DesignIntf,
  DesignEditors,
  {$ELSE}
  DsgnIntf,
  {$ENDIF} DBConsts, DB;

procedure Register;

implementation

uses dxtree, dxDBTree, dxDBTrel, ShellAPI;

const
  dxdbtVersion = '1.54';

type
  TdxDBTreeViewEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TdxDBTreeViewEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    1: ShellExecute(0, PChar('OPEN'), PChar('http://www.devexpress.com'), Nil, Nil, SW_SHOWMAXIMIZED);
  end;
end;

function TdxDBTreeViewEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'ExpressDBTreeView ' + dxdbtVersion;
    1: Result := 'http://www.devexpress.com';
    2: Result := 'Developer Express Inc.';    
  end;
end;

function TdxDBTreeViewEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

type
  TCustomDBTreeViewFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TCustomDBTreeViewFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TCustomDBTreeViewFieldProperty.GetValueList(List: TStrings);
begin
end;

procedure TCustomDBTreeViewFieldProperty.GetValues(Proc: TGetStrProc);
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

type
  TDBTreeViewFieldProperty = class(TCustomDBTreeViewFieldProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TDBTreeViewFieldProperty.GetValueList(List: TStrings);
var
  DBTreeView : TdxDBTreeView;
begin
  DBTreeView := GetComponent(0) as TdxDBTreeView;
  if(DBTreeView.DataSource <> nil) And (DBTreeView.DataSource.DataSet <> nil)then
    DBTreeView.DataSource.DataSet.GetFieldNames(List);
end;

type
  TLookUpTreeViewFieldProperty = class(TCustomDBTreeViewFieldProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TLookUpTreeViewFieldProperty.GetValueList(List: TStrings);
var
  CustomLookUpTreeView : TCustomdxLookUpTreeView;
begin
  CustomLookUpTreeView := GetComponent(0) as TCustomdxLookUpTreeView;
  if(CustomLookUpTreeView.ListSource <> nil)
   And (CustomLookUpTreeView.ListSource.DataSet <> nil)then
    CustomLookUpTreeView.ListSource.DataSet.GetFieldNames(List);
end;

procedure Register;
begin
  RegisterComponents('ExpressDBTree', [TdxTreeView, TdxDBTreeView, TdxTreeViewEdit, TdxDBTreeViewEdit,
    TdxLookUpTreeView, TdxDBLookUpTreeView]);

  RegisterComponentEditor(TdxDBTreeView, TdxDBTreeViewEditor);

  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeView, 'ImageIndexField', TDBTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeView, 'KeyField', TDBTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeView, 'ListField', TDBTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeView, 'ParentField', TDBTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeView, 'DisplayField', TDBTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBTreeView, 'StateIndexField', TDBTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxLookUpTreeView, 'KeyField', TLookUpTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxLookUpTreeView, 'ListField', TLookUpTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxLookUpTreeView, 'DisplayField', TLookUpTreeViewFieldProperty);  
  RegisterPropertyEditor(TypeInfo(string), TCustomdxLookUpTreeView, 'ParentField', TLookUpTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxLookUpTreeView, 'ImageIndexField', TLookUpTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomdxLookUpTreeView, 'StateIndexField', TLookUpTreeViewFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxDBLookUpTreeView, 'AssignField', TLookUpTreeViewFieldProperty);
end;

end.
