
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

  scxTLPrefixName = 'TcxTreeList';

  scxIndexOutOfBounds    = 'Index %d out of bounds';
  scxInvalidStreamFormat = 'Invalid stream format';
  scxMultiSelectRequired = 'Multi select required';

  // designer constants

  scxDesignerCaption     = 'TreeListDesigner editing - ';
  scxBands               = 'Bands...';
  scxColumns             = 'Columns...';
  scxCreateAllItems      = 'Create all columns';
  scxDeleteAllItems      = 'Delete all columns';
  scxItems = 'Items editor...';

  // customization form
                                      
  scxCustomizeCaption = 'Customization';
  scxColumnsCaption   = '   Columns   ';
  scxBandsCaption     = '    Bands    ';

  // Summary menu item captions
  scxTreeListNoneMenuItem = 'None';
  scxTreeListSumMenuItem = 'Sum';
  scxTreeListMinMenuItem = 'Min';
  scxTreeListMaxMenuItem = 'Max';
  scxTreeListCountMenuItem = 'Count';
  scxTreeListAvgMenuItem = 'Average';
  scxTreeListAllNodesMenuItem = 'All Nodes';
  // Column Header menu item captions
  scxTreeListSortAscendingMenuItem = '&Sort Ascending';
  scxTreeListSortDescendingMenuItem = 'S&ort Descending';
  scxTreeListClearSortingMenuItem = '&Clear Sorting';
  scxTreeListFooterMenuItem = '&Footer';
  scxTreeListGroupFootersMenuItem = '&Group Footers';
  scxTreeListGroupFootersInvisibleMenuItem = '&Hidden';
  scxTreeListGroupFootersVisibleWhenExpandedMenuItem = '&Visible When Expanded';
  scxTreeListGroupFootersAlwaysVisibleMenuItem = '&Always Visible';
  scxTreeListRemoveThisColumnMenuItem = 'R&emove This Column';
  scxTreeListFieldChooserMenuItem = 'F&ield Chooser';
  scxTreeListHorizontalAlignmentMenuItem = 'Ho&rizontal Alignment';
  scxTreeListHorizontalAlignmentLeftMenuItem = '&Left';
  scxTreeListHorizontalAlignmentCenterMenuItem = 'Ce&nter';
  scxTreeListHorizontalAlignmentRightMenuItem = '&Right';
  scxTreeListVerticalAlignmentMenuItem = 'Ver&tical Alignment';
  scxTreeListVerticalAlignmentBottomMenuItem = '&Bottom';
  scxTreeListVerticalAlignmentCenterMenuItem = 'Ce&nter';
  scxTreeListVerticalAlignmentTopMenuItem = '&Top';
  scxTreeListBestFitMenuItem = '&Best Fit';
  scxTreeListBestFitAllColumnsMenuItem = 'Bes&t Fit (all columns)';

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
  InternalAdd('scxTLPrefixName', @scxTLPrefixName);
  InternalAdd('scxDesignerCaption', @scxDesignerCaption);
  InternalAdd('scxBands', @scxBands);
  InternalAdd('scxColumns', @scxColumns);
  InternalAdd('scxCreateAllItems', @scxCreateAllItems);
  InternalAdd('scxDeleteAllItems', @scxDeleteAllItems);
  InternalAdd('scxItems', @scxItems);
  InternalAdd('scxCustomizeCaption', @scxCustomizeCaption);
  InternalAdd('scxColumnsCaption', @scxColumnsCaption);
  InternalAdd('scxBandsCaption', @scxBandsCaption);
  InternalAdd('scxTreeListNoneMenuItem', @scxTreeListNoneMenuItem);
  InternalAdd('scxTreeListSumMenuItem', @scxTreeListSumMenuItem);
  InternalAdd('scxTreeListMinMenuItem', @scxTreeListMinMenuItem);
  InternalAdd('scxTreeListMaxMenuItem', @scxTreeListMaxMenuItem);
  InternalAdd('scxTreeListCountMenuItem', @scxTreeListCountMenuItem);
  InternalAdd('scxTreeListAvgMenuItem', @scxTreeListAvgMenuItem);
  InternalAdd('scxTreeListAllNodesMenuItem', @scxTreeListAllNodesMenuItem);
  InternalAdd('scxTreeListSortAscendingMenuItem', @scxTreeListSortAscendingMenuItem);
  InternalAdd('scxTreeListSortDescendingMenuItem', @scxTreeListSortDescendingMenuItem);
  InternalAdd('scxTreeListClearSortingMenuItem', @scxTreeListClearSortingMenuItem);
  InternalAdd('scxTreeListFooterMenuItem', @scxTreeListFooterMenuItem);
  InternalAdd('scxTreeListGroupFootersMenuItem', @scxTreeListGroupFootersMenuItem);
  InternalAdd('scxTreeListGroupFootersInvisibleMenuItem', @scxTreeListGroupFootersInvisibleMenuItem);
  InternalAdd('scxTreeListGroupFootersVisibleWhenExpandedMenuItem', @scxTreeListGroupFootersVisibleWhenExpandedMenuItem);
  InternalAdd('scxTreeListGroupFootersAlwaysVisibleMenuItem', @scxTreeListGroupFootersAlwaysVisibleMenuItem);
  InternalAdd('scxTreeListRemoveThisColumnMenuItem', @scxTreeListRemoveThisColumnMenuItem);
  InternalAdd('scxTreeListFieldChooserMenuItem', @scxTreeListFieldChooserMenuItem);
  InternalAdd('scxTreeListHorizontalAlignmentMenuItem', @scxTreeListHorizontalAlignmentMenuItem);
  InternalAdd('scxTreeListHorizontalAlignmentLeftMenuItem', @scxTreeListHorizontalAlignmentLeftMenuItem);
  InternalAdd('scxTreeListHorizontalAlignmentCenterMenuItem', @scxTreeListHorizontalAlignmentCenterMenuItem);
  InternalAdd('scxTreeListHorizontalAlignmentRightMenuItem', @scxTreeListHorizontalAlignmentRightMenuItem);
  InternalAdd('scxTreeListVerticalAlignmentMenuItem', @scxTreeListVerticalAlignmentMenuItem);
  InternalAdd('scxTreeListVerticalAlignmentBottomMenuItem', @scxTreeListVerticalAlignmentBottomMenuItem);
  InternalAdd('scxTreeListVerticalAlignmentCenterMenuItem', @scxTreeListVerticalAlignmentCenterMenuItem);
  InternalAdd('scxTreeListVerticalAlignmentTopMenuItem', @scxTreeListVerticalAlignmentTopMenuItem);
  InternalAdd('scxTreeListBestFitMenuItem', @scxTreeListBestFitMenuItem);
  InternalAdd('scxTreeListBestFitAllColumnsMenuItem', @scxTreeListBestFitAllColumnsMenuItem);
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
