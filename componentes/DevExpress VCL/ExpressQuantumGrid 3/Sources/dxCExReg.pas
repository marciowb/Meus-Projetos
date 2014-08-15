
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express extended columns registration                       }
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

unit dxCExReg;

interface

{$I dxTLVer.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  TypInfo, dxTLReg, dxTLClEx, dxGrReg, dxGrClEx{$IFNDEF DELPHI6}, DsgnIntf{$ELSE},
  DesignIntf, DesignEditors, VCLEditors{$ENDIF};

const
   // TreeList
   nTLExtColumns = 1;
   TLExtendedColumns: array [0..nTLExtColumns - 1] of TPersistentClass =(
        TdxTreeListPopupColumn);
   // Grid
   nGrExtColumns = 2;
   GrExtendedColumns: array [0..nGrExtColumns - 1] of TPersistentClass =(
        TdxDBGridPopupColumn,
        TdxDBGridExtLookupColumn);

type
{TdxDBGridExtLookupColumnPickListFieldProperty}
TdxDBGridExtLookupColumnPickListFieldProperty = class(TStringProperty)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure GetValueList(List: TStrings); virtual;
  procedure GetValues(Proc: TGetStrProc); override;
end;

function TdxDBGridExtLookupColumnPickListFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBGridExtLookupColumnPickListFieldProperty.GetValueList(List: TStrings);
var
  AColumn: TdxDBGridExtLookupColumn;
  PrevActive: Boolean;
begin
  AColumn := TdxDBGridExtLookupColumn(GetComponent(0));
  if AColumn.DBGridLayout <> nil then
  with AColumn.DBGridLayout do
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

procedure TdxDBGridExtLookupColumnPickListFieldProperty.GetValues(Proc: TGetStrProc);
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
  // TreeList
  RegisterClasses(TLExtendedColumns);
  for I := Low(TLExtendedColumns) to High(TLExtendedColumns) do
     RegisterNoIcon([TComponentClass(TLExtendedColumns[I])]);
  // Grid
  RegisterClasses(GrExtendedColumns);
  for I := Low(GrExtendedColumns) to High(GrExtendedColumns) do
     RegisterNoIcon([TComponentClass(GrExtendedColumns[I])]);

  RegisterPropertyEditor(TypeInfo(string), TdxDBGridExtLookupColumn, 'PickListField', TdxDBGridExtLookupColumnPickListFieldProperty);
  {$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxDBTreeListExtLookupColumn, 'ClearKey', TShortCutProperty);
  {$ENDIF}
end;

initialization
  Classes.RegisterClasses(TLExtendedColumns);
  AddTreeListColumns(TLExtendedColumns);

  Classes.RegisterClasses(GrExtendedColumns);
  AddADBGroupListColumns(GrExtendedColumns);

end.
