{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{                   ExpressPivotGrid                                 }
{                                                                    }
{       Copyright (c) 2005-2010 Developer Express Inc.               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPIVOTGRID AND ALL ACCOMPANYING }
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.              }
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

unit cxPivotGridStrs;

{$I cxVer.inc}

interface

uses
  cxCustomPivotGrid;

resourcestring

  scxDataField  = 'Data';
  //
  scxDropFilterFields = 'Drop Filter Fields Here';
  scxDropDataItems    = 'Drop Data Fields Here';
  scxDropRowFields    = 'Drop Row Fields Here';
  scxDropColumnFields = 'Drop Column Fields Here';
  scxGrandTotal       = 'Grand Total';
  scxNoDataToDisplay  = '<No data to display>';

  // field list strings
  scxAddTo            = 'Add To';
  scxDragItems        = 'Drag Items to the PivotGrid';
  scxFieldListCaption = 'PivotGrid Field List';

  scxRowArea    = 'Row Area';
  scxColumnArea = 'Column Area';
  scxFilterArea = 'Filter Area';
  scxDataArea   = 'Data Area';

  // group strings 
  scxGroupTotal      = '%s Total';
  scxGroupCount      = '%s Count';
  scxGroupSum        = '%s Sum';
  scxGroupMin        = '%s Min';
  scxGroupMax        = '%s Max';
  scxGroupAverage    = '%s Average';
  scxGroupStdDev     = '%s StdDev';
  scxGroupStdDevP    = '%s StdDevP';
  scxGroupVariance   = '%s Var';
  scxGroupVarianceP  = '%s VarP';
  scxGroupCustom     = '%s Custom';

  scxOthers           = 'Others';

  // filter strings
  scxPivotGridShowAll = '(Show All)';
  scxPivotGridOk      = 'Ok';
  scxPivotGridCancel  = 'Cancel';

  // intervals

  scxQuarterFormat = 'Qtr %d';

  // pivot grid exception

  scxFieldNotADataField = 'Field must be in data area!';
  scxInvalidLayout  = 'Invalid layout!';
  scxNotImplemented =  'Not implemented yet!';

  // pivot grid pupup menu items
  scxSeparator       = '-';

  scxHide            = 'Hide';
  scxOrder           = 'Order';
  scxMoveToBeginning = 'Move to Beginning';
  scxMoveToEnd       = 'Move to End';
  scxMoveToLeft      = 'Move to Left';
  scxMoveToRight     = 'Move to Right';
  //
  scxExpand          = 'Expand';
  scxCollapse        = 'Collapse';
  scxExpandAll       = 'Expand All';
  scxCollapseAll     = 'Collapse All';
  // misc. commands
  scxShowCustomization = 'Show Field List';
  scxHideCustomization = 'Hide Field List';

const
  scxCustomization: array[Boolean] of Pointer =
    (@scxShowCustomization, @scxHideCustomization);
  scxExpandCollapse: array[Boolean] of Pointer =
    (@scxExpand, @scxCollapse);

  TotalDescriptions: array[TcxPivotGridSummaryType] of Pointer =
    (@scxGroupCount, @scxGroupSum, @scxGroupMin, @scxGroupMax, @scxGroupAverage,
     @scxGroupStdDev, @scxGroupStdDevP, @scxGroupVariance, @scxGroupVarianceP, @scxGroupCustom);

implementation

end.
