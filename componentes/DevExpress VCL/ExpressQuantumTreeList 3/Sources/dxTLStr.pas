
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressQuantumGrid Suite const                              }
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

unit dxTLStr;

interface

{$I dxTLVer.inc}

const
  dxSInvalidOwner                    = 38801;  // 'Invalid Owner TdxTreeListNode'
  dxSColumnsCaption                  = 38802;  // 'Columns'
  dxSTitleWarning                    = 38803;  // 'Confirm';
  dxSDeleteRecordQuestion            = 38804;  // 'Delete record?'
  dxSDeleteMultipleRecordsQuestion   = 38805;  // 'Delete all selected records?'
  dxSColumnNotFound                  = 38806;  // '%s: Column by Field ''%s'' not found')
  dxSPanelText                       = 38807;  // 'Drag a column header here to group by that column'
  dxSInvalidDataSetMode              = 38808;  // 'Dataset in edit or insert mode'

  dxSBandsCaption                    = 38809;  // '    Bands    '
  dxSHeadersCaption                  = 38810;  // '   Headers   '
  dxSDefaultFieldsError              = 38811;  // 'DefaultFields property should be set to False'

  dxSInvalidGroupName                = 38812;  // 'Invalidate group name!'
  dxSInvalidGroupNameDuplicate       = 38813;  // 'Invalidate group name: duplicate!'

implementation

{$R dxTLStr.res}
  
end.

