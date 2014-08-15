
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid extended columns registration            }
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

unit dxColReg;

interface

{$I dxTLVer.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, dxTL, dxDBGrid, Menus, DBCtrls, StdCtrls,
  TypInfo, dxGrClms, dxGrReg, dxGrWzrd, dxGrImEd, dxDBTLCl
  {$IFNDEF DELPHI6}, DsgnIntf{$ELSE}, DesignIntf, DesignEditors, VCLEditors{$ENDIF};

const
   nExtColumns = 16;
   ExtendedColumns : array [0..nExtColumns - 1] of TPersistentClass =(
        TdxDBGridButtonColumn,
        TdxDBGridDateColumn,
        TdxDBGridCheckColumn,
        TdxDBGridImageColumn,
        TdxDBGridSpinColumn,
        TdxDBGridLookupColumn,
        TdxDBGridPickColumn,
        TdxDBGridCalcColumn,
        TdxDBGridBlobColumn,
        TdxDBGridHyperLinkColumn,
        TdxDBGridTimeColumn,
        TdxDBGridCurrencyColumn,
        TdxDBGridMemoColumn,
        TdxDBGridGraphicColumn,
        TdxDBGridMRUColumn,
        TdxDBGridWrapperColumn);

type
{TdxDBTreeListImageColumnProperty}
TdxDBTreeListImageColumnProperty = class(TPropertyEditor)
public
  function GetAttributes: TPropertyAttributes; override;
  procedure Edit; override;
  function GetValue: string; override;
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
Begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
End;

procedure Register;
var
  I: Integer;
begin
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

initialization
  Classes.RegisterClasses(ExtendedColumns);
  AddADBGroupListColumns(ExtendedColumns);

end.
