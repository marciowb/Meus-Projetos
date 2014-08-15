
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express extended standalone lookup edit registration        }
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

unit dxExLReg;

interface

{$I dxTLVer.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, dxExELib{$IFNDEF DELPHI6}, DsgnIntf{$ELSE},
  DesignIntf, DesignEditors, VCLEditors{$ENDIF};

type
  { TdxDBExtLookupEditPickListFieldProperty }
  TdxDBExtLookupEditPickListFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TdxDBExtLookupEditPickListFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TdxDBExtLookupEditPickListFieldProperty.GetValueList(List: TStrings);
var
  AEdit: TdxDBExtLookupEdit;
  PrevActive: Boolean;
begin
  AEdit := TdxDBExtLookupEdit(GetComponent(0));
  if AEdit.DBGridLayout <> nil then
    with AEdit.DBGridLayout do
    begin
      PrevActive := Active;
      try
        // TODO DBGridParent
        Active := True;
        if (DBGrid.DataSource <> nil) and (DBGrid.DataSource.DataSet <> nil) then
          DBGrid.DataSource.DataSet.GetFieldNames(List);
      finally
        Active := PrevActive;
      end;
    end;
end;

procedure TdxDBExtLookupEditPickListFieldProperty.GetValues(Proc: TGetStrProc);
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
begin
  // DB
  RegisterComponents('Express DBEditors', [TdxDBExtLookupEdit]);
  RegisterPropertyEditor(TypeInfo(string), TdxDBExtLookupEdit, 'PickListField',
    TdxDBExtLookupEditPickListFieldProperty);
  {$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxDBExtLookupEdit, 'ClearKey', TShortCutProperty);
  {$ENDIF}
end;

end.
