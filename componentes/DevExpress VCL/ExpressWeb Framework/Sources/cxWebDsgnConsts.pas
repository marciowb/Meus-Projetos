{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebDsgnConsts;

interface

{$I cxVer.inc}

uses
  {$IFDEF VCL}
  Graphics,
  {$ELSE}
  QGraphics,
  {$ENDIF}
  LibHelp;

var
  cxWebDesignerHintShowPause: Cardinal = 400;
  cxWebDesignerHintHidePause: Cardinal = 5000;
  clcxWebDesignerGridColor: TColor = clBtnShadow;
  clcxWebDesignerSurfaceColor: TColor = clWindow;

const
  cxMarkSize = 5;
  cxDefaultGridSize = 8;
  cxMinGridSize = 2;
  cxMaxGridSize = 128;
  cxMinScaleFactor = 25;
  cxMaxScaleFactor = 400;
  cxNewComponentMinSize = 8;
  cxDefaultDividerPos = 100;

  // help contexts
  hccxfmAlign = LibHelp.hcFAlign;
  hccxfmSize = LibHelp.hcFSize;
  hccxfmScale = LibHelp.hcFScale;
  hccxfmTabOrder = LibHelp.hcFTabOrder;
  hccxAlignToGrid = LibHelp.hcFAlignToGrid;
  hccxSaveAsTemplate = LibHelp.hcFSaveAsTemplate;
  hccxCreationOrder = LibHelp.hcFCreateOrder;
  hccxViewAsText = LibHelp.hcFViewAsText;
  hccxTextDFM = LibHelp.hcFTextDFM;
  hccxRevert = LibHelp.hcFRevert;
  hccxEditCommand = 0;
  hccxUndoCommand = 0;
  hccxRedoCommand = 0;
  hccxCutCommand = 0;
  hccxCopyCommand = 0;
  hccxPasteCommand = 0;
  hccxDeleteCommand = 0;
  hccxSelectAllCommand = 0;
  hccxfmEnvironmentOptions = 0;
  hccxfmInsertWebFrameModule = 0;
  hccxfmNewWebModule = 0;

const
  { don't localize }
  scxButtonBar = 'ButtonBar';
  scxExpressWebObjectsRootRegPath = 'Developer Express\WebObjects';
  scxExpressWebObjectsFormLayoutsRegPath = scxExpressWebObjectsRootRegPath + '\FormLayouts';
  scxExpressWebObjectsEnvOptRegPath = scxExpressWebObjectsRootRegPath + '\EnvironmentOptions';
  scxHeight = 'Height';
  scxItem = 'Item';
  scxColumn = 'Column';
  scxStyleDesigner = '%s%s%s Style Editor';
  scxTVDesigner = '%s%s%s Items Editor';
  scxWebGridColumnDesigner = '%s%s%s Column Editor';
  scxWebMenuItemDesigner = '%s%s%s Item Editor';
  scxWidth = 'Width';

  scxCompanyName = 'Developer Express Inc.';
  scxCompanyWebPage = 'http://www.devexpress.com';
  scxProductName = 'ExpressWeb Framework';
  scxProductPage = 'ExpressWeb Framework';
  scxNewWebModuleHint =  'New Express WebModule';

  scxProductWizardPage = 'ExpressWeb Framework';

  scxWebProjectWizardName = 'Web Application';
  scxWebProjectWizardIconName = 'TCXWEBPROJECT';
  scxWebProjectWizardComment = 'Creates a ' + scxWebProjectWizardName;
  scxWebProjectWizardID = scxCompanyName + '.' + scxWebProjectWizardName;

  scxWebPageModuleWizardName = 'Web Page Module';
  scxWebPageModuleWizardIconName = 'TCXWEBPAGEMODULE';
  scxWebPageModuleWizardComment = 'Creates a ' + scxWebPageModuleWizardName;
  scxWebPageModuleWizardID = scxCompanyName + '.' + scxWebPageModuleWizardName;

  scxWebFramesetWizardName = 'Web Frameset Module';
  scxWebFramesetWizardIconName = 'TCXWEBFRAMESET';
  scxWebFramesetWizardComment = 'Creates a ' + scxWebFramesetWizardName;
  scxWebFramesetWizardID = scxCompanyName + '.' + scxWebFramesetWizardName;

  scxWebDataModuleWizardName = 'Web Data Module';
  scxWebDataModuleWizardIconName = 'TCXWEBDATAMODULE';
  scxWebDataModuleWizardComment = 'Creates a ' + scxWebDataModuleWizardName;
  scxWebDataModuleWizardID = scxCompanyName + '.' + scxWebDataModuleWizardName;

function cxGetProductText: string;

implementation

uses
  cxWebConsts;
  
function cxGetProductText: string;
begin
  Result := scxProductName + ' ' + cxWebConstsVersion;
end;

end.
