{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_Mxconsts;

interface

uses
  Mxconsts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMxconstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatMxconstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('hcDDecisionCubeEditor',hcDDecisionCubeEditor);
    AddConstant('hcDDecisionCubeDimensions',hcDDecisionCubeDimensions);
    AddConstant('hcDDecisionCubeMemoryControl',hcDDecisionCubeMemoryControl);
    AddConstant('hcDDecisionCubeDesignerOptions',hcDDecisionCubeDesignerOptions);
    AddConstant('hcDDecisionCubeLimits',hcDDecisionCubeLimits);
    AddConstant('hcDDecisionQueryEditor',hcDDecisionQueryEditor);
    AddConstant('hcDDecisionQueryDimensions',hcDDecisionQueryDimensions);
    AddConstant('hcDDecisionQuerySQLEditor',hcDDecisionQuerySQLEditor);
    AddConstant('sRowError',sRowError);
    AddConstant('sAllValues',sAllValues);
    AddConstant('sMovetoRow',sMovetoRow);
    AddConstant('sMovetoCol',sMovetoCol);
    AddConstant('sMakeDimOpen',sMakeDimOpen);
    AddConstant('sDrilled',sDrilled);
    AddConstant('sCouldNotOpen',sCouldNotOpen);
    AddConstant('sNoSumsAvailable',sNoSumsAvailable);
    AddConstant('sNoSumsCouldBeLoaded',sNoSumsCouldBeLoaded);
    AddConstant('sNoDimsAvailable',sNoDimsAvailable);
    AddConstant('sNoDimsCouldBeLoaded',sNoDimsCouldBeLoaded);
    AddConstant('sTemplatePrefix',sTemplatePrefix);
    AddConstant('sGridCellError',sGridCellError);
    AddConstant('sTotalCaption',sTotalCaption);
    AddConstant('sActivateLabel',sActivateLabel);
    AddConstant('sRowCaption',sRowCaption);
    AddConstant('sColCaption',sColCaption);
    AddConstant('sCaptionMenu1',sCaptionMenu1);
    AddConstant('sCaptionMenu2',sCaptionMenu2);
    AddConstant('sCaptionMenu3',sCaptionMenu3);
    AddConstant('sDrillIn',sDrillIn);
    AddConstant('sGridMenu1',sGridMenu1);
    AddConstant('sGridMenu2',sGridMenu2);
    AddConstant('sGridMenu3',sGridMenu3);
    AddConstant('sGridMenu4',sGridMenu4);
    AddConstant('sUnsupportedDataType',sUnsupportedDataType);
    AddConstant('sRowOutOfRange',sRowOutOfRange);
    AddConstant('sColOutOfRange',sColOutOfRange);
    AddConstant('sDupeItem',sDupeItem);
    AddConstant('sArrayIndexOutOfRange',sArrayIndexOutOfRange);
    AddConstant('sLowCapacityError',sLowCapacityError);
    AddConstant('sQryNotInitialized',sQryNotInitialized);
    AddConstant('sSortedListError',sSortedListError);
    AddConstant('sDuplicateString',sDuplicateString);
    AddConstant('sMaxAllowedSums',sMaxAllowedSums);
    AddConstant('sGeneralArrayError',sGeneralArrayError);
    AddConstant('sDimIndexError',sDimIndexError);
    AddConstant('sIllegalValueForBin',sIllegalValueForBin);
    AddConstant('sIllegalDimMap',sIllegalDimMap);
    AddConstant('sDimMapActiveError',sDimMapActiveError);
    AddConstant('sNotAvailable',sNotAvailable);
    AddConstant('sGetValueCounts',sGetValueCounts);
    AddConstant('sDateBinningNotAllowed',sDateBinningNotAllowed);
    AddConstant('sEmptyDataSet',sEmptyDataSet);
    AddConstant('sNoDataSet',sNoDataSet);
    AddConstant('sNoAggs',sNoAggs);
    AddConstant('sNoDims',sNoDims);
    AddConstant('sUnknownDims',sUnknownDims);
    AddConstant('sGroupsMissing',sGroupsMissing);
    AddConstant('sDecisionQueryError',sDecisionQueryError);
    AddConstant('sDataSetError',sDataSetError);
    AddConstant('sQueryError',sQueryError);
    AddConstant('sCountStar',sCountStar);
    AddConstant('sAddAvgWarning',sAddAvgWarning);
    AddConstant('sAddAvgStarWarning',sAddAvgStarWarning);
    AddConstant('sQueryLegal',sQueryLegal);
    AddConstant('sAddFieldExists',sAddFieldExists);
    AddConstant('sAggTypeNotAllowed',sAggTypeNotAllowed);
    AddConstant('sDimTypeNotAllowed',sDimTypeNotAllowed);
    AddConstant('sAverageRequires',sAverageRequires);
    AddConstant('sWantToExit',sWantToExit);
    AddConstant('sQueryIllegal',sQueryIllegal);
    AddConstant('sQueryEditIllegal',sQueryEditIllegal);
    AddConstant('sRemoveFieldError',sRemoveFieldError);
    AddConstant('sAllFields',sAllFields);
    AddConstant('sQueryFields',sQueryFields);
    AddConstant('sEditDone',sEditDone);
    AddConstant('sEditQuery',sEditQuery);
    AddConstant('sQParseRemovedField',sQParseRemovedField);
    AddConstant('sCubeLimitsExceeded',sCubeLimitsExceeded);
    AddConstant('sMaxAllowedDims',sMaxAllowedDims);
    AddConstant('sMaxAllowedCells',sMaxAllowedCells);
    AddConstant('sUnsupportedFieldType',sUnsupportedFieldType);
    AddConstant('sFetchValues',sFetchValues);
    AddConstant('sUserCanceled',sUserCanceled);
    AddConstant('sBinningValues',sBinningValues);
    AddConstant('sCreatingIndexes',sCreatingIndexes);
    AddConstant('sCreateDerivedSummaryError',sCreateDerivedSummaryError);
    AddConstant('sTrue',sTrue);
    AddConstant('sFalse',sFalse);
    AddConstant('sBinTypeMismatch',sBinTypeMismatch);
    AddConstant('sFatalCacheError',sFatalCacheError);
    AddConstant('sStringTypeNoSupported',sStringTypeNoSupported);
    AddConstant('sDataSetTooLarge',sDataSetTooLarge);
    AddConstant('sBuildingDataStore',sBuildingDataStore);
    AddConstant('sSumLabel',sSumLabel);
    AddConstant('sCountLabel',sCountLabel);
    AddConstant('sMaxLabel',sMaxLabel);
    AddConstant('sMinLabel',sMinLabel);
    AddConstant('sAverageLabel',sAverageLabel);
    AddConstant('sVarLabel',sVarLabel);
    AddConstant('sSDLabel',sSDLabel);
    AddConstant('sAggLabel',sAggLabel);
    AddConstant('sUnsupportedVarType',sUnsupportedVarType);
    AddConstant('sOtherValues',sOtherValues);
    AddConstant('sSelectFromError',sSelectFromError);
    AddConstant('sArgumentExpected',sArgumentExpected);
    AddConstant('sGroupOnExpressionError',sGroupOnExpressionError);
    AddConstant('SOutofBounds',SOutofBounds);
    AddConstant('sIDAPILangID',sIDAPILangID);
  end;
end;

class function TatMxconstsLibrary.LibraryName: string;
begin
  result := 'Mxconsts';
end;

initialization
  RegisterScripterLibrary(TatMxconstsLibrary, True);

{$WARNINGS ON}

end.

