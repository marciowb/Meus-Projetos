
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressQuantumTreeList                                       }
{                                                                    }
{       Copyright (c) 1998-2010 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSQUANTUMTREELIST AND ALL        }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxTLStrs;

{$I cxVer.inc}

interface

uses
  cxClasses, dxCore;

resourcestring
  scxIndexOutOfBounds    = 'Index %d out of bounds';
  scxInvalidStreamFormat = 'Invalid stream format';
  scxMultiSelectRequired = 'Multi select required';

  // designers constants

  scxDesignerCaption     = 'TreeListDesigner editing - ';
  scxBands               = 'Bands...';
  scxColumns             = 'Columns...';
  scxCreateAllItems      = 'Create all columns';
  scxDeleteAllItems      = 'Delete all columns';
  scxItems = 'Items editor...';

  // customizing box
  
  scxCustomizeCaption = 'Customize';
  scxColumnsCaption   = '   Columns   ';
  scxBandsCaption     = '    Bands    ';

  scxOperationNotSupported = 'Operation is not supported';

  scxTreeListDeletingFocusedConfirmationText = 'Delete record(s)?';
  scxTreeListDeletingConfirmationCaption = 'Confirm';

  scxExportNotVisibleControl = 'Control must be visible for export';

  function scxStr(AResString: Pointer): string;

implementation

function scxStr(AResString: Pointer): string;
begin
  Result := cxGetResourceString(AResString);
end;

procedure AddExpressQuantumTreeListResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAdress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAdress);
  end;

begin
  InternalAdd('scxIndexOutOfBounds', @scxIndexOutOfBounds);
  InternalAdd('scxInvalidStreamFormat', @scxInvalidStreamFormat);
  InternalAdd('scxMultiSelectRequired', @scxMultiSelectRequired);
  InternalAdd('scxDesignerCaption', @scxDesignerCaption);
  InternalAdd('scxBands', @scxBands);
  InternalAdd('scxColumns', @scxColumns);
  InternalAdd('scxCreateAllItems', @scxCreateAllItems);
  InternalAdd('scxDeleteAllItems', @scxDeleteAllItems);
  InternalAdd('scxItems', @scxItems);
  InternalAdd('scxCustomizeCaption', @scxCustomizeCaption);
  InternalAdd('scxColumnsCaption', @scxColumnsCaption);
  InternalAdd('scxBandsCaption', @scxBandsCaption);
  InternalAdd('scxOperationNotSupported', @scxOperationNotSupported);
  InternalAdd('scxTreeListDeletingFocusedConfirmationText', @scxTreeListDeletingFocusedConfirmationText);
  InternalAdd('scxTreeListDeletingConfirmationCaption', @scxTreeListDeletingConfirmationCaption);
  InternalAdd('scxExportNotVisibleControl', @scxExportNotVisibleControl);
end;

initialization
  scxStr(@scxBands);
  dxResourceStringsRepository.RegisterProduct('ExpressQuantumTreeList', @AddExpressQuantumTreeListResourceStringNames);

finalization
  dxResourceStringsRepository.UnRegisterProduct('ExpressQuantumTreeList');

end.
