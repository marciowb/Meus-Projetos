{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxSSTypes;

{$I cxVer.inc}

interface

uses
  Classes, Windows, SysUtils, Graphics, dxCore;

type
  ESpreadSheetError = class(EdxException);

  PByte = ^Byte;
  PWord = ^Word;
  PDouble = ^Double;
  PBoolean = ^Boolean;
  PInteger =  ^Integer;
  PSmallInt = ^SmallInt;

  PByteArray = ^TByteArray;
  TByteArray = array[0..MaxInt div SizeOf(Byte) - 1] of Byte;

  PBoolArray = ^TBoolArray;
  TBoolArray = array[0..MaxInt div SizeOf(Boolean) - 1] of Boolean;

  PIntArray = ^TIntArray;
  TIntArray = array[0..MaxInt div SizeOf(Integer) - 1] of Integer;

  PInt64 = ^Int64;
  PRectArray = ^TRectArray;
  TRectArray = array[0..MaxInt div SizeOf(TRect) - 1] of TRect;

  TcxSSRectsArray = array of TRect;

  TcxString = string;
  PcxString = PChar;

  TcxSortType = (stAscending, stDescending);

  TcxSSHeaderType = (htCol, htRow);

  TcxSSNavigatorBtn = (nbStart, nbPrev, nbNext, nbEnd);

  TcxSSPainterType = (ptOffice97Style, ptOfficeXPStyle, ptCustom);

  TcxSSCellsModify = (msShiftCol, msShiftRow, msAllCol, msAllRow);
  TcxSSModifyType = (mtDelete, mtInsert);

  TcxSSEdgeBorder = (eLeft, eTop, eRight, eBottom);
  TcxSSEdgeBorders = set of TcxSSEdgeBorder;

  TcxSSEdgeLineStyle = (lsDefault,  lsThin, lsMedium, lsDashed, lsDotted,
    lsThick,  lsDouble, lsHair, lsMediumDashed, lsDashDot, lsMediumDashDot,
    lsDashDotDot, lsMediumDashDotDot, lsSlantedDashDot, lsNone);

  TcxSSHitType = (htSheetCell, htSheetColumn, htSheetRow, htSheetCaption, htCaptionButton);
  TcxSSHitTestInfo = record
    case HitType: TcxSSHitType of
      htSheetCell: (CellCol, CellRow: Integer);
      htSheetColumn: (Col: Integer);
      htSheetRow: (Row: Integer);
      htSheetCaption: (Page: Integer);
      htCaptionButton: (Button: TcxSSNavigatorBtn);
  end;

  TRange = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: Integer);
      1: (TopLeft, BottomRight: Int64);
  end;

  TcxSSFillStyle = (fsSolid, fsGray75, fsGray50, fsGray25, fsGray12, fsGray6,
    fsHorzStrip, fsVertStrip, fsRevDiagonalStrip, fsDiagonalStrip, fsDiagCrossHatch,
    fsThickCrossHatch, fsThinHorzStrip, fsThinVertStrip, fsThinRevDiagonalStrip,
    fsThinDiagonalStrip, fsThinDiagCrossHatch, fsThinThickCrossHatch);

  PcxSSFuncRec = ^TcxSSFuncRec;

  TcxSSCellState = (cLocked, cReadOnly, cMerge, cShrinkToFit);
  TcxSSCellStates = set of TcxSSCellState;

  PcxSSFontRec = ^TcxSSFontRec;
  TcxSSFontRec = {$IFNDEF DELPHI12} packed {$ENDIF}  record
    Name: string;
    FontColor: Word;
    Style: TFontStyles;
    Charset: TFontCharset;
    Size: ShortInt;
    FontHandle: HFont;
    Extents: TSize;
  end;

  TcxFillBrushHandle = HBrush;
  TcxFontHandle = HFont;
  TcxPainterHandle = HDC;
  TcxRegionHandle  = HRGN;

  TcxHorzTextAlign = (haGENERAL, haLEFT, haCENTER, haRIGHT, haFILL, haJUSTIFY);
  TcxVertTextAlign = (vaTOP, vaCENTER, vaBOTTOM, vaJUSTIFY);

  TcxDisplayTextAlignment = (dtaLEFT, dtaCENTER, dtaRIGHT, dtaFILL, dtaJUSTIFY);

  TcxTextBrick = {$IFNDEF DELPHI12} packed {$ENDIF}  record
    YPos: Integer;
    Text: TcxString;
    BreakExtra, BreakCount: Integer;
  end;

  TWordExtents = array of TcxTextBrick;

  TcxTextParameters = packed record
    HorzAlign: TcxHorzTextAlign;
    VertAlign: TcxVertTextAlign;
    WordBreak: Boolean;
    XPos: Integer;
    FontColor: Word;
    FontHandle: TcxFontHandle;
    TextBricks: TWordExtents;
  end;

  TcxSSEdgeStyleRec = packed record
    Style: TcxSSEdgeLineStyle;
    Color: Word;
  end;

  TcxSSBordersStyle = array[TcxSSEdgeBorder] of TcxSSEdgeStyleRec;

  PcxSSCellStyleRec = ^TcxSSCellStyleRec;
  TcxSSCellStyleRec = packed record
    FormatIndex: Word;
    HorzAlign: TcxHorzTextAlign;
    VertAlign: TcxVertTextAlign;
    WordBreak: Boolean;
    ShrinkToFit: Boolean;
    CellState: TcxSSCellStates;
    FontPtr: PcxSSFontRec;
    BrushStyle: TcxSSFillStyle;
    BrushFgColor: Word;
    BrushBkColor: Word;
    Borders: TcxSSBordersStyle;
    RefCount: Integer;
  end;

  TcxSSColor = type Word; 
  TxlsDataFormat = type Word;

  TcxSSDataType = (dtText, dtFunction, dtDateTime, dtControl);

  PcxSSCellRec = ^TcxSSCellRec;
  TcxSSCellRec = {$IFNDEF DELPHI12} packed {$ENDIF} record
    Text: TcxString;
    StylePtr: PcxSSCellStyleRec;
    case DataType: TcxSSDataType of
      dtText: ();
      dtFunction: (FuncRecPtr: PcxSSFuncRec);
      dtDateTime: (DateTime: Double);
      dtControl: (Control: TObject);
  end;

  TcxSSCellsArray = packed array[0..MaxInt div SizeOf(TcxSSCellRec) - 1] of PcxSSCellRec;
  PcxSSCellsArray = ^TcxSSCellsArray;

  PcxSSColumn = ^TcxSSColumn;
  TcxSSColumn = packed record
    CellsCount: Integer;
    Cells: PcxSSCellsArray;
  end;

  TcxSSColumns = packed array[0..MaxInt div SizeOf(TcxSSColumn) - 1] of TcxSSColumn;
  PcxSSColumns = ^TcxSSColumns;

  Tcx3DArea = packed record
    Page: Byte;
    Area: TRange;
  end;

  PcxSSNameDefinition = ^TcxSSNameDefinition;
  TcxSSNameDefinition = {$IFNDEF DELPHI12} packed {$ENDIF} record
    Name: string;
    Definition: Tcx3DArea;
    IsDeleted: Boolean;
  end;

  TcxSSNamesDef = array of TcxSSNameDefinition;

  TcxSSSheetDef = record
    SheetName: string;
    SheetIndex: Word;
  end;

  TcxSSSheetsDef = array of TcxSSSheetDef;

  PcxStackItem = ^TcxStackItem;
  TcxStackItem = packed record
    Size: Word;
    Tokens: PByteArray;
  end;

  TcxSSFuncStates = (fsError, fsBool, fsSource);

  TcxSSFuncRec = packed record
    Page: Integer;
    Col: Integer;
    Row: Integer;
    FuncTree: TcxStackItem;
    CalcResult: TcxStackItem;
    IterationCount: Integer;
    States: TcxSSFuncStates;
    IsBusy: Integer;
    IsBadFunction: Boolean;
  end;

const
  cxLineWidth: array[TcxSSEdgeLineStyle] of Byte =
    (1, 1, 2, 1, 1, 3, 3, 1, 2, 1, 2, 1, 2, 2, 1);
  EmptyHandle:  Integer = 0 ;
  cxMaxViewCoord = MaxInt div 20;
  cxMaxViewRect: TRect = (Left: 0; Top: 0; Right: cxMaxViewCoord; Bottom: cxMaxViewCoord);
  cxDefaultFontName = 'Tahoma';

{$IFNDEF DELPHI5}
function Supports(const Instance: TObject; const IID: TGUID; out Intf): Boolean; overload; 
{$ENDIF}

implementation

{$IFNDEF DELPHI5}
function Supports(const Instance: TObject; const IID: TGUID; out Intf): Boolean;
begin
  Result := (Instance <> nil) and Instance.GetInterface(IID, Intf);
end;
{$ENDIF}

end.
