{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressFlowChart                                            }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSFLOWCHART AND ALL ACCOMPANYING}
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxFcStrs;

interface

uses
  dxflchrt;

{$I cxVer.inc}

resourcestring
  sdxFlowChartArrowStyleNone = 'None';
  sdxFlowChartArrowStyleArrow = 'Arrow';
  sdxFlowChartArrowStyleEllipseArrow = 'Ellipse Arrow';
  sdxFlowChartArrowStyleRectArrow = 'Rect Arrow';

  sdxFlowChartConnectionEditorArrowColor = 'Arrow Color';
  sdxFlowChartConnectionEditorArrowSize = 'Arrow Size';
  sdxFlowChartConnectionEditorArrowStyle = 'Arrow Style';
  sdxFlowChartConnectionEditorCaption = 'Edit Connection';
  sdxFlowChartConnectionEditorColor = 'Color';
  sdxFlowChartConnectionEditorDestination = 'Destination';
  sdxFlowChartConnectionEditorLinkedPoint = 'Linked Point';
  sdxFlowChartConnectionEditorSource = 'Source';
  sdxFlowChartConnectionEditorText = 'Text';
  sdxFlowChartConnectionEditorTextFontHint = 'Text Font';

  sdxFlowChartDialogButtonOk = '&Ok';
  sdxFlowChartDialogButtonCancel = '&Cancel';

  sdxFlowChartBorderStyleAdjust = 'Adjust';
  sdxFlowChartBorderStyleBottom = 'Bottom';
  sdxFlowChartBorderStyleDiagonal = 'Diagonal';
  sdxFlowChartBorderStyleFlat = 'Flat';
  sdxFlowChartBorderStyleLeft = 'Left';
  sdxFlowChartBorderStyleMiddle = 'Middle';
  sdxFlowChartBorderStyleMono = 'Mono';
  sdxFlowChartBorderStyleRight = 'Right';
  sdxFlowChartBorderStyleSoft = 'Soft';
  sdxFlowChartBorderStyleTop = 'Top';

  sdxFlowChartEdgeStyleRaisedIn = 'RaisedIn';
  sdxFlowChartEdgeStyleRaisedOut = 'RaisedOut';
  sdxFlowChartEdgeStyleSunkenIn = 'SunkenIn';
  sdxFlowChartEdgeStyleSunkenOut = 'SunkenOut';

  sdxFlowChartEditorChildItem = 'Child Item of the %s';
  sdxFlowChartEditorConnection = 'Connect';
  sdxFlowChartEditorConnectionArrowDestinationHint = 'Destination Arrow';
  sdxFlowChartEditorConnectionArrowDestinationSizeHint = 'Destination Arrow Size';
  sdxFlowChartEditorConnectionArrowSourceHint = 'Source Arrow';
  sdxFlowChartEditorConnectionArrowSourceSizeHint = 'Source Arrow Size';
  sdxFlowChartEditorConnectionLinkedPointDestinationHint = 'Linked point of Destination object';
  sdxFlowChartEditorConnectionLinkedPointSourceHint = 'Linked point of Source object';
  sdxFlowChartEditorConnectionStyleHint = 'Line Style';
  sdxFlowChartEditorConnectionTextFontHint = 'Text Font';
  sdxFlowChartEditorCreate = 'Create';
  sdxFlowChartEditorCreateConnectionHint = 'Connection';
  sdxFlowChartEditorCreateObjectHint = 'Object';
  sdxFlowChartEditorEdit = '&Edit';
  sdxFlowChartEditorEditBringToFront = 'Bring To &Front';
  sdxFlowChartEditorEditClearSelection = 'Cl&ear Selection';
  sdxFlowChartEditorEditCopy = '&Copy';
  sdxFlowChartEditorEditCut = 'Cu&t';
  sdxFlowChartEditorEditDelete = '&Delete';
  sdxFlowChartEditorEditPaste = '&Paste';
  sdxFlowChartEditorEditSelectAll = 'Se&lect All';
  sdxFlowChartEditorEditSendToBack = 'Send To &Back';
  sdxFlowChartEditorEditUndo = '&Undo';
  sdxFlowChartEditorFile = '&File';
  sdxFlowChartEditorFileOpen = '&Open';
  sdxFlowChartEditorFileSave = 'Save &As...';
  sdxFlowChartEditorFitHint = 'Fit';
  sdxFlowChartEditorHelp = '&Help';
  sdxFlowChartEditorHelpContents = '&Contents';
  sdxFlowChartEditorMainItemOfUnion = 'Main Item of the Union %d';
  sdxFlowChartEditorObject = 'Object';
  sdxFlowChartEditorObjectImagePositionHint = 'Image Position';
  sdxFlowChartEditorObjectLineWidthHint = 'Line Width';
  sdxFlowChartEditorObjectShapeStyleHint = 'Shape Style';
  sdxFlowChartEditorObjectTextFontHint = 'Text Font';
  sdxFlowChartEditorObjectTextPositionHint = 'Text Position';
  sdxFlowChartEditorOptions = '&Options';
  sdxFlowChartEditorOptionsDynamicMoving = 'Dynamic &Moving';
  sdxFlowChartEditorOptionsDynamicSizing = 'Dynamic &Sizing';
  sdxFlowChartEditorPixels = '%d px.';
  sdxFlowChartEditorPoint = '%d Point';
  sdxFlowChartEditorProperties = '&Properties';
  sdxFlowChartEditorUnions = '&Unions';
  sdxFlowChartEditorUnionsAdd = 'Add To Union';
  sdxFlowChartEditorUnionsClear = 'Clear Union';
  sdxFlowChartEditorUnionsClearAll = 'Clear All Unions';
  sdxFlowChartEditorUnionsNew = 'New Union';
  sdxFlowChartEditorUnionsRemove = 'Remove From Union';
  sdxFlowChartEditorView = '&View';
  sdxFlowChartEditorViewActualSize = '&Actual Size';
  sdxFlowChartEditorViewAntialiasing = '&Antialiasing';
  sdxFlowChartEditorViewFit = '&Fit';
  sdxFlowChartEditorViewZoomIn = 'Zoom &In';
  sdxFlowChartEditorViewZoomOut = 'Zoom &Out';
  sdxFlowChartEditorZoomHint = 'Zoom';

  sdxFlowChartObjectEditorBackgroundColor = 'Background Color';
  sdxFlowChartObjectEditorBorderStyle = 'Border Style';
  sdxFlowChartObjectEditorCaption = 'Edit Object';
  sdxFlowChartObjectEditorEdgeStyle = 'Edge Style';
  sdxFlowChartObjectEditorFrameTab = 'Frame';
  sdxFlowChartObjectEditorGeneralTab = 'General';
  sdxFlowChartObjectEditorHeight = 'Height';
  sdxFlowChartObjectEditorImageClear = 'Clear Image';
  sdxFlowChartObjectEditorImageLayout = 'Image Layout';
  sdxFlowChartObjectEditorImageTab = 'Image';
  sdxFlowChartObjectEditorLineWidth = 'Line Width';
  sdxFlowChartObjectEditorShapeColor = 'Shape Color';
  sdxFlowChartObjectEditorShapeType = 'Shape Type';
  sdxFlowChartObjectEditorText = 'Text';
  sdxFlowChartObjectEditorTextLayout = 'Text Layout';
  sdxFlowChartObjectEditorTransparent = 'Transparent';
  sdxFlowChartObjectEditorWidth = 'Width';

  sdxFlowChartLayoutTopLeft = 'Top-Left';
  sdxFlowChartLayoutTop = 'Top';
  sdxFlowChartLayoutTopRight = 'Top-Right';
  sdxFlowChartLayoutLeft = 'Left';
  sdxFlowChartLayoutCenter = 'Center';
  sdxFlowChartLayoutRight = 'Right';
  sdxFlowChartLayoutBottomLeft = 'Bottom-Left';
  sdxFlowChartLayoutBottom = 'Bottom';
  sdxFlowChartLayoutBottomRight = 'Bottom-Right';

  sdxFlowChartShapeTypeNone = 'None';
  sdxFlowChartShapeTypeRect = 'Rectangle';
  sdxFlowChartShapeTypeEllipse = 'Ellipse';
  sdxFlowChartShapeTypeRoundRect = 'Round Rect';
  sdxFlowChartShapeTypeDiamond = 'Diamond';
  sdxFlowChartShapeTypeNorthTriangle = 'North Triangle';
  sdxFlowChartShapeTypeSouthTriangle = 'South Triangle';
  sdxFlowChartShapeTypeEastTriangle = 'East Triangle';
  sdxFlowChartShapeTypeWestTriangle = 'West Triangle';
  sdxFlowChartShapeTypeHexagon = 'Hexagon';

  sdxFlowChartUnion = 'Union';
  sdxFlowChartUnions = 'Unions';
  sdxFlowChartUnionEditorCaption = 'Select Union';

  sdxFlowChartConnectionStyleStraight = 'Straight';
  sdxFlowChartConnectionStyleCurved = 'Curved';
  sdxFlowChartConnectionStyleRectHorizontal = 'Rect Horizontal';
  sdxFlowChartConnectionStyleRectVertical = 'Rect Vertical';

const
  dxFlowChartArrowStyleNamesMap: array [TdxFcaType] of Pointer = (
    @sdxFlowChartArrowStyleNone, @sdxFlowChartArrowStyleArrow,
    @sdxFlowChartArrowStyleEllipseArrow, @sdxFlowChartArrowStyleRectArrow);

  dxFlowChartConnectionStyleNamesMap: array[TdxFclStyle] of Pointer = (
    @sdxFlowChartConnectionStyleStraight, @sdxFlowChartConnectionStyleCurved,
    @sdxFlowChartConnectionStyleRectHorizontal, @sdxFlowChartConnectionStyleRectVertical);

  dxFlowChartShapeNamesMap: array[TdxFcShapeType] of Pointer = (
    @sdxFlowChartShapeTypeNone, @sdxFlowChartShapeTypeRect,
    @sdxFlowChartShapeTypeEllipse, @sdxFlowChartShapeTypeRoundRect,
    @sdxFlowChartShapeTypeDiamond, @sdxFlowChartShapeTypeNorthTriangle,
    @sdxFlowChartShapeTypeSouthTriangle, @sdxFlowChartShapeTypeEastTriangle,
    @sdxFlowChartShapeTypeWestTriangle, @sdxFlowChartShapeTypeHexagon, nil);

  dxFlowChartLayoutNamesMap: array[0..8] of Pointer = (
    @sdxFlowChartLayoutTopLeft, @sdxFlowChartLayoutTop, @sdxFlowChartLayoutTopRight,
    @sdxFlowChartLayoutLeft, @sdxFlowChartLayoutCenter, @sdxFlowChartLayoutRight,
    @sdxFlowChartLayoutBottomLeft, @sdxFlowChartLayoutBottom, @sdxFlowChartLayoutBottomRight);

implementation

uses
  dxCore;

procedure AddFlowChartResourceStringNames(AProduct: TdxProductResourceStrings);
begin
  AProduct.Add('sdxFlowChartArrowStyleNone', @sdxFlowChartArrowStyleNone);
  AProduct.Add('sdxFlowChartArrowStyleArrow', @sdxFlowChartArrowStyleArrow);
  AProduct.Add('sdxFlowChartArrowStyleEllipseArrow', @sdxFlowChartArrowStyleEllipseArrow);
  AProduct.Add('sdxFlowChartArrowStyleRectArrow', @sdxFlowChartArrowStyleRectArrow);

  AProduct.Add('sdxFlowChartConnectionEditorArrowColor', @sdxFlowChartConnectionEditorArrowColor);
  AProduct.Add('sdxFlowChartConnectionEditorArrowSize', @sdxFlowChartConnectionEditorArrowSize);
  AProduct.Add('sdxFlowChartConnectionEditorArrowStyle', @sdxFlowChartConnectionEditorArrowStyle);
  AProduct.Add('sdxFlowChartConnectionEditorCaption', @sdxFlowChartConnectionEditorCaption);
  AProduct.Add('sdxFlowChartConnectionEditorColor', @sdxFlowChartConnectionEditorColor);
  AProduct.Add('sdxFlowChartConnectionEditorDestination', @sdxFlowChartConnectionEditorDestination);
  AProduct.Add('sdxFlowChartConnectionEditorLinkedPoint', @sdxFlowChartConnectionEditorLinkedPoint);
  AProduct.Add('sdxFlowChartConnectionEditorSource', @sdxFlowChartConnectionEditorSource);
  AProduct.Add('sdxFlowChartConnectionEditorText', @sdxFlowChartConnectionEditorText);
  AProduct.Add('sdxFlowChartConnectionEditorTextFontHint', @sdxFlowChartConnectionEditorTextFontHint);

  AProduct.Add('sdxFlowChartDialogButtonOk', @sdxFlowChartDialogButtonOk);
  AProduct.Add('sdxFlowChartDialogButtonCancel', @sdxFlowChartDialogButtonCancel);

  AProduct.Add('sdxFlowChartBorderStyleAdjust', @sdxFlowChartBorderStyleAdjust);
  AProduct.Add('sdxFlowChartBorderStyleBottom', @sdxFlowChartBorderStyleBottom);
  AProduct.Add('sdxFlowChartBorderStyleDiagonal', @sdxFlowChartBorderStyleDiagonal);
  AProduct.Add('sdxFlowChartBorderStyleFlat', @sdxFlowChartBorderStyleFlat);
  AProduct.Add('sdxFlowChartBorderStyleLeft', @sdxFlowChartBorderStyleLeft);
  AProduct.Add('sdxFlowChartBorderStyleMiddle', @sdxFlowChartBorderStyleMiddle);
  AProduct.Add('sdxFlowChartBorderStyleMono', @sdxFlowChartBorderStyleMono);
  AProduct.Add('sdxFlowChartBorderStyleRight', @sdxFlowChartBorderStyleRight);
  AProduct.Add('sdxFlowChartBorderStyleSoft', @sdxFlowChartBorderStyleSoft);
  AProduct.Add('sdxFlowChartBorderStyleTop', @sdxFlowChartBorderStyleTop);

  AProduct.Add('sdxFlowChartEdgeStyleRaisedIn', @sdxFlowChartEdgeStyleRaisedIn);
  AProduct.Add('sdxFlowChartEdgeStyleRaisedOut', @sdxFlowChartEdgeStyleRaisedOut);
  AProduct.Add('sdxFlowChartEdgeStyleSunkenIn', @sdxFlowChartEdgeStyleSunkenIn);
  AProduct.Add('sdxFlowChartEdgeStyleSunkenOut', @sdxFlowChartEdgeStyleSunkenOut);

  AProduct.Add('sdxFlowChartEditorChildItem', @sdxFlowChartEditorChildItem);
  AProduct.Add('sdxFlowChartEditorConnection', @sdxFlowChartEditorConnection);
  AProduct.Add('sdxFlowChartEditorConnectionArrowDestinationHint', @sdxFlowChartEditorConnectionArrowDestinationHint);
  AProduct.Add('sdxFlowChartEditorConnectionArrowDestinationSizeHint', @sdxFlowChartEditorConnectionArrowDestinationSizeHint);
  AProduct.Add('sdxFlowChartEditorConnectionArrowSourceHint', @sdxFlowChartEditorConnectionArrowSourceHint);
  AProduct.Add('sdxFlowChartEditorConnectionArrowSourceSizeHint', @sdxFlowChartEditorConnectionArrowSourceSizeHint);
  AProduct.Add('sdxFlowChartEditorConnectionLinkedPointDestinationHint', @sdxFlowChartEditorConnectionLinkedPointDestinationHint);
  AProduct.Add('sdxFlowChartEditorConnectionLinkedPointSourceHint', @sdxFlowChartEditorConnectionLinkedPointSourceHint);
  AProduct.Add('sdxFlowChartEditorConnectionStyleHint', @sdxFlowChartEditorConnectionStyleHint);
  AProduct.Add('sdxFlowChartEditorConnectionTextFontHint', @sdxFlowChartEditorConnectionTextFontHint);
  AProduct.Add('sdxFlowChartEditorCreate', @sdxFlowChartEditorCreate);
  AProduct.Add('sdxFlowChartEditorCreateConnectionHint', @sdxFlowChartEditorCreateConnectionHint);
  AProduct.Add('sdxFlowChartEditorCreateObjectHint', @sdxFlowChartEditorCreateObjectHint);
  AProduct.Add('sdxFlowChartEditorEdit', @sdxFlowChartEditorEdit);
  AProduct.Add('sdxFlowChartEditorEditBringToFront', @sdxFlowChartEditorEditBringToFront);
  AProduct.Add('sdxFlowChartEditorEditClearSelection', @sdxFlowChartEditorEditClearSelection);
  AProduct.Add('sdxFlowChartEditorEditCopy', @sdxFlowChartEditorEditCopy);
  AProduct.Add('sdxFlowChartEditorEditCut', @sdxFlowChartEditorEditCut);
  AProduct.Add('sdxFlowChartEditorEditDelete', @sdxFlowChartEditorEditDelete);
  AProduct.Add('sdxFlowChartEditorEditPaste', @sdxFlowChartEditorEditPaste);
  AProduct.Add('sdxFlowChartEditorEditSelectAll', @sdxFlowChartEditorEditSelectAll);
  AProduct.Add('sdxFlowChartEditorEditSendToBack', @sdxFlowChartEditorEditSendToBack);
  AProduct.Add('sdxFlowChartEditorEditUndo', @sdxFlowChartEditorEditUndo);
  AProduct.Add('sdxFlowChartEditorFile', @sdxFlowChartEditorFile);
  AProduct.Add('sdxFlowChartEditorFileOpen', @sdxFlowChartEditorFileOpen);
  AProduct.Add('sdxFlowChartEditorFileSave', @sdxFlowChartEditorFileSave);
  AProduct.Add('sdxFlowChartEditorFitHint', @sdxFlowChartEditorFitHint);
  AProduct.Add('sdxFlowChartEditorHelp', @sdxFlowChartEditorHelp);
  AProduct.Add('sdxFlowChartEditorHelpContents', @sdxFlowChartEditorHelpContents);
  AProduct.Add('sdxFlowChartEditorMainItemOfUnion', @sdxFlowChartEditorMainItemOfUnion);
  AProduct.Add('sdxFlowChartEditorObject', @sdxFlowChartEditorObject);
  AProduct.Add('sdxFlowChartEditorObjectImagePositionHint', @sdxFlowChartEditorObjectImagePositionHint);
  AProduct.Add('sdxFlowChartEditorObjectLineWidthHint', @sdxFlowChartEditorObjectLineWidthHint);
  AProduct.Add('sdxFlowChartEditorObjectShapeStyleHint', @sdxFlowChartEditorObjectShapeStyleHint);
  AProduct.Add('sdxFlowChartEditorObjectTextFontHint', @sdxFlowChartEditorObjectTextFontHint);
  AProduct.Add('sdxFlowChartEditorObjectTextPositionHint', @sdxFlowChartEditorObjectTextPositionHint);
  AProduct.Add('sdxFlowChartEditorOptions', @sdxFlowChartEditorOptions);
  AProduct.Add('sdxFlowChartEditorOptionsDynamicMoving', @sdxFlowChartEditorOptionsDynamicMoving);
  AProduct.Add('sdxFlowChartEditorOptionsDynamicSizing', @sdxFlowChartEditorOptionsDynamicSizing);
  AProduct.Add('sdxFlowChartEditorPixels', @sdxFlowChartEditorPixels);
  AProduct.Add('sdxFlowChartEditorPoint', @sdxFlowChartEditorPoint);
  AProduct.Add('sdxFlowChartEditorProperties', @sdxFlowChartEditorProperties);
  AProduct.Add('sdxFlowChartEditorUnions', @sdxFlowChartEditorUnions);
  AProduct.Add('sdxFlowChartEditorUnionsAdd', @sdxFlowChartEditorUnionsAdd);
  AProduct.Add('sdxFlowChartEditorUnionsClear', @sdxFlowChartEditorUnionsClear);
  AProduct.Add('sdxFlowChartEditorUnionsClearAll', @sdxFlowChartEditorUnionsClearAll);
  AProduct.Add('sdxFlowChartEditorUnionsNew', @sdxFlowChartEditorUnionsNew);
  AProduct.Add('sdxFlowChartEditorUnionsRemove', @sdxFlowChartEditorUnionsRemove);
  AProduct.Add('sdxFlowChartEditorView', @sdxFlowChartEditorView);
  AProduct.Add('sdxFlowChartEditorViewAntialiasing', @sdxFlowChartEditorViewAntialiasing);
  AProduct.Add('sdxFlowChartEditorViewActualSize', @sdxFlowChartEditorViewActualSize);
  AProduct.Add('sdxFlowChartEditorViewFit', @sdxFlowChartEditorViewFit);
  AProduct.Add('sdxFlowChartEditorViewZoomIn', @sdxFlowChartEditorViewZoomIn);
  AProduct.Add('sdxFlowChartEditorViewZoomOut', @sdxFlowChartEditorViewZoomOut);
  AProduct.Add('sdxFlowChartEditorZoomHint', @sdxFlowChartEditorZoomHint);

  AProduct.Add('sdxFlowChartObjectEditorBackgroundColor', @sdxFlowChartObjectEditorBackgroundColor);
  AProduct.Add('sdxFlowChartObjectEditorBorderStyle', @sdxFlowChartObjectEditorBorderStyle);
  AProduct.Add('sdxFlowChartObjectEditorCaption', @sdxFlowChartObjectEditorCaption);
  AProduct.Add('sdxFlowChartObjectEditorEdgeStyle', @sdxFlowChartObjectEditorEdgeStyle);
  AProduct.Add('sdxFlowChartObjectEditorFrameTab', @sdxFlowChartObjectEditorFrameTab);
  AProduct.Add('sdxFlowChartObjectEditorGeneralTab', @sdxFlowChartObjectEditorGeneralTab);
  AProduct.Add('sdxFlowChartObjectEditorHeight', @sdxFlowChartObjectEditorHeight);
  AProduct.Add('sdxFlowChartObjectEditorImageClear', @sdxFlowChartObjectEditorImageClear);
  AProduct.Add('sdxFlowChartObjectEditorImageLayout', @sdxFlowChartObjectEditorImageLayout);
  AProduct.Add('sdxFlowChartObjectEditorImageTab', @sdxFlowChartObjectEditorImageTab);
  AProduct.Add('sdxFlowChartObjectEditorLineWidth', @sdxFlowChartObjectEditorLineWidth);
  AProduct.Add('sdxFlowChartObjectEditorShapeColor', @sdxFlowChartObjectEditorShapeColor);
  AProduct.Add('sdxFlowChartObjectEditorShapeType', @sdxFlowChartObjectEditorShapeType);
  AProduct.Add('sdxFlowChartObjectEditorText', @sdxFlowChartObjectEditorText);
  AProduct.Add('sdxFlowChartObjectEditorTextLayout', @sdxFlowChartObjectEditorTextLayout);
  AProduct.Add('sdxFlowChartObjectEditorTransparent', @sdxFlowChartObjectEditorTransparent);
  AProduct.Add('sdxFlowChartObjectEditorWidth', @sdxFlowChartObjectEditorWidth);

  AProduct.Add('sdxFlowChartLayoutTopLeft', @sdxFlowChartLayoutTopLeft);
  AProduct.Add('sdxFlowChartLayoutTop', @sdxFlowChartLayoutTop);
  AProduct.Add('sdxFlowChartLayoutTopRight', @sdxFlowChartLayoutTopRight);
  AProduct.Add('sdxFlowChartLayoutLeft', @sdxFlowChartLayoutLeft);
  AProduct.Add('sdxFlowChartLayoutCenter', @sdxFlowChartLayoutCenter);
  AProduct.Add('sdxFlowChartLayoutRight', @sdxFlowChartLayoutRight);
  AProduct.Add('sdxFlowChartLayoutBottomLeft', @sdxFlowChartLayoutBottomLeft);
  AProduct.Add('sdxFlowChartLayoutBottom', @sdxFlowChartLayoutBottom);
  AProduct.Add('sdxFlowChartLayoutBottomRight', @sdxFlowChartLayoutBottomRight);

  AProduct.Add('sdxFlowChartShapeTypeNone', @sdxFlowChartShapeTypeNone);
  AProduct.Add('sdxFlowChartShapeTypeRect', @sdxFlowChartShapeTypeRect);
  AProduct.Add('sdxFlowChartShapeTypeEllipse', @sdxFlowChartShapeTypeEllipse);
  AProduct.Add('sdxFlowChartShapeTypeRoundRect', @sdxFlowChartShapeTypeRoundRect);
  AProduct.Add('sdxFlowChartShapeTypeDiamond', @sdxFlowChartShapeTypeDiamond);
  AProduct.Add('sdxFlowChartShapeTypeNorthTriangle', @sdxFlowChartShapeTypeNorthTriangle);
  AProduct.Add('sdxFlowChartShapeTypeSouthTriangle', @sdxFlowChartShapeTypeSouthTriangle);
  AProduct.Add('sdxFlowChartShapeTypeEastTriangle', @sdxFlowChartShapeTypeEastTriangle);
  AProduct.Add('sdxFlowChartShapeTypeWestTriangle', @sdxFlowChartShapeTypeWestTriangle);
  AProduct.Add('sdxFlowChartShapeTypeHexagon', @sdxFlowChartShapeTypeHexagon);

  AProduct.Add('sdxFlowChartUnion', @sdxFlowChartUnion);
  AProduct.Add('sdxFlowChartUnions', @sdxFlowChartUnions);
  AProduct.Add('sdxFlowChartUnionEditorCaption', @sdxFlowChartUnionEditorCaption);

  AProduct.Add('sdxFlowChartConnectionStyleStraight', @sdxFlowChartConnectionStyleStraight);
  AProduct.Add('sdxFlowChartConnectionStyleCurved', @sdxFlowChartConnectionStyleCurved);
  AProduct.Add('sdxFlowChartConnectionStyleRectHorizontal', @sdxFlowChartConnectionStyleRectHorizontal);
  AProduct.Add('sdxFlowChartConnectionStyleRectVertical', @sdxFlowChartConnectionStyleRectVertical);
end;

initialization
  dxResourceStringsRepository.RegisterProduct('ExpressFlowChart', @AddFlowChartResourceStringNames);

finalization
  dxResourceStringsRepository.UnRegisterProduct('ExpressFlowChart');
end.
