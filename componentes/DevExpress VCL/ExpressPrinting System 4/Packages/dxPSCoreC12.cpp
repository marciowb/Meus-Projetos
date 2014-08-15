//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSCoreC12.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("vclx.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("vclimg.bpi");
USEPACKAGE("dxComnC12.bpi");
USEPACKAGE("cxEditorsC12.bpi");
USEPACKAGE("cxExtEditorsC12.bpi");
USEPACKAGE("cxPageControlC12.bpi");
USEPACKAGE("cxLibraryC12.bpi");
USEPACKAGE("vcldb.bpi");
USEPACKAGE("dxThemeC12.bpi");
USEPACKAGE("dxCoreC12.bpi");
USEPACKAGE("cxDataC12.bpi");
USEPACKAGE("dxGDIPlusC12.bpi");
USEUNIT("dxWrap.pas");
USEUNIT("dxBkGnd.pas");
USEUNIT("dxBrhDlg.pas");
USEUNIT("dxExtCtrls.pas");
USEUNIT("dxExtCtrlsStrs.pas");
USEUNIT("dxFEFDlg.pas");
USEUNIT("dxfmChFN.pas");
USEUNIT("dxfmClr.pas");
USEUNIT("dxfmDfnStl.pas");
USEUNIT("dxfmDTFmt.pas");
USEUNIT("dxfmMnPg.pas");
USEUNIT("dxfmPNFmt.pas");
USEUNIT("dxfmZoom.pas");
USEUNIT("dxPcPrVw.pas");
USEUNIT("dxPgsDlg.pas");
USEUNIT("dxPSHFLibrary.pas");
USEUNIT("dxPpAttr.pas");
USEUNIT("dxPreVw.pas");
USEUNIT("dxPrnDev.pas");
USEUNIT("dxPrnDlg.pas");
USEUNIT("dxPrnPg.pas");
USEUNIT("dxPSAutoHFTextMnuBld.pas");
USEUNIT("dxPSCompsProvider.pas");
USEUNIT("dxPSCore.pas");
USEUNIT("dxPSCPDsg.pas");
USEUNIT("dxPSEdgePatterns.pas");
USEUNIT("dxPSEngn.pas");
USEUNIT("dxPSESys.pas");
USEUNIT("dxPSEvnt.pas");
USEUNIT("dxPSExcelEdgePatterns.pas");
USEUNIT("dxPSExcelFillPatterns.pas");
USEUNIT("dxPSFillPatterns.pas");
USEUNIT("dxPSfmAutoHFTextFmt.pas");
USEUNIT("dxPSfmCompositionAdd.pas");
USEUNIT("dxPSfmCompositionDsg.pas");
USEUNIT("dxPSfmEditDesc.pas");
USEUNIT("dxPSfmLnkAdd.pas");
USEUNIT("dxPSfmTtl.pas");
USEUNIT("dxPSForm.pas");
USEUNIT("dxPSGlbl.pas");
USEUNIT("dxPSGraphicLnk.pas");
USEUNIT("dxPSHFToolBarBld.pas");
USEUNIT("dxPSImgs.pas");
USEUNIT("dxPSPgsMnuBld.pas");
USEUNIT("dxPSPopupMan.pas");
USEUNIT("dxPSPrVw.pas");
USEUNIT("dxPSPrVwOpt.pas");
USEUNIT("dxPSPrVwStd.pas");
USEUNIT("dxPSRes.pas");
USEUNIT("dxPSSngltn.pas");
USEUNIT("dxPSUtl.pas");
USEUNIT("dxBase.pas");
USEUNIT("dxPSBaseGridLnk.pas");
USEUNIT("dxPSContainerLnk.pas");
USEUNIT("dxPSDBBasedXplorer.pas");
USEUNIT("dxPSExtDlgs.pas");
USEUNIT("dxPSFileBasedXplorer.pas");
USEUNIT("dxPSfmReportProperties.pas");
USEUNIT("dxPSShapes.pas");
USEUNIT("dxPSTextLnk.pas");
USEUNIT("dxPSStandardFillPatterns.pas");
USEUNIT("dxPSXplorerTreeView.pas");
USEUNIT("dxPSPDFStrings.pas");
USEUNIT("dxPSPDFExport.pas");
USEUNIT("dxPSReportRenderCanvas.pas");
USEUNIT("dxPSPDFExportCore.pas");
USEUNIT("dxPSPDFCrypt.pas");
USEUNIT("dxPSPDFFonts.pas");
USEUNIT("dxPSTrueTypeFont.pas");
USEUNIT("dxPSPDFMetaFileParser.pas");
USEUNIT("dxPSPDFExportDialog.pas");
USEUNIT("dxPSfmFootnotes.pas");
USEFORMNS("dxPSfmFootnotes.pas", dxPSfmFootnotes, dxfmReportFootnotesProperties);
USEFORMNS("dxBrhDlg.pas", dxBrhDlg, dxBrushDlg);
USEFORMNS("dxFEFDlg.pas", dxFEFDlg, dxFEFDialog);
USEFORMNS("dxfmChFN.pas", dxfmChFN, fmdxChangeFileName);
USEFORMNS("dxfmClr.pas", dxfmClr, dxfmColorPalette);
USEFORMNS("dxfmDfnStl.pas", dxfmDfnStl, dxfmDefinePrintStyles);
USEFORMNS("dxfmDTFmt.pas", dxfmDTFmt, dxfmDateTimeFormats);
USEFORMNS("dxfmPNFmt.pas", dxfmPNFmt, dxfmPageNumberFormat);
USEFORMNS("dxfmZoom.pas", dxfmZoom, fmZoom);
USEFORMNS("dxPgsDlg.pas", dxPgsDlg, dxfmPageSetupDialog);
USEFORMNS("dxPrnDlg.pas", dxPrnDlg, dxfmPrintDialog);
USEFORMNS("dxPSCPDsg.pas", dxPSCPDsg, dxfmCPDesigner);
USEFORMNS("dxPSfmAutoHFTextFmt.pas", dxPSfmAutoHFTextFmt, dxfmAutoText);
USEFORMNS("dxPSfmCompositionAdd.pas", dxPSfmCompositionAdd, dxfmCompositionAddItems);
USEFORMNS("dxPSfmCompositionDsg.pas", dxPSfmCompositionDsg, dxfmCompositionDesignWindow);
USEFORMNS("dxPSfmEditDesc.pas", dxPSfmEditDesc, dxfmEditDescription);
USEFORMNS("dxPSfmLnkAdd.pas", dxPSfmLnkAdd, dxfmAddComponent);
USEFORMNS("dxPSfmTtl.pas", dxPSfmTtl, dxfmReportTitleProperties);
USEFORMNS("dxPSPrVwOpt.pas", dxPSPrVwOpt, dxfmOptions);
USEFORMNS("dxPSPrVwStd.pas", dxPSPrVwStd, dxfmStdPreview);
USEFORMNS("dxPSContainerLnk.pas", dxPSContainerLnk, dxfmCustomContainerDesignWindow);
USEFORMNS("dxPSfmReportProperties.pas", dxPSfmReportProperties, dxfmPSReportProperties);
USEFORMNS("dxPSTextLnk.pas", dxPSTextLnk, dxfmTextReportLinkDesignWindow);
USEFORMNS("dxPSPDFExportDialog.pas", dxPSPDFExportDialog, dxPSPDFExportDialogForm);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
