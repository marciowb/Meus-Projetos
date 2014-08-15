
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumTreeList Suite registration                   }
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

unit dxTLCReg;

interface

{$I dxTLVer.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxTL, Menus, StdCtrls, TypInfo, dxTLReg, dxTLImEd, dxTLClms
  {$IFNDEF DELPHI6}, DsgnIntf{$ELSE}, DesignIntf, DesignEditors, VCLEditors{$ENDIF};

const
   nExtColumns = 14 + 1{TODO};
   ExtendedColumns: array [0..nExtColumns - 1] of TPersistentClass =(
        TdxTreeListButtonColumn,
        TdxTreeListDateColumn,
        TdxTreeListCheckColumn,
        TdxTreeListImageColumn,
        TdxTreeListSpinColumn,
        TdxTreeListPickColumn,
        TdxTreeListCalcColumn,
        TdxTreeListHyperLinkColumn,
        TdxTreeListTimeColumn,
        TdxTreeListCurrencyColumn,
        TdxTreeListMemoColumn,
        TdxTreeListGraphicColumn,
        TdxTreeListBlobColumn,
        TdxTreeListMRUColumn,
        TdxTreeListWrapperColumn{TODO});

type
  { TdxTreeListImageColumnProperty }
  TdxTreeListImageColumnProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
    function GetValue: string; override;
  end;

{ TdxTreeListImageColumnProperty }
function TdxTreeListImageColumnProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

procedure TdxTreeListImageColumnProperty.Edit;
begin
 if ShowImagesValuesEditor(TdxTreeListImageColumn(GetComponent(0))) then
    Designer.Modified;
end;

function TdxTreeListImageColumnProperty.GetValue: string;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

procedure Register;
var
  I: Integer;
begin
  RegisterClasses(ExtendedColumns);
  for I := Low(ExtendedColumns) to High(ExtendedColumns) do
     RegisterNoIcon([TComponentClass(ExtendedColumns[I])]);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxTreeListImageColumn, 'ImageIndexes', TdxTreeListImageColumnProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxTreeListImageColumn, 'Values', TdxTreeListImageColumnProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TdxTreeListImageColumn, 'Descriptions', TdxTreeListImageColumnProperty);
  {$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxTreeListButtonColumn, 'ClickKey', TShortCutProperty);
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxTreeListHyperLinkColumn, 'StartKey', TShortCutProperty);
  {$ENDIF}
end;

initialization
  Classes.RegisterClasses(ExtendedColumns);
  AddTreeListColumns(ExtendedColumns);

end.
