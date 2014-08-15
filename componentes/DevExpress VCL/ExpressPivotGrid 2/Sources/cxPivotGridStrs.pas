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
  // prefilter commands
  scxShowPrefilterDialog = 'Show Prefilter Dialog';

  // prefilter
  scxPrefilterIsEmpty = '<Prefilter is Empty>';
  scxPrefilterCustomizeButtonCaption = 'Prefilter...';

  // connection designer
  scxConnectUsing   = 'Connect using';
  scxAnalysisServer = 'Analysis server';
  scxCubeFile       = 'Cube file';
  scxFile           = 'File';
  scxServer         = 'Server';
  scxDatabase       = 'Database';
  scxCube           = 'Cube';
  scxMeasures       = 'Measures';

  scxUnsupportedProviderVersion = 'Unsupported data provider version:%d';

  scxInvalidProviderVersion = 'Provider version doesn''t match the OLAP data source version';


const
  scxCustomization: array[Boolean] of Pointer =
    (@scxShowCustomization, @scxHideCustomization);
  scxExpandCollapse: array[Boolean] of Pointer =
    (@scxExpand, @scxCollapse);

  TotalDescriptions: array[TcxPivotGridSummaryType] of Pointer =
    (@scxGroupCount, @scxGroupSum, @scxGroupMin, @scxGroupMax, @scxGroupAverage,
     @scxGroupStdDev, @scxGroupStdDevP, @scxGroupVariance, @scxGroupVarianceP, @scxGroupCustom);

  scxOLAPFilterCaption = 'OLAP Filter';
  scxOLAPTotalCaption = 'OLAP Grand Total';

implementation

uses
  dxCore;

procedure AddExpressPivotGridResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAdress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAdress);
  end;

begin
  InternalAdd('scxDataField', @scxDataField);
  InternalAdd('scxDropFilterFields', @scxDropFilterFields);
  InternalAdd('scxDropDataItems', @scxDropDataItems);
  InternalAdd('scxDropRowFields', @scxDropRowFields);
  InternalAdd('scxDropColumnFields', @scxDropColumnFields);
  InternalAdd('scxGrandTotal', @scxGrandTotal);
  InternalAdd('scxNoDataToDisplay', @scxNoDataToDisplay);
  InternalAdd('scxAddTo', @scxAddTo);
  InternalAdd('scxDragItems', @scxDragItems);
  InternalAdd('scxFieldListCaption', @scxFieldListCaption);
  InternalAdd('scxRowArea', @scxRowArea);
  InternalAdd('scxColumnArea', @scxColumnArea);
  InternalAdd('scxFilterArea', @scxFilterArea);
  InternalAdd('scxDataArea', @scxDataArea);
  InternalAdd('scxGroupTotal', @scxGroupTotal);
  InternalAdd('scxGroupCount', @scxGroupCount);
  InternalAdd('scxGroupSum', @scxGroupSum);
  InternalAdd('scxGroupMin', @scxGroupMin);
  InternalAdd('scxGroupMax', @scxGroupMax);
  InternalAdd('scxGroupAverage', @scxGroupAverage);
  InternalAdd('scxGroupStdDev', @scxGroupStdDev);
  InternalAdd('scxGroupStdDevP', @scxGroupStdDevP);
  InternalAdd('scxGroupVariance', @scxGroupVariance);
  InternalAdd('scxGroupVarianceP', @scxGroupVarianceP);
  InternalAdd('scxGroupCustom', @scxGroupCustom);
  InternalAdd('scxOthers', @scxOthers);
  InternalAdd('scxPivotGridShowAll', @scxPivotGridShowAll);
  InternalAdd('scxPivotGridOk', @scxPivotGridOk);
  InternalAdd('scxPivotGridCancel', @scxPivotGridCancel);
  InternalAdd('scxQuarterFormat', @scxQuarterFormat);
  InternalAdd('scxFieldNotADataField', @scxFieldNotADataField);
  InternalAdd('scxInvalidLayout', @scxInvalidLayout);
  InternalAdd('scxNotImplemented', @scxNotImplemented);
  InternalAdd('scxSeparator', @scxSeparator);
  InternalAdd('scxHide', @scxHide);
  InternalAdd('scxOrder', @scxOrder);
  InternalAdd('scxMoveToBeginning', @scxMoveToBeginning);
  InternalAdd('scxMoveToEnd', @scxMoveToEnd);
  InternalAdd('scxMoveToLeft', @scxMoveToLeft);
  InternalAdd('scxMoveToRight', @scxMoveToRight);
  InternalAdd('scxExpand', @scxExpand);
  InternalAdd('scxCollapse', @scxCollapse);
  InternalAdd('scxExpandAll', @scxExpandAll);
  InternalAdd('scxCollapseAll', @scxCollapseAll);
  InternalAdd('scxShowCustomization', @scxShowCustomization);
  InternalAdd('scxHideCustomization', @scxHideCustomization);
  InternalAdd('scxShowPrefilterDialog', @scxShowPrefilterDialog);
  InternalAdd('scxPrefilterIsEmpty', @scxPrefilterIsEmpty);
  InternalAdd('scxPrefilterCustomizeButtonCaption', @scxPrefilterCustomizeButtonCaption);
  InternalAdd('scxConnectUsing', @scxConnectUsing);
  InternalAdd('scxAnalysisServer', @scxAnalysisServer);
  InternalAdd('scxCubeFile', @scxCubeFile);
  InternalAdd('scxFile', @scxFile);
  InternalAdd('scxServer', @scxServer);
  InternalAdd('scxDatabase', @scxDatabase);
  InternalAdd('scxCube', @scxCube);
  InternalAdd('scxMeasures', @scxMeasures);
  InternalAdd('scxUnsupportedProviderVersion', @scxUnsupportedProviderVersion);
  InternalAdd('scxInvalidProviderVersion', @scxInvalidProviderVersion);
end;

initialization
  dxResourceStringsRepository.RegisterProduct('ExpressPivotGrid', @AddExpressPivotGridResourceStringNames);

finalization
  dxResourceStringsRepository.UnRegisterProduct('ExpressPivotGrid');

end.
