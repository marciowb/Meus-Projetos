{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                   BBBBB   }

unit ppTypes;

interface

{$I ppIfDef.pas}

uses
  Windows, Messages, Classes, Graphics, Mask, SysUtils, TypInfo, Dialogs, Forms;

const

{test}

{******************************************************************************
 *
 ** V E R S I O N   C O N T R O L   C O N S T A N T S
 *
{******************************************************************************}

{$IFDEF Enterprise}
  ppEdition  = 'Enterprise';
{$ENDIF}

{$IFDEF Professional}
  ppEdition  = 'Professional';
{$ENDIF}

{$IFDEF Standard}
  ppEdition  = 'Standard';
{$ENDIF}

  ppVersion  = '12.0';
  ppBuildNo = 162;  //do not change

  VersionNoMaxLength = 20;

{$IFDEF Demo}
  IsDemoCopy = True;   {used by the demo application}
  DemoPages = 5;
{$ELSE}
  IsDemoCopy = False;
{$ENDIF}

  cUntitled = 'Untitled';
  cNone     = '<None>';

  {conversions}
  InchPerMM: Single = 0.03937;

  {unique ID for internal window messages }
  ppWCustomMsg = 5050;

  ppQuarterInchInMM = 6350;
  ppHalfInchInMM = 12700;
  ppLetterPaperWidthInMM = 215900;
  ppLetterPaperHeightInMM = 279401;
  ppA4PaperWidthInMM = 210000;
  ppA4PaperHeightInMM = 297000;

  chEnterKey = #13;

  cNullGuid: TGUID = '{00000000-0000-0000-0000-000000000000}';

  {simulated enumerated types for DeviceType property}
  dtArchive = 'ArchiveFile';
  dtPDF = 'PDF';
  dtPrinter = 'Printer';
  dtFile = 'TextFile';
  dtTextFile = 'TextFile';
  dtReportTextFile = 'ReportTextFile';
  dtXHTMLFile = 'XHTMLFile';
  dtScreen  = 'Screen';
  dtRTF = 'RTF';
  dtDoc = 'DOC';
  dtXLSData = 'XLSData';
  dtXLSReport = 'XLSReport';
  dtBMP = 'BMP';
  dtMetaFile = 'MetaFile';
  dtJPEG = 'JPEG';
{$IFDEF Delphi11}
  dtGIF = 'GIF';
{$ENDIF}
{$IFDEF Delphi12}
  dtPNG = 'PNG';
  dtTIFF = 'dtTIFF';
{$ENDIF}

  {simulated enumerated types for LanguageID property}
  ltDefault = 'Default';
  ltDanish = 'Danish (Denmark)';
  ltDutch = 'Dutch (Netherlands)';
  ltEnglish = 'English (United States)';
  ltFrench = 'French (France)';
  ltGerman = 'German (Germany)';
  ltItalian = 'Italian (Italy)';
  ltPortugueseBrazil = 'Portuguese (Brazil)';
  ltPortuguese = 'Portuguese (Portugal)';
  ltSpanish = 'Spanish (Spain)';
  ltSpanishMexico = 'Spanish (Mexico)';
  ltSwedish = 'Swedish (Sweden)';
  ltNorwegian = 'Norwegian (Norway)';
  ltCustom = 'Custom';

  {strings base number}
  ciBaseNumber = 43000;
  ciAltBaseNumber = 54000;
//  ciAltBaseNumber = 5000;

  varNumerics = [varSmallint, varInteger, varSingle, varDouble, varCurrency, varDate];
  
{******************************************************************************
 *
 ** M E S S A G E   C O N S T A N T S
 *
{******************************************************************************}

  {custom messages  }
  RM_COMPONENTNAMECHANGE = WM_USER + 100;  {enables ppComponent to notify ppDesignerWindow}
  RM_BANDHEIGHTCHANGE    = WM_USER + 101;  {enables ppBands to notify ppDesignerWindow}
  RM_REPORTDESTROY       = WM_USER + 102;  {enables ppReport to notify ppDesignerWindow}
  RM_CALCWORKSPACEWIDTH  = WM_USER + 103;  {enables ppReport to notify ppDesignerWindow}
  RM_COMPONENTDESTROY    = WM_USER + 104;  {enables ppReport to notify ppDesignerWindow}
  RM_UNITSCHANGE         = WM_USER + 105;  {enables ppReport to notify ppDesignerWindow}
  RM_GROUPMENUCLICK      = WM_USER + 106;  {enables ppGroupBand to notify ppDesignerWindow}
  RM_COMPONENTCHANGE     = WM_USER + 107;  {enables ppReport, ppBands, ppComponent to notify ppDesignerWindow}
  RM_COMPONENTDATAPIPELINECHANGE = WM_USER + 108;  {enables ppComponent to notify ppDesignerWindow}
  RM_SETREPORT           = WM_USER + 109;  {enables ppReport to notify ppDesignerWindow}
  RM_SETLANGUAGE         = WM_USER + 110;  {enables ppReport to notify ppDesignerWindow}
  RM_GETDISPLAYFORMATS   = WM_USER + 111;  {enables ppComponent to notify ppDesignerWindow}
  RM_INSTANTIATECOMPONENTDC = WM_USER + 112;  {enables ppComponent to notify ppDesignerWindow}
  RM_INSTANTIATEBANDDC   = WM_USER + 113;  {enables ppBand to notify ppDesignerWindow}
  RM_BANDADDED           = WM_USER + 114;  {enables ppReport to notify ppDesignerWindow}
  RM_BANDREMOVED         = WM_USER + 115;  {enables ppReport to notify ppDesignerWindow}
  RM_BANDDESTROY         = WM_USER + 116;  {enables ppBand to notify ppDesignerWindow}
  RM_REPORTPRINTING      = WM_USER + 117;  {enables ppReport to notify ppDesignerWindow}

  RM_ADDREPORT           = WM_USER + 118;  {enables ppReport to notify ppDesignerWindow}
  RM_REMOVEREPORT        = WM_USER + 119;  {enables ppReport to notify ppDesignerWindow}
  RM_BOUNDSLOCKCHANGE    = WM_USER + 120;  {enables ppComponent to notify ppDesignerWindow}
  RM_CAPTIONCHANGE       = WM_USER + 121;  {enables ppComponent to notify ppDesignerWindow}
  RM_REPORTLOADSTART     = WM_USER + 122;  {enables ppReport to notify ppDesignerWindow}
  RM_REPORTLOADEND       = WM_USER + 123;  {enables ppReport to notify ppDesignerWindow}
  RM_REPORTUPDATEBEGIN   = WM_USER + 124;  {enables ppReport to notify ppDesignerWindow}
  RM_REPORTUPDATEEND     = WM_USER + 125;  {enables ppReport to notify ppDesignerWindow}
  RM_PRINTERCHANGE       = WM_USER + 126;  {enable  ppReport to notify ppDesignerWindow}
  RM_COMPONENTADDED      = WM_USER + 127;  {enable  ppReport to notify ppDesignerWindow}
  RM_COMPONENTREMOVED    = WM_USER + 128;  {enable  ppReport to notify ppDesignerWindow}
  RM_COMPONENTUPDATED    = WM_USER + 129;  {enable  ppReport to notify ppDesignerWindow}
  RM_REPORTNEWSTART      = WM_USER + 130;  {enables ppReport to notify ppDesignerWindow}
  RM_REPORTNEWEND        = WM_USER + 131;  {enables ppReport to notify ppDesignerWindow}
  RM_REPORTSAVESTART     = WM_USER + 132;  {enables ppReport to notify ppDesignerWindow}

{******************************************************************************
 *
 ** E V E N T   C O N S T A N T S
 *
{******************************************************************************}

  ciProducerAfterPrint = 0;
  ciProducerBeforePrint = 1;
  ciProducerCancel = 2;
  ciProducerCancelDialogCreate = 3;
  ciProducerCancelDialogClose = 4;
  ciProducerPreviewFormCreate = 5;
  ciProducerPreviewFormClose = 6;
  ciProducerPrintDialogCreate = 7;
  ciProducerPrintDialogClose = 8;
  ciProducerSaveText = 9;
  ciReportAfterAutoSearchDialogCreate = 10;
  ciReportAutoSearchDialogClose = 11;
  ciReportGetAutoSearchValues = 12;
  ciEngineStart = 13;
  ciEngineEnd = 14;
  ciEngineEndColumn = 15;
  ciEngineEndFirstPass = 16;
  ciEngineEndPage = 17;
  ciEngineEndSecondPass = 18;
  ciEngineStartColumn = 19;
  ciEngineStartFirstPass = 20;
  ciEngineStartPage = 21;
  ciEngineStartSecondPass = 22;
  ciBandAfterPrint = 23;
  ciBandBeforePrint = 24;
  ciBandAfterGenerate = 25;
  ciBandBeforeGenerate = 26;
  ciGroupAfterGroupBreak = 27;
  ciGroupBeforeGroupBreak = 28;
  ciGroupBeforeHeader = 29;
  ciGroupBeforeFooter = 30;
  ciGroupGetBreakValue = 31;
  ciComponentPrint = 32;
  ciComponentCalc = 33;
  ciComponentReset = 34;
  ciTraversal = 35;
  ciPipelineActiveChange = 36;
  ciPipelineRecordPositionChange = 37;
  ciPipelineMasterRecordPositionChange = 38;
  ciPipelineTraversal = 39;
  ciPipelineGotoBookmark = 40;
  ciPipelineDataChange = 41;
  ciPipelineFirst = 42;
  ciPipelineNext = 43;
  ciPipelinePrior = 44;
  ciPipelineLast = 45;
  ciPipelineOpen = 46;
  ciPipelineClose = 132;
  ciCacheableSwitchCache = 48;
  ciCacheableRaiseException = 49;
  ciCacheableFreeCache = 50;
  ciBeforeGenerateSQL = 51;
  ciAfterGenerateSQL = 52;
  ciComponentGetText = 53;
  ciCrossTabCalcDimensionValue = 54;
  ciCrossTabFormatCell = 55;
  ciCrossTabGetCaptionText = 56;
  ciCrossTabGetDimensionName = 57;
  ciCrossTabGetDimensionCaption = 58;
  ciCrossTabGetDimensionValue = 59;
  ciCrossTabGetTotalCaptionText = 60;
  ciCrossTabGetTotalValueText = 61;
  ciCrossTabGetValueText = 62;
  ciCrossTabTraverseRecord = 63;
  ciCrossTabBeforeCalc = 64;
  ciCrossTabAfterCalc = 65;
  ciReportCreateAutoSearchCriteria = 66;
  ciComponentCalcLookAhead = 67;
  ciGroupBreak = 68;
  ciComponentGetPicture = 69;
  ciProducerCreate = 70;
  ciProducerDestroy = 71;
  ciReportBeforeAutoSearchDialogCreate = 72;
  ciDataSetClose = 132; // was 73, but now is same as ciPipelineBeforeClose
  ciWindowPosChanged = 74;
  ciListViewScroll = 75;
  ciListViewSort = 76;
  ciWindowResized = 77;
  ciSQLLinkChanged = 78;
  ciSQLSelectFieldsChanged = 79;
  ciSQLSearchCriteriaChanged = 80;
  ciSQLConvertedToText = 81;
  ciSQLNameChanged = 82;
  ciSQLOrderByFieldsChanged = 83;
  ciPrintableDrawCommandCreate = 84;
  ciPrintableDrawCommandClick = 85;
  ciMemoGetMemo = 86;
  ciEngineNoData = 87;
  ciReportOutlineNodeCreate = 88;
  ciProducerAfterPrintToPrinter = 89;
  ciEngineAfterSendPage = 90;
  ciEngineBeforeGenerate = 91;
  ciScreenDeviceBeforeDrawPage = 92;
  ciScreenDeviceAfterDrawPage = 93;
  ciViewerPageChange = 94;
  ciViewerPrintStateChange = 95;
  ciViewerStatusChange = 96;
  ciViewerReset = 97;
  ciDevicePageReceive = 98;
  ciPublisherReceivePage = 99;
  ciPublisherAfterPageRequest = 100;
  ciOutlineViewerVisibilityChanged = 101;
  ciSearchToolBarChanged = 102;
  ciSearchPreviewActionPerformed = 103;
  ciNewSearchOccurrence = 104;
  ciProducerAssignPreviewFormSettings = 105;
  ciPropertyChange = 106;
  ciLoadXMLStart = 107;
  ciLoadXMLEnd = 108;
  ciPublisherReset = 109;
  ciBackgroundPrintingComplete = 110;
  ciNameChanged = 111;
  ciInitializePrinterSetup = 112;
  ciComponentBoundsChanged = 113;
  ciComponentInvalidateDesignControl = 114;
  ciComponentBringToFront = 115;
  ciComponentSendToBack = 116;
  ciComponentParentWidthChanged = 117;
  ciComponentParentHeightChanged = 118;
  ciBandBeforeHeightChange = 119;
  ciBandAfterHeightChange = 120;
  ciBandGetScreenPixelTop = 121;
  ciBandSetScreenPixelTop = 122;
  ciReportBandAdded = 123;
  ciReportBandRemoved = 124;
  ciBandResize = 125;
  ciReportComponentAdded = 126;
  ciReportComponentRemoved = 127;
  ciBandCaptionChanged = 128;
  ciViewerMouseDown = 129;
  ciPipelineBeforeOpen = 130;
  ciPipelineAfterOpen = 131;
  ciPipelineBeforeClose = 132;
  ciPipelineAfterClose = 133;
  ciReportBeforeOpenDataPipelines = 134;
  ciReportAfterOpenDataPipelines = 135;
  ciReportInitializeParameters = 136;
  ciSQLObjectModified = 137;
  ciSQLObjectEndUpdate = 138;
  ciDetailOutOfSpace = 139;
  ciProducerPageRequest = 140;
  ciPageBackward = 141;
  ciRichTextMailMerge = 142;
  ciFileDeviceCreate = 143;
  ciPrinterDeviceCreate = 144;
  ciPrinterDeviceStateChange = 145;
  ciPrinterDeviceBeforeStartJob = 145;
  ciPrinterDevicAfterStartJob = 146;
  ciPrinterDeviceBeforeEndJob = 147;
  ciPrinterDeviceAfterEndJob = 148;
  ciPrinterDeviceBeforeStartPage = 149;
  ciPrinterDeviceAfterStartPage = 150;
  ciPrinterDeviceBeforeEndPage = 151;
  ciPrinterDeviceAfterEndPage = 152;
  ciParamValueChange = 153;
  ciDataViewReportAssigned = 154;
  ciCrossTabCompareDimensionValues = 155;
  ciGroupGetFileSuffix = 156;
  ciGroupGetEmailSettings = 157;
  ciProducerBeforeEmail = 158;
  ciProducerAfterEmail = 159;


{******************************************************************************
 *
 ** L A N G U A G E   C O N S T A N T S
 *
{******************************************************************************}

  ppMsgOK = 17;
  ppMsgCancel = 5;

  {legacy constants no longer used - retained for backward compatibility}
  ppMsg100Percent             = 1;
  ppMsgAccessingData          = 2;
  ppMsgAll                    = 3;
  ppMsgArchiveFile            = 34;
  ppMsgAutoSize               = 226;
  ppMsgAutoSizeFont           = 441;
  ppMsgBlankWhenZero          = 227;
  ppMsgBottomOffset           = 397;
  ppMsgBottom                 = 325;
  ppMsgCalculating            = 4;
  ppMsgCalculations           = 228;
  ppMsgCalcOrder              = 693;
  ppMsgCenter                 = 229;
  ppMsgCharWrap               = 157;
  ppMsgChild                  = 380;
  ppMsgClose                  = 6;
  ppMsgConfigure              = 443;
  ppMsgCopies                 = 7;
  ppMsgCurrent                = 8;
  ppMsgCurrentPage            = 9;
  ppMsgDirectDraw             = 681;
  ppMsgDisplayFormat          = 230;
  ppMsgDouble                 = 231;
  ppMsgDrawing                = 10;
  ppMsgDrillDown              = 498;
  ppMsgDynamicHeight          = 232;
  ppMsgEnterPage              = 11;
  ppMsgErrorLoadingMemo       = 399;
  ppMsgExpandAll              = 643;
  ppMsgFirst                  = 13;
  ppMsgFixed                  = 382;
  ppMsgGroups                 = 146;
  ppMsgHide                   = 225;
  ppMsgHeight                 = 184;
  ppMsgIgnore                 = 416;
  ppMsgIgnoreAll              = 417;
  ppMsgLast                   = 14;
  ppMsgLeft                   = 181;
  ppMsgLines                  = 233;
  ppMsgLineTypes              = 117;
  ppMsgMaintainAspectRatio    = 412;
  ppMsgNext                   = 15;
  ppMsgNewPage                = 234;
  ppMsgNewPrintJob            = 373;
  ppMsgObject                 = 269;
  ppMsgObjects                = 270;
  ppMsgObjectLeft             = 181;
  ppMsgObjectTop              = 182;
  ppMsgObjectWidth            = 183;
  ppMsgObjectHeight           = 184;
  ppMsgOf                     = 16;
  ppMsgOpen                   = 361;
  ppMsgOverFlowOffset         = 419;
  ppMsgPage                   = 18;
  ppMsgPageRange              = 19;
  ppMsgPages                  = 20;
  ppMsgPageWidth              = 31;
  ppMsgParentHeight           = 370;
  ppMsgParentWidth            = 371;
  ppMsgParentPrinterSetup     = 413;
  ppMsgPicture                = 235;
  ppMsgPosition               = 386;
  ppMsgPrint                  = 22;
  ppMsgPrintHumanReadable     = 442;
  ppMsgPrinting               = 24;
  ppMsgPrinter                = 25;
  ppMsgPrintToFile            = 26;
  ppMsgPrintingNoPC           = 27;
  ppMsgPrintingPages          = 28;
  ppMsgPrintOnFirstPage       = 236;
  ppMsgPrintOnLastPage        = 237;
  ppMsgPrintPreview           = 23;
  ppMsgPrior                  = 29;
  ppMsgReady                  = 180;
  ppMsgReprintOnOverFlow      = 238;
  ppMsgReprintOnSubsequent    = 239;
  ppMsgResetPageNo            = 410;
  ppMsgRight                  = 327;
  ppMsgSearchData             = 1021;
  ppMsgSection                = 381;
  ppMsgSetValue               = 119;
  ppMsgShapeTypes             = 118;
  ppMsgShiftRelativeTo        = 336;
  ppMsgShiftWithParent        = 240;
  ppMsgSingle                 = 241;
  ppMsgStaticHeight           = 242;
  ppMsgStopPosition           = 507;
  ppMsgStretch                = 243;
  ppMsgStretchWithParent      = 244;
  ppMsgSuppressRepeatedValues = 245;
  ppMsgTextFile               = 37;
  ppMsgTop                    = 324;
  ppMsgTransparent            = 246;
  ppMsgTraverseAllData        = 644;
  ppMsgUndelete               = 129;
  ppMsgUndo                   = 130;
  ppMsgVisible                = 247;
  ppMsgWhole                  = 30;
  ppMsgWidth                  = 183;
  ppMsgWordWrap               = 248;

type

{$IFNDEF Delphi12}
  TBytes = array of Byte;
{$ENDIF}

{******************************************************************************
 *
 ** E N U M E R A T E D   T Y P E S
 *
{******************************************************************************}

  TppFontAttributeType = (faFontName, faFontSize);

  TppCollationType = (ctANSI, ctASCII, ctBinary, ctVariant);

  TppColorButtonType = (ctFont, ctLine, ctFill, ctHighlight);
  TppColorPaletteType = (ptFont, ptLine, ptFill, ptHighlight, ptCustom);

  TppAlignHorizontalType = (ahLeft, ahCenter, ahRight);
  TppAlignVerticalType = (avTop, avCenter, avBottom);

  TppAlignType = (asAlignLeftEdges, asAlignVerticalCenters, asAlignRightEdges,
                  asAlignTopEdges, asAlignHorizontalCenters, asAlignBottomEdges,
                  asSpaceHorizontally,   asSpaceVertically,
                  asCenterHorizontally,  asCenterVertically);

  TppSizeType = (asShrinkWidth, asGrowWidth, asShrinkHeight, asGrowHeight);

  TppDirectionType = (dtUp, dtDown, dtLeft, dtRight);

  TppAnchorType = (atLeft, atTop, atRight, atBottom);

  TppBandType = (btHeader,  btTitle, btColumnHeader, btGroupHeader, btDetail,
                 btGroupFooter, btColumnFooter, btSummary, btFooter, btPageStyle, btNotKnown);

  TppBorderPositionType = (bpLeft, bpTop, bpRight, bpBottom);

  {@TppBarCodeType

  <Table>
  Value         Meaning
  ---------     -------
   bcUPC_A      UPC (Universal Product Code) is the bar code of choice for the
                retail industry in the United States.  UPC is a coding system as
                well as a symbology; it is designed to uniquely identify a
                product and its manufacturer.  The actual UPC code is a 10-digit
                code:  the first five digits represent the manufacturer, the
                next five as a unique product identifier code assigned by the
                manufacturer.  This 10-digit code is preceded with a "number
                system" digit and followed by a check digit.
                Thus the UPC-A bar code encodes 12 digits of data.

                When you apply for a UPC manufacturer number, the UCC (Uniform
                Code Council) assigns you a six digit number; the first digit is
                a "Number System" digit from 0 to 9.  The meanings of each of
                these digits is listed below.  The next five digits is your
                actual manufacturer number.

                The Number System assignments are as follows:

                0 - 92,000 manufacturer identification numbers; 8,000 locally
                assigned numbers
                1 - Reserved
                2 - Random weight consumer packages
                3 - Drug products

                4 - In-store marking without format
                5 - UPC coupons
                6 - 100,000 manufacturer identification numbers
                7 - 100,000 manufacturer identification numbers
                8 - Reserved
                9 - Reserved

                Since all UPC-A codes encoded 12 digits of data, UPC-A is a
                fixed-width symbology.

   bcUPC_E      UPC (Universal Product Code) is the bar code of choice for the
                retail industry in the United States.  UPC is a coding system as
                well as a symbology; it is designed to uniquely identify a
                product and its manufacturer.  Please see the description for
                UPC-A for a full explanation of number systems and the UCC.
                UPC-E is a shortened version of UPC-A.  It encodes 6 digits of
                data and a check digit versus the 11 digits of data for UPC-A.
                UPC-E is normally utilized in applications where space is at a
                premium.  Some examples include soda bottles, candy bars, and
                magazines. UPC-E is known as the "zero suppression" version of
                UPC-A.
                Essentially, every UPC-E 6 digit code can be expanded to be an
                11 digit code.  The converse is also true:  UPC-A codes can be
                shrunk down to a 6 digit zero-suppressed code.  However, there
                are many rules governing how this suppression takes place.  Only
                manufacturers with specific manufacturer codes can take
                advantage of UPC-E.  It is outside the scope of this help file
                to describe all of these rules and exceptions. After you've
                applied for a UPC manufacturer's number, you will receive
                documentation that describes this process in detail.
                It is important to note that the BarCode component's
                implementation of UPC-E is expecting only 6 digits of data.
                Automatic zero-suppression is not supported.
                Also note that most barcode readers have two modes of operation
                for reading UPC-E codes:  one where the data scanned is only 6
                digits, the other where the zero-expansion is automatically done
                to return 11 digits.  Please check the documentation of your
                scanner for information regarding these modes.
                UPC-E, like UPC-A, can be combined with either a 2 or 5 digit
                add-on mode.  For example, most magazine covers utilize UPC-E
                with a 2 digit add-on.
                Since all UPC-E codes encode 7 digits of data, UPC-E is a
                fixed-width symbology.

   bcEAN_13     EAN stands for the European Article Numbering.  It is also
                compatible with JAN and IAN.  EAN is the standard for retail
                applications in countries other than the United States.  EAN-13
                encodes 13 digits, but does so in the same amount of space that
                UPC encodes 12 digits.  This is accomplished because the first
                digit is actually encoded in the parity of the left side bars,
                rather than by actual bars.

                The makeup of an EAN code is similar to a UPC, except that it
                starts with a 1 to 3 digit code identifying the country of
                origin.  The standard EAN country codes can be found in numerous
                places, including several Web sites.  Note that an EAN code with
                a first digit of "0" is exactly the same as a UPC code encoding
                the same digits.

                EAN codes are becoming widespread even in the U.S., especially
                on books.  An ISBN number can be encoded in the EAN main code,
                then the price of the book can be encoded in the 5 digit addon.
                This is commonly called "Bookland EAN".  Note that all Bookland
                EAN codes must start with "978".

   bcEAN_8      EAN stands for the European Article Numbering.  It is also
                compatible with JAN and IAN.  EAN is the standard for retail
                applications in countries other than the United States.  EAN-8
                encodes 7 digits of data and a check digit.
                The makeup of an EAN code is similar to a UPC, except that it
                starts with a 1 to 3 digit code identifying the country of
                origin.  The standard EAN country codes can be found in numerous
                places, including several Web sites.
                It is important to note that this shorter version of EAN-13 is
                not a suppression code like UPC-E is.  It simply is a way for
                manufacturers to utilize a shorter barcode if space is a
                consideration. While EAN-13 is used to implement a Bookland code
                (see EAN-13 description), EAN-8 cannot be used.

   bcInt2of5    Interleaved 2 of 5 (sometimes abbreviated I2of5 or ITF) is a
                high-density, continuous numeric symbology mainly used in the
                distribution industry.  Many packages you receive have ITF bar
                codes on them.  ITF is a very efficient symbology because it
                encodes data both in the bars and spaces.  Each digit is made up
                of five bars, of which two are wide; thus the name "2 of 5".
                Since data is encoded in both bars and spaces, all ITF bar codes
                must have an even number of digits!  Many applications will add
                a trailing zero if the number to be encoded contains an odd
                number of digits.  If you are encoding less than ten digits, ITF
                is the most efficient bar code.

                One of the problems with ITF is that a partial scan has a high
                probability of decoding as a valid, but shorter, ITF symbol.  To
                minimize this risk, ITF bar codes are often used with bearer bars
                (sometimes called protection stripes).  Bearer bars are
                horizontal bars running along the top and bottom of the symbol.
                They decrease the probability that a partial scan will decode as
                valid.

   bcCode128    Code 128 is an extremely flexible symbology and can be used to
                create alphanumeric barcodes.  It derives its name from the fact
                that it can represent all 128 ASCII symbols.

   bcCode39     Code 39 was the first alphanumeric symbology to be developed.
                It is now in wide use and is the de facto standard for
                non-retail applications.  It can encode the 26 letters of the
                alphabet (in upper case), the 10 digits, and the symbols
                "- . $ / + %"  Code 39 gets its name because each character has
                five bars and four spaces (nine elements); of those nine, three
                are wide.  Thus, "3 of 9."  If you need to encode any
                non-numeric data, its a choice between 3 of 9 and Code 128.  In
                most cases, a proper implementation of Code 128 is more
                efficient.  However, 3 of 9 is more universally accepted by
                barcode readers.
                Code 39 Extended is not exactly a new symbology, more of a
                configuration setting for barcode readers.  If you set your
                reader to Code 39 Extended mode, it will then interpret regular
                Code 39 character pairs as a single character (for example, '/A'
                would be 'a').  It basically allows you to encode all 128
                standard ASCII characters, whereas regular Code 39 only does a
                subset of those.TppBarCode supports Code 39 Extended, although
                enabling Human Readable text is not recommended for this type of
                data.

   bcIntelligentMail
                This symbology was developed by the United States Postal Service
                and replaces PostNet.

                Details are availble from the USPS.

                http://ribbs.usps.gov/intelligentmail_mailpieces/documents/tech_guides/USPSIMB_QandA.pdf


   bcPostnet    This symbology was developed by the United States Post Office
                for the purpose of marking postal items so that they could be
                sorted by automatic equipment.  In the strictest sense, Postnet
                is not a bar code, since information is not encoded into the
                width of the bars.
                Postnet encodes using the height of the bars instead.  Postnet
                codes generally match the length of a Zip code; that is, either
                5 or 9 digits.  Recently, the Post Office has accepted a Postnet
                code with 11 digits, the last two being used as the first two
                digits of a street address, PO Box, apartment number, etc.  For
                more information about the proper use of Postnet codes, contact
                your local Post Office.

   bcFIM        The Facing Identification Mark (FIM) barcode, like Postnet, is
                used exclusively by the United States Postal Service.  There are
                no commercially available barcode scanners that support FIM,
                since it has no meaning outside of mail sorting.  The FIM
                barcode, which appears in the upper right of an envelope or
                postcard next to the stamp, serves two purposes:
                1)  To allow letter mail that does not contain luminescent
                stamps or meter imprints to be faced (oriented) and canceled
                (postmarked) by machine.
                2)  To allow business reply mail and courtesy reply mail to be
                separated from other letters and cards for direct processing by
                optical character readers (OCRs) or barcode sorters (BCSs).
                The FIM symbology is perhaps the most simplistic barcode
                standard in the world.  It is a series of nine bars or spaces.
                Each bar or space is immediately followed by a space equal to a
                bar width.  Despite all of the possible combinations, there are
                exactly three FIM codes, appropriately named A, B, and C.
                Each FIM pattern has a different use based on the situation.  It
                is beyond the scope of this documentation to speak about those
                uses here.
                Interested parties should request the United States Postal
                Service Publication 25, dated August 1995.  It describes the FIM
                standard in detail.
                Please note that the default BarWidth for this code is 1/32" and
                the default height is 5/8".  The Post Office does not allow for
                any modification of these dimensions.  If you choose to modify
                them, there is no telling what the ramifications are.

   bcCodabar    Codabar is a variable-length, self-checking (e.g. no check
                digit) symbology that is primarily used
                in libraries, blood banks, photo finishing, and overnight
                delivery airbills.  It is sometimes referred to as "Code 2 of
                7."

                Codabar is basically a numeric code, although it also will
                encode the following symbols: -$:/.+

                Codabar utilizes four different start and stop codes, namely A
                through D.  These four characters cannot appear anywhere within
                the symbol, only at the beginning or end.  Every Codabar code
                must start and end with one of them.  Normally, these start and
                stop codes are used to identify a database that the numeric data
                is used with.  If a given application does not need this
                granularity, it is common practice to use "A" as the start
                character and "B" as the stop character.

    bcMSI       MSI (also known as Modified Plessey) is a barcode symbology developed
                by the MSI Data Corporation, based on the original Plessey symbology.
                It is a continuous symbology that is not self-checking. MSI is used
                primarily for inventory control, marking storage containers and shelves
                in warehouse environments.

   </Table>}

  TppBarCodeType = (bcUPC_A, bcUPC_E, bcEAN_13, bcEAN_8, bcInt2of5, bcCode128, bcCode39, bcIntelligentMail, bcPostnet, bcFIM, bcCodabar, bcMSI);

  TppBarCodeOrientation = (orLeftToRight, orRightToLeft, orTopToBottom, orBottomToTop);

  Tpp2DBarCodeType = (bcPDF417, bcMaxicode);

  TppBreakType = (btDataField, btCustomField);

  TppBoundsLockStateType = (ppblLeft, ppblTop, ppblWidth, ppblHeight);

  TppCacheType = (ppctMemory, ppctFile);

  TppCacheActionType = (ppcaCreate, ppcaWrite, ppcaRead, ppcaDump, ppcaFree, ppcaSetCacheableProperties, ppcaSetCacheCount);

  {retained for backward compatiblity, use TppVarType}
  TppCalcType = (ctDate, ctDateTime, ctPrintDateTime, ctPageCount, ctPageSet,
                 ctPageSetDesc, ctPageNo, ctPageNoDesc, ctTime, ctCustom);

  { Represents the color palette reduction method to be used for GIF images. }
  TppColorReductionType = (crWebSafe, crOptimized, crOptimizedWin, crGrayscale);

  TppGuidCollationType = (gcMSSQLServer, gcMSAccess, gcGuid, gcString);

  TppNullCollationType = (ncNullsFirst, ncNullsLast);

  TppDatabaseType = (dtAdvantage, dtInterBase, dtMSAccess, dtMSSQLServer,
                     dtSybaseASE, dtSybaseASA, dtOracle, dtParadox, dtElevateDB,
                     dtDBISAM, dtFlashFiler, dtMySQL, dtApollo, dtPostgreSQL, dtNexusDB,
                     dtFirebird, dtOther);

  TppDataPipelineStateType = (ppdaFirstRecord, ppdaLastRecord, ppdaNoRecords);

  TppDataType = (dtBoolean, dtDate, dtTime, dtDateTime, dtInteger, dtSingle,
                 dtDouble, dtExtended, dtCurrency, dtChar, dtString, dtVariant,
                 dtLongint, dtBLOB, dtMemo, dtGraphic, dtNotKnown, dtLargeInt, dtGUID);

  TppDataTypeSet = set of TppDataType;


  TppDataEditType = (ppemAll, ppemPreview, ppemTables, ppemFields, ppemCalcs, ppemSearch, ppemGroup, ppemGroupSearch, ppemSort, ppemLink, ppemText);

  TppDBCalcType = (dcCount, dcSum, dcMinimum, dcMaximum, dcAverage);

  TppDesignerStateType  = (dsModal, dsUndelete, dsBeginDrag, dsDraggingControl, dsDraggingBand,
                      dsBounding, dsAdditiveBounding, dsSizingControl, dsDeleting,
                      dsUndeleting, dsSelectionChanged, dsDestroying, dsPreviewing,
                      dsOutline, dsPrinting, dsSettingReport, dsUpdating, dsRestoringReportState, dsSavingReportState);

  TppDesignStateType = (pppcDesigning, pppcDesignPreviewing, pppcDesignPrinting,
                        pppcDisplayData, pppcCopying, pppcPasting, pppcLoading,
                        pppcTemplateLoading, pppcTemplateSaving, pppcUpdating, pppcCreating,
                        pppcEmpty);

  TppDeviceType = (dvPrinter, dvScreen, dvFile, dvArchive);
  
  TppDeviceActionType = (ppdvCancelJob, ppdvEndJob, ppdvGetPageRequest, ppdvReceivePage, ppdvStartJob, ppdvReset);

  TppDialogType = (ppdtOpen, ppdtSave);

  TppDuplexType = (dpNone, dpVertical, dpHorizontal);

  TppEngineStateType = (esInitialized, esFirstPass, esSecondPass, esNoData,
                        esPrintingTitle, esPrintingSummary,
                        esStartSection, esGenerateSection, esEndSection);

  TppFileType = (ftComma, ftTab, ftFixedLength, ftCustom);

  TppFontToImageType = (ftAllFontsAsText, ftAllFontsAsImages, ftStandardFontsAsText,
                        ftEnumeratedFontsAsText, ftEnumeratedFontsAsImages);

  TppFormatType = (ftBinary, ftASCII);

  TppFrameStyleType = (fsDashed, fsSolid);

  TppGradientStyle = (gsNone, gsHorizontal, gsVertical);

  TppImageOutputType = (otJPEG, otGIF);
  

  TppLanguageType = (lgDefault, lgDanish, lgDutch, lgEnglish, lgFrench, lgGerman,
                     lgItalian, lgPortugueseBrazil, lgPortuguese, lgSpanish,
                     lgSpanishMexico, lgSwedish, lgNorwegian, lgCustom);

  TppLinePositionType = (lpTop, lpBottom, lpLeft, lpRight, lpDiagLeft, lpDiagRight);

  TppLineStyleType = (lsSingle, lsDouble);

  TppLocateOption = (pploCaseInsensitive, pploPartialKey);

  TppNoDataBehaviorType = (ndMessageDialog, ndMessageOnPage, ndBlankPage, ndBlankReport);

  TppOperationType = (ppopRemove, ppopActiveChange, ppopDataChange, ppopUserNameChange, ppopNew, ppopLanguageChange, ppopProgramChange,
                      ppopSetValue);

  TppOutlineNodeType = (ntRoot, ntReport, ntSubReport, ntGroup, ntPage, ntNoOutline, ntOther);

  TppPageSettingType = (psAll, psPageList, psSinglePage, psFirstPage, psLastPage, psPageRange);
  TppPageRangeType = (prAll, prOddPages, prEvenPages);

  TppPassSettingType = (psOnePass, psTwoPass);

  TppPDFEmbedFontOption = (efAllFonts, efFontList, efUseSubset);

  TppPDFFontType = (pfType0, pfType1, pfTrueType, pfCID);

  TppFontEncoding = (feAnsi, feUnicode);

  TppPrintBehaviorType = (pbChild, pbSection, pbFixed);

  TppPrintConditionType = (pppcStartOfReport, pppcEndOfReport,
                           pppcStartOfPage, pppcEndOfPage,
                           pppcStartOfColumn, pppcEndOfColumn,
                           pppcStartOfGroup, pppcEndOfGroup,
                           pppcOnTraversal);

  TppPrinterCapType = (pcPaperNames, pcPapers, pcPaperWidths, pcPaperHeights, pcBinNames, pcBins);

  TppPrintHeightType = (phStatic, phDynamic);

  TppPrintTimesType = (ptZero, ptOne, ptRepeat, ptCount);

  TppPropEditType = (etAutoEdit, etEdit, etFieldList, etDataPipelineList, etValueList);

  TppMenuItemType = (mtBoolean, mtDialog, mtEnumerated);

  TppRangeBeginType = (rbFirstRecord, rbLastRecord, rbCurrentRecord);

  TppRangeEndType = (reFirstRecord, reLastRecord, reCurrentRecord, reCount);

  TppRAPInterfaceOption = (riDialog, riNotebookTab);

  TppRAPOption = (roViewVariables, roEditVariables, roViewEvents, roEditEvents, roViewGlobals, roEditGlobals);

  TppResolutionType = (pprtHorizontal, pprtVertical);

  TppSaveToType = (stDatabase, stFile);

  TppSearchOperatorType = (soEqual, soNotEqual,
                           soLessThan, soLessThanOrEqualTo,
                           soGreaterThan, soGreaterThanOrEqualTo,
                           soLike, soNotLike,
                           soBetween, soNotBetween,
                           soInList, soNotInList,
                           soBlank, soNotBlank);

  TppLogicalOperatorType = (loAnd, loOr, loNot);

  TppSortOrderType = (soAscending, soDescending, soNone);

  TppShowComponent = (scLabel, scMemo, scRichText, scCalc, scImage,
                      scShape, scLine, scBarCode, scTeeChart,
                      scDBText, scDBMemo, scDBRichText, scDBCalc, scDBImage,
                      scDBBarCode, scDBTeeChart, scRegion, scSubReport,
                      scSystemVariable, scVariable, scPageBreak, sc2DBarCode, scDB2DBarCode, scPaintBox);

  TppSQLType = (sqBDELocal, sqSQL1, sqSQL2);

  TppSubReportActionType = (ppsrReset, ppsrExpandDrillDowns, ppsrCollapseDrillDowns, ppsrEnableProcessMessages);

  TppUnitType = (utScreenPixels, utInches, utMillimeters, utPrinterPixels, utMMThousandths);

  TppVarEventType = (veTraversal, veDataPipelineTraversal, vePageStart, vePageEnd, veColumnStart,
                     veColumnEnd, veReportStart, veReportEnd, veGroupStart, veGroupEnd, veGroupBeforeHeader, veGroupBeforeFooter);

  TppVarType = (vtDate, vtDateTime, vtDocumentName, vtPrintDateTime, vtPageCount, vtPageSet,
                vtPageSetDesc, vtPageNo, vtPageNoDesc, vtTime, vtCopyNo, vtCopyNoDesc, vtSearchDesc);

  TppNextActionType = (ppnaNone, ppnaDesign, ppnaPreview);

  TppTextAlignment = (taLeftJustified, taRightJustified, taCentered, taFullJustified);

  TppXhtmlViewerStyleType = (vsPlain, vsPageRect, vsBackground, vsTableCell);

  TppZoomSettingType = (zsWholePage, zsPageWidth, zs100Percent, zsPercentage);

  TppPreviewActionType = (paPrint, paEmail, paAutoSearch, paTextSearch, paWholePage, paPageWidth, pa100Percent,
                          paFirst, paPrior, paNext, paLast, paCancel, paClose, paGoToPage);

  TppTextSearchType = (stSearch, stFirst, stNext, stPrior, stLast, stRefresh, stCancel, stDone);

  TppVerticalScrollEventType = (vsLineUp, vsLineDown, vsPageUp, vsPageDown, vsThumbPos, vsThumbTrack, vsTop, vsBottom, vsEndScroll);

  TppHorizontalScrollEventType = (hsLineLeft, hsLineRight, hsPageLeft, hsPageRight, hsThumbPos, hsThumbTrack, hsLeft, hsRight, hsEndScroll);

  TppTextSearchStateType = (seSearchingPage, seCancelled, seActiveSearch);

  TppDeviceStateType = (dsBeforeStartJob, dsAfterStartJob,
                               dsBeforeEndJob, dsAfterEndJob,
                               dsBeforeStartPage, dsAfterStartPage,
                               dsBeforeEndPage, dsAfterEndPage,
                               dsBeforeDrawCommand, dsAfterDrawCommand);

  TppExportComponentType = (ecText, ecLine, ecShape, ecImage, ecRichText, ecBarCode, ecOther);

  {$IFNDEF Delphi9}
  TppGradientDirection = (gdHorizontal, gdVertical);
  {$ENDIF}


{******************************************************************************
 *
 ** M I S C
 *
{******************************************************************************}

  TppTabStopPos  = array [0..99] of Integer;

  TppPointArray = array of TPoint; 

  TppMultiKeyHelp = record
    mkSize: DWORD;
    mkKeylist: Char;
    szKeyphrase: array[0..255] of Char;
  end;


const
  cReportBands       = [btHeader, btDetail, btFooter];
  cChildReportBands  = [btTitle, btDetail, btSummary];

  cAllShowComponents = [scLabel, scMemo, scRichText, scCalc, scImage,
                        scShape, scLine, scBarCode, scTeeChart,
                        scDBText, scDBMemo, scDBRichText, scDBCalc, scDBImage,
                        scDBBarCode, scDBTeeChart, scRegion, scSubReport,
                        scSystemVariable, scVariable, scPageBreak, sc2DBarCode, scDB2DBarCode, scPaintBox];

  cAllRAPInterfaceOptions = [riDialog, riNotebookTab];
  cAllRAPOptions = [roViewVariables, roEditVariables, roViewEvents, roEditEvents, roViewGlobals, roEditGlobals];
  cRAPDialogOptions = [roViewVariables, roEditVariables];

  cPOSBarCodes = [bcEAN_13, bcEAN_8, bcUPC_A, bcUPC_E];

  cAllDataEditOptions = [ppemTables, ppemFields, ppemCalcs, ppemGroup, ppemGroupSearch, ppemSearch, ppemSort, ppemText, ppemPreview];

  csAlignLeftIdent = 'taLeftJustify';
  csAlignRightIdent = 'taRightJustify';
  csAlignCenterIdent = 'taCenter';

  cAllExportComponents = [ecText, ecLine, ecShape, ecImage, ecRichText, ecBarCode, ecOther];


{******************************************************************************
 *
 ** S E T   T Y P E S
 *
{******************************************************************************}
type

  TppAnchors = set of TppAnchorType;
  TppBandTypes = set of TppBandType;
  TppBorderPositions = set of TppBorderPositionType;
  TppBoundsLockStates = set of TppBoundsLockStateType;
  TppDatabaseTypes = set of TppDatabaseType;
  TppDataPipelineStates = set of TppDataPipelineStateType;
  TppDataEditTypes = set of TppDataEditType;
  TppDesignerStates = set of TppDesignerStateType;
  TppDesignStates = set of TppDesignStateType;
  TppEngineStates = set of TppEngineStateType;
  TppEvents = set of Byte;
  TppImageOutputTypes = set of TppImageOutputType;
  TppLocateOptions = set of TppLocateOption;
  TppNoDataBehaviors = set of TppNoDataBehaviorType;
  TppPDFEmbedFontOptions = set of TppPDFEmbedFontOption;
  TppPrintConditions = set of TppPrintConditionType;
  TppSearchOperators = set of TppSearchOperatorType;
  TppShowComponents = set of TppShowComponent;
  TppRAPInterfaceOptions = set of TppRAPInterfaceOption;
  TppRAPOptions = set of TppRAPOption;
  TppLogicalOperatorTypes = set of TppLogicalOperatorType;
  TppExportComponents = set of TppExportComponentType;


{******************************************************************************
 *
 ** E V E N T S
 *
{******************************************************************************}

  TppAlignEvent = procedure (Action: TppAlignType) of object;
  {@TppComponentEvent}
  TppComponentEvent = procedure (Sender: TObject; Component: TComponent) of object;
  TppCreateReportEvent = procedure(Sender: TObject; const aDataName: String; var aReport: TObject) of object;
  TppCreateAutoSearchFieldEvent = procedure(Sender: TObject; aAutoSearchField: TObject) of object;
  TppDialogEvent = procedure (Sender: TObject; aDialog: TObject) of object;
  TppDrawCommandEvent = procedure (Sender: TObject; aDrawCommand: TObject) of object;
  TppEmailErrorEvent = procedure (Sender: TObject; aErrorText: String) of object;
  TppFormatEvent = procedure(Sender: TObject; DisplayFormat: String; DataType: TppDataType; Value: Variant; var Text: String) of object;
  TppGetDataNamesEvent = procedure(Sender: TObject; aDataNameList: TStrings) of object;
  TppGetDisplayFormatsEvent = procedure (Sender: TObject; DisplayFormats: TStrings) of object;
  TppGetBreakValueEvent = procedure(Sender: TObject; var aBreakValue: String) of object;
  TppGetAliasForFieldEvent = procedure (Sender: TObject; aDataPipeline: TObject; const aDataField: String; var aFieldAlias: String) of object;
  TppGetFieldForAliasEvent = procedure (Sender: TObject; const aFieldAlias: String; var aDataPipeline: TObject; var aDataField: String) of object;
  TppGetFieldsEvent = procedure(Sender: TObject; const aDataName: String; aFieldList: TStrings) of object;
  TppGetEmailSettingsEvent = procedure(Sender: TObject; aEmailSettings: TObject) of object;
  TppGetLastPageCachedEvent = procedure(Sender: TObject; var aPageNo: Longint) of object;
  TppGetTextEvent = procedure(Sender: TObject; var Text: String) of object;
  TppGotoPageEvent = procedure (Sender: TObject; aPageNo: Longint) of object;
  TppHelpEvent = procedure(Sender: TObject; var aHelpFile, aKeyphrase: String; var aCallHelp: Boolean) of object;
  TppHorizontalScrollEvent = procedure(Sender: TObject; aPosition: SmallInt; aEventType: TppHorizontalScrollEventType) of object;
  {@TppNoDataEvent}
  TppNoDataEvent = procedure(Sender: TObject; aDialog: TObject; var aShowDialog: Boolean; aDrawCommand: TObject; var aAddDrawCommand: Boolean) of object;
  TppLocateEvent = function (Sender: TObject; const aReportName: String): Boolean of object;
  TppMemoEvent = procedure(Sender: TObject; aLines: TStrings) of object;
  TppPageDefChangeQueryEvent = procedure(Sender: TObject; aNewPageDef: TObject; var CanChange: Boolean) of object;
  TppPageEvent = procedure (Sender: TObject; aPage: TObject) of object;
  {@TppPageRequestEvent}
  TppPageRequestEvent = procedure (Sender: TObject; aPageRequest: TObject) of object;
  TppPaintEvent = procedure(aCanvas: TCanvas) of object;
  TppPictureEvent = procedure(Sender: TObject; aPicture: TPicture) of object;
  TppRenameFolderEvent = procedure(Sender: TObject; aFolderId: Integer; const aNewName: String) of object;
  TppSaveImageEvent = procedure(Sender: TObject; aFileName: String) of object;
  TppSaveLineEvent = procedure(Sender: TObject; var Line: String) of object;
  TppSaveTextEvent = procedure(Sender: TObject; var Text: String) of object;
  {@TppStreamEvent}
  TppStreamEvent = procedure (Sender: TObject; Stream: TStream) of object;
  TppTabChangeEvent = procedure (Sender: TObject; NewTab: String; var AllowChange: Boolean) of object;
  TppTextDeviceSaveEvent = procedure(aTextDevice: TObject; aComponent: TObject; var aText: String) of object;
  TppValidateNameEvent = procedure(Sender: TObject; const aName: String; var aNameValid: Boolean) of object;
  TppValidateComponentEvent = procedure (Sender: TObject; Component: TComponent; var Valid: Boolean) of object;
  TppVarCalcEvent = procedure (Sender: TObject; var Value: Variant) of object;
  TppVerticalScrollEvent = procedure(Sender: TObject; aPosition: SmallInt; aEventType: TppVerticalScrollEventType) of object;
  TppXHTMLProgressEvent = procedure (Sender: TObject; const aMessage: String; aTotalParts, aPartsComplete: Integer) of object;
  {@TppReportInitializeEvent}
  TppReportInitializeEvent = procedure(Sender: TObject; var aCancel: Boolean) of object;
  TppPrinterDeviceStateChangeEvent = procedure(Sender: TObject; aStateChange: TppDeviceStateType) of object;  
  TppHyperLinkClickEvent = procedure (Sender: TObject ; var aWebAddress: string ; var Handled: Boolean) of object;

{******************************************************************************
 *
 ** C A C H E   R E C O R D S
 *
{******************************************************************************}

{note: for WIN32, use compiler directive to declare strings as 'ShortStrings'
       this is required for record structures}

{$H-}

{further note: hopefully the compiler directive above will never be needed.
 Strings take up took much cache space and should be avoided at all costs.}

  {used by ArchiveReader and ArchiveDevice to read header info}
  TppPageEntryRec = record
    Position: Longint;
    AbsolutePageNo: Longint;
  end; {record, TppPageEntry}

  {used by Engine to track print position}
  TppRect = record
    Left: Longint;
    Top: Longint;
    Right: Longint;
    Bottom: Longint;
  end; {record, TppRect}

  {used to store bounds rect of anchored component's parent}
  TppSizeRect = record
    Left:   Integer;
    Top:    Integer;
    Width:  Integer;
    Height: Integer;
  end; {record, TppSizeRect}

  {used by the PDF Device to store coordinates as extended types}
  TppDoubleRect = record
    Left: Double;
    Top: Double;
    Right: Double;
    Bottom: Double;
  end;

  TppBandSaveRec = record
    FObjectListIndex: Integer;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;
    FPartialAdjustment: Longint;
    FPrintPositionBreak: Boolean;
    FPrintingSection: Boolean;
  end; {record, TppBandSaveRec}

  TppReportBandSaveRec = record
    FObjectListIndex: Integer;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;
    FPartialAdjustment: Longint;
    FPrintPositionBreak: Boolean;
    FPrintingSection: Boolean;

    FAlreadyPageBreak: Boolean;
  end; {record, TppReportBandSaveRec}

  TppGroupBandSaveRec = record
    FObjectListIndex: Integer;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;
    FPartialAdjustment: Longint;
    FPrintPositionBreak: Boolean;
    FPrintingSection: Boolean;

    FGeneration: Boolean;
  end; {record, TppGroupBandSaveRec}

  TppGroupHeaderBandSaveRec = record
    FObjectListIndex: Integer;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;
    FPartialAdjustment: Longint;
    FPrintPositionBreak: Boolean;
    FPrintingSection: Boolean;

    FGeneration: Boolean;

    FAlreadyColumnBreak: Boolean;
    FAlreadyPageBreak: Boolean;
    FPageHeaderVisible: Boolean;
    FPageFooterVisible: Boolean;
    FPageStyleVisible: Boolean;
  end; {record, TppGroupBandSaveRec}

  TppDetailBandSaveRec = record
    FObjectListIndex: Integer;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;
    FPartialAdjustment: Longint;
    FPrintPositionBreak: Boolean;
    FPrintingSection: Boolean;

    FBandsPerRecordCount: Integer;
  end; {record, TppBandSaveRec}

  TppGroupSaveRec = record
    FFirstPageNo: Longint;
    FLastPageNo: Longint;
    FBreaking: Boolean;
    FBreakNo: Longint;
    FFirstColumn: Integer;
    FResetOnCheck: Boolean;
    FKeptTogether: Boolean;
  end; {record, TppGroupSaveRec}

  TppCustomComponentSaveRec = record
    FDrawComponent: Boolean;
  end; {record, TppCalcSaveRec}

  TppCalcSaveRec = record
    FDrawComponent: Boolean;

    FBoolean: Boolean;
    FDateTime: TDateTime;
    FInteger: Longint;
    FDouble: Double;
  end; {record, TppCalcSaveRec}

  TppVariableSaveRec = record
    FDrawComponent: Boolean;
    FResetOnCompute: Boolean;

    FBoolean: Boolean;
    FChar: Char;
    FCurrency: Currency;
    FInteger: Longint;
    FDateTime: TDateTime;
    FDouble: Double;
    FExtended: Extended;
    FSingle: Single;
  end; {record, TppVariableSaveRec}

  TppCustomTextSaveRec = record
    FDrawComponent: Boolean;
    FPriorValueSame: Boolean;
    FFirstPage: Integer;
    FFirstColumn: Integer;
    FAlreadyPrinted: Boolean;
  end;

  TppDBTextSaveRec = record
    FDrawComponent: Boolean;

    FAlreadyPrinted: Boolean;
    FFirstPage: Longint;
    FFirstColumn: Longint;
    FPriorValueSame: Boolean;
    FResetOnCompute: Boolean;
  end; {record, TppDBTextSaveRec}

  TppDBCalcSaveRec = record
    FDrawComponent: Boolean;

    FAlreadyPrinted: Boolean;
    FFirstPage: Longint;
    FPriorValueSame: Boolean;
    FResetOnCompute: Boolean;

    FDivisor: Double;
    FValue: Double;
  end; {record, TppDBCalcSaveRec}

  TppStretchableSaveRec = record
    FDrawComponent: Boolean;
    FDrawShifter: Boolean;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;
  end; {record, TppStretchableSaveRec}

  TppCustomMemoSaveRec = record
    FDrawComponent: Boolean;
    FDrawShifter: Boolean;
    FKeptTogether: Boolean;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;

    FCharPos: Longint;
  end; {record, TppCustomMemoSaveRec}

  TppDBMemoSaveRec = record
    FDrawComponent: Boolean;
    FDrawShifter: Boolean;
    FKeptTogether: Boolean;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;

    FAlreadyPrinted: Boolean;
    FCharPos: Longint;
    FPriorValueSame: Boolean;
    FResetOnCompute: Boolean;
  end; {record, TppDBMemoSaveRec}

  TppRegionSaveRec = record
    FDrawComponent: Boolean;
    FDrawShifter: Boolean;
    FKeptTogether: Boolean;
    FObjectIndex: Integer;
    FOverFlow: Boolean;
    FPartialGeneration: Boolean;

    FObjectListIndex: Integer;
    FPartialAdjustment: Longint;
  end; {record, TppRegionSaveRec}

  TppDataPipelineSaveRec = record
    FNoRecords: Boolean;
    FLastRecord: Boolean;
    FFirstRecord: Boolean;
    FBookmarked: Boolean;
    FBookmark: Longint;
    FTraversalCount: Longint;
    FRecordNo: Longint;
  end;  {record, TppDataPipelineSaveRec}

  TppEngineSaveRec = record
    FAdvanceRecord: Boolean;
    FAllColumnsStarted: Boolean;
    FAllDataTraversed: Boolean;
    FBandIndex: Integer;
    FBandListIndex: Integer;
    FReportBandCount: Longint;
    FInitialized: Boolean;
    FFirstPass: Boolean;
    FNoData: Boolean;
    FPrintingSummary: Boolean;
    FPrintingTitle: Boolean;
    FStartSection: Boolean;
    FGenerateSection: Boolean;
    FEndSection: Boolean;
    FStartOfReport: Boolean;
    FStartOfPage: Boolean;
    FStartOfColumn: Boolean;
    FStartOfGroup: Boolean;
    FOnTraversal: Boolean;
    FEndOfGroup: Boolean;
    FEndOfColumn: Boolean;
    FEndOfPage: Boolean;
    FEndOfReport: Boolean;
    FTraversedMaster: Boolean;
    FTraversedDetail: Boolean;
    FCalcsOutOfSync: Boolean;

    FMasterNoRecords: Boolean;
    FMasterLastRecord: Boolean;
    FMasterFirstRecord: Boolean;
    FMasterBookmarked: Boolean;
    FMasterBookmark: Longint;
    FMasterTraversalCount: Longint;
    FMasterRecordNo: Longint;

    FDetailNoRecords: Boolean;
    FDetailLastRecord: Boolean;
    FDetailFirstRecord: Boolean;
    FDetailBookmarked: Boolean;
    FDetailBookmark: Longint;
    FDetailTraversalCount: Longint;
    FDetailRecordNo: Longint;

  end;  {record, TppEngineSaveRec}

{$H+}


{******************************************************************************
 *
 ** E X C E P T I O N S
 *
{******************************************************************************}

  EReportBuilderError = class(Exception);
  EPrintError = class(EReportBuilderError);
  EDataError = class(EReportBuilderError);
  EDesignError = class(EReportBuilderError);
  EInvalidPropertyError = class(EReportBuilderError);
  ETemplateLoadError = class(EReportBuilderError);
  ETemplateSaveError = class(EReportBuilderError);
  EInvalidTemplateError = class(EReportBuilderError);
  EOutlineError = class(EReportBuilderError);
  EBackgroundPrintError = class(EReportBuilderError);
  EBackgroundPrintTimeoutError = class(EBackgroundPrintError);
  EParameterError = class(EReportBuilderError);
  EEmailError = class(EReportBuilderError);

  ECodeError = class(EReportBuilderError)
  private
    FRAPProgram: TObject;
    FProgramName: string;
    FProgramCode: string;
  public
    property RAPProgram: TObject read FRAPProgram write FRAPProgram;
    property ProgramName: string read FProgramName write FProgramName;
    property ProgramCode: string read FProgramCode write FProgramCode;
  end;



implementation






end.

