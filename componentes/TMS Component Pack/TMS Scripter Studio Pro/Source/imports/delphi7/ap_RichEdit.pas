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
unit ap_RichEdit;

interface

uses
  Messages,
  Windows,
  RichEdit,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatRichEditLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TCharFormatAWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: Longint;
    FdwEffects: Longint;
    FyHeight: Longint;
    FyOffset: Longint;
    FcrTextColor: TColorRef;
    FbCharSet: Byte;
    FbPitchAndFamily: Byte;
  public
    constructor Create(ARecord: TCharFormatA);
    function ObjToRec: TCharFormatA;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: Longint read FdwMask write FdwMask;
    property dwEffects: Longint read FdwEffects write FdwEffects;
    property yHeight: Longint read FyHeight write FyHeight;
    property yOffset: Longint read FyOffset write FyOffset;
    property crTextColor: TColorRef read FcrTextColor write FcrTextColor;
    property bCharSet: Byte read FbCharSet write FbCharSet;
    property bPitchAndFamily: Byte read FbPitchAndFamily write FbPitchAndFamily;
  end;
  
  TCharFormatWWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: Longint;
    FdwEffects: Longint;
    FyHeight: Longint;
    FyOffset: Longint;
    FcrTextColor: TColorRef;
    FbCharSet: Byte;
    FbPitchAndFamily: Byte;
  public
    constructor Create(ARecord: TCharFormatW);
    function ObjToRec: TCharFormatW;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: Longint read FdwMask write FdwMask;
    property dwEffects: Longint read FdwEffects write FdwEffects;
    property yHeight: Longint read FyHeight write FyHeight;
    property yOffset: Longint read FyOffset write FyOffset;
    property crTextColor: TColorRef read FcrTextColor write FcrTextColor;
    property bCharSet: Byte read FbCharSet write FbCharSet;
    property bPitchAndFamily: Byte read FbPitchAndFamily write FbPitchAndFamily;
  end;
  
  _charrangeWrapper = class(TatRecordWrapper)
  private
    FcpMin: Longint;
    FcpMax: LongInt;
  public
    constructor Create(ARecord: _charrange);
    function ObjToRec: _charrange;
  published
    property cpMin: Longint read FcpMin write FcpMin;
    property cpMax: LongInt read FcpMax write FcpMax;
  end;
  
  TEXTRANGEAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TEXTRANGEA);
    function ObjToRec: TEXTRANGEA;
  published
  end;
  
  TEXTRANGEWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TEXTRANGEW);
    function ObjToRec: TEXTRANGEW;
  published
  end;
  
  _editstreamWrapper = class(TatRecordWrapper)
  private
    FdwCookie: Longint;
    FdwError: Longint;
  public
    constructor Create(ARecord: _editstream);
    function ObjToRec: _editstream;
  published
    property dwCookie: Longint read FdwCookie write FdwCookie;
    property dwError: Longint read FdwError write FdwError;
  end;
  
  FINDTEXTAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: FINDTEXTA);
    function ObjToRec: FINDTEXTA;
  published
  end;
  
  FINDTEXTWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: FINDTEXTW);
    function ObjToRec: FINDTEXTW;
  published
  end;
  
  FINDTEXTEXAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: FINDTEXTEXA);
    function ObjToRec: FINDTEXTEXA;
  published
  end;
  
  FINDTEXTEXWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: FINDTEXTEXW);
    function ObjToRec: FINDTEXTEXW;
  published
  end;
  
  _formatrangeWrapper = class(TatRecordWrapper)
  private
    Fhdc: HDC;
    FhdcTarget: HDC;
  public
    constructor Create(ARecord: _formatrange);
    function ObjToRec: _formatrange;
  published
    property hdc: HDC read Fhdc write Fhdc;
    property hdcTarget: HDC read FhdcTarget write FhdcTarget;
  end;
  
  _paraformatWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: DWORD;
    FwNumbering: Word;
    FwReserved: Word;
    FdxStartIndent: Longint;
    FdxRightIndent: Longint;
    FdxOffset: Longint;
    FwAlignment: Word;
    FcTabCount: Smallint;
  public
    constructor Create(ARecord: _paraformat);
    function ObjToRec: _paraformat;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: DWORD read FdwMask write FdwMask;
    property wNumbering: Word read FwNumbering write FwNumbering;
    property wReserved: Word read FwReserved write FwReserved;
    property dxStartIndent: Longint read FdxStartIndent write FdxStartIndent;
    property dxRightIndent: Longint read FdxRightIndent write FdxRightIndent;
    property dxOffset: Longint read FdxOffset write FdxOffset;
    property wAlignment: Word read FwAlignment write FwAlignment;
    property cTabCount: Smallint read FcTabCount write FcTabCount;
  end;
  
  CHARFORMAT2AWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: DWORD;
    FdwEffects: DWORD;
    FyHeight: Longint;
    FyOffset: Longint;
    FcrTextColor: TColorRef;
    FbCharSet: Byte;
    FbPitchAndFamily: Byte;
    FwWeight: Word;
    FsSpacing: Smallint;
    FcrBackColor: TColorRef;
    Flid: LCID;
    FdwReserved: DWORD;
    FsStyle: Smallint;
    FwKerning: Word;
    FbUnderlineType: Byte;
    FbAnimation: Byte;
    FbRevAuthor: Byte;
    FbReserved1: Byte;
  public
    constructor Create(ARecord: CHARFORMAT2A);
    function ObjToRec: CHARFORMAT2A;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwEffects: DWORD read FdwEffects write FdwEffects;
    property yHeight: Longint read FyHeight write FyHeight;
    property yOffset: Longint read FyOffset write FyOffset;
    property crTextColor: TColorRef read FcrTextColor write FcrTextColor;
    property bCharSet: Byte read FbCharSet write FbCharSet;
    property bPitchAndFamily: Byte read FbPitchAndFamily write FbPitchAndFamily;
    property wWeight: Word read FwWeight write FwWeight;
    property sSpacing: Smallint read FsSpacing write FsSpacing;
    property crBackColor: TColorRef read FcrBackColor write FcrBackColor;
    property lid: LCID read Flid write Flid;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
    property sStyle: Smallint read FsStyle write FsStyle;
    property wKerning: Word read FwKerning write FwKerning;
    property bUnderlineType: Byte read FbUnderlineType write FbUnderlineType;
    property bAnimation: Byte read FbAnimation write FbAnimation;
    property bRevAuthor: Byte read FbRevAuthor write FbRevAuthor;
    property bReserved1: Byte read FbReserved1 write FbReserved1;
  end;
  
  CHARFORMAT2WWrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: DWORD;
    FdwEffects: DWORD;
    FyHeight: Longint;
    FyOffset: Longint;
    FcrTextColor: TColorRef;
    FbCharSet: Byte;
    FbPitchAndFamily: Byte;
    FwWeight: Word;
    FsSpacing: Smallint;
    FcrBackColor: TColorRef;
    Flid: LCID;
    FdwReserved: DWORD;
    FsStyle: Smallint;
    FwKerning: Word;
    FbUnderlineType: Byte;
    FbAnimation: Byte;
    FbRevAuthor: Byte;
    FbReserved1: Byte;
  public
    constructor Create(ARecord: CHARFORMAT2W);
    function ObjToRec: CHARFORMAT2W;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: DWORD read FdwMask write FdwMask;
    property dwEffects: DWORD read FdwEffects write FdwEffects;
    property yHeight: Longint read FyHeight write FyHeight;
    property yOffset: Longint read FyOffset write FyOffset;
    property crTextColor: TColorRef read FcrTextColor write FcrTextColor;
    property bCharSet: Byte read FbCharSet write FbCharSet;
    property bPitchAndFamily: Byte read FbPitchAndFamily write FbPitchAndFamily;
    property wWeight: Word read FwWeight write FwWeight;
    property sSpacing: Smallint read FsSpacing write FsSpacing;
    property crBackColor: TColorRef read FcrBackColor write FcrBackColor;
    property lid: LCID read Flid write Flid;
    property dwReserved: DWORD read FdwReserved write FdwReserved;
    property sStyle: Smallint read FsStyle write FsStyle;
    property wKerning: Word read FwKerning write FwKerning;
    property bUnderlineType: Byte read FbUnderlineType write FbUnderlineType;
    property bAnimation: Byte read FbAnimation write FbAnimation;
    property bRevAuthor: Byte read FbRevAuthor write FbRevAuthor;
    property bReserved1: Byte read FbReserved1 write FbReserved1;
  end;
  
  PARAFORMAT2Wrapper = class(TatRecordWrapper)
  private
    FcbSize: UINT;
    FdwMask: DWORD;
    FwNumbering: Word;
    FwReserved: Word;
    FdxStartIndent: Longint;
    FdxRightIndent: Longint;
    FdxOffset: Longint;
    FwAlignment: Word;
    FcTabCount: Smallint;
    FdySpaceBefore: Longint;
    FdySpaceAfter: Longint;
    FdyLineSpacing: Longint;
    FsStyle: Smallint;
    FbLineSpacingRule: Byte;
    FbCRC: Byte;
    FwShadingWeight: Word;
    FwShadingStyle: Word;
    FwNumberingStart: Word;
    FwNumberingStyle: Word;
    FwNumberingTab: Word;
    FwBorderSpace: Word;
    FwBorderWidth: Word;
    FwBorders: Word;
  public
    constructor Create(ARecord: PARAFORMAT2);
    function ObjToRec: PARAFORMAT2;
  published
    property cbSize: UINT read FcbSize write FcbSize;
    property dwMask: DWORD read FdwMask write FdwMask;
    property wNumbering: Word read FwNumbering write FwNumbering;
    property wReserved: Word read FwReserved write FwReserved;
    property dxStartIndent: Longint read FdxStartIndent write FdxStartIndent;
    property dxRightIndent: Longint read FdxRightIndent write FdxRightIndent;
    property dxOffset: Longint read FdxOffset write FdxOffset;
    property wAlignment: Word read FwAlignment write FwAlignment;
    property cTabCount: Smallint read FcTabCount write FcTabCount;
    property dySpaceBefore: Longint read FdySpaceBefore write FdySpaceBefore;
    property dySpaceAfter: Longint read FdySpaceAfter write FdySpaceAfter;
    property dyLineSpacing: Longint read FdyLineSpacing write FdyLineSpacing;
    property sStyle: Smallint read FsStyle write FsStyle;
    property bLineSpacingRule: Byte read FbLineSpacingRule write FbLineSpacingRule;
    property bCRC: Byte read FbCRC write FbCRC;
    property wShadingWeight: Word read FwShadingWeight write FwShadingWeight;
    property wShadingStyle: Word read FwShadingStyle write FwShadingStyle;
    property wNumberingStart: Word read FwNumberingStart write FwNumberingStart;
    property wNumberingStyle: Word read FwNumberingStyle write FwNumberingStyle;
    property wNumberingTab: Word read FwNumberingTab write FwNumberingTab;
    property wBorderSpace: Word read FwBorderSpace write FwBorderSpace;
    property wBorderWidth: Word read FwBorderWidth write FwBorderWidth;
    property wBorders: Word read FwBorders write FwBorders;
  end;
  
  _msgfilterWrapper = class(TatRecordWrapper)
  private
    Fmsg: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: _msgfilter);
    function ObjToRec: _msgfilter;
  published
    property msg: UINT read Fmsg write Fmsg;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  TReqSizeWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TReqSize);
    function ObjToRec: TReqSize;
  published
  end;
  
  _selchangeWrapper = class(TatRecordWrapper)
  private
    Fseltyp: Word;
  public
    constructor Create(ARecord: _selchange);
    function ObjToRec: _selchange;
  published
    property seltyp: Word read Fseltyp write Fseltyp;
  end;
  
  TEndDropFilesWrapper = class(TatRecordWrapper)
  private
    FhDrop: THandle;
    Fcp: Longint;
    FfProtected: Bool;
  public
    constructor Create(ARecord: TEndDropFiles);
    function ObjToRec: TEndDropFiles;
  published
    property hDrop: THandle read FhDrop write FhDrop;
    property cp: Longint read Fcp write Fcp;
    property fProtected: Bool read FfProtected write FfProtected;
  end;
  
  _enprotectedWrapper = class(TatRecordWrapper)
  private
    Fmsg: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: _enprotected);
    function ObjToRec: _enprotected;
  published
    property msg: UINT read Fmsg write Fmsg;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  _ensaveclipboardWrapper = class(TatRecordWrapper)
  private
    FcObjectCount: Longint;
    Fcch: Longint;
  public
    constructor Create(ARecord: _ensaveclipboard);
    function ObjToRec: _ensaveclipboard;
  published
    property cObjectCount: Longint read FcObjectCount write FcObjectCount;
    property cch: Longint read Fcch write Fcch;
  end;
  
  ENOLEOPFAILEDWrapper = class(TatRecordWrapper)
  private
    Fiob: Longint;
    FlOper: Longint;
    Fhr: HRESULT;
  public
    constructor Create(ARecord: ENOLEOPFAILED);
    function ObjToRec: ENOLEOPFAILED;
  published
    property iob: Longint read Fiob write Fiob;
    property lOper: Longint read FlOper write FlOper;
    property hr: HRESULT read Fhr write Fhr;
  end;
  
  OBJECTPOSITIONSWrapper = class(TatRecordWrapper)
  private
    FcObjectCount: Longint;
  public
    constructor Create(ARecord: OBJECTPOSITIONS);
    function ObjToRec: OBJECTPOSITIONS;
  published
    property cObjectCount: Longint read FcObjectCount write FcObjectCount;
  end;
  
  ENLINKWrapper = class(TatRecordWrapper)
  private
    Fmsg: UINT;
    FwParam: WPARAM;
    FlParam: LPARAM;
  public
    constructor Create(ARecord: ENLINK);
    function ObjToRec: ENLINK;
  published
    property msg: UINT read Fmsg write Fmsg;
    property wParam: WPARAM read FwParam write FwParam;
    property lParam: LPARAM read FlParam write FlParam;
  end;
  
  _encorrecttextWrapper = class(TatRecordWrapper)
  private
    Fseltyp: Word;
  public
    constructor Create(ARecord: _encorrecttext);
    function ObjToRec: _encorrecttext;
  published
    property seltyp: Word read Fseltyp write Fseltyp;
  end;
  
  _punctuationWrapper = class(TatRecordWrapper)
  private
    FiSize: UINT;
  public
    constructor Create(ARecord: _punctuation);
    function ObjToRec: _punctuation;
  published
    property iSize: UINT read FiSize write FiSize;
  end;
  
  _compcolorWrapper = class(TatRecordWrapper)
  private
    FcrText: TColorRef;
    FcrBackground: TColorRef;
    FdwEffects: Longint;
  public
    constructor Create(ARecord: _compcolor);
    function ObjToRec: _compcolor;
  published
    property crText: TColorRef read FcrText write FcrText;
    property crBackground: TColorRef read FcrBackground write FcrBackground;
    property dwEffects: Longint read FdwEffects write FdwEffects;
  end;
  
  _repastespecialWrapper = class(TatRecordWrapper)
  private
    FdwAspect: DWORD;
    FdwParam: DWORD;
  public
    constructor Create(ARecord: _repastespecial);
    function ObjToRec: _repastespecial;
  published
    property dwAspect: DWORD read FdwAspect write FdwAspect;
    property dwParam: DWORD read FdwParam write FdwParam;
  end;
  
  GETTEXTEXWrapper = class(TatRecordWrapper)
  private
    Fcb: DWORD;
    Fflags: DWORD;
    Fcodepage: UINT;
  public
    constructor Create(ARecord: GETTEXTEX);
    function ObjToRec: GETTEXTEX;
  published
    property cb: DWORD read Fcb write Fcb;
    property flags: DWORD read Fflags write Fflags;
    property codepage: UINT read Fcodepage write Fcodepage;
  end;
  
  GETTEXTLENGTHEXWrapper = class(TatRecordWrapper)
  private
    Fflags: DWORD;
    Fcodepage: UINT;
  public
    constructor Create(ARecord: GETTEXTLENGTHEX);
    function ObjToRec: GETTEXTLENGTHEX;
  published
    property flags: DWORD read Fflags write Fflags;
    property codepage: UINT read Fcodepage write Fcodepage;
  end;
  

implementation

constructor TCharFormatAWrapper.Create(ARecord: TCharFormatA);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FdwEffects := ARecord.dwEffects;
  FyHeight := ARecord.yHeight;
  FyOffset := ARecord.yOffset;
  FcrTextColor := ARecord.crTextColor;
  FbCharSet := ARecord.bCharSet;
  FbPitchAndFamily := ARecord.bPitchAndFamily;
end;

function TCharFormatAWrapper.ObjToRec: TCharFormatA;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.dwEffects := FdwEffects;
  result.yHeight := FyHeight;
  result.yOffset := FyOffset;
  result.crTextColor := FcrTextColor;
  result.bCharSet := FbCharSet;
  result.bPitchAndFamily := FbPitchAndFamily;
end;

constructor TCharFormatWWrapper.Create(ARecord: TCharFormatW);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FdwEffects := ARecord.dwEffects;
  FyHeight := ARecord.yHeight;
  FyOffset := ARecord.yOffset;
  FcrTextColor := ARecord.crTextColor;
  FbCharSet := ARecord.bCharSet;
  FbPitchAndFamily := ARecord.bPitchAndFamily;
end;

function TCharFormatWWrapper.ObjToRec: TCharFormatW;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.dwEffects := FdwEffects;
  result.yHeight := FyHeight;
  result.yOffset := FyOffset;
  result.crTextColor := FcrTextColor;
  result.bCharSet := FbCharSet;
  result.bPitchAndFamily := FbPitchAndFamily;
end;

constructor _charrangeWrapper.Create(ARecord: _charrange);
begin
  inherited Create;
  FcpMin := ARecord.cpMin;
  FcpMax := ARecord.cpMax;
end;

function _charrangeWrapper.ObjToRec: _charrange;
begin
  result.cpMin := FcpMin;
  result.cpMax := FcpMax;
end;

constructor TEXTRANGEAWrapper.Create(ARecord: TEXTRANGEA);
begin
  inherited Create;
end;

function TEXTRANGEAWrapper.ObjToRec: TEXTRANGEA;
begin
end;

constructor TEXTRANGEWWrapper.Create(ARecord: TEXTRANGEW);
begin
  inherited Create;
end;

function TEXTRANGEWWrapper.ObjToRec: TEXTRANGEW;
begin
end;

constructor _editstreamWrapper.Create(ARecord: _editstream);
begin
  inherited Create;
  FdwCookie := ARecord.dwCookie;
  FdwError := ARecord.dwError;
end;

function _editstreamWrapper.ObjToRec: _editstream;
begin
  result.dwCookie := FdwCookie;
  result.dwError := FdwError;
end;

constructor FINDTEXTAWrapper.Create(ARecord: FINDTEXTA);
begin
  inherited Create;
end;

function FINDTEXTAWrapper.ObjToRec: FINDTEXTA;
begin
end;

constructor FINDTEXTWWrapper.Create(ARecord: FINDTEXTW);
begin
  inherited Create;
end;

function FINDTEXTWWrapper.ObjToRec: FINDTEXTW;
begin
end;

constructor FINDTEXTEXAWrapper.Create(ARecord: FINDTEXTEXA);
begin
  inherited Create;
end;

function FINDTEXTEXAWrapper.ObjToRec: FINDTEXTEXA;
begin
end;

constructor FINDTEXTEXWWrapper.Create(ARecord: FINDTEXTEXW);
begin
  inherited Create;
end;

function FINDTEXTEXWWrapper.ObjToRec: FINDTEXTEXW;
begin
end;

constructor _formatrangeWrapper.Create(ARecord: _formatrange);
begin
  inherited Create;
  Fhdc := ARecord.hdc;
  FhdcTarget := ARecord.hdcTarget;
end;

function _formatrangeWrapper.ObjToRec: _formatrange;
begin
  result.hdc := Fhdc;
  result.hdcTarget := FhdcTarget;
end;

constructor _paraformatWrapper.Create(ARecord: _paraformat);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FwNumbering := ARecord.wNumbering;
  FwReserved := ARecord.wReserved;
  FdxStartIndent := ARecord.dxStartIndent;
  FdxRightIndent := ARecord.dxRightIndent;
  FdxOffset := ARecord.dxOffset;
  FwAlignment := ARecord.wAlignment;
  FcTabCount := ARecord.cTabCount;
end;

function _paraformatWrapper.ObjToRec: _paraformat;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.wNumbering := FwNumbering;
  result.wReserved := FwReserved;
  result.dxStartIndent := FdxStartIndent;
  result.dxRightIndent := FdxRightIndent;
  result.dxOffset := FdxOffset;
  result.wAlignment := FwAlignment;
  result.cTabCount := FcTabCount;
end;

constructor CHARFORMAT2AWrapper.Create(ARecord: CHARFORMAT2A);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FdwEffects := ARecord.dwEffects;
  FyHeight := ARecord.yHeight;
  FyOffset := ARecord.yOffset;
  FcrTextColor := ARecord.crTextColor;
  FbCharSet := ARecord.bCharSet;
  FbPitchAndFamily := ARecord.bPitchAndFamily;
  FwWeight := ARecord.wWeight;
  FsSpacing := ARecord.sSpacing;
  FcrBackColor := ARecord.crBackColor;
  Flid := ARecord.lid;
  FdwReserved := ARecord.dwReserved;
  FsStyle := ARecord.sStyle;
  FwKerning := ARecord.wKerning;
  FbUnderlineType := ARecord.bUnderlineType;
  FbAnimation := ARecord.bAnimation;
  FbRevAuthor := ARecord.bRevAuthor;
  FbReserved1 := ARecord.bReserved1;
end;

function CHARFORMAT2AWrapper.ObjToRec: CHARFORMAT2A;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.dwEffects := FdwEffects;
  result.yHeight := FyHeight;
  result.yOffset := FyOffset;
  result.crTextColor := FcrTextColor;
  result.bCharSet := FbCharSet;
  result.bPitchAndFamily := FbPitchAndFamily;
  result.wWeight := FwWeight;
  result.sSpacing := FsSpacing;
  result.crBackColor := FcrBackColor;
  result.lid := Flid;
  result.dwReserved := FdwReserved;
  result.sStyle := FsStyle;
  result.wKerning := FwKerning;
  result.bUnderlineType := FbUnderlineType;
  result.bAnimation := FbAnimation;
  result.bRevAuthor := FbRevAuthor;
  result.bReserved1 := FbReserved1;
end;

constructor CHARFORMAT2WWrapper.Create(ARecord: CHARFORMAT2W);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FdwEffects := ARecord.dwEffects;
  FyHeight := ARecord.yHeight;
  FyOffset := ARecord.yOffset;
  FcrTextColor := ARecord.crTextColor;
  FbCharSet := ARecord.bCharSet;
  FbPitchAndFamily := ARecord.bPitchAndFamily;
  FwWeight := ARecord.wWeight;
  FsSpacing := ARecord.sSpacing;
  FcrBackColor := ARecord.crBackColor;
  Flid := ARecord.lid;
  FdwReserved := ARecord.dwReserved;
  FsStyle := ARecord.sStyle;
  FwKerning := ARecord.wKerning;
  FbUnderlineType := ARecord.bUnderlineType;
  FbAnimation := ARecord.bAnimation;
  FbRevAuthor := ARecord.bRevAuthor;
  FbReserved1 := ARecord.bReserved1;
end;

function CHARFORMAT2WWrapper.ObjToRec: CHARFORMAT2W;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.dwEffects := FdwEffects;
  result.yHeight := FyHeight;
  result.yOffset := FyOffset;
  result.crTextColor := FcrTextColor;
  result.bCharSet := FbCharSet;
  result.bPitchAndFamily := FbPitchAndFamily;
  result.wWeight := FwWeight;
  result.sSpacing := FsSpacing;
  result.crBackColor := FcrBackColor;
  result.lid := Flid;
  result.dwReserved := FdwReserved;
  result.sStyle := FsStyle;
  result.wKerning := FwKerning;
  result.bUnderlineType := FbUnderlineType;
  result.bAnimation := FbAnimation;
  result.bRevAuthor := FbRevAuthor;
  result.bReserved1 := FbReserved1;
end;

constructor PARAFORMAT2Wrapper.Create(ARecord: PARAFORMAT2);
begin
  inherited Create;
  FcbSize := ARecord.cbSize;
  FdwMask := ARecord.dwMask;
  FwNumbering := ARecord.wNumbering;
  FwReserved := ARecord.wReserved;
  FdxStartIndent := ARecord.dxStartIndent;
  FdxRightIndent := ARecord.dxRightIndent;
  FdxOffset := ARecord.dxOffset;
  FwAlignment := ARecord.wAlignment;
  FcTabCount := ARecord.cTabCount;
  FdySpaceBefore := ARecord.dySpaceBefore;
  FdySpaceAfter := ARecord.dySpaceAfter;
  FdyLineSpacing := ARecord.dyLineSpacing;
  FsStyle := ARecord.sStyle;
  FbLineSpacingRule := ARecord.bLineSpacingRule;
  FbCRC := ARecord.bCRC;
  FwShadingWeight := ARecord.wShadingWeight;
  FwShadingStyle := ARecord.wShadingStyle;
  FwNumberingStart := ARecord.wNumberingStart;
  FwNumberingStyle := ARecord.wNumberingStyle;
  FwNumberingTab := ARecord.wNumberingTab;
  FwBorderSpace := ARecord.wBorderSpace;
  FwBorderWidth := ARecord.wBorderWidth;
  FwBorders := ARecord.wBorders;
end;

function PARAFORMAT2Wrapper.ObjToRec: PARAFORMAT2;
begin
  result.cbSize := FcbSize;
  result.dwMask := FdwMask;
  result.wNumbering := FwNumbering;
  result.wReserved := FwReserved;
  result.dxStartIndent := FdxStartIndent;
  result.dxRightIndent := FdxRightIndent;
  result.dxOffset := FdxOffset;
  result.wAlignment := FwAlignment;
  result.cTabCount := FcTabCount;
  result.dySpaceBefore := FdySpaceBefore;
  result.dySpaceAfter := FdySpaceAfter;
  result.dyLineSpacing := FdyLineSpacing;
  result.sStyle := FsStyle;
  result.bLineSpacingRule := FbLineSpacingRule;
  result.bCRC := FbCRC;
  result.wShadingWeight := FwShadingWeight;
  result.wShadingStyle := FwShadingStyle;
  result.wNumberingStart := FwNumberingStart;
  result.wNumberingStyle := FwNumberingStyle;
  result.wNumberingTab := FwNumberingTab;
  result.wBorderSpace := FwBorderSpace;
  result.wBorderWidth := FwBorderWidth;
  result.wBorders := FwBorders;
end;

constructor _msgfilterWrapper.Create(ARecord: _msgfilter);
begin
  inherited Create;
  Fmsg := ARecord.msg;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
end;

function _msgfilterWrapper.ObjToRec: _msgfilter;
begin
  result.msg := Fmsg;
  result.wParam := FwParam;
  result.lParam := FlParam;
end;

constructor TReqSizeWrapper.Create(ARecord: TReqSize);
begin
  inherited Create;
end;

function TReqSizeWrapper.ObjToRec: TReqSize;
begin
end;

constructor _selchangeWrapper.Create(ARecord: _selchange);
begin
  inherited Create;
  Fseltyp := ARecord.seltyp;
end;

function _selchangeWrapper.ObjToRec: _selchange;
begin
  result.seltyp := Fseltyp;
end;

constructor TEndDropFilesWrapper.Create(ARecord: TEndDropFiles);
begin
  inherited Create;
  FhDrop := ARecord.hDrop;
  Fcp := ARecord.cp;
  FfProtected := ARecord.fProtected;
end;

function TEndDropFilesWrapper.ObjToRec: TEndDropFiles;
begin
  result.hDrop := FhDrop;
  result.cp := Fcp;
  result.fProtected := FfProtected;
end;

constructor _enprotectedWrapper.Create(ARecord: _enprotected);
begin
  inherited Create;
  Fmsg := ARecord.msg;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
end;

function _enprotectedWrapper.ObjToRec: _enprotected;
begin
  result.msg := Fmsg;
  result.wParam := FwParam;
  result.lParam := FlParam;
end;

constructor _ensaveclipboardWrapper.Create(ARecord: _ensaveclipboard);
begin
  inherited Create;
  FcObjectCount := ARecord.cObjectCount;
  Fcch := ARecord.cch;
end;

function _ensaveclipboardWrapper.ObjToRec: _ensaveclipboard;
begin
  result.cObjectCount := FcObjectCount;
  result.cch := Fcch;
end;

constructor ENOLEOPFAILEDWrapper.Create(ARecord: ENOLEOPFAILED);
begin
  inherited Create;
  Fiob := ARecord.iob;
  FlOper := ARecord.lOper;
  Fhr := ARecord.hr;
end;

function ENOLEOPFAILEDWrapper.ObjToRec: ENOLEOPFAILED;
begin
  result.iob := Fiob;
  result.lOper := FlOper;
  result.hr := Fhr;
end;

constructor OBJECTPOSITIONSWrapper.Create(ARecord: OBJECTPOSITIONS);
begin
  inherited Create;
  FcObjectCount := ARecord.cObjectCount;
end;

function OBJECTPOSITIONSWrapper.ObjToRec: OBJECTPOSITIONS;
begin
  result.cObjectCount := FcObjectCount;
end;

constructor ENLINKWrapper.Create(ARecord: ENLINK);
begin
  inherited Create;
  Fmsg := ARecord.msg;
  FwParam := ARecord.wParam;
  FlParam := ARecord.lParam;
end;

function ENLINKWrapper.ObjToRec: ENLINK;
begin
  result.msg := Fmsg;
  result.wParam := FwParam;
  result.lParam := FlParam;
end;

constructor _encorrecttextWrapper.Create(ARecord: _encorrecttext);
begin
  inherited Create;
  Fseltyp := ARecord.seltyp;
end;

function _encorrecttextWrapper.ObjToRec: _encorrecttext;
begin
  result.seltyp := Fseltyp;
end;

constructor _punctuationWrapper.Create(ARecord: _punctuation);
begin
  inherited Create;
  FiSize := ARecord.iSize;
end;

function _punctuationWrapper.ObjToRec: _punctuation;
begin
  result.iSize := FiSize;
end;

constructor _compcolorWrapper.Create(ARecord: _compcolor);
begin
  inherited Create;
  FcrText := ARecord.crText;
  FcrBackground := ARecord.crBackground;
  FdwEffects := ARecord.dwEffects;
end;

function _compcolorWrapper.ObjToRec: _compcolor;
begin
  result.crText := FcrText;
  result.crBackground := FcrBackground;
  result.dwEffects := FdwEffects;
end;

constructor _repastespecialWrapper.Create(ARecord: _repastespecial);
begin
  inherited Create;
  FdwAspect := ARecord.dwAspect;
  FdwParam := ARecord.dwParam;
end;

function _repastespecialWrapper.ObjToRec: _repastespecial;
begin
  result.dwAspect := FdwAspect;
  result.dwParam := FdwParam;
end;

constructor GETTEXTEXWrapper.Create(ARecord: GETTEXTEX);
begin
  inherited Create;
  Fcb := ARecord.cb;
  Fflags := ARecord.flags;
  Fcodepage := ARecord.codepage;
end;

function GETTEXTEXWrapper.ObjToRec: GETTEXTEX;
begin
  result.cb := Fcb;
  result.flags := Fflags;
  result.codepage := Fcodepage;
end;

constructor GETTEXTLENGTHEXWrapper.Create(ARecord: GETTEXTLENGTHEX);
begin
  inherited Create;
  Fflags := ARecord.flags;
  Fcodepage := ARecord.codepage;
end;

function GETTEXTLENGTHEXWrapper.ObjToRec: GETTEXTLENGTHEX;
begin
  result.flags := Fflags;
  result.codepage := Fcodepage;
end;



procedure TatRichEditLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('UID_UNKNOWN',UID_UNKNOWN);
    AddConstant('UID_TYPING',UID_TYPING);
    AddConstant('UID_DELETE',UID_DELETE);
    AddConstant('UID_DRAGDROP',UID_DRAGDROP);
    AddConstant('UID_CUT',UID_CUT);
    AddConstant('UID_PASTE',UID_PASTE);
    AddConstant('cchTextLimitDefault',cchTextLimitDefault);
    AddConstant('RICHEDIT_CLASSA',RICHEDIT_CLASSA);
    AddConstant('RICHEDIT_CLASSW',RICHEDIT_CLASSW);
    AddConstant('RICHEDIT_CLASS',RICHEDIT_CLASS);
    AddConstant('RICHEDIT_CLASS10A',RICHEDIT_CLASS10A);
    AddConstant('WM_CONTEXTMENU',WM_CONTEXTMENU);
    AddConstant('WM_PRINTCLIENT',WM_PRINTCLIENT);
    AddConstant('EM_GETLIMITTEXT',EM_GETLIMITTEXT);
    AddConstant('EM_SCROLLCARET',EM_SCROLLCARET);
    AddConstant('EM_CANPASTE',EM_CANPASTE);
    AddConstant('EM_DISPLAYBAND',EM_DISPLAYBAND);
    AddConstant('EM_EXGETSEL',EM_EXGETSEL);
    AddConstant('EM_EXLIMITTEXT',EM_EXLIMITTEXT);
    AddConstant('EM_EXLINEFROMCHAR',EM_EXLINEFROMCHAR);
    AddConstant('EM_EXSETSEL',EM_EXSETSEL);
    AddConstant('EM_FINDTEXT',EM_FINDTEXT);
    AddConstant('EM_FORMATRANGE',EM_FORMATRANGE);
    AddConstant('EM_GETCHARFORMAT',EM_GETCHARFORMAT);
    AddConstant('EM_GETEVENTMASK',EM_GETEVENTMASK);
    AddConstant('EM_GETOLEINTERFACE',EM_GETOLEINTERFACE);
    AddConstant('EM_GETPARAFORMAT',EM_GETPARAFORMAT);
    AddConstant('EM_GETSELTEXT',EM_GETSELTEXT);
    AddConstant('EM_HIDESELECTION',EM_HIDESELECTION);
    AddConstant('EM_PASTESPECIAL',EM_PASTESPECIAL);
    AddConstant('EM_REQUESTRESIZE',EM_REQUESTRESIZE);
    AddConstant('EM_SELECTIONTYPE',EM_SELECTIONTYPE);
    AddConstant('EM_SETBKGNDCOLOR',EM_SETBKGNDCOLOR);
    AddConstant('EM_SETCHARFORMAT',EM_SETCHARFORMAT);
    AddConstant('EM_SETEVENTMASK',EM_SETEVENTMASK);
    AddConstant('EM_SETOLECALLBACK',EM_SETOLECALLBACK);
    AddConstant('EM_SETPARAFORMAT',EM_SETPARAFORMAT);
    AddConstant('EM_SETTARGETDEVICE',EM_SETTARGETDEVICE);
    AddConstant('EM_STREAMIN',EM_STREAMIN);
    AddConstant('EM_STREAMOUT',EM_STREAMOUT);
    AddConstant('EM_GETTEXTRANGE',EM_GETTEXTRANGE);
    AddConstant('EM_FINDWORDBREAK',EM_FINDWORDBREAK);
    AddConstant('EM_SETOPTIONS',EM_SETOPTIONS);
    AddConstant('EM_GETOPTIONS',EM_GETOPTIONS);
    AddConstant('EM_FINDTEXTEX',EM_FINDTEXTEX);
    AddConstant('EM_GETWORDBREAKPROCEX',EM_GETWORDBREAKPROCEX);
    AddConstant('EM_SETWORDBREAKPROCEX',EM_SETWORDBREAKPROCEX);
    AddConstant('EM_SETUNDOLIMIT',EM_SETUNDOLIMIT);
    AddConstant('EM_REDO',EM_REDO);
    AddConstant('EM_CANREDO',EM_CANREDO);
    AddConstant('EM_GETUNDONAME',EM_GETUNDONAME);
    AddConstant('EM_GETREDONAME',EM_GETREDONAME);
    AddConstant('EM_STOPGROUPTYPING',EM_STOPGROUPTYPING);
    AddConstant('EM_SETTEXTMODE',EM_SETTEXTMODE);
    AddConstant('EM_GETTEXTMODE',EM_GETTEXTMODE);
    AddConstant('TM_PLAINTEXT',TM_PLAINTEXT);
    AddConstant('TM_RICHTEXT',TM_RICHTEXT);
    AddConstant('TM_SINGLELEVELUNDO',TM_SINGLELEVELUNDO);
    AddConstant('TM_MULTILEVELUNDO',TM_MULTILEVELUNDO);
    AddConstant('TM_SINGLECODEPAGE',TM_SINGLECODEPAGE);
    AddConstant('TM_MULTICODEPAGE',TM_MULTICODEPAGE);
    AddConstant('EM_AUTOURLDETECT',EM_AUTOURLDETECT);
    AddConstant('EM_GETAUTOURLDETECT',EM_GETAUTOURLDETECT);
    AddConstant('EM_SETPALETTE',EM_SETPALETTE);
    AddConstant('EM_GETTEXTEX',EM_GETTEXTEX);
    AddConstant('EM_GETTEXTLENGTHEX',EM_GETTEXTLENGTHEX);
    AddConstant('EM_SETPUNCTUATION',EM_SETPUNCTUATION);
    AddConstant('EM_GETPUNCTUATION',EM_GETPUNCTUATION);
    AddConstant('EM_SETWORDWRAPMODE',EM_SETWORDWRAPMODE);
    AddConstant('EM_GETWORDWRAPMODE',EM_GETWORDWRAPMODE);
    AddConstant('EM_SETIMECOLOR',EM_SETIMECOLOR);
    AddConstant('EM_GETIMECOLOR',EM_GETIMECOLOR);
    AddConstant('EM_SETIMEOPTIONS',EM_SETIMEOPTIONS);
    AddConstant('EM_GETIMEOPTIONS',EM_GETIMEOPTIONS);
    AddConstant('EM_CONVPOSITION',EM_CONVPOSITION);
    AddConstant('EM_SETLANGOPTIONS',EM_SETLANGOPTIONS);
    AddConstant('EM_GETLANGOPTIONS',EM_GETLANGOPTIONS);
    AddConstant('EM_GETIMECOMPMODE',EM_GETIMECOMPMODE);
    AddConstant('IMF_AUTOKEYBOARD',IMF_AUTOKEYBOARD);
    AddConstant('IMF_AUTOFONT',IMF_AUTOFONT);
    AddConstant('IMF_IMECANCELCOMPLETE',IMF_IMECANCELCOMPLETE);
    AddConstant('IMF_IMEALWAYSSENDNOTIFY',IMF_IMEALWAYSSENDNOTIFY);
    AddConstant('ICM_NOTOPEN',ICM_NOTOPEN);
    AddConstant('ICM_LEVEL3',ICM_LEVEL3);
    AddConstant('ICM_LEVEL2',ICM_LEVEL2);
    AddConstant('ICM_LEVEL2_5',ICM_LEVEL2_5);
    AddConstant('ICM_LEVEL2_SUI',ICM_LEVEL2_SUI);
    AddConstant('EN_MSGFILTER',EN_MSGFILTER);
    AddConstant('EN_REQUESTRESIZE',EN_REQUESTRESIZE);
    AddConstant('EN_SELCHANGE',EN_SELCHANGE);
    AddConstant('EN_DROPFILES',EN_DROPFILES);
    AddConstant('EN_PROTECTED',EN_PROTECTED);
    AddConstant('EN_CORRECTTEXT',EN_CORRECTTEXT);
    AddConstant('EN_STOPNOUNDO',EN_STOPNOUNDO);
    AddConstant('EN_IMECHANGE',EN_IMECHANGE);
    AddConstant('EN_SAVECLIPBOARD',EN_SAVECLIPBOARD);
    AddConstant('EN_OLEOPFAILED',EN_OLEOPFAILED);
    AddConstant('EN_OBJECTPOSITIONS',EN_OBJECTPOSITIONS);
    AddConstant('EN_LINK',EN_LINK);
    AddConstant('EN_DRAGDROPDONE',EN_DRAGDROPDONE);
    AddConstant('ENM_NONE',ENM_NONE);
    AddConstant('ENM_CHANGE',ENM_CHANGE);
    AddConstant('ENM_UPDATE',ENM_UPDATE);
    AddConstant('ENM_SCROLL',ENM_SCROLL);
    AddConstant('ENM_KEYEVENTS',ENM_KEYEVENTS);
    AddConstant('ENM_MOUSEEVENTS',ENM_MOUSEEVENTS);
    AddConstant('ENM_REQUESTRESIZE',ENM_REQUESTRESIZE);
    AddConstant('ENM_SELCHANGE',ENM_SELCHANGE);
    AddConstant('ENM_DROPFILES',ENM_DROPFILES);
    AddConstant('ENM_PROTECTED',ENM_PROTECTED);
    AddConstant('ENM_CORRECTTEXT',ENM_CORRECTTEXT);
    AddConstant('ENM_SCROLLEVENTS',ENM_SCROLLEVENTS);
    AddConstant('ENM_DRAGDROPDONE',ENM_DRAGDROPDONE);
    AddConstant('ENM_IMECHANGE',ENM_IMECHANGE);
    AddConstant('ENM_LANGCHANGE',ENM_LANGCHANGE);
    AddConstant('ENM_OBJECTPOSITIONS',ENM_OBJECTPOSITIONS);
    AddConstant('ENM_LINK',ENM_LINK);
    AddConstant('ES_SAVESEL',ES_SAVESEL);
    AddConstant('ES_SUNKEN',ES_SUNKEN);
    AddConstant('ES_DISABLENOSCROLL',ES_DISABLENOSCROLL);
    AddConstant('ES_SELECTIONBAR',ES_SELECTIONBAR);
    AddConstant('ES_NOOLEDRAGDROP',ES_NOOLEDRAGDROP);
    AddConstant('ES_EX_NOCALLOLEINIT',ES_EX_NOCALLOLEINIT);
    AddConstant('ES_VERTICAL',ES_VERTICAL);
    AddConstant('ES_NOIME',ES_NOIME);
    AddConstant('ES_SELFIME',ES_SELFIME);
    AddConstant('ECO_AUTOWORDSELECTION',ECO_AUTOWORDSELECTION);
    AddConstant('ECO_AUTOVSCROLL',ECO_AUTOVSCROLL);
    AddConstant('ECO_AUTOHSCROLL',ECO_AUTOHSCROLL);
    AddConstant('ECO_NOHIDESEL',ECO_NOHIDESEL);
    AddConstant('ECO_READONLY',ECO_READONLY);
    AddConstant('ECO_WANTRETURN',ECO_WANTRETURN);
    AddConstant('ECO_SAVESEL',ECO_SAVESEL);
    AddConstant('ECO_SELECTIONBAR',ECO_SELECTIONBAR);
    AddConstant('ECO_VERTICAL',ECO_VERTICAL);
    AddConstant('ECOOP_SET',ECOOP_SET);
    AddConstant('ECOOP_OR',ECOOP_OR);
    AddConstant('ECOOP_AND',ECOOP_AND);
    AddConstant('ECOOP_XOR',ECOOP_XOR);
    AddConstant('WB_CLASSIFY',WB_CLASSIFY);
    AddConstant('WB_MOVEWORDLEFT',WB_MOVEWORDLEFT);
    AddConstant('WB_MOVEWORDRIGHT',WB_MOVEWORDRIGHT);
    AddConstant('WB_LEFTBREAK',WB_LEFTBREAK);
    AddConstant('WB_RIGHTBREAK',WB_RIGHTBREAK);
    AddConstant('WB_MOVEWORDPREV',WB_MOVEWORDPREV);
    AddConstant('WB_MOVEWORDNEXT',WB_MOVEWORDNEXT);
    AddConstant('WB_PREVBREAK',WB_PREVBREAK);
    AddConstant('WB_NEXTBREAK',WB_NEXTBREAK);
    AddConstant('PC_FOLLOWING',PC_FOLLOWING);
    AddConstant('PC_LEADING',PC_LEADING);
    AddConstant('PC_OVERFLOW',PC_OVERFLOW);
    AddConstant('PC_DELIMITER',PC_DELIMITER);
    AddConstant('WBF_WORDWRAP',WBF_WORDWRAP);
    AddConstant('WBF_WORDBREAK',WBF_WORDBREAK);
    AddConstant('WBF_OVERFLOW',WBF_OVERFLOW);
    AddConstant('WBF_LEVEL1',WBF_LEVEL1);
    AddConstant('WBF_LEVEL2',WBF_LEVEL2);
    AddConstant('WBF_CUSTOM',WBF_CUSTOM);
    AddConstant('IMF_FORCENONE',IMF_FORCENONE);
    AddConstant('IMF_FORCEENABLE',IMF_FORCEENABLE);
    AddConstant('IMF_FORCEDISABLE',IMF_FORCEDISABLE);
    AddConstant('IMF_CLOSESTATUSWINDOW',IMF_CLOSESTATUSWINDOW);
    AddConstant('IMF_VERTICAL',IMF_VERTICAL);
    AddConstant('IMF_FORCEACTIVE',IMF_FORCEACTIVE);
    AddConstant('IMF_FORCEINACTIVE',IMF_FORCEINACTIVE);
    AddConstant('IMF_FORCEREMEMBER',IMF_FORCEREMEMBER);
    AddConstant('IMF_MULTIPLEEDIT',IMF_MULTIPLEEDIT);
    AddConstant('WBF_CLASS',WBF_CLASS);
    AddConstant('WBF_ISWHITE',WBF_ISWHITE);
    AddConstant('WBF_BREAKLINE',WBF_BREAKLINE);
    AddConstant('WBF_BREAKAFTER',WBF_BREAKAFTER);
    AddConstant('CFM_BOLD',CFM_BOLD);
    AddConstant('CFM_ITALIC',CFM_ITALIC);
    AddConstant('CFM_UNDERLINE',CFM_UNDERLINE);
    AddConstant('CFM_STRIKEOUT',CFM_STRIKEOUT);
    AddConstant('CFM_PROTECTED',CFM_PROTECTED);
    AddConstant('CFM_LINK',CFM_LINK);
    AddConstant('CFM_SIZE',CFM_SIZE);
    AddConstant('CFM_COLOR',CFM_COLOR);
    AddConstant('CFM_FACE',CFM_FACE);
    AddConstant('CFM_OFFSET',CFM_OFFSET);
    AddConstant('CFM_CHARSET',CFM_CHARSET);
    AddConstant('CFE_BOLD',CFE_BOLD);
    AddConstant('CFE_ITALIC',CFE_ITALIC);
    AddConstant('CFE_UNDERLINE',CFE_UNDERLINE);
    AddConstant('CFE_STRIKEOUT',CFE_STRIKEOUT);
    AddConstant('CFE_PROTECTED',CFE_PROTECTED);
    AddConstant('CFE_LINK',CFE_LINK);
    AddConstant('CFE_AUTOCOLOR',CFE_AUTOCOLOR);
    AddConstant('yHeightCharPtsMost',yHeightCharPtsMost);
    AddConstant('SCF_SELECTION',SCF_SELECTION);
    AddConstant('SCF_WORD',SCF_WORD);
    AddConstant('SCF_DEFAULT',SCF_DEFAULT);
    AddConstant('SCF_ALL',SCF_ALL);
    AddConstant('SCF_USEUIRULES',SCF_USEUIRULES);
    AddConstant('SF_TEXT',SF_TEXT);
    AddConstant('SF_RTF',SF_RTF);
    AddConstant('SF_RTFNOOBJS',SF_RTFNOOBJS);
    AddConstant('SF_TEXTIZED',SF_TEXTIZED);
    AddConstant('SF_UNICODE',SF_UNICODE);
    AddConstant('SFF_SELECTION',SFF_SELECTION);
    AddConstant('SFF_PLAINRTF',SFF_PLAINRTF);
    AddConstant('FT_MATCHCASE',FT_MATCHCASE);
    AddConstant('FT_WHOLEWORD',FT_WHOLEWORD);
    AddConstant('MAX_TAB_STOPS',MAX_TAB_STOPS);
    AddConstant('lDefaultTab',lDefaultTab);
    AddConstant('PFM_STARTINDENT',PFM_STARTINDENT);
    AddConstant('PFM_RIGHTINDENT',PFM_RIGHTINDENT);
    AddConstant('PFM_OFFSET',PFM_OFFSET);
    AddConstant('PFM_ALIGNMENT',PFM_ALIGNMENT);
    AddConstant('PFM_TABSTOPS',PFM_TABSTOPS);
    AddConstant('PFM_NUMBERING',PFM_NUMBERING);
    AddConstant('PFM_OFFSETINDENT',PFM_OFFSETINDENT);
    AddConstant('PFN_BULLET',PFN_BULLET);
    AddConstant('PFA_LEFT',PFA_LEFT);
    AddConstant('PFA_RIGHT',PFA_RIGHT);
    AddConstant('PFA_CENTER',PFA_CENTER);
    AddConstant('CFM_EFFECTS',CFM_EFFECTS);
    AddConstant('CFM_ALL',CFM_ALL);
    AddConstant('PFM_ALL',PFM_ALL);
    AddConstant('CFM_SMALLCAPS',CFM_SMALLCAPS);
    AddConstant('CFM_ALLCAPS',CFM_ALLCAPS);
    AddConstant('CFM_HIDDEN',CFM_HIDDEN);
    AddConstant('CFM_OUTLINE',CFM_OUTLINE);
    AddConstant('CFM_SHADOW',CFM_SHADOW);
    AddConstant('CFM_EMBOSS',CFM_EMBOSS);
    AddConstant('CFM_IMPRINT',CFM_IMPRINT);
    AddConstant('CFM_DISABLED',CFM_DISABLED);
    AddConstant('CFM_REVISED',CFM_REVISED);
    AddConstant('CFM_BACKCOLOR',CFM_BACKCOLOR);
    AddConstant('CFM_LCID',CFM_LCID);
    AddConstant('CFM_UNDERLINETYPE',CFM_UNDERLINETYPE);
    AddConstant('CFM_WEIGHT',CFM_WEIGHT);
    AddConstant('CFM_SPACING',CFM_SPACING);
    AddConstant('CFM_KERNING',CFM_KERNING);
    AddConstant('CFM_STYLE',CFM_STYLE);
    AddConstant('CFM_ANIMATION',CFM_ANIMATION);
    AddConstant('CFM_REVAUTHOR',CFM_REVAUTHOR);
    AddConstant('CFE_SUBSCRIPT',CFE_SUBSCRIPT);
    AddConstant('CFE_SUPERSCRIPT',CFE_SUPERSCRIPT);
    AddConstant('CFM_SUBSCRIPT',CFM_SUBSCRIPT);
    AddConstant('CFM_SUPERSCRIPT',CFM_SUPERSCRIPT);
    AddConstant('CFM_EFFECTS2',CFM_EFFECTS2);
    AddConstant('CFM_ALL2',CFM_ALL2);
    AddConstant('CFE_SMALLCAPS',CFE_SMALLCAPS);
    AddConstant('CFE_ALLCAPS',CFE_ALLCAPS);
    AddConstant('CFE_HIDDEN',CFE_HIDDEN);
    AddConstant('CFE_OUTLINE',CFE_OUTLINE);
    AddConstant('CFE_SHADOW',CFE_SHADOW);
    AddConstant('CFE_EMBOSS',CFE_EMBOSS);
    AddConstant('CFE_IMPRINT',CFE_IMPRINT);
    AddConstant('CFE_DISABLED',CFE_DISABLED);
    AddConstant('CFE_REVISED',CFE_REVISED);
    AddConstant('CFE_AUTOBACKCOLOR',CFE_AUTOBACKCOLOR);
    AddConstant('CFU_CF1UNDERLINE',CFU_CF1UNDERLINE);
    AddConstant('CFU_INVERT',CFU_INVERT);
    AddConstant('CFU_UNDERLINEDOTTED',CFU_UNDERLINEDOTTED);
    AddConstant('CFU_UNDERLINEDOUBLE',CFU_UNDERLINEDOUBLE);
    AddConstant('CFU_UNDERLINEWORD',CFU_UNDERLINEWORD);
    AddConstant('CFU_UNDERLINE',CFU_UNDERLINE);
    AddConstant('CFU_UNDERLINENONE',CFU_UNDERLINENONE);
    AddConstant('PFM_SPACEBEFORE',PFM_SPACEBEFORE);
    AddConstant('PFM_SPACEAFTER',PFM_SPACEAFTER);
    AddConstant('PFM_LINESPACING',PFM_LINESPACING);
    AddConstant('PFM_STYLE',PFM_STYLE);
    AddConstant('PFM_BORDER',PFM_BORDER);
    AddConstant('PFM_SHADING',PFM_SHADING);
    AddConstant('PFM_NUMBERINGSTYLE',PFM_NUMBERINGSTYLE);
    AddConstant('PFM_NUMBERINGTAB',PFM_NUMBERINGTAB);
    AddConstant('PFM_NUMBERINGSTART',PFM_NUMBERINGSTART);
    AddConstant('PFM_RTLPARA',PFM_RTLPARA);
    AddConstant('PFM_KEEP',PFM_KEEP);
    AddConstant('PFM_KEEPNEXT',PFM_KEEPNEXT);
    AddConstant('PFM_PAGEBREAKBEFORE',PFM_PAGEBREAKBEFORE);
    AddConstant('PFM_NOLINENUMBER',PFM_NOLINENUMBER);
    AddConstant('PFM_NOWIDOWCONTROL',PFM_NOWIDOWCONTROL);
    AddConstant('PFM_DONOTHYPHEN',PFM_DONOTHYPHEN);
    AddConstant('PFM_SIDEBYSIDE',PFM_SIDEBYSIDE);
    AddConstant('PFM_TABLE',PFM_TABLE);
    AddConstant('PFM_EFFECTS',PFM_EFFECTS);
    AddConstant('PFM_ALL2',PFM_ALL2);
    AddConstant('PFE_RTLPARA',PFE_RTLPARA);
    AddConstant('PFE_KEEP',PFE_KEEP);
    AddConstant('PFE_KEEPNEXT',PFE_KEEPNEXT);
    AddConstant('PFE_PAGEBREAKBEFORE',PFE_PAGEBREAKBEFORE);
    AddConstant('PFE_NOLINENUMBER',PFE_NOLINENUMBER);
    AddConstant('PFE_NOWIDOWCONTROL',PFE_NOWIDOWCONTROL);
    AddConstant('PFE_DONOTHYPHEN',PFE_DONOTHYPHEN);
    AddConstant('PFE_SIDEBYSIDE',PFE_SIDEBYSIDE);
    AddConstant('PFE_TABLEROW',PFE_TABLEROW);
    AddConstant('PFE_TABLECELLEND',PFE_TABLECELLEND);
    AddConstant('PFE_TABLECELL',PFE_TABLECELL);
    AddConstant('PFA_JUSTIFY',PFA_JUSTIFY);
    AddConstant('SEL_EMPTY',SEL_EMPTY);
    AddConstant('SEL_TEXT',SEL_TEXT);
    AddConstant('SEL_OBJECT',SEL_OBJECT);
    AddConstant('SEL_MULTICHAR',SEL_MULTICHAR);
    AddConstant('SEL_MULTIOBJECT',SEL_MULTIOBJECT);
    AddConstant('GCM_RIGHTMOUSEDROP',GCM_RIGHTMOUSEDROP);
    AddConstant('OLEOP_DOVERB',OLEOP_DOVERB);
    AddConstant('CF_RTF',CF_RTF);
    AddConstant('CF_RTFNOOBJS',CF_RTFNOOBJS);
    AddConstant('CF_RETEXTOBJ',CF_RETEXTOBJ);
    AddConstant('GT_DEFAULT',GT_DEFAULT);
    AddConstant('GT_USECRLF',GT_USECRLF);
    AddConstant('GTL_DEFAULT',GTL_DEFAULT);
    AddConstant('GTL_USECRLF',GTL_USECRLF);
    AddConstant('GTL_PRECISE',GTL_PRECISE);
    AddConstant('GTL_CLOSE',GTL_CLOSE);
    AddConstant('GTL_NUMCHARS',GTL_NUMCHARS);
    AddConstant('GTL_NUMBYTES',GTL_NUMBYTES);
    AddConstant('WCH_EMBEDDING',WCH_EMBEDDING);
  end;
end;

class function TatRichEditLibrary.LibraryName: string;
begin
  result := 'RichEdit';
end;

initialization
  RegisterScripterLibrary(TatRichEditLibrary, True);

{$WARNINGS ON}

end.

