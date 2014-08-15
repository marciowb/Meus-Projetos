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

unit cxSSIntf;

interface

{$I cxVer.inc}

uses
  Windows, cxSSTypes, cxExcelConst;

type
  IcxSpreadSheetListener = interface
  ['{87FE7288-8326-40ED-9102-D54A6D27AE18}']
    function BeginUpdate: Integer;
    function EndUpdate: Integer;
  end;

  { IcxCellStyle }
  IcxSpreadSheetCellStyle = interface
  ['{3A381E00-4311-49A2-816B-C79F4690AF96}']
    procedure SetBorderStyle(const ASide: TcxSSEdgeBorder;
      AStyle: TcxSSEdgeLineStyle; AColor: Byte);
    procedure SetFillStyle(const AStyle: TcxSSFillStyle; AFgColor, ABkColor: Byte);
    procedure SetFormatStyle(const AFormat: TxlsDataFormat);
    procedure SetFont(const AFont: TcxSSFontRec);
    procedure SetCellStyle(const AStyle: PcxSSCellStyleRec;
      ASetDefaultBorders: Boolean = False);
  end;

  { IcxSpreadSheetCell }
  IcxSpreadSheetCell = interface
  ['{4D22A8C2-F327-4080-B3B6-D8526CE00F0E}']
    function GetCellStyle: IcxSpreadSheetCellStyle;
    procedure SetText(const AValue: string);
    function GetText: string;
    procedure SetTextEx(const Value: string; IsFormula: Boolean = False; Analyze: Boolean = True);
  end;

  { IcxBookSheet }
  IcxBookSheet = interface
  ['{6EA75673-9538-4626-97C8-08A5A818FCB4}']
    procedure SetColRowSize(const AKind: TcxSSHeaderType;
      const AColumn, ASize: Integer; ALocked: Boolean; AVisible: Boolean = True);
    procedure SetDefaultSize(const AKind: TcxSSHeaderType; ASize: Integer);
    procedure SetMergedCells(const ARect: TRect; IsMerge: Boolean);
    procedure SetPageDimension(const HorzCount, VertCount: Integer);
    procedure SetProtection(Value: Boolean);
    procedure SetViewInformation(const ASelectionRect: TRect;
      AViewFormulas, AViewGrid, AViewHeaders, AScrollBars: Boolean);
    function GetCell(const ACol, ARow: Integer): IcxSpreadSheetCell;
  end;

  { IcxSpreadSheetBook }
  IcxSpreadSheetBook = interface
  ['{BD273CEA-BD42-43E1-9E05-2CE37DE710F6}']
    function AddSheet(const AName: string; AVisible: Boolean): IcxBookSheet;
    function BeginUpdate: Integer;
    function DefineName(const AName: string; APage: Word; const ARect: TRect): Integer;
    function EndUpdate: Integer;
    function GetCell(APage: Word; ACol, ARow: Integer): IcxSpreadSheetCell;
    function GetSheet(APage: Word): IcxBookSheet;
    function GetPageCount: Word;
    procedure SetProtection(Value: Boolean); 
    procedure SetDefaultStyle(const AStyle: PcxSSCellStyleRec);
    procedure SetPalette(const APalette: PcxExcelPalette);
    procedure SetPageVisible(APage: Word; const AValue: Boolean);
  end;

implementation

end.

