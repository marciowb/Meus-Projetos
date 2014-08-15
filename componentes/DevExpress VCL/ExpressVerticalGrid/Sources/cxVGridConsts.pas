{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressVerticalGrid                                          }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSVERTICALGRID AND ALL           }
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
unit cxVGridConsts;

{$I cxVer.inc}

interface

resourcestring
  cxSvgIndexError = 'Index error';
  cxSvgInvalidRowClass = 'Can''t create row';
  cxSvgAssignRowsError = 'Can''t assign rows';
  cxSvgDeletingFocusedConfirmationText = 'Delete record?';
  cxSvgDeletingConfirmationCaption = 'Confirm';

  cxSvgOKCaption = 'OK';
  cxSvgCancelCaption = 'Cancel';

  cxSvgCustomizeCaption = 'Customize';
  cxSvgCustomizeCategoriesCaption = 'Categories';
  cxSvgCustomizeDeleteCategory = '&Delete';
  cxSvgCustomizeNewCategory = '&New...';
  cxSvgCustomizeRowsCaption = 'Rows';

  cxSvgNewCategoryCaption = 'New Category';
  cxSvgNewCategoryLabelCaption = '&Category:';

  cxSvgLayoutEditorCaption = 'Layout editor';
  cxSvgLayoutEditorCustomize = '&Customize';

  //cxRTTIInspector
  cxSvgRTTIInspectorEmptyGlyph = '(None)';
  cxSvgUnknown = '(Unknown)';
  cxSvgExportNotVisibleControl = 'Can''t export invisible control';
  cxSvgRTTICollectionEditCaption = 'Editing %s%s%s';
  cxSvgRTTICollectionAdd = '&Add';
  cxSvgRTTICollectionAddHint = 'Add New';
  cxSvgRTTICollectionDelete = '&Delete';
  cxSvgRTTICollectionDeleteHint = 'Delete Selected';
  cxSvgRTTICollectionSelectAll = '&Select All';
  cxSvgRTTICollectionToolbar = '&Toolbar';
  cxSvgRTTICollectionTextLabel = 'Text &Labels';
  cxSvgRTTICollectionMoveUp = 'Move &Up';
  cxSvgRTTICollectionMoveUpHint = 'Move Selected Up';
  cxSvgRTTICollectionMoveDown = 'Move Dow&n';
  cxSvgRTTICollectionMoveDownHint = 'Move Selected Down';

implementation

uses
  dxCore;
  
procedure AddExpressVerticalGridResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAdress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAdress);
  end;

begin
  InternalAdd('cxSvgIndexError', @cxSvgIndexError);
  InternalAdd('cxSvgInvalidRowClass', @cxSvgInvalidRowClass);
  InternalAdd('cxSvgAssignRowsError', @cxSvgAssignRowsError);
  InternalAdd('cxSvgDeletingFocusedConfirmationText', @cxSvgDeletingFocusedConfirmationText);
  InternalAdd('cxSvgDeletingConfirmationCaption', @cxSvgDeletingConfirmationCaption);
  InternalAdd('cxSvgOKCaption', @cxSvgOKCaption);
  InternalAdd('cxSvgCancelCaption', @cxSvgCancelCaption);
  InternalAdd('cxSvgCustomizeCaption', @cxSvgCustomizeCaption);
  InternalAdd('cxSvgCustomizeCategoriesCaption', @cxSvgCustomizeCategoriesCaption);
  InternalAdd('cxSvgCustomizeDeleteCategory', @cxSvgCustomizeDeleteCategory);
  InternalAdd('cxSvgCustomizeNewCategory', @cxSvgCustomizeNewCategory);
  InternalAdd('cxSvgCustomizeRowsCaption', @cxSvgCustomizeRowsCaption);
  InternalAdd('cxSvgNewCategoryCaption', @cxSvgNewCategoryCaption);
  InternalAdd('cxSvgNewCategoryLabelCaption', @cxSvgNewCategoryLabelCaption);
  InternalAdd('cxSvgLayoutEditorCaption', @cxSvgLayoutEditorCaption);
  InternalAdd('cxSvgLayoutEditorCustomize', @cxSvgLayoutEditorCustomize);
  InternalAdd('cxSvgRTTIInspectorEmptyGlyph', @cxSvgRTTIInspectorEmptyGlyph);
  InternalAdd('cxSvgUnknown', @cxSvgUnknown);
  InternalAdd('cxSvgExportNotVisibleControl', @cxSvgExportNotVisibleControl);
  InternalAdd('cxSvgRTTICollectionEditCaption', @cxSvgRTTICollectionEditCaption);
  InternalAdd('cxSvgRTTICollectionAdd', @cxSvgRTTICollectionAdd);
  InternalAdd('cxSvgRTTICollectionAddHint', @cxSvgRTTICollectionAddHint);
  InternalAdd('cxSvgRTTICollectionDelete', @cxSvgRTTICollectionDelete);
  InternalAdd('cxSvgRTTICollectionDeleteHint', @cxSvgRTTICollectionDeleteHint);
  InternalAdd('cxSvgRTTICollectionSelectAll', @cxSvgRTTICollectionSelectAll);
  InternalAdd('cxSvgRTTICollectionToolbar', @cxSvgRTTICollectionToolbar);
  InternalAdd('cxSvgRTTICollectionTextLabel', @cxSvgRTTICollectionTextLabel);
  InternalAdd('cxSvgRTTICollectionMoveUp', @cxSvgRTTICollectionMoveUp);
  InternalAdd('cxSvgRTTICollectionMoveUpHint', @cxSvgRTTICollectionMoveUpHint);
  InternalAdd('cxSvgRTTICollectionMoveDown', @cxSvgRTTICollectionMoveDown);
  InternalAdd('cxSvgRTTICollectionMoveDownHint', @cxSvgRTTICollectionMoveDownHint);
end;

initialization
  dxResourceStringsRepository.RegisterProduct('ExpressVerticalGrid', @AddExpressVerticalGridResourceStringNames);

finalization
  dxResourceStringsRepository.UnRegisterProduct('ExpressVerticalGrid');

end.

