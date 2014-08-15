
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressInspector extended rows registration                 }
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

unit dxRowReg;

interface

{$I dxInsVer.inc}

procedure Register;

implementation

uses
  Classes, SysUtils, TypInfo, dxImRwEd, dxInspRw, DB, dxInspct, dxInsReg, dxDBInsp,
  dxDBInRw{$IFNDEF DELPHI6}, DsgnIntf{$ELSE}, DesignIntf, DesignEditors, VCLEditors{$ENDIF},
  MaskProp;

const
   nExtRows = 16;
   ExtendedRows: array [0..nExtRows-1] of TPersistentClass
     = (TdxInspectorTextMaskRow,
        TdxInspectorTextDateRow,
        TdxInspectorTextCheckRow,
        TdxInspectorTextCalcRow,
        TdxInspectorTextButtonRow,
        TdxInspectorTextSpinRow,
        TdxInspectorTextPickRow,
        TdxInspectorTextImageRow,
        TdxInspectorTextTimeRow,
        TdxInspectorTextCurrencyRow,
        TdxInspectorTextHyperLinkRow,
        TdxInspectorTextBlobRow,
        TdxInspectorTextMRURow,
        TdxInspectorTextPopupRow,
        TdxInspectorTextMemoRow,
        TdxInspectorTextGraphicRow);

   nExtDBRows = 17;
   ExtendedDBRows: array [0..nExtDBRows-1] of TPersistentClass
     = (TdxInspectorDBMaskRow,
        TdxInspectorDBDateRow,
        TdxInspectorLookupRow,
        TdxInspectorDBCheckRow,
        TdxInspectorDBCalcRow,
        TdxInspectorDBButtonRow,
        TdxInspectorDBSpinRow,
        TdxInspectorDBPickRow,
        TdxInspectorBlobRow,
        TdxInspectorDBImageRow,
        TdxInspectorDBTimeRow,
        TdxInspectorDBCurrencyRow,
        TdxInspectorDBHyperLinkRow,
        TdxInspectorDBPopupRow,
        TdxInspectorDBMRURow,
        TdxInspectorDBMemoRow,
        TdxInspectorDBGraphicRow);

type
  { TdxInspectorImageRowProperty }
  TdxInspectorImageRowProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

{ TdxInspectorImageRowProperty }
function TdxInspectorImageRowProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TdxInspectorImageRowProperty.Edit;
begin
 if ShowImageValuesEditor(TdxInspectorImageRow(GetComponent(0))) then
   Designer.Modified;
end;

function TdxInspectorImageRowProperty.GetValue: string;
Begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
End;

procedure Register;
var
  I: Integer;
begin
  RegisterClasses(ExtendedDBRows);
  for I := Low(ExtendedDBRows) to High(ExtendedDBRows) do
     RegisterNoIcon([TComponentClass(ExtendedDBRows[I])]);
  RegisterClasses(ExtendedRows);
  for I := Low(ExtendedRows) to High(ExtendedRows) do
     RegisterNoIcon([TComponentClass(ExtendedRows[I])]);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxInspectorImageRow, 'ImageIndexes', TdxInspectorImageRowProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxInspectorImageRow, 'Values', TdxInspectorImageRowProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxInspectorImageRow, 'Descriptions', TdxInspectorImageRowProperty);
  {$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxInspectorButtonRow, 'ClickKey', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxInspectorHyperLinkRow, 'StartKey', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxInspectorLookupRow, 'ClearKey', TShortCutProperty);
  {$ENDIF}
  RegisterPropertyEditor(TypeInfo(string), TdxInspectorTextMaskRow, 'EditMask', TMaskProperty);
  RegisterPropertyEditor(TypeInfo(string), TdxInspectorDBMaskRow, 'EditMask', TMaskProperty);
end;

initialization
  Classes.RegisterClasses(ExtendedRows);
  Classes.RegisterClasses(ExtendedDBRows);

  AddInspectorRows(ExtendedRows);
  AddDBInspectorRows(ExtendedDBRows);

finalization
  ResetDefaultRowClasses;

end.
