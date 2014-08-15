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

unit cxSSRes;

{$I cxVer.inc}

interface

resourcestring
  scxSheetName = 'Sheet';

  // categories constants (do not localize)
  scxSpreadSheet = 'SpreadSheet';
  scxSpreadSheetDesc = 'SpreadSheet properties and/or events';

  // SpreadSheetBook errors
  scxSpreadSheetErrorReadSST        = 'Reading SST record error';
  scxSpreadSheetInvalidSheetNumber  = 'Invalid page number';
  scxSpreadSheetInvalidFileName     = 'Invalid file %s name';
  scxSpreadSheetInvalidFileFormat   = 'Invalid %s file format'; // for external use
  scxSpreadSheetInvalidStreamFormat = 'Invalid stream format';
  scxSpreadSheetInvalidSheetCaption = 'Sheet caption invalid or already exist';
  scxSpreadSheetSheetPageExist      = 'Page already exists'; // for external use
  scxSpreadSheetMergeCellError      = 'Merge cell error, certain cells already merged';
  scxChangePartOfMergeCells         = 'Cannot change part of merged cells';
  scxSpreadSheetMergeCellError2     = 'Some modified cells are merged';
  scxSpreadSheetDefineNameError     = 'Error define name, name already exist'; // for external use
  scxSpreadSheetDefineNameError2    = 'Error define name, name contains extra characters';  // for external use
  scxSpreadSheetDeleteLastSheet     = 'Cannot delete the last sheet';

  // sheet popup menu constants
  scxPopupMenuMergeCells  = 'Merge cells';
  scxPopupMenuSplitCells  = 'Split cells';
  scxPopupMenuFormatCells = 'Format cells'; // for external use
  scxPopupMenuHideRows    = 'Hide rows'; // for external use
  scxPopupMenuUnhideRows  = 'Unhide rows'; // for external use
  scxPopupMenuHideCols    = 'Hide column'; // for external use
  scxPopupMenuUnhideCols  = 'Unhide column'; // for external use

  // insert and deliting cells constants // for external use
  scxSpreadSheetShiftCellLeft   = 'Shift cells left';
  scxSpreadSheetShiftCellTop    = 'Shift cells top';
  scxSpreadSheetShiftCellRight  = 'Shift cells right';
  scxSpreadSheetShiftCellBottom = 'Shift cells bottom';
  scxSpreadSheetAllRow          = 'Entire row';
  scxSpreadSheetAllColumn       = 'Entire column';
  scxSpreadSheetDeleteCells     = 'Delete';
  scxSpreadSheetInsertCells     = 'Insert';

  // datastorage
  scxDataStorageErrorReadCellRecord = 'Error reading cell record';
  scxDataStorageErrorSetCellRecord  = 'Error setting cell record';
  // style
  scxStyleInvalidColorIndex = 'Invalid color index';
  scxStyleInvalidCellStyle  = 'Invalid cell style';

  // calculation error
  scxCaclulatorCyclingError      = 'Calculation error. Formula cycled indexes present';
  scxCaclulatorConstructFormula  = 'Error constructing formula. Parsed expression error offset at';
  scxCaclulatorParseFormula      = 'Error parsing formula at string position'; // for external use
  scxCaclulatorStringExpression  = 'Error syntax in string expression';
  scxCaclulatorFuncInvalidIndex  = 'Invalid function index'; // for external use
  scxCaclulatorFuncInvalidName   = 'Invalid function name'; // for external use
  scxCaclulatorErrorSymbol       = 'Error - symbol '')'' expected!';
  scxCaclulatorErrorString       = 'Error - unterminated string!';
  scxCaclulatorUnknownExpression = 'Unknown string expression';
  scxCaclulatorUnknownToken      = 'Unknown token in expression';
  scxCaclulatorDivByZero         = 'Division by zero!'; // for external use
  scxCaclulatorTypeErr           = 'Incompatible operands type!'; // for external use
  scxCaclulatorMissingTokens     = 'Missing tokens';
  scxCaclulatorMissingParamters  = 'Missing stack parameters';
  scxCaclulatorFuncNeedResult    = 'Function need result';

  // error codes such as excel program (do not localize)
  scxNullError    = '#NULL!';
  scxDivZeroError = '#DIV/0!';
  scxValueError   = '#VALUE!';
  scxNameError    = '#NAME!';
  scxNumError     = '#NUM!';
  scxRefError     = '#REF!';
  scxNAError      = '#N/A!';

  // forms resources
  scxFormApply  = 'Apply';  // for external use
  scxFormCancel = 'Cancel';
  scxFormOk     = 'Ok';

  // format form strings
  scxFormatDialogFormatCaption = 'Format cells';
  scxFormatCellStyle           = 'Cell style';
  scxFormatCellStyleType       = 'Style type';
  scxFormatStyleStyleSettings  = 'Style settings';

  scxFormatStyleGeneral  = '&General';
  scxFormatStyleCurrency = '&Currency';
  scxFormatStyleNumber   = '&Number';
  scxFormatStyleDateTime = '&Date/Time';
  scxFormatStyleText     = '&Text';

  scxGeneralStyleDescription  = 'General format cells have no specific format.';
  scxNumberStyleDescription   = 'Number is used for general display of numbers.';
  scxCurrencyStyleDescription = 'Currency formats are used for general monetary amounts.';
  scxDateTimeStyleDescription = 'Date/Time formats are used for date and time serial numbers as Date/Time values.';
  scxTextStyleDescription     = 'Text formatted cells are treated as text even when a number is in the cell.  The cell is displayed exactly as entered.';

  scxFormatDialogText          = '&Alignment';
  scxFormatDialogBorder        = '&Border';
  scxFormatDialogPatterns      = '&Patterns';
  scxFormatDialogHorzAlign     = '&Horizontal';
  scxFormatDialogVertAlign     = '&Vertical';
  scxFormatDialogTextAlignment = 'Text alignment';
  scxFormatDialogTextControl   = 'Text control';
  scxFormatDialogGeneral       = 'General';
  scxFormatDialogLeft          = 'Left';
  scxFormatDialogCenter        = 'Center';
  scxFormatDialogRight         = 'Right';
  scxFormatDialogFill          = 'Fill';
  scxFormatDialogJustify       = 'Justify';
  scxFormatDialogTop           = 'Top';
  scxFormatDialogBottom        = 'Bottom';
  scxFormatDialogWrap          = '&Word wrap';
  scxFormatDialogFont          = '&Font';
  scxFormatDialogNone          = '&None';
  scxFormatDialogNone2         = 'None';
  scxFormatDialogOutline       = '&Ou&tl&ine';
  scxFormatDialogInside        = '&Inside';
  scxFormatDialogItems         = 'Items';
  scxFormatDialogAllBorder     = 'All borders';
  scxFormatDialogLine          = 'Line';
  scxFormatDialogStyle         = '&Style:';
  scxFormatDialogColor         = '&Color:';
  scxFormatDialogTextStr       = 'Text';
  scxFormatDialogCellShading   = 'Cell shading';
  scxFormatDialogSample        = 'Sample';
  scxFormatDialogPattern       = '&Pattern:';
  scxFormatDialogSampleText    = 'The quick brown fox jumps over the lazy dog';
  scxUseDefaultColor           = 'Use default color';
  scxColorEditorCaption        = 'Color property editor'; 

  // history constants
  scxChangeCellsStyle  = 'Format cells';
  scxChangeCellsData   = 'Change cells';
  scxChangeInsertCells = 'Insert cells';
  scxChangeDeleteCells = 'Delete cells';
  scxPasteCommand      = 'Paste cells';
  scxCutCommand        = 'Cut cells';
  scxMergeCells        = 'Merge cells'; // for external use
  scxSplitCells        = 'Split cells'; // for external use
  scxSortCellsAction   = 'Sort cells';
  scxClearCells        = 'Clear cells';
  scxClearAllAction    = 'Clear all';

  // color box dialog strings
  scxColorBoxAutomatic = 'Automatic';
  scxColorBoxNone      = 'None'; // for external use

  // import/export strings
  scxExcelImportUndefinedString = 'Undefined string in shared string table!';
  scxXLSFuncCustructErr = 'Formula not construct'; // do not localize
  scxXLSUnknownFunc     = 'Unknown function'; // do not localize
  scxXLSSharedFunc      = 'Shared'; // do not localize
  scxXLSNameRef         = 'Invalid name reference: ';
  scxXLSFileHasUnknownFunction = 'Stream has unknown function''s';  

  scxWorkbookWrite = 'Error store workbook stream';
  scxWorkbookRead  = 'Error read workbook stream'; // for external use

// function names definition (do not localize)
  sxlfAbs         = 'ABS';
  sxlfAcos        = 'ACOS';
  sxlfAcosh       = 'ACOSH';
  sxlfAnd         = 'AND';
  sxlfAsin        = 'ASIN';
  sxlfAsinh       = 'ASINH';
  sxlfAtan        = 'ATAN';
  sxlfAtan2       = 'ATAN2';
  sxlfAtanh       = 'ATANH';
  sxlfAverage     = 'AVERAGE';
  sxlfAverageA    = 'AVERAGEA';
  sxlfCos         = 'COS';
  sxlfCosh        = 'COSH';
  sxlfCount       = 'COUNT';
  sxlfCounta      = 'COUNTA';
  sxlfCountblank  = 'COUNTBLANK';
  sxlfCountif     = 'COUNTIF';
  sxlfDate        = 'DATE';
  sxlfDay         = 'DAY';
  sxlfDollar      = 'DOLLAR';
  sxlfExp         = 'EXP';
  sxlfFact        = 'FACT';
  sxlfInt         = 'INT';
  sxlfIF          = 'IF';
  sxlfLn          = 'LN';
  sxlfLog         = 'LOG';
  sxlfLog10       = 'LOG10';
  sxlfMax         = 'MAX';
  sxlfMin         = 'MIN';
  sxlfMod         = 'MOD';
  sxlfMonth       = 'MONTH';
  sxlfNot         = 'NOT';
  sxlfNow         = 'NOW';
  sxlfOdd         = 'ODD';
  sxlfOr          = 'OR';
  sxlfPi          = 'PI';
  sxlfPower       = 'POWER';
  sxlfRadians     = 'RADIANS';
  sxlfRand        = 'RAND';
  sxlfRound       = 'ROUND';
  sxlfRounddown   = 'ROUNDDOWN';
  sxlfRoundup     = 'ROUNDUP';
  sxlfSign        = 'SIGN';
  sxlfSin         = 'SIN';
  sxlfSinh        = 'SINH';
  sxlfSqrt        = 'SQRT';
  sxlfSum         = 'SUM';
  sxlfSumsq       = 'SUMSQ';
  sxlfTan         = 'TAN';
  sxlfTanh        = 'TANH';
  sxlfTime        = 'TIME';
  sxlfToday       = 'TODAY';
  sxlfTrunc       = 'TRUNC';
  sxlfYear        = 'YEAR';
  sxlfWeekDay     = 'WEEKDAY';
  sxlfFalse       = 'FALSE';
  sxlfTrue        = 'TRUE';

  sxlfEven        = 'EVEN';
  sxlfTrim        = 'TRIM';
  sxlfCeiling     = 'CEILING';
  sxlfFloor       = 'FLOOR';
  sxlfConcatenate = 'CONCATENATE';
  sxlfDegrees     = 'DEGREES';
  sxlfFixed       = 'FIXED';
  sxlfHour        = 'HOUR';
  sxlfMinute      = 'MINUTE';
  sxlfSecond      = 'SECOND';
  sxlfIsEven      = 'ISEVEN';
  sxlfIsOdd       = 'ISODD';
  sxlfIsBlank     = 'ISBLANK';
  sxlfIsNa        = 'ISNA';
  sxlfIsLogical   = 'ISLOGICAL';
  sxlfIsErr       = 'ISERR';
  sxlfIsError     = 'ISERROR';
  sxlfIsNonText   = 'ISNONTEXT';
  sxlfIsNumber    = 'ISNUMBER';
  sxlfIsText      = 'ISTEXT';
  sxlfLen         = 'LEN';
  sxlfLeft        = 'LEFT';
  sxlfRight       = 'RIGHT';
  sxlfMid         = 'MID';
  sxlfLower       = 'LOWER';
  sxlfUpper       = 'UPPER';

implementation

uses
  dxCore;

procedure AddExpressSpreadSheetResourceStringNames(AProduct: TdxProductResourceStrings);

  procedure InternalAdd(const AResourceStringName: string; AAdress: Pointer);
  begin
    AProduct.Add(AResourceStringName, AAdress);
  end;

begin
  InternalAdd('scxSheetName', @scxSheetName);
  InternalAdd('scxSpreadSheetErrorReadSST', @scxSpreadSheetErrorReadSST);
  InternalAdd('scxSpreadSheetInvalidSheetNumber', @scxSpreadSheetInvalidSheetNumber);
  InternalAdd('scxSpreadSheetInvalidFileName', @scxSpreadSheetInvalidFileName);
  InternalAdd('scxSpreadSheetInvalidFileFormat', @scxSpreadSheetInvalidFileFormat);
  InternalAdd('scxSpreadSheetInvalidStreamFormat', @scxSpreadSheetInvalidStreamFormat);
  InternalAdd('scxSpreadSheetInvalidSheetCaption', @scxSpreadSheetInvalidSheetCaption);
  InternalAdd('scxSpreadSheetSheetPageExist', @scxSpreadSheetSheetPageExist);
  InternalAdd('scxSpreadSheetMergeCellError', @scxSpreadSheetMergeCellError);
  InternalAdd('scxChangePartOfMergeCells', @scxChangePartOfMergeCells);
  InternalAdd('scxSpreadSheetMergeCellError2', @scxSpreadSheetMergeCellError2);
  InternalAdd('scxSpreadSheetDefineNameError', @scxSpreadSheetDefineNameError);
  InternalAdd('scxSpreadSheetDefineNameError2', @scxSpreadSheetDefineNameError2);
  InternalAdd('scxSpreadSheetDeleteLastSheet', @scxSpreadSheetDeleteLastSheet);
  InternalAdd('scxPopupMenuMergeCells', @scxPopupMenuMergeCells);
  InternalAdd('scxPopupMenuSplitCells', @scxPopupMenuSplitCells);
  InternalAdd('scxPopupMenuFormatCells', @scxPopupMenuFormatCells);
  InternalAdd('scxPopupMenuHideRows', @scxPopupMenuHideRows);
  InternalAdd('scxPopupMenuUnhideRows', @scxPopupMenuUnhideRows);
  InternalAdd('scxPopupMenuHideCols', @scxPopupMenuHideCols);
  InternalAdd('scxPopupMenuUnhideCols', @scxPopupMenuUnhideCols);
  InternalAdd('scxSpreadSheetShiftCellLeft', @scxSpreadSheetShiftCellLeft);
  InternalAdd('scxSpreadSheetShiftCellTop', @scxSpreadSheetShiftCellTop);
  InternalAdd('scxSpreadSheetShiftCellRight', @scxSpreadSheetShiftCellRight);
  InternalAdd('scxSpreadSheetShiftCellBottom', @scxSpreadSheetShiftCellBottom);
  InternalAdd('scxSpreadSheetAllRow', @scxSpreadSheetAllRow);
  InternalAdd('scxSpreadSheetAllColumn', @scxSpreadSheetAllColumn);
  InternalAdd('scxSpreadSheetDeleteCells', @scxSpreadSheetDeleteCells);
  InternalAdd('scxSpreadSheetInsertCells', @scxSpreadSheetInsertCells);
  InternalAdd('scxDataStorageErrorReadCellRecord', @scxDataStorageErrorReadCellRecord);
  InternalAdd('scxDataStorageErrorSetCellRecord', @scxDataStorageErrorSetCellRecord);
  InternalAdd('scxStyleInvalidColorIndex', @scxStyleInvalidColorIndex);
  InternalAdd('scxStyleInvalidCellStyle', @scxStyleInvalidCellStyle);
  InternalAdd('scxCaclulatorCyclingError', @scxCaclulatorCyclingError);
  InternalAdd('scxCaclulatorConstructFormula', @scxCaclulatorConstructFormula);
  InternalAdd('scxCaclulatorParseFormula', @scxCaclulatorParseFormula);
  InternalAdd('scxCaclulatorStringExpression', @scxCaclulatorStringExpression);
  InternalAdd('scxCaclulatorFuncInvalidIndex', @scxCaclulatorFuncInvalidIndex);
  InternalAdd('scxCaclulatorFuncInvalidName', @scxCaclulatorFuncInvalidName);
  InternalAdd('scxCaclulatorErrorSymbol', @scxCaclulatorErrorSymbol);
  InternalAdd('scxCaclulatorErrorString', @scxCaclulatorErrorString);
  InternalAdd('scxCaclulatorUnknownExpression', @scxCaclulatorUnknownExpression);
  InternalAdd('scxCaclulatorUnknownToken', @scxCaclulatorUnknownToken);
  InternalAdd('scxCaclulatorDivByZero', @scxCaclulatorDivByZero);
  InternalAdd('scxCaclulatorTypeErr', @scxCaclulatorTypeErr);
  InternalAdd('scxCaclulatorMissingTokens', @scxCaclulatorMissingTokens);
  InternalAdd('scxCaclulatorMissingParamters', @scxCaclulatorMissingParamters);
  InternalAdd('scxCaclulatorFuncNeedResult', @scxCaclulatorFuncNeedResult);
  InternalAdd('scxFormApply', @scxFormApply);
  InternalAdd('scxFormCancel', @scxFormCancel);
  InternalAdd('scxFormOk', @scxFormOk);
  InternalAdd('scxFormatDialogFormatCaption', @scxFormatDialogFormatCaption);
  InternalAdd('scxFormatCellStyle', @scxFormatCellStyle);
  InternalAdd('scxFormatCellStyleType', @scxFormatCellStyleType);
  InternalAdd('scxFormatStyleStyleSettings', @scxFormatStyleStyleSettings);
  InternalAdd('scxFormatStyleGeneral', @scxFormatStyleGeneral);
  InternalAdd('scxFormatStyleCurrency', @scxFormatStyleCurrency);
  InternalAdd('scxFormatStyleNumber', @scxFormatStyleNumber);
  InternalAdd('scxFormatStyleDateTime', @scxFormatStyleDateTime);
  InternalAdd('scxFormatStyleText', @scxFormatStyleText);
  InternalAdd('scxGeneralStyleDescription', @scxGeneralStyleDescription);
  InternalAdd('scxNumberStyleDescription', @scxNumberStyleDescription);
  InternalAdd('scxCurrencyStyleDescription', @scxCurrencyStyleDescription);
  InternalAdd('scxDateTimeStyleDescription', @scxDateTimeStyleDescription);
  InternalAdd('scxTextStyleDescription', @scxTextStyleDescription);
  InternalAdd('scxFormatDialogText', @scxFormatDialogText);
  InternalAdd('scxFormatDialogBorder', @scxFormatDialogBorder);
  InternalAdd('scxFormatDialogPatterns', @scxFormatDialogPatterns);
  InternalAdd('scxFormatDialogHorzAlign', @scxFormatDialogHorzAlign);
  InternalAdd('scxFormatDialogVertAlign', @scxFormatDialogVertAlign);
  InternalAdd('scxFormatDialogTextAlignment', @scxFormatDialogTextAlignment);
  InternalAdd('scxFormatDialogTextControl', @scxFormatDialogTextControl);
  InternalAdd('scxFormatDialogGeneral', @scxFormatDialogGeneral);
  InternalAdd('scxFormatDialogLeft', @scxFormatDialogLeft);
  InternalAdd('scxFormatDialogCenter', @scxFormatDialogCenter);
  InternalAdd('scxFormatDialogRight', @scxFormatDialogRight);
  InternalAdd('scxFormatDialogFill', @scxFormatDialogFill);
  InternalAdd('scxFormatDialogJustify', @scxFormatDialogJustify);
  InternalAdd('scxFormatDialogTop', @scxFormatDialogTop);
  InternalAdd('scxFormatDialogBottom', @scxFormatDialogBottom);
  InternalAdd('scxFormatDialogWrap', @scxFormatDialogWrap);
  InternalAdd('scxFormatDialogFont', @scxFormatDialogFont);
  InternalAdd('scxFormatDialogNone', @scxFormatDialogNone);
  InternalAdd('scxFormatDialogNone2', @scxFormatDialogNone2);
  InternalAdd('scxFormatDialogOutline', @scxFormatDialogOutline);
  InternalAdd('scxFormatDialogInside', @scxFormatDialogInside);
  InternalAdd('scxFormatDialogItems', @scxFormatDialogItems);
  InternalAdd('scxFormatDialogAllBorder', @scxFormatDialogAllBorder);
  InternalAdd('scxFormatDialogLine', @scxFormatDialogLine);
  InternalAdd('scxFormatDialogStyle', @scxFormatDialogStyle);
  InternalAdd('scxFormatDialogColor', @scxFormatDialogColor);
  InternalAdd('scxFormatDialogTextStr', @scxFormatDialogTextStr);
  InternalAdd('scxFormatDialogCellShading', @scxFormatDialogCellShading);
  InternalAdd('scxFormatDialogSample', @scxFormatDialogSample);
  InternalAdd('scxFormatDialogPattern', @scxFormatDialogPattern);
  InternalAdd('scxFormatDialogSampleText', @scxFormatDialogSampleText);
  InternalAdd('scxUseDefaultColor', @scxUseDefaultColor);
  InternalAdd('scxColorEditorCaption', @scxColorEditorCaption);
  InternalAdd('scxChangeCellsStyle', @scxChangeCellsStyle);
  InternalAdd('scxChangeCellsData', @scxChangeCellsData);
  InternalAdd('scxChangeInsertCells', @scxChangeInsertCells);
  InternalAdd('scxChangeDeleteCells', @scxChangeDeleteCells);
  InternalAdd('scxPasteCommand', @scxPasteCommand);
  InternalAdd('scxCutCommand', @scxCutCommand);
  InternalAdd('scxMergeCells', @scxMergeCells);
  InternalAdd('scxSplitCells', @scxSplitCells);
  InternalAdd('scxSortCellsAction', @scxSortCellsAction);
  InternalAdd('scxClearCells', @scxClearCells);
  InternalAdd('scxClearAllAction', @scxClearAllAction);
  InternalAdd('scxColorBoxAutomatic', @scxColorBoxAutomatic);
  InternalAdd('scxColorBoxNone', @scxColorBoxNone);
  InternalAdd('scxExcelImportUndefinedString', @scxExcelImportUndefinedString);
  InternalAdd('scxXLSNameRef', @scxXLSNameRef);
  InternalAdd('scxXLSFileHasUnknownFunction', @scxXLSFileHasUnknownFunction);
  InternalAdd('scxWorkbookWrite', @scxWorkbookWrite);
  InternalAdd('scxWorkbookRead', @scxWorkbookRead);
end;

initialization
  dxResourceStringsRepository.RegisterProduct('ExpressSpreadSheet', @AddExpressSpreadSheetResourceStringNames);

finalization
  dxResourceStringsRepository.UnRegisterProduct('ExpressSpreadSheet');

end.

