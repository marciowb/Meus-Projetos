
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

unit dxLExReg;

interface

{$I dxTLVer.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  TypInfo, dxTLReg, dxTLClEx, dxGrReg, dxGrClEx, dxDTLReg{$IFNDEF DELPHI6},
  DsgnIntf{$ELSE}, DesignIntf, DesignEditors, VCLEditors{$ENDIF};

const
   // DBTreeList
   nDBTLExtColumns = 2;
   DBTLExtendedColumns: array [0..nDBTLExtColumns - 1] of TPersistentClass =(
        TdxDBTreeListPopupColumn,
        TdxDBTreeListExtLookupColumn);

procedure Register;
var
  I: Integer;
begin
  RegisterClasses(DBTLExtendedColumns);
  for I := Low(DBTLExtendedColumns) to High(DBTLExtendedColumns) do
     RegisterNoIcon([TComponentClass(DBTLExtendedColumns[I])]);
  // Hide properties
  RegisterPropertyEditor(TypeInfo(TControl), TdxDBTreeListExtLookupColumn, 'PopupControl', nil);
  {$IFDEF DELPHI6}
  RegisterPropertyEditor(TypeInfo(TShortCut), TdxDBTreeListExtLookupColumn, 'ClearKey', TShortCutProperty);
  {$ENDIF}
end;

initialization
  Classes.RegisterClasses(DBTLExtendedColumns);
  AddDBTreeListColumns(DBTLExtendedColumns);

end.
