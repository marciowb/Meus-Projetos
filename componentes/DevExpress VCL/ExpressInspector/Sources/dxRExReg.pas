
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Extended lookup row registration                            }
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

unit dxRExReg;

interface

{$I dxInsVer.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  TypInfo, dxInRwEx, dxInsReg{$IFNDEF DELPHI6}, DsgnIntf{$ELSE}, DesignIntf, DesignEditors, VCLEditors{$ENDIF};

const
   nInspectorExtRows = 1;
   InspectorExtendedRows: array [0..nInspectorExtRows - 1] of TPersistentClass =(
     TdxInspectorDBExtLookupRow);

type
  { TdxDBInspectorExtLookupRowPickListFieldProperty }
  TdxDBInspectorExtLookupRowPickListFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TdxDBInspectorExtLookupRowPickListFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBInspectorExtLookupRowPickListFieldProperty.GetValueList(List: TStrings);
var
  ARow: TdxInspectorDBExtLookupRow;
  PrevActive: Boolean;
begin
  ARow := TdxInspectorDBExtLookupRow(GetComponent(0));
  if ARow.DBGridLayout <> nil then
  with ARow.DBGridLayout do
  begin
    PrevActive := Active;
    try
      Active := True;
      if (DBGrid.DataSource <> nil) and (DBGrid.DataSource.DataSet <> nil) then
        DBGrid.DataSource.DataSet.GetFieldNames(List);
    finally
      Active := PrevActive;
    end;
  end;
end;

procedure TdxDBInspectorExtLookupRowPickListFieldProperty.GetValues(Proc: TGetStrProc);
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

procedure Register;
var
  I: Integer;
begin
  RegisterClasses(InspectorExtendedRows);
  for I := Low(InspectorExtendedRows) to High(InspectorExtendedRows) do
     RegisterNoIcon([TComponentClass(InspectorExtendedRows[I])]);
  RegisterPropertyEditor(TypeInfo(string), TdxInspectorDBExtLookupRow, 'PickListField', TdxDBInspectorExtLookupRowPickListFieldProperty);
  // Hide properties
  RegisterPropertyEditor(TypeInfo(TControl), TdxInspectorDBExtLookupRow, 'PopupControl', nil);
  {$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxInspectorDBExtLookupRow, 'ClearKey', TShortCutProperty);
  {$ENDIF}
end;

initialization
  Classes.RegisterClasses(InspectorExtendedRows);
  AddDBInspectorRows(InspectorExtendedRows);
  
end.
