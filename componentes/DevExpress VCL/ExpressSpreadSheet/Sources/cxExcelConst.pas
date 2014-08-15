
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

unit cxExcelConst;

{$I cxVer.inc}

interface
uses
  SysUtils, {$IFDEF WIN32} Windows, Graphics, {$ELSE} QGraphics, {$ENDIF}
   cxSSTypes, cxSSRes; 

type
  PcxExcelPalette = ^TcxExcelPalette;
  TcxExcelPalette = packed array[0..55] of TColor;

  PBiffRecHeader = ^TBiffRecHeader;
  TBiffRecHeader = packed record
    RecType: Word;
    RecSize: Word;
    RecData: array[0..MaxInt div SizeOf(Byte) - 5] of Byte;
  end;

  PxlsTreeNode = ^TxlsTreeNode;
  TxlsFileStorage = packed record
    LinkToSST: PxlsTreeNode;
    RootHeader: PxlsTreeNode;
    Pages: PxlsTreeNode;
  end;

  TxlsSheetInfo = packed record
    SheetId: Word;
    LinkToBoundSheet: PxlsTreeNode;
    LinkToWindow2: PxlsTreeNode;
    LinkToDimension: PxlsTreeNode;
    LinkToIndex: PxlsTreeNode;
    LinkToMergedCells: PxlsTreeNode;
    BOF: array[0..19] of Byte;
  end;

  TxlsTreeNode = packed record
    Next: PxlsTreeNode;
    Prev: PxlsTreeNode;
    case Integer of
      0: (SheetInfo: TxlsSheetInfo; SheetNodesList: PxlsTreeNode);
      1: (RecType: Word; RecSize: Word);
      2: (ByteData: array[0..(8220 div SizeOf(Byte)) - 1] of Byte);
      3: (WordData: array[0..(8220 div SizeOf(Word)) - 1] of Word);
      4: (IntData: array[0..(8220 div SizeOf(Integer)) - 1] of Integer);
  end;

  TSSTBlock = packed record
    StringCount: Word;
    StringOffset: Word;
    RecType: Word;
    DataSize: Word;
    Data: array[0..8191] of Byte;
  end;

  TSSTList = array of TSSTBlock;

  TExtSSTBlock = packed record
    StreamOffset: Integer;
    StringOffset: Word;
    Reserved: Word;
  end;

  TExtSST = packed record
    RecType: Word;
    DataSize: Word;
    StringPerBlock: Word;
    Data: array[0..255] of TExtSSTBlock;
  end;

  TSSSTStringInfo = packed record
    HashCode: Word;
    StrSize: Word;
    Block: Word;
    Offset: Word;
  end;

  TSSSTStringsInfo = array of TSSSTStringInfo;

  TcxSSFuncParams = (fpVariable, fpFixed, fpNone);

  TcxProc = procedure;

  PcxExcelFuncDefinition = ^TcxExcelFuncDefinition;
  TcxExcelFuncDefinition = {$IFNDEF DELPHI12} packed {$ENDIF} record
    Token: Word;
    Name: string;
    Definition: TcxProc;
    case Params: TcxSSFuncParams of
      fpVariable, fpFixed:
        (ParamsCount: Byte);
  end;

const
  { Biff reecords constants }
  brc1904                    =   $0022;              // 1904 Date System
  brcADDIN                   =   $0087;              // Workbook Is an Add-in Macro
  brcADDMENU                 =   $00C2;              // Menu Addition
  brcARRAY                   =   $0221;              // Array-Entered Formula
  brcAUTOFILTER              =   $009E;              // AutoFilter Data
  brcAUTOFILTERINFO          =   $009D;              // Drop-Down Arrow Count
  brcBACKUP                  =   $0040;              // Save Backup Version of the File
  brcBLANK                   =   $0201;              // Cell Value, Blank Cell
  brcBOF                     =   $0809;              // Beginning of File
  brcBOOKBOOL                =   $00DA;              // Workbook Option Flag
  brcBOOLERR                 =   $0205;              // Cell Value, Boolean or Error
  brcBOTTOMMARGIN            =   $0029;              // Bottom Margin Measurement
  brcBOUNDSHEET              =   $0085;              // Sheet Information
  brcCALCCOUNT               =   $000C;              // Iteration Count
  brcCALCMODE                =   $000D;              // Calculation Mode
  brcCF                      =   $01B1;              // Conditional Formatting Conditions
  brcCODENAME                =   $0042;              // VBE Object Name
  brcCODEPAGE                =   $0042;              // Default Code Page
  brcCOLINFO                 =   $007D;              // Column Formatting Information
  brcCONDFMT                 =   $01B0;              // Conditional Formatting Range Information
  brcCONTINUE                =   $003C;              // Continues Long Records
  brcCONTINUEFRT             =   $0812;              // Continued FRT
  brcCOORDLIST               =   $00A9;              // Polygon Object Vertex Coordinates
  brcCOUNTRY                 =   $008C;              // Default Country and WIN.INI Country
  brcCRN                     =   $005A;              // Nonresident Operands
  brcDBCELL                  =   $00D7;              // Stream Offsets
  brcDBQUERYEXT              =   $0803;              // Database Query Extensions
  brcDCON                    =   $0050;              // Data Consolidation Information
  brcDCONBIN                 =   $01B5;              // Data Consolidation Information
  brcDCONNAME                =   $0052;              // Data Consolidation Named References
  brcDCONREF                 =   $0051;              // Data Consolidation References
  brcDEFAULTROWHEIGHT        =   $0225;              // Default Row Height
  brcDEFCOLWIDTH             =   $0055;              // Default Width for Columns
  brcDELMENU                 =   $00C3;              // Menu Deletion
  brcDELTA                   =   $0010;              // Iteration Increment
  brcDIMENSIONS              =   $0200;              // Cell Table Size
  brcDOCROUTE                =   $00B8;              // Routing Slip Information
  brcDSF                     =   $0161;              // Double Stream File
  brcDV                      =   $01BE;              // Data Validation Criteria
  brcDVAL                    =   $01B2;              // Data Validation Information
  brcEDG                     =   $0088;              // Edition Globals
  brcEOF                     =   $000A;              // End of File
  brcEXCEL9FILE              =   $01C0;              // Excel 9 File
  brcEXTERNCOUNT             =   $0016;              // Number of External References
  brcEXTERNNAME              =   $0023;              // Externally Referenced Name
  brcEXTERNSHEET             =   $0017;              // External Reference
  brcEXTSST                  =   $00FF;              // Extended Shared String Table
  brcEXTSTRING               =   $0804;              // FRT String
  brcFILEPASS                =   $002F;              // File Is Password-Protected
  brcFILESHARING             =   $005B;              // File-Sharing Information
  brcFILESHARING2            =   $01A5;              // File-Sharing Information for Shared Lists
  brcFILTERMODE              =   $009B;              // Sheet Contains Filtered List
  brcFNGROUPCOUNT            =   $009C;              // Built-in Function Group Count
  brcFNGROUPNAME             =   $009A;              // Function Group Name
  brcFONT                    =   $0031;              // Font Description
  brcFOOTER                  =   $0015;              // Print Footer on Each Page
  brcFORMAT                  =   $041E;              // Number Format
  brcFORMULA                 =   $0006;              // Cell Formula
  brcGCW                     =   $00Ab;              // Global Column-Width Flags
  brcGRIDSET                 =   $0082;              // State Change of Gridlines Option
  brcGUTS                    =   $0080;              // Size of Row and Column Gutters
  brcHCENTER                 =   $0083;              // Center Between Horizontal Margins
  brcHEADER                  =   $0014;              // Print Header on Each Page
  brcHIDEOBJ                 =   $008D;              // Object Display Options
  brcHLINK                   =   $01B8;              // Hyperlink
  brcHLINKTOOLTIP            =   $0800;              // Hyperlink Tooltip
  brcHORIZONTALPAGEBREAKS    =   $001B;              // Explicit Row Page Breaks
  brcIMDATA                  =   $007F;              // Image Data
  brcINDEX                   =   $020B;              // Index Record
  brcINTERFACEEND            =   $00E2;              // End of User Interface Records
  brcINTERFACEHDR            =   $00E1;              // Beginning of User Interface Records
  brcITERATION               =   $0011;              // Iteration Mode
  brcLABEL                   =   $0204;              // Cell Value, String Constant
  brcLABELSST                =   $00FD;              // Cell Value, String Constant/SST
  brcLEFTMARGIN              =   $0026;              // Left Margin Measurement
  brcLHNGRAPH                =   $0095;              // Named Graph Information
  brcLHRECORD                =   $0094;              // .WK? File Conversion Information
  brcLPR                     =   $0098;              // Sheet Was Printed Using LINE.PRINT(
  brcMERGECELLS              =   $00E5;              // Merged Cells
  brcMMS                     =   $00C1;              // ADDMENU/DELMENU Record Group Count
  brcMSODRAWING              =   $00EC;              // Microsoft Office Drawing
  brcMSODRAWINGGROUP         =   $00ED;              // Microsoft Office Drawing Group
  brcMSODRAWINGSELECTION     =   $00ED;              // Microsoft Office Drawing Selection
  brcMULBLANK                =   $00BE;              // Multiple Blank Cells
  brcMULRK                   =   $00BD;              // Multiple RK Cells
  brcNAME                    =   $0018;              // Defined Name
  brcNOTE                    =   $001C;              // Comment Associated with a Cell
  brcNUMBER                  =   $0203;              // Cell Value, Floating-Point Number
  brcOBJ                     =   $005D;              // Describes a Graphic Object
  brcOBJPROTECT              =   $0063;              // Objects Are Protected
  brcOBPROJ                  =   $00D3;              // Visual Basic Project
  brcOLEDBCONN               =   $080A;              // OLE Database Connection
  brcOLESIZE                 =   $00DE;              // Size of OLE Object
  brcPALETTE                 =   $0092;              // Color Palette Definition
  brcPANE                    =   $0041;              // Number of Panes and Their Position
  brcPARAMQRY                =   $00DC;              // Query Parameters
  brcPASSWORD                =   $0013;              // Protection Password
  brcPLS                     =   $004D;              // Environment-Specific Print Record
  brcPRECISION               =   $000E;              // Precision
  brcPRINTGRIDLINES          =   $002B;              // Print Gridlines Flag
  brcPRINTHEADERS            =   $002A;              // Print Row/Column Labels
  brcPROTECT                 =   $0012;              // Protection Flag
  brcPROT4REV                =   $01AF;              // Shared Workbook Protection Flag
  brcQSI                     =   $01AD;              // External Data Range
  brcQSIF                    =   $0807;              // Query Table Field Formatting
  brcQSIR                    =   $0806;              // Query Table Formatting
  brcQSISXTAG                =   $0802;              // PivotTable and Query Table Extensions
  brcRECALCID                =   $01C1;              // Recalc Information
  brcRECIPNAME               =   $00B9;              // Recipient Name
  brcREFMODE                 =   $000F;              // Reference Mode
  brcREFRESHALL              =   $01B7;              // Refresh Flag
  brcRIGHTMARGIN             =   $0027;              // Right Margin Measurement
  brcRK                      =   $027E;              // Cell Value, RK Number
  brcROW                     =   $0208;              // Describes a Row
  brcRSTRING                 =   $00D6;              // Cell with Character Formatting
  brcSAVERECALC              =   $005F;              // Recalculate Before Save
  brcSCENARIO                =   $00AF;              // Scenario Data
  brcSCENMAN                 =   $00AE;              // Scenario Output Data
  brcSCENPROTECT             =   $00DD;              // Scenario Protection
  brcSCL                     =   $00A0;              // Window Zoom Magnification
  brcSELECTION               =   $001D;              // Current Selection
  brcSETUP                   =   $00A1;              // Page Setup
  brcSHRFMLA                 =   $04BC;              // Shared Formula
  brcSORT                    =   $0090;              // Sorting Options
  brcSOUND                   =   $0096;              // Sound Note
  brcSST                     =   $00FC;              // Shared String Table
  brcSTANDARDWIDTH           =   $0099;              // Standard Column Width
  brcSTRING                  =   $0207;              // String Value of a Formula
  brcSTYLE                   =   $0293;              // Style Information
  brcSUB                     =   $0091;              // Subscriber
  brcSUPBOOK                 =   $01AE;              // Supporting Workbook
  brcSXDB                    =   $00C6;              // PivotTable Cache Data
  brcSXDBEX                  =   $0122;              // PivotTable Cache Data
  brcSXDI                    =   $00C5;              // Data Item
  brcSXEX                    =   $00F1;              // PivotTable View Extended Information
  brcSXEXT                   =   $00DC;              // External Source Information
  brcSXFDBTYPE               =   $01BB;              // SQL Datatype Identifier
  brcSXFILT                  =   $00F2;              // PivotTable Rule Filter
  brcSXFORMAT                =   $00FB;              // PivotTable Format Record
  brcSXFORMULA               =   $0103;              // PivotTable Formula Record
  brcSXFMLA                  =   $00F9;              // PivotTable Parsed Expression
  brcSXIDSTM                 =   $00D5;              // Stream ID
  brcSXIVD                   =   $00B4;              // Row/Column Field Ids
  brcSXLI                    =   $00B5;              // Line Item Array
  brcSXNAME                  =   $00F6;              // PivotTable Name
  brcSXPAIR                  =   $00F8;              // PivotTable Name Pair
  brcSXPI                    =   $00B6;              // Page Item
  brcSXPIEX                  =   $080E;              // OLAP Page Item Extensions
  brcSXRULE                  =   $00F0;              // PivotTable Rule Data
  brcSXSTRING                =   $00CD;              // String
  brcSXSELECT                =   $00F7;              // PivotTable Selection Information
  brcSXTBL                   =   $00D0;              // Multiple Consolidation Source Info
  brcSXTBPG                  =   $00D2;              // Page Item Indexes
  brcSXTBRGIITM              =   $00D1;              // Page Item Name Count
  brcSXTH                    =   $080D;              // PivotTable OLAP Hierarchy
  brcSXVD                    =   $00B1;              // View Fields
  brcSXVDEX                  =   $0100;              // Extended PivotTable View Fields
  brcSXVDTEX                 =   $080F;              // View Dimension OLAP Extensions
  brcSXVI                    =   $00B2;              // View Item
  brcSXVIEW                  =   $00B0;              // View Definition
  brcSXVIEWEX                =   $080C;              // Pivot Table OLAP Extensions
  brcSXVIEWEX9               =   $0810;              // Pivot Table Extensions
  brcSXVS                    =   $00E3;              // View Source
  brcTABID                   =   $013D;              // Sheet Tab Index Array
  brcTABIDCONF               =   $00EA;              // Sheet Tab ID of Conflict History
  brcTABLE                   =   $0236;              // Data Table
  brcTEMPLATE                =   $0060;              // Workbook Is a Template
  brcTOPMARGIN               =   $0028;              // Top Margin Measurement
  brcTXO                     =   $01B6;              // Text Object
  brcUDDESC                  =   $00DF;              // Description String for Chart Autoformat
  brcUNCALCED                =   $005E;              // Recalculation Status
  brcUSERBVIEW               =   $01A9;              // Workbook Custom View Settings
  brcUSERSVIEWBEGIN          =   $01AA;              // Custom View Settings
  brcUSERSVIEWEND            =   $01Ab;              // End of Custom View Records
  brcUSESELFS                =   $0160;              // Natural Language Formulas Flag
  brcVCENTER                 =   $0084;              // Center Between Vertical Margins
  brcVERTICALPAGEBREAKS      =   $001A;              // Explicit Column Page Breaks
  brcWINDOW1                 =   $003D;              // Window Information
  brcWINDOW2                 =   $023E;              // Sheet Window Information
  brcWINDOWPROTECT           =   $0019;              // Windows Are Protected
  brcWOPT                    =   $080B;              // Web Options
  brcWRITEACCESS             =   $005C;              // Write Access User Name
  brcWRITEPROT               =   $0086;              // Workbook Is Write-Protected
  brcWSBOOL                  =   $0081;              // Additional Workspace Information
  brcXCT                     =   $0059;              // CRN Record Count
  brcXF                      =   $00E0;              // Extended Format
  brcXL5MODIFY               =   $0162;              // Flag for DSF

  { Biff reecord new codes  in excel 2000 }
  brcnCF                         =   $01B1;
  brcnCODENAME                   =   $01BA;
  brcnCONDFMT                    =   $11B0;
  brcnDCONBIN                    =   $11B5;
  brcnDSF                        =   $1161;
  brcnDV                         =   $11Be;
  brcnDVAL                       =   $11B2;
  brcnEXCEL9FILE                 =   $11C0;
  brcnEXTSST                     =   $01FF;
  brcnHLINK                      =   $11B8;
  brcnLABELSST                   =   $01FD;
  brcnMERGECELLS                 =   $01E5;
  brcnMSODRAWING                 =   $01Ec;
  brcnMSODRAWINGGROUP            =   $01Eb;
  brcnMSODRAWINGSELECTION        =   $01Ed;
  brcnPARAMQRY                   =   $01DC;
  brcnPROT4REV                   =   $11Af;
  brcnPROT4REVPASS               =   $01BC;
  brcnQSI                        =   $11Ad;
  brcnRECALCID                   =   $11C1;
  brcnREFRESHALL                 =   $11B7;
  brcnSST                        =   $01FC;
  brcnSUPBOOK                    =   $11Ae;
  brcnSXDB                       =   $01C6;
  brcnSXDBEX                     =   $1122;
  brcnSXEX                       =   $01F1;
  brcnSXFDBTYPE                  =   $11BB;
  brcnSXFILT                     =   $01F2;
  brcnSXFMLA                     =   $01F9;
  brcnSXFORMAT                   =   $01FB;
  brcnSXFORMULA                  =   $1103;
  brcnSXNAME                     =   $01F6;
  brcnSXPAIR                     =   $01F8;
  brcnSXRULE                     =   $01F0;
  brcnSXSELECT                   =   $01F7;
  brcnSXVDEX                     =   $1100;
  brcnTXO                        =   $11B6;
  brcnUSERBVIEW                  =   $11A9;
  brcnUSERSVIEWBEGIN             =   $11Aa;
  brcnUSERSVIEWEND               =   $11Ab;
  brcnUSESELFS                   =   $1160;
  brcnXL5MODIFY                  =   $1162;

  // microsoft excel formula ptg - tokens for parsed expression
  ptgExp       = $01;
  ptgTbl       = $02;
  ptgAdd       = $03;
  ptgSub       = $04;
  ptgMul       = $05;
  ptgDiv       = $06;
  ptgPower     = $07;
  ptgConcat    = $08;
  ptgLT        = $09;
  ptgLE        = $0A;
  ptgEQ        = $0B;
  ptgGE        = $0C;
  ptgGT        = $0D;
  ptgNE        = $0E;
  ptgIsect     = $0F;
  ptgUnion     = $10;
  ptgRange     = $11;
  ptgUplus     = $12;
  ptgUminus    = $13;
  ptgPercent   = $14;
  ptgParen     = $15;
  ptgMissArg   = $16;
  ptgStr       = $17;
  ptgExtend    = $18;
  ptgAttr      = $19;
  ptgSheet     = $1A;
  ptgEndSheet  = $1B;
  ptgErr       = $1C;
  ptgBool      = $1D;
  ptgInt       = $1E;
  ptgNum       = $1F;
  ptgArray     = $20;
  ptgFunc      = $21;
  ptgFuncVar   = $22;
  ptgName      = $23;
  ptgRef       = $24;
  ptgArea      = $25;
  ptgMemArea   = $26;
  ptgMemErr    = $27;
  ptgMemNoMem  = $28;
  ptgMemFunc   = $29;
  ptgRefErr    = $2A;
  ptgAreaErr   = $2B;
  ptgRefN      = $2C;
  ptgAreaN     = $2D;
  ptgMemAreaN  = $2E;
  ptgMemNoMemN = $2F;

  ptgNameX     = $39;
  ptgRef3d     = $3A;
  ptgArea3d    = $3B;
  ptgRefErr3d  = $3C;
  ptgAreaErr3d = $3D;

  ptgArrayV    = $40;
  ptgFuncV     = $41;
  ptgFuncVarV  = $42;
  ptgNameV     = $43;
  ptgRefV      = $44;
  ptgAreaV     = $45;
  ptgMemAreaV  = $46;
  ptgMemErrV   = $47;
  ptgMemNoMemV = $48;
  ptgMemFuncV  = $49;
  ptgRefErrV   = $4A;
  ptgAreaErrV  = $4B;
  ptgRefNV     = $4C;
  ptgAreaNV    = $4D;
  ptgMemAreaNV = $4E;
  ptgMemNoMemNV= $4F;

  ptgFuncCEV   = $58;
  ptgNameXV    = $59;
  ptgRef3dV    = $5A;
  ptgArea3dV   = $5B;
  ptgRefErr3dV = $5C;
  ptgAreaErr3dV= $5D;

  ptgArrayA    = $60;
  ptgFuncA     = $61;
  ptgFuncVarA  = $62;
  ptgNameA     = $63;
  ptgRefA      = $64;
  ptgAreaA     = $65;
  ptgMemAreaA  = $66;
  ptgMemErrA   = $67;
  ptgMemNoMemA = $68;
  ptgMemFuncA  = $69;
  ptgRefErrA   = $6A;
  ptgAreaErrA  = $6B;
  ptgRefNA     = $6C;
  ptgAreaNA    = $6D;
  ptgMemAreaNA = $6E;
  ptgMemNoMemNA= $6F;

  ptgFuncCEA   = $78;
  ptgNameXA    = $79;
  ptgRef3dA    = $7A;
  ptgArea3dA   = $7B;
  ptgRefErr3dA = $7C;
  ptgAreaErr3dA= $7D;

   DefaultXLSFunctions: array[0..80] of TcxExcelFuncDefinition =
   ((Token: 24;  Name: sxlfAbs; ParamsCount: 1), (Token: 99;  Name: sxlfAcos; ParamsCount: 1),
    (Token: 233; Name: sxlfAcosh; ParamsCount: 1), (Token: 36;  Name: sxlfAnd; ParamsCount: 1),
    (Token: 98;  Name: sxlfAsin; ParamsCount: 1), (Token: 232; Name: sxlfAsinh; ParamsCount: 1),
    (Token: 18;  Name: sxlfAtan; ParamsCount: 1), (Token: 97;  Name: sxlfAtan2; ParamsCount: 2),
    (Token: 234; Name: sxlfAtanh; ParamsCount: 1), (Token: 5;   Name: sxlfAverage; ParamsCount: 1),
    (Token: 361; Name: sxlfAverageA; ParamsCount: 1), (Token: 16;  Name: sxlfCos; ParamsCount: 1),
    (Token: 230; Name: sxlfCosh; ParamsCount: 1), (Token: 0;   Name: sxlfCount; ParamsCount: 1),
    (Token: 169; Name: sxlfCounta; ParamsCount: 1), (Token: 347; Name: sxlfCountblank; ParamsCount: 1),
    (Token: 346; Name: sxlfCountif; ParamsCount: 2), (Token: 65;  Name: sxlfDate; ParamsCount: 3),
    (Token: 67;  Name: sxlfDay; ParamsCount: 1), (Token: 13;  Name: sxlfDollar; ParamsCount: 1),
    (Token: 21;  Name: sxlfExp; ParamsCount: 1), (Token: 184; Name: sxlfFact; ParamsCount: 1),
    (Token: 25;  Name: sxlfInt; ParamsCount: 1), (Token: 1;   Name: sxlfIF; ParamsCount: 2),
    (Token: 22;  Name: sxlfLn; ParamsCount: 1), (Token: 109; Name: sxlfLog; ParamsCount: 1),
    (Token: 23;  Name: sxlfLog10; ParamsCount: 1), (Token: 7;   Name: sxlfMax; ParamsCount: 1),
    (Token: 6;   Name: sxlfMin; ParamsCount: 1), (Token: 39;  Name: sxlfMod; ParamsCount: 2),
    (Token: 68;  Name: sxlfMonth; ParamsCount: 1), (Token: 38;  Name: sxlfNot; ParamsCount: 1),
    (Token: 74;  Name: sxlfNow; ParamsCount: 0), (Token: 298; Name: sxlfOdd; ParamsCount: 1),
    (Token: 37;  Name: sxlfOr; ParamsCount: 1), (Token: 19;  Name: sxlfPi; ParamsCount: 0),
    (Token: 337; Name: sxlfPower; ParamsCount: 2), (Token: 342; Name: sxlfRadians; ParamsCount: 1),
    (Token: 63;  Name: sxlfRand; ParamsCount: 0), (Token: 27;  Name: sxlfRound; ParamsCount: 2),
    (Token: 213; Name: sxlfRounddown; ParamsCount: 2), (Token: 212; Name: sxlfRoundup; ParamsCount: 2),
    (Token: 26;  Name: sxlfSign; ParamsCount: 1), (Token: 15;  Name: sxlfSin; ParamsCount: 1),
    (Token: 229; Name: sxlfSinh; ParamsCount: 1), (Token: 20;  Name: sxlfSqrt; ParamsCount: 1),
    (Token: 4;   Name: sxlfSum; ParamsCount: 1), (Token: 321; Name: sxlfSumsq; ParamsCount: 1),
    (Token: 17;  Name: sxlfTan; ParamsCount: 1), (Token: 231; Name: sxlfTanh; ParamsCount: 1),
    (Token: 66;  Name: sxlfTime; ParamsCount: 3), (Token: 221; Name: sxlfToday; ParamsCount: 0),
    (Token: 197; Name: sxlfTrunc; ParamsCount: 1), (Token: 69;  Name: sxlfYear; ParamsCount: 1),
    (Token: 70;  Name: sxlfWeekDay; ParamsCount: 1), (Token: 35;  Name: sxlfFalse; ParamsCount: 0),
    (Token: 34;  Name: sxlfTrue; ParamsCount: 0), (Token: 118; Name: sxlfTrim; ParamsCount: 1),
    (Token: 279; Name: sxlfEven; ParamsCount: 1), (Token: 288; Name: sxlfCeiling; ParamsCount: 2),
    (Token: 285; Name: sxlfFloor; ParamsCount: 2), (Token: 336; Name: sxlfConcatenate; ParamsCount: 1),
    (Token: 343; Name: sxlfDegrees; ParamsCount: 1), (Token: 14;  Name: sxlfFixed; ParamsCount: 1),
    (Token: 71;  Name: sxlfHour; ParamsCount: 1), (Token: 72;  Name: sxlfMinute; ParamsCount: 1),
    (Token: 73;  Name: sxlfSecond; ParamsCount: 1), (Token: 198; Name: sxlfIsLogical; ParamsCount: 1),
    (Token: 126; Name: sxlfIsErr; ParamsCount: 1), (Token: 3;   Name: sxlfIsError; ParamsCount: 1),
    (Token: 190; Name: sxlfIsNonText; ParamsCount: 1), (Token: 129; Name: sxlfIsBlank; ParamsCount: 1),
    (Token: 2;   Name: sxlfIsNa; ParamsCount: 1), (Token: 128; Name: sxlfIsNumber; ParamsCount: 1),
    (Token: 127; Name: sxlfIsText; ParamsCount: 1), (Token: 32;  Name: sxlfLen; ParamsCount: 1),
    (Token: 115; Name: sxlfLeft; ParamsCount: 1), (Token: 116; Name: sxlfRight; ParamsCount: 1),
    (Token: 31;  Name: sxlfMid; ParamsCount: 3), (Token: 112; Name: sxlfLower; ParamsCount: 1),
    (Token: 113; Name: sxlfUpper; ParamsCount: 1));

  BOF: packed array[0..15] of Byte =
    ($00, $06, $05, $00, $bb, $0d, $cc, $07,
     $c9, $00, $00, $00, $06, $00, $00, $00);

  WINDOW1: packed array[0..17] of Byte =
    ($e0, $01, $69, $00, $cc, $42, $7f, $26, $38,
     $00, $00, $00, $00, $00, $01, $00, $58, $02);

  EOF_REC: packed array[0..1] of Word = (brcEOF, 0);

  DefaultStylesTable: packed array[0..16, 0..19] of Byte =
   (($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($01, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($01, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($02, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($02, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $f5, $ff, $20, $00, $00, $f4, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($00, $00, $00, $00, $01, $00, $20, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20),
    ($01, $00, $2b, $00, $f5, $ff, $20, $00, $00, $f8, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $20));

  DefaultFont: packed array[0..12] of Word =
   ($00C8, $0000, $7FFF, $0190, $0000, $0000, $0000,
    $0105, $0041, $0072, $0069, $0061, $006C);

  cxExcelStdColors: TcxExcelPalette =
    ($000000, $FFFFFF, $0000FF, $00FF00, $FF0000, $00FFFF, $FF00FF, $FFFF00,
     $000080, $008000, $800000, $008080, $800080, $808000, $C0C0C0, $808080,
     $FF9999, $663399, $CCFFFF, $FFFFCC, $660066, $8080FF, $CC6600, $FFCCCC,
     $800000, $FF00FF, $00FFFF, $FFFF00, $800080, $000080, $808000, $FF0000,
     $FFCC00, $FFFFCC, $CCFFCC, $99FFFF, $FFCC99, $CC99FF, $FF99CC, $99CCFF,
     $FF6633, $CCCC33, $00CC99, $00CCFF, $0099FF, $0066FF, $996666, $969696,
     $663300, $669933, $003300, $003333, $003399, $663399, $993333, $333333);

  ExcelColorIndexes: array[0..58] of Word =
    ($08, $3C, $3B, $3A, $38, $12, $3E, $3F, $10, $35, $13, $11, $15, $0C,
     $36, $17, $0A, $34, $32, $39, $31, $30, $14, $37, $0E, $33, $0D, $0B,
     $0F, $28, $3D, $16, $2D, $2F, $2B, $2A, $29, $2C, $2E, $09, $18, $19,
     $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23, $24, $25, $26, $27,
     $40, $41, $8000);

  ExcelDefaultFormats: array[0..$31] of string =
   ('Default', '0', '0.00', '#,##0', '#,##0.00', '_($#,##0_);($#,##0)',
    '_($#,##0_);[Red]($#,##0)', '_($#,##0.00_);($#,##0.00)', '_($#,##0.00_);[Red]($#,##0.00)',
    '0%', '0.00%', '0.00E+00', '# ?/?', '# ??/??', 'm/d/yy', 'd-mmm-y', 'd-mmm',
    'mmmm-yy', 'h:mm AM/PM', 'h:mm:ss AM/PM', 'h:mm', 'h:mm:SS', 'm/d/yy h:mm',
    '', '',  '',  '', '', '', '', '', '',  '', '', '', '', '', '(#,##0_);(#,##0)',
    '(#,##0_);[Red](#,##0)', '(#,##0.00_);(#,##0.00)', '(#,##0.00_);[Red](#,##0.00)',
    '_(* #,##0_);_(* (#,##0);_(* "-"_);_(@_)', '_($* #,##0_);_($* (#,##0);_($* "-"_);_(@_)',
    '_(* #,##0.00_);_(* (#,##0.00);_(* "-"??_);_(@_)', '_($* #,##0.00_);_($* (#,##0.00);_($* "-"??_);_(@_)',
    'mm:ss', '[h]:mm:ss', 'mm:ss.0', '# #0.0E+0', '@');

  IsUnicodeStr = $01;
  IsRichStr    = $08;
  cxSSDefaultColorValue = $41 - 8;

  DateTimeFormats: set of Byte =
    [$0E, $0F, $10, $11, $12, $13, $14, $15, $16, $2D, $2E, $2F, $A4, $A5];
  CurrencyFormats: set of Byte =
    [$5, $6, $7, $8, $2A, $2B, $2C];
  NumberFormats: set of Byte =
    [$1, $2, $3, $4, $9, $A, $B, $C, $D, $25, $26, $27, $28, $29, $30];

procedure CheckFormat(const Format: string; var Index: Word);
function FormatIsCurrency(const AIndex: Integer): Boolean; overload;
function FormatIsCurrency(const Format: string; var AIndex: Integer): Boolean; overload;
function FormatIsDateTime(const AIndex: Integer): Boolean; overload;
function FormatIsDateTime(const Format: string; var AIndex: Integer): Boolean; overload;
function FormatIsNumber(const AIndex: Integer): Boolean; overload;
function FormatIsNumber(const Format: string; var AIndex: Integer): Boolean; overload;
function FormatIsRegistered(const AIndex: Integer): Boolean;

function FuncArgByToken(const AToken: Integer; var ACount: Integer): Boolean;
function FuncDefByToken(const AToken: Integer): PcxExcelFuncDefinition;
function FuncDefByName(const AName: string): PcxExcelFuncDefinition;
function FuncNameByToken(const AToken: Integer; var AName: string): Boolean;
function RegisterFunction(const AName: string; const AToken, MinArgs: Integer): PcxExcelFuncDefinition;
function xlsSetColor(AColor: TColor; APalette: PcxExcelPalette; ADefault: Word): Word;

implementation

var
  RegisteredFunctions: array of  TcxExcelFuncDefinition;

procedure CheckFormat(const Format: string; var Index: Word);
var
  S: string;
  AIndex: Integer;
begin
  if Format = 'dd/mm/yy' then
    Index := $A4
  else
     if Format = 'dd\.mmmm\.yy' then
       Index := $A5
     else
     begin
       AIndex := Index;
       if (AIndex <> 0) or (AIndex <> $31) then
       try
         S := AnsiLowerCase(Format);
         if not (FormatIsDateTime(S, AIndex) or FormatIsCurrency(S, AIndex) or
            FormatIsNumber(S, AIndex)) then AIndex := 0;
       finally
         Index := AIndex;
       end;
     end;
end;

function FormatIsCurrency(const AIndex: Integer): Boolean;
begin
  Result :=  FormatIsRegistered(AIndex) and (AIndex in CurrencyFormats);
end;

function FormatIsCurrency(const Format: string; var AIndex: Integer): Boolean;
begin
  Result := FormatIsCurrency(AIndex);
  if not Result then
  begin
    Result := Pos('$', Format) <> 0;
    if Result then
      AIndex := $7;
  end;
end;

function FormatIsDateTime(const AIndex: Integer): Boolean;
begin
  Result :=  FormatIsRegistered(AIndex) and (AIndex in DateTimeFormats);
end;

function FormatIsDateTime(const Format: string; var AIndex: Integer): Boolean;
var
  HasDate, HasTime: Boolean;
  AFormat: string;
const
  Formats: array[0..3] of Integer = (0, $0E, $15, $16);
begin
  AFormat := AnsiLowerCase(Format);
  if (AIndex in [$A4, $A5]) then
    Result := ((AFormat = 'dd/mm/yy') or (AFormat = 'dd\.mmmm\.yy'))
  else
    Result := FormatIsDateTime(AIndex);
  if not Result then
  begin
    HasDate := ((Pos('d', AFormat) <> 0)) or
      (Pos('y', AFormat) <> 0) or (Pos('m', AFormat) <> 0);
    HasTime := (Pos('h', AFormat) <> 0) or ((Pos('s', AFormat) <> 0)) or
      (Pos('ms', AFormat) <> 0);
    Result := HasDate or HasTime;
    if Result then
      AIndex := Formats[Byte(HasDate) + Byte(HasTime) * 2];
  end;
end;

function FormatIsNumber(const AIndex: Integer): Boolean;
begin
  Result :=  FormatIsRegistered(AIndex) and (AIndex in NumberFormats);
end;

function FormatIsNumber(const Format: string; var AIndex: Integer): Boolean;

  function CheckValue(AChar: Char; FormatIndex: Byte): Boolean;
  begin
    Result := Pos(AChar, Format) <> 0;
    if Result then
      AIndex := FormatIndex;
  end;

begin
  Result := FormatIsNumber(AIndex) or CheckValue('%', $A) or CheckValue('e', $B) or
    CheckValue(',', $4) or CheckValue('.', $2) or CheckValue('0', 1);
end;

function FormatIsRegistered(const AIndex: Integer): Boolean;
begin
  Result := (AIndex > 0) and (AIndex < $31) or (AIndex = $A4) or (AIndex = $A5);
end;

function FuncArgByToken(const AToken: Integer; var ACount: Integer): Boolean;
var
  ADef: PcxExcelFuncDefinition;
begin
  ADef := FuncDefByToken(AToken);
  Result := ADef <> nil;
  if Result then
    ACount := ADef^.ParamsCount;
end;

function FuncDefByToken(const AToken: Integer): PcxExcelFuncDefinition;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to High(DefaultXLSFunctions) do
   if DefaultXLSFunctions[I].Token = AToken then
   begin
     Result := @DefaultXLSFunctions[I];
     Exit;
   end;
  for I := 0 to Length(RegisteredFunctions) - 1 do
   if RegisteredFunctions[I].Token = AToken then
   begin
     Result := @RegisteredFunctions[I];
     Exit;
   end;
end;

function FuncDefByName(const AName: string): PcxExcelFuncDefinition;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to High(DefaultXLSFunctions) do
   if AnsiCompareText(DefaultXLSFunctions[I].Name, AName) = 0 then
   begin
     Result := @DefaultXLSFunctions[I];
     Exit;
   end;
  for I := 0 to Length(RegisteredFunctions) - 1 do
   if AnsiCompareText(RegisteredFunctions[I].Name, AName) = 0 then
   begin
     Result := @RegisteredFunctions[I];
     Exit;
   end;
end;

function FuncNameByToken(const AToken: Integer; var AName: string): Boolean;
var
  ADef: PcxExcelFuncDefinition;
begin
  ADef := FuncDefByToken(AToken);
  Result := ADef <> nil;
  if Result then
    AName := ADef^.Name;
end;

function RegisterFunction(const AName: string; const AToken, MinArgs: Integer): PcxExcelFuncDefinition;
var
  ALen: Integer;
begin
  Result := nil;
  if (FuncDefByToken(AToken) = nil) and (FuncDefByName(AName) = nil) then
  begin
    ALen := Length(RegisteredFunctions);
    SetLength(RegisteredFunctions, ALen + 1);
    Result := @RegisteredFunctions[ALen];
    Result^.Name := AName;
    Result^.Token := AToken;
    Result^.ParamsCount := MinArgs;
    Result^.Definition := nil;
    Result^.Params := fpFixed;
  end;
end;

function xlsSetColor(AColor: TColor; APalette: PcxExcelPalette; ADefault: Word): Word;
var
  I: Integer;
begin
  if AColor = clWindow then
  begin
    Result := $41 - 8;
    Exit;
  end;
  Result := ADefault;
  AColor := ColorToRGB(AColor);
  for I :=  Low(APalette^) to High(APalette^) do
    if APalette^[I] = AColor then
    begin
      Result := I;
      Exit;
    end;
end;

end.
