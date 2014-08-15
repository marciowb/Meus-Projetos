
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressMasterView string IDs                                }
{                                                                   }
{       Copyright (c) 1999-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSMASTERVIEW AND ALL            }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM      }
{   ONLY.                                                           }
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

unit dxMasterViewStrs;

interface

const
  dxsMVBase = 39600;

  dxsMVDeleteConfirmCaptionText   = dxsMVBase + 00;  // Confirm
  dxsMVDeleteConfirmText          = dxsMVBase + 01;  // Delete record from %s?
  dxsMVMultipleDeleteConfirmText  = dxsMVBase + 02;  // Delete all selected records from %s?
  dxsMVGroupByBoxText             = dxsMVBase + 03;  // Drag a column header here to group by that column
  dxsMVCBCaption                  = dxsMVBase + 04;  // Customize
  dxsMVCBColumns                  = dxsMVBase + 05;  // Columns
  dxsMVCBOptions                  = dxsMVBase + 06;  // Options
  dxsMVCBNoFields                 = dxsMVBase + 07;  // (no fields available)

  dxsMVCBOptionCaption                   = dxsMVBase + 08;  // Caption
  dxsMVCBOptionFooter                    = dxsMVBase + 09;  // Footer
  dxsMVCBOptionGrid                      = dxsMVBase + 10;  // Grid
  dxsMVCBOptionGridWithPreview           = dxsMVBase + 11;  // Grid with Preview
  dxsMVCBOptionGroupByBox                = dxsMVBase + 12;  // GroupBy Box
  dxsMVCBOptionHeader                    = dxsMVBase + 13;  // Header
  dxsMVCBOptionHeaderForFirstNode        = dxsMVBase + 14;  // Header for the First Node
  dxsMVCBOptionHeaderForFirstVisibleNode = dxsMVBase + 15;  // Header for the First Visible Node
  dxsMVCBOptionHeaderAfterExpandedNode   = dxsMVBase + 16;  // Header after Expanded Node
  dxsMVCBOptionOccupyRestSpace           = dxsMVBase + 17;  // Columns Occupy the Rest Space
  dxsMVCBOptionPreview                   = dxsMVBase + 18;  // Preview
  dxsMVCBOptionViewMode                  = dxsMVBase + 19;  // Horizontal

  dxsMVImageColumnEditorValueText        = dxsMVBase + 20;  // Value
  dxsMVImageColumnEditorImageIndexText   = dxsMVBase + 21;  // ImageIndex
  dxsMVImageColumnEditorDescriptionIndex = dxsMVBase + 22;  // Description

implementation

{$R *.RES}

end.
