//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxPSCoreC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dxcomnC5.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vcljpg50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEUNIT("dxPSRes.pas");
USEUNIT("dxBase.pas");
USEUNIT("dxPrnPg.pas");
USEUNIT("dxPSGlbl.pas"); 
USEUNIT("dxPcPrVw.pas"); 
USEUNIT("dxPreVw.pas"); 
USEUNIT("dxPSCore.pas"); 
USEUNIT("dxPPAttr.pas"); 
USEUNIT("dxPrnDev.pas"); 
USEUNIT("dxBkgnd.pas"); 
USEUNIT("dxWrap.pas"); 
USEUNIT("dxPSUtl.pas"); 
USEUNIT("dxFmMnPg.pas"); 
USEUNIT("dxPSImgs.pas"); 
USEUNIT("dxPSPopupMan.pas"); 
USEUNIT("dxPSEvnt.pas"); 
USEUNIT("dxPSESys.pas"); 
USEUNIT("dxPSEngn.pas"); 
USEUNIT("dxPSPrVw.pas"); 
USEUNIT("dxPSForm.pas"); 
USEUNIT("dxPSPgsMnuBld.pas"); 
USEUNIT("dxExtCtrlsStrs.pas"); 
USEUNIT("dxExtctrls.pas");
USEUNIT("dxPSBaseGridLnk.pas");
USEUNIT("dxPSEdgePatterns.pas");
USEUNIT("dxPSFillPatterns.pas");
USEFORMNS("dxPSPrVwStd.pas", Dxpsprvwstd, dxfmStdPreview);
USEFORMNS("dxFEFDlg.pas", Dxfefdlg, dxFEFDialog);
USEFORMNS("dxfmClr.pas", Dxfmclr, dxfmColorPalette);
USEFORMNS("dxPrnDlg.pas", Dxprndlg, fmdxPrintDialog);
USEFORMNS("dxfmZoom.pas", Dxfmzoom, fmZoom);
USEFORMNS("dxPgSDlg.pas", Dxpgsdlg, dxfmPageSetupDialog); 
USEFORMNS("dxBrhDlg.pas", Dxbrhdlg, dxBrushDlg);
USEFORMNS("dxfmChFN.pas", Dxfmchfn, fmdxChangeFileName); 
USEFORMNS("dxfmpnfmt.pas", Dxfmpnfmt, fmPageNumberFormat); 
USEFORMNS("dxfmDTFmt.pas", Dxfmdtfmt, fmDateTimeFormats); 
USEFORMNS("dxfmDfnStl.pas", Dxfmdfnstl, fmdxDefinePrintStyles); 
USEFORMNS("dxPSPrVwOpt.pas", Dxpsprvwopt, fmOptions); 
USEFORMNS("dxPSfmttl.pas", dxPSfmttl, dxfmReportTitleProperties); 
USEFORMNS("dxPSfmEditDesc.pas", Dxpsfmeditdesc, dxfmEditDescription);
USEFORMNS("dxPSfmLnkAdd.pas", Dxpsfmlnkadd, dxfmSelectComponent);
USEUNIT("dxPSGraphicLnk.pas");
USEUNIT("dxPSCompsProvider.pas");
USEFORMNS("dxPSCPDsg.pas", Dxpscpdsg, dxfmCPDesigner);
USEFORMNS("dxPSfmCompositionAdd.pas", Dxpsfmcompositionadd, dxfmCompositionAddItems);
USEFORMNS("dxPSfmCompositionDsg.pas", Dxpsfmcompositiondsg, dxfmCompositionDesignWindow);	
USEUNIT("dxPSContainerLnk.pas");
USEUNIT("dxPSDBBasedXplorer.pas");
USEUNIT("dxPSExtDlgs.pas");
USEUNIT("dxPSFileBasedXplorer.pas");
USEUNIT("dxPSfmReportProperties.pas");
USEUNIT("dxPSShapes.pas");
USEFORMNS("dxPSTextLnk.pas", Dxpstextlnk, dxfmTextReportLinkDesignWindow);
USEUNIT("dxPSStandardFillPatterns.pas");
USEUNIT("dxPSXplorerTreeView.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
    return 1;
}
//---------------------------------------------------------------------------
