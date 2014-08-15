{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSPDFExportCore;

interface

{$I cxVer.inc}
{$DEFINE DX_PDF_COMPRESS_STREAMS}

uses
  Windows, SysUtils, Classes,
{$IFDEF DX_PDF_COMPRESS_STREAMS}
  ZLib,
{$ENDIF}
{$IFDEF USEJPEGIMAGE}
  Jpeg,
{$ENDIF}
  Graphics, cxClasses, dxCore, cxGeometry, cxGraphics, dxPSPDFStrings, dxPSPDFCrypt;

const
  dxPDFCanCompressStreams = {$IFDEF DX_PDF_COMPRESS_STREAMS}True{$ELSE}False{$ENDIF};
  dxPDFCanUseJPEGCompression = {$IFDEF USEJPEGIMAGE}True{$ELSE}False{$ENDIF};
  sdxPDFExt = '.pdf';

type
  TdxPSPDFImage = class;
  TdxPSPDFFile = class;
  TdxPSPDFPage = class;
  TdxPSPDFLength = class;
  TdxPSPDFPageList = class;
  TdxPSPDFPatternList = class;
  TdxPSPDFCatalog = class;
  TdxPSPDFFontList = class;
  TdxPSPDFImageList = class;
  TdxPSPDFObjectList = class;
  TdxPSPDFCustomObject = class;
  TdxPSPDFCustomFont = class;
  TdxPSPDFResources = class;
  TdxPSPDFCustomPattern = class;
  TdxPSPDFEncryptCustomHelper = class;
  
  TdxPSPDFPageContentClipMode = (pcmAdd, pcmDiff);
  TdxPSPDFStreamEncoding = (pseFlate, pseDCT);
  TdxPSPDFStreamType = (pstText, pstImage);

  TdxPSPDFABCArray = array[Byte] of TABC;

  TdxPSPDFRect = packed record
    Left, Top, Right, Bottom: Double;
  end;

  TdxPSPDFPoint = packed record
    X, Y: Double;
  end;
  TdxPSPDFPointArray = array of TdxPSPDFPoint;

  EdxPSPDFException = class(EdxException);

  { TdxPSPDFWriter }

  TdxPSPDFWriter = class(TObject)
  private
    FCompressStreams: Boolean;
    FCurrentObject: TdxPSPDFCustomObject;
    FCurrentStream: TStream;
    FEncryptHelper: TdxPSPDFEncryptCustomHelper;
    FJPEGQuality: Integer;
    FObjectsOffsets: TList;
    FStream: TStream;
    FTempBufferStream: TMemoryStream;
    FUseJPEGCompression: Boolean;
    procedure AddObjectOffset(AOffset: Integer);
  protected
    Catalog, DocumentInfo, EncryptInfo: TdxPSPDFCustomObject;
    procedure BeginDocument;
    procedure BeginObject(AObject: TdxPSPDFCustomObject);
    procedure BeginStream(AStreamType: TdxPSPDFStreamType);
    procedure EndDocument;
    procedure EndObject;
    procedure EndStream;
    procedure WriteStreamHeader(AStreamType: TdxPSPDFStreamType);
    procedure WriteTrailerSection;
    procedure WriteXRefSection;
    //
    property CompressStreams: Boolean read FCompressStreams;
    property EncryptHelper: TdxPSPDFEncryptCustomHelper read FEncryptHelper;
    property JPEGQuality: Integer read FJPEGQuality;
    property ObjectsOffsets: TList read FObjectsOffsets;
    property Stream: TStream read FStream;
    property TempBufferStream: TMemoryStream read FTempBufferStream;
    property UseJPEGCompression: Boolean read FUseJPEGCompression;
  public
    constructor Create(AStream: TStream; AEncryptHelper: TdxPSPDFEncryptCustomHelper;
      ACompressStreams, AUseJPEGCompression: Boolean; AJPEGQuality: Integer); virtual;
    destructor Destroy; override;
    function EncodeString(const S: string; AHexArray: Boolean = True): string;
    function GetStreamEncoding(AStreamType: TdxPSPDFStreamType): TdxPSPDFStreamEncoding;
    function MakeLinkToObject(AObject: TdxPSPDFCustomObject): string;
    procedure BeginParamsSet;
    procedure EndParamsSet;
    procedure WriteBitmap(ABitmap: TBitmap);
    procedure WriteStream(AStream: TStream);
    procedure WriteString(const S: string; AWriteCrLf: Boolean = True);
    //
    property CurrentObject: TdxPSPDFCustomObject read FCurrentObject;
    property CurrentStream: TStream read FCurrentStream;
  end;

  { TdxPSPDFCustomObject }

  TdxPSPDFCustomObject = class(TObject)
  private
    FContentStreamLength: TdxPSPDFLength;
    FIndex: Integer;
  protected
    function GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean; virtual;
    procedure BeginSave(AWriter: TdxPSPDFWriter); virtual;
    procedure EndSave(AWriter: TdxPSPDFWriter); virtual;
    procedure WriteContentStream(AWriter: TdxPSPDFWriter); virtual;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); virtual;
    //
    property Index: Integer read FIndex write FIndex;
  public
    destructor Destroy; override;
    procedure PopulateExportList(AList: TdxPSPDFObjectList); virtual;
    procedure SaveTo(AWriter: TdxPSPDFWriter); virtual;
  end;

  { TdxPSPDFObject }

  TdxPSPDFObject = class(TdxPSPDFCustomObject)
  protected
    class function GetSubType: string; virtual;
    class function GetType: string; virtual;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  end;

  { TdxPSPDFDocumentInfo }

  TdxPSPDFDocumentInfo = class(TdxPSPDFCustomObject)
  private
    FAuthor: string;
    FCreator: string;
    FKeywords: string;
    FProducer: string;
    FSubject: string;
    FTitle: string;
  protected
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  public
    property Author: string read FAuthor write FAuthor;
    property Creator: string read FCreator write FCreator;
    property Keywords: string read FKeywords write FKeywords;
    property Producer: string read FProducer write FProducer;
    property Subject: string read FSubject write FSubject;
    property Title: string read FTitle write FTitle;
  end;

  { TdxPSPDFObjectList }

  TdxPSPDFObjectList = class(TcxObjectList)
  private
    function GetItem(Index: Integer): TdxPSPDFCustomObject;
  public
    procedure PopulateExportList(AList: TdxPSPDFObjectList); virtual;
    procedure SaveTo(AWriter: TdxPSPDFWriter);
    //
    property Items[Index: Integer]: TdxPSPDFCustomObject read GetItem;
  end;

  { TdxPSPDFPageContent }

  TdxPSPDFPageContent = class(TdxPSPDFCustomObject)
  private
    FContentData: TMemoryStream;
    FFont: TdxPSPDFCustomFont;
    FFontColor: TColor;
    FFontSize: Double;
    FForeColor: TColor;
    FParent: TdxPSPDFPage;
    function GetPageHeight: Integer;
    function GetPageWidth: Integer;
    function GetPatternList: TdxPSPDFPatternList;
    procedure SetFontColor(AValue: TColor);
  protected
    function AddBitmap(ABitmap: TBitmap): Integer;
    function CreateBitmap(AGraphic: TGraphic; var ANeedDestroy: Boolean): TBitmap;
    function GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean; override;
    procedure AppendScript(const S: string);
    procedure ApplyFontStyle(const AStyle: TFontStyles; R: TdxPSPDFRect; X, Y: Double);
    procedure SelectFont(AFont: TdxPSPDFCustomFont);
    procedure WriteContentStream(AWriter: TdxPSPDFWriter); override;
    procedure WriteRotationParams(ARotationAngle: Double;
      var R: TdxPSPDFRect; out X, Y: Double); virtual;
    procedure WriteText(X, Y: Double; const AText: WideString); virtual;
    //
    property ForeColor: TColor read FForeColor;
  public
    constructor Create(APage: TdxPSPDFPage); virtual;
    destructor Destroy; override;
    //
    procedure ApplyClipping(AClipMode: TdxPSPDFPageContentClipMode = pcmAdd); virtual;
    procedure AdjustFontSize(const AText: WideString; ATextWidth: Double); virtual;
    procedure Concat(A1, A2, A3, A4: Double; AOffsetX, AOffsetY: Double); virtual;
    function CheckColor(var AColor: TColor): Boolean;
    procedure CurveTo(X1, Y1, X2, Y2, X3, Y3: Double); virtual;
    procedure DrawGraphic(const R: TdxPSPDFRect; AGraphic: TGraphic); virtual;
    procedure DrawFrame(const R: TdxPSPDFRect; ABorderWidth: Double;
      ABorderColor: TColor; ABorders: TcxBorders); overload; virtual;
    procedure DrawFrame(const R: TdxPSPDFRect; ABorderWidth: Double;
      ATopLeftBorderColor, ARightBottomBorderColor: TColor; ABorders: TcxBorders); overload; virtual;
    procedure DrawText(const AClipRect, ATextRect: TdxPSPDFRect;
      const AText: WideString; ARotateAngle: Double = 0;
      ACharsSpacing: Double = 0; AWordSpacing: Double = 0);
    procedure Fill;
    procedure FillPolygon(AColor: TColor = clDefault;
      ABackgroundColor: TColor = clNone; AFillMode: Integer = ALTERNATE);
    procedure FillRect(const R: TdxPSPDFRect; AColor: TColor = clDefault);
    procedure FillRectByBrush(const R: TdxPSPDFRect; AColor: TColor; AStyle: TBrushStyle = bsSolid);
    procedure FillRectByGraphic(const R: TdxPSPDFRect; AWidth, AHeight: Double; AGraphic: TGraphic);
    procedure FillRectByPattern(const R: TdxPSPDFRect; APattern: TdxPSPDFCustomPattern);
    procedure LineTo(const P: TdxPSPDFPoint); overload;
    procedure LineTo(X, Y: Double); overload;
    procedure MoveTo(const P: TdxPSPDFPoint); overload;
    procedure MoveTo(X, Y: Double); overload;
    procedure Pie(const R: TdxPSPDFRect; const APoint1, APoint2: TdxPSPDFPoint; AColor: TColor);
    procedure Polyline(const APoints: TdxPSPDFPointArray;
      ALineWidth: Double; AColor: TColor = clDefault);
    procedure Polygon(const APoints: TdxPSPDFPointArray; ALineWidth: Double;
      AColor: TColor = clDefault; ABackgroundColor: TColor = clNone;
      AFillMode: Integer = ALTERNATE);
    procedure SelectBackColor(AColor: TColor);
    procedure SelectClipRect(const R: TdxPSPDFRect); virtual;
    procedure SelectClipRegion(ARegion: HRGN; AScaleFactor: Double); virtual;
    procedure SelectForeColor(AColor: TColor);
    procedure SelectLineWidth(ALineWidth: Double);
    function TextWidth(const AText: WideString): Double; virtual;
    procedure WriteEllipse(const R: TdxPSPDFRect);
    procedure WritePie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
    procedure WritePoints(const APoints: TdxPSPDFPointArray);
    procedure WriteRectangle(const R: TdxPSPDFRect);
    procedure WriteRoundRect(const R: TdxPSPDFRect; AEllipseWidth, AEllipseHeight: Double);
    //
    procedure RestoreGraphicState;
    procedure SaveGraphicState;
    //
    property Font: TdxPSPDFCustomFont read FFont write FFont;
    property FontColor: TColor read FFontColor write SetFontColor;
    property FontSize: Double read FFontSize write FFontSize;
    property PageHeight: Integer read GetPageHeight;
    property PageWidth: Integer read GetPageWidth;
    property Parent: TdxPSPDFPage read FParent;
    property PatternList: TdxPSPDFPatternList read GetPatternList;
  end;

  { TdxPSPDFPage }

  TdxPSPDFPage = class(TdxPSPDFObject)
  private
    FContent: TdxPSPDFPageContent;
    FPageHeight: Integer;
    FPageWidth: Integer;
    FParent: TdxPSPDFPageList;
    function GetPageBounds: TRect;
    function GetPageResources: TdxPSPDFResources;
  protected
    class function GetType: string; override;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  public
    constructor Create(AParent: TdxPSPDFPageList);
    destructor Destroy; override;
    procedure PopulateExportList(AList: TdxPSPDFObjectList); override;
    //
    property Content: TdxPSPDFPageContent read FContent;
    property PageBounds: TRect read GetPageBounds;
    property PageHeight: Integer read FPageHeight write FPageHeight;
    property PageResources: TdxPSPDFResources read GetPageResources;
    property PageWidth: Integer read FPageWidth write FPageWidth;
    property Parent: TdxPSPDFPageList read FParent;
  end;

  { TdxPSPDFCustomPattern }

  TdxPSPDFCustomPattern = class(TdxPSPDFObject)
  private
    FOwner: TdxPSPDFPatternList;
    FPatternHeight: Double;
    FPatternWidth: Double;
    function GetName: string;
    function GetPatternIndex: Integer;
  protected
    class function GetType: string; override;
    function GetContentData: string; virtual;
    function GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean; override;
    procedure WriteContentStream(AWriter: TdxPSPDFWriter); override;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
    procedure WritePatternResources(AWriter: TdxPSPDFWriter); virtual;
  public
    constructor Create(AOwner: TdxPSPDFPatternList; APatternWidth, APatternHeight: Double);
    function Compare(APattern: TdxPSPDFCustomPattern): Boolean; virtual;
    //
    property ContentData: string read GetContentData;
    property Name: string read GetName;
    property Owner: TdxPSPDFPatternList read FOwner;
    property PatternHeight: Double read FPatternHeight;
    property PatternIndex: Integer read GetPatternIndex;
    property PatternWidth: Double read FPatternWidth;
  end;

  { TdxPSPDFBrushPattern }

  TdxPSPDFBrushPattern = class(TdxPSPDFCustomPattern)
  private
    FColor: TColor;
    FStyle: TBrushStyle;
  public
    function GetContentData: string; override;
  public
    constructor Create(AOwner: TdxPSPDFPatternList; AStyle: TBrushStyle; AColor: TColor);
    function Compare(APattern: TdxPSPDFCustomPattern): Boolean; override;
    //
    property Color: TColor read FColor;
    property Style: TBrushStyle read FStyle;
  end;

  { TdxPSPDFImagePattern }

  TdxPSPDFImagePattern = class(TdxPSPDFCustomPattern)
  private
    FImageIndex: Integer;
    function GetImage: TdxPSPDFImage;
  protected
    function GetContentData: string; override;
    procedure WritePatternResources(AWriter: TdxPSPDFWriter); override;
  public
    constructor Create(AOwner: TdxPSPDFPatternList;
      APatternWidth, APatternHeight: Double; AImageIndex: Integer);
    function Compare(APattern: TdxPSPDFCustomPattern): Boolean; override;
    //
    property Image: TdxPSPDFImage read GetImage;
    property ImageIndex: Integer read FImageIndex;
  end;

  { TdxPSPDFPatternList }

  TdxPSPDFPatternList = class(TdxPSPDFObjectList)
  private
    FResources: TdxPSPDFResources;
    function GetItem(Index: Integer): TdxPSPDFCustomPattern;
  public
    constructor Create(AResources: TdxPSPDFResources); virtual;
    function AddPattern(ABrushStyle: TBrushStyle; AColor: TColor): TdxPSPDFCustomPattern; overload;
    function AddPattern(AImageIndex: Integer;
      APatternWidth, APatternHeight: Double): TdxPSPDFCustomPattern; overload;
    function AddPattern(APattern: TdxPSPDFCustomPattern): TdxPSPDFCustomPattern; overload;
    function FindPattern(APattern: TdxPSPDFCustomPattern): Integer; virtual;
    //
    property Items[Index: Integer]: TdxPSPDFCustomPattern read GetItem; default;
    property Resources: TdxPSPDFResources read FResources;
  end;

  { TdxPSPDFPageList }

  TdxPSPDFPageList = class(TdxPSPDFObject)
  private
    FCatalog: TdxPSPDFCatalog;
    FList: TdxPSPDFObjectList;
    function GetPage(Index: Integer): TdxPSPDFPage;
    function GetPageCount: Integer;
  protected
    class function GetType: string; override;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  public
    constructor Create(ACatalog: TdxPSPDFCatalog); virtual;
    destructor Destroy; override;
    function AddPage: TdxPSPDFPage;
    procedure Clear;
    procedure PopulateExportList(AList: TdxPSPDFObjectList); override;
    //
    property Catalog: TdxPSPDFCatalog read FCatalog;
    property Page[Index: Integer]: TdxPSPDFPage read GetPage;
    property PageCount: Integer read GetPageCount;
  end;

  { TdxPSPDFResources }

  TdxPSPDFResources = class(TdxPSPDFCustomObject)
  private
    FCatalog: TdxPSPDFCatalog;
    FFontList: TdxPSPDFFontList;
    FImageList: TdxPSPDFImageList;
    FPatterns: TdxPSPDFPatternList;
  protected
    function GetUsedFontsLinks(AWriter: TdxPSPDFWriter): string;
    function GetUsedImageLinks(AWriter: TdxPSPDFWriter): string;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
    procedure WritePatternsHeader(AWriter: TdxPSPDFWriter);
  public
    constructor Create(ACatalog: TdxPSPDFCatalog); virtual;
    destructor Destroy; override;
    function AddBitmap(ABitmap: TBitmap): Integer;
    procedure Clear;
    procedure PopulateExportList(AList: TdxPSPDFObjectList); override;
    //
    property Catalog: TdxPSPDFCatalog read FCatalog;
    property FontList: TdxPSPDFFontList read FFontList;
    property ImageList: TdxPSPDFImageList read FImageList;
    property Patterns: TdxPSPDFPatternList read FPatterns;
  end;

  { TdxPSPDFCatalog }

  TdxPSPDFCatalog = class(TdxPSPDFObject)
  private
    FPageList: TdxPSPDFPageList;
    FParent: TdxPSPDFFile;
    FResources: TdxPSPDFResources;
  protected
    class function GetType: string; override;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  public
    constructor Create(AParent: TdxPSPDFFile); virtual;
    destructor Destroy; override;
    procedure Clear;
    procedure PopulateExportList(AList: TdxPSPDFObjectList); override;
    //
    property PageList: TdxPSPDFPageList read FPageList;
    property Parent: TdxPSPDFFile read FParent;
    property Resources: TdxPSPDFResources read FResources;
  end;

  { TdxPSPDFCustomFont }

  TdxPSPDFCustomFont = class(TdxPSPDFObject)
  private
    FCharset: Integer;
    FEmbed: Boolean;
    FFamilyName: string;
    FFontIndex: Integer;
    FOwner: TdxPSPDFFontList;
    FStyle: TFontStyles;
    FUsed: Boolean;
    function GetCodePage: Integer;
    function GetName: string;
  protected
    class function GetType: string; override;
    function GetFontCharset(AFont: TFont): Integer; 
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
    //
    property Used: Boolean read FUsed write FUsed;
  public
    constructor Create(AOwner: TdxPSPDFFontList; AEmbed: Boolean; AFont: TFont); virtual;
    function Compare(AFont: TFont): Boolean; virtual;
    function CreateFont: TFont; virtual;
    function EncodeFontName: string; virtual;
    function EncodeText(const S: WideString): AnsiString; virtual; abstract;
    function TextWidth(const S: WideString): Integer; virtual; abstract;
    //
    property Charset: Integer read FCharset;
    property CodePage: Integer read GetCodePage;
    property Embed: Boolean read FEmbed;
    property FamilyName: string read FFamilyName;
    property FontIndex: Integer read FFontIndex;
    property Name: string read GetName;
    property Owner: TdxPSPDFFontList read FOwner;
    property Style: TFontStyles read FStyle;
  end;

  TdxPSPDFCustomFontClass = class of TdxPSPDFCustomFont;

  { TdxPSPDFFontList }

  TdxPSPDFFontList = class(TdxPSPDFObjectList)
  private
    function GetItem(Index: Integer): TdxPSPDFCustomFont;
  public
    function Add(AFont: TFont; ACanUseCID, AEmbedFont: Boolean): Integer;
    function FindFont(AFont: TFont): Integer;
    procedure RemoveUnusedFonts;
    //
    property Items[Index: Integer]: TdxPSPDFCustomFont read GetItem;
  end;

  { TdxPSPDFLength }

  TdxPSPDFLength = class(TdxPSPDFCustomObject)
  private
    FLength: Integer;
  public
    procedure SaveTo(AWriter: TdxPSPDFWriter); override;
    //
    property Length: Integer read FLength write FLength;
  end;

  { TdxPSPDFImage }

  TdxPSPDFImage = class(TdxPSPDFObject)
  private
    FBitmap: TBitmap;
    FOwner: TdxPSPDFImageList;
    function GetImageIndex: Integer;
    function GetName: string;
  protected
    class function GetSubType: string; override;
    class function GetType: string; override;
    function GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean; override;
    procedure WriteContentStream(AWriter: TdxPSPDFWriter); override;
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  public
    constructor Create(AOwner: TdxPSPDFImageList; ABitmap: TBitmap); virtual;
    destructor Destroy; override;
    function Compare(ABitmap: TBitmap): Boolean;
    //
    property Bitmap: TBitmap read FBitmap;
    property ImageIndex: Integer read GetImageIndex;
    property Name: string read GetName;
    property Owner: TdxPSPDFImageList read FOwner;
  end;

  { TdxPSPDFImageList }

  TdxPSPDFImageList = class(TdxPSPDFObjectList)
  private
    function GetItem(Index: Integer): TdxPSPDFImage;
  public
    function AddBitmap(ABitmap: TBitmap): Integer;
    function FindBitmap(ABitmap: TBitmap): Integer;
    //
    property Items[Index: Integer]: TdxPSPDFImage read GetItem; 
  end;

  TdxPSPDFDocumentAction = (pdaPrint, pdaContentCopy, pdaContentEdit,
    pdaComment, pdaPrintHighResolution, pdaDocumentAssemble);  
  TdxPSPDFDocumentActions = set of TdxPSPDFDocumentAction;

  { TdxPSPDFSecurityOptions }

  TdxPSPDFEncrypt40BitKey = array [0..4] of Byte;
  TdxPSPDFEncrypt128BitKey = array [0..15] of Byte;
  TdxPSPDFEncryptKeyLength = (pekl40, pekl128);

  TdxPSPDFSecurityOptions = class(TPersistent)
  private
    FAllowActions: TdxPSPDFDocumentActions;
    FEnabled: Boolean;
    FKeyLength: TdxPSPDFEncryptKeyLength;
    FOwnerPassword: string;
    FUserPassword: string;
    function GetIsAllowActionsStored: Boolean;
  public
    constructor Create; virtual;
    procedure Assign(Source: TPersistent); override;
  published
    property AllowActions: TdxPSPDFDocumentActions read FAllowActions write FAllowActions stored GetIsAllowActionsStored;
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property KeyLength: TdxPSPDFEncryptKeyLength read FKeyLength write FKeyLength default pekl128;
    property OwnerPassword: string read FOwnerPassword write FOwnerPassword;
    property UserPassword: string read FUserPassword write FUserPassword;
  end;

  { TdxPSPDFEncryptCustomInfo }

  TdxPSPDFEncryptCustomInfo = class(TdxPSPDFCustomObject)
  private
    FEncryptHelper: TdxPSPDFEncryptCustomHelper;
  protected
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  public
    constructor Create(AEncryptHelper: TdxPSPDFEncryptCustomHelper); virtual;
    //
    property EncryptHelper: TdxPSPDFEncryptCustomHelper read FEncryptHelper;
  end;

  { TdxPSPDFEncryptCustomHelper }

  TdxPSPDFEncryptCustomHelper = class(TObject)
  private
    FEnabled: Boolean;
    FEncryptionFlags: Integer;
    FFileID: AnsiString;
    FFileKey: TdxPSPDFEncrypt128BitKey;
    FInfo: TdxPSPDFEncryptCustomInfo;
    FOwnerKey: AnsiString;
    FUserKey: AnsiString;
  protected
    function CalculateEncryptionFlags(AAllowActions: TdxPSPDFDocumentActions): Integer; virtual; abstract;
    function CalculateOwnerKey(AOptions: TdxPSPDFSecurityOptions): AnsiString; virtual; abstract;
    function CalculateUserKey(AOptions: TdxPSPDFSecurityOptions): AnsiString; virtual; abstract;
    function CreateEncryptInfo: TdxPSPDFEncryptCustomInfo; virtual; abstract;
    procedure CalculateFileKey; virtual;
    procedure CalculateKey(AOptions: TdxPSPDFSecurityOptions); virtual; abstract;
    procedure CalculateKeyMD5(AOptions: TdxPSPDFSecurityOptions; out ADigest: TdxMD5Byte16);
  public
    constructor Create(AOptions: TdxPSPDFSecurityOptions); virtual;
    destructor Destroy; override;
    procedure EncryptBuffer(ABuffer: PByteArray; ABufferSize, AObjectIndex: Integer); virtual; abstract;
    procedure EncryptStream(AStream: TMemoryStream; AObjectIndex: Integer);
    procedure PopulateExportList(AList: TdxPSPDFObjectList); virtual;
    //
    property Enabled: Boolean read FEnabled;
    property EncryptionFlags: Integer read FEncryptionFlags;
    property FileID: AnsiString read FFileID;
    property FileKey: TdxPSPDFEncrypt128BitKey read FFileKey;
    property OwnerKey: AnsiString read FOwnerKey;
    property UserKey: AnsiString read FUserKey;
  end;
  TdxPSPDFEncryptCustomHelperClass = class of TdxPSPDFEncryptCustomHelper;

  { TdxPSPDFFile }

  TdxPSPDFFile = class(TObject)
  private
    FCatalog: TdxPSPDFCatalog;
    FCompressStreams: Boolean;
    FDocumentInfo: TdxPSPDFDocumentInfo;
    FEmbedFonts: Boolean;
    FJPEGQuality: Integer;
    FSecurityOptions: TdxPSPDFSecurityOptions;
    FUseCIDFonts: Boolean;
    FUseJPEGCompression: Boolean;
    function GetFontList: TdxPSPDFFontList;
    procedure SetJPEGQuality(AValue: Integer);
    procedure SetSecurityOptions(AValue: TdxPSPDFSecurityOptions);
  protected
    function CreateEncryptHelper: TdxPSPDFEncryptCustomHelper; virtual;
    function CreateExportList: TdxPSPDFObjectList; virtual;
    function CreateWriter(AOutStream: TStream; AEncryptHelper: TdxPSPDFEncryptCustomHelper): TdxPSPDFWriter; virtual;
    function GetFontClass: TdxPSPDFCustomFontClass; virtual;
    procedure CalculateObjectsIndexes(AList: TdxPSPDFObjectList; AWriter: TdxPSPDFWriter); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function AddFont(AFont: TFont): TdxPSPDFCustomFont;
    function AddPage: TdxPSPDFPage;
    procedure Reset;
    procedure SaveToFile(const AFileName: string);
    procedure SaveToStream(AStream: TStream);
    //
    property Catalog: TdxPSPDFCatalog read FCatalog;
    property CompressStreams: Boolean read FCompressStreams write FCompressStreams;
    property DocumentInfo: TdxPSPDFDocumentInfo read FDocumentInfo;
    property EmbedFonts: Boolean read FEmbedFonts write FEmbedFonts;
    property FontList: TdxPSPDFFontList read GetFontList;
    property JPEGQuality: Integer read FJPEGQuality write SetJPEGQuality;
    property SecurityOptions: TdxPSPDFSecurityOptions read FSecurityOptions write SetSecurityOptions;
    property UseCIDFonts: Boolean read FUseCIDFonts write FUseCIDFonts;
    property UseJPEGCompression: Boolean read FUseJPEGCompression write FUseJPEGCompression;
  end;

const
  dxPSPDFDefaultAllowedActions = [pdaPrint, pdaPrintHighResolution,
    pdaContentCopy, pdaContentEdit, pdaComment, pdaDocumentAssemble];

function dxConvertPointsToPDFPoints(const R: array of TPoint;
  const AWindowOrgOffset: TPoint; AScaleFactor: Double): TdxPSPDFPointArray;
function dxConvertToPDFPoint(const P: TPoint; AScaleFactor: Double): TdxPSPDFPoint;
function dxConvertToPDFRect(const R: TRect; AScaleFactor: Double): TdxPSPDFRect;
function dxIsPDFRectEmpty(const R: TdxPSPDFRect): Boolean;
function dxMakePDFBounds(ALeft, ATop, AWidth, AHeight: Double): TdxPSPDFRect;
function dxMakePDFPoint(X, Y: Double): TdxPSPDFPoint;
function dxPDFEncodeBounds(const R: TdxPSPDFRect; APageHeight: Double): string;
function dxPDFEncodeColor(AColor: TColor): string;
function dxPDFEncodeFloat(AFloat: Double): string;
function dxPDFLineTo(X, Y: Double): string;
function dxPDFMoveTo(X, Y: Double): string;
implementation

uses
  Math, dxPSPDFFonts, cxDrawTextUtils;

type
  TdxPDFPassKey = array [0..31] of Byte;

  { TdxPSPDFEncrypt40Info }

  TdxPSPDFEncrypt40Info = class(TdxPSPDFEncryptCustomInfo)
  protected
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  end;

  { TdxPSPDFEncrypt128Info }

  TdxPSPDFEncrypt128Info = class(TdxPSPDFEncryptCustomInfo)
  protected
    procedure WriteHeader(AWriter: TdxPSPDFWriter); override;
  end;

  { TdxPSPDFEncrypt40Helper }

  TdxPSPDFEncrypt40Helper = class(TdxPSPDFEncryptCustomHelper)
  private
    FKey: TdxPSPDFEncrypt40BitKey;
  protected
    function CalculateEncryptionFlags(AAllowActions: TdxPSPDFDocumentActions): Integer; override;
    function CalculateOwnerKey(AOptions: TdxPSPDFSecurityOptions): AnsiString; override;
    function CalculateUserKey(AOptions: TdxPSPDFSecurityOptions): AnsiString; override;
    function CreateEncryptInfo: TdxPSPDFEncryptCustomInfo; override;
    procedure CalculateKey(AOptions: TdxPSPDFSecurityOptions); override;
  public
    procedure EncryptBuffer(ABuffer: PByteArray; ABufferSize, AObjectIndex: Integer); override;
    //
    property Key: TdxPSPDFEncrypt40BitKey read FKey;
  end;

  { TdxPSPDFEncrypt128Helper }

  TdxPSPDFEncrypt128Helper = class(TdxPSPDFEncryptCustomHelper)
  private
    FKey: TdxPSPDFEncrypt128BitKey;
  protected
    function CalculateEncryptionFlags(AAllowActions: TdxPSPDFDocumentActions): Integer; override;
    function CalculateOwnerKey(AOptions: TdxPSPDFSecurityOptions): AnsiString; override;
    function CalculateUserKey(AOptions: TdxPSPDFSecurityOptions): AnsiString; override;
    function CreateEncryptInfo: TdxPSPDFEncryptCustomInfo; override;
    procedure CalculateKey(AOptions: TdxPSPDFSecurityOptions); override;
  public
    procedure EncryptBuffer(ABuffer: PByteArray; ABufferSize, AObjectIndex: Integer); override;
    //
    property Key: TdxPSPDFEncrypt128BitKey read FKey;
  end;

const
  dxPDFPassKey: TdxPDFPassKey = (
    $28, $BF, $4E, $5E, $4E, $75, $8A, $41, $64, $00, $4E, $56, $FF, $FA,
    $01, $08, $2E, $2E, $00, $B6, $D0, $68, $3E, $80, $2F, $0C, $A9, $FE,
    $64, $53, $69, $7A
  );

  DefaultJPEGQuality = 90;
  DefaultPageHeight = 792;
  DefaultPageWidth = 612;

  dxCurveAngle1 = 1 - 11 / 20;
  dxCurveAngle2 = 1 + 11 / 20;

  D2P = 96 / 72;

const
  sdxPDFFontNotSelected = 'Font not selected';

  //note: don't localize!!!
  EncodeFilterMap: array[TdxPSPDFStreamEncoding] of string = (
    '/FlateDecode', '/DCTDecode'
  );

function dxIsPDFRectEmpty(const R: TdxPSPDFRect): Boolean;
begin
  Result := (R.Left >= R.Right) or (R.Top >= R.Bottom); 
end;

function dxMakePDFBounds(ALeft, ATop, AWidth, AHeight: Double): TdxPSPDFRect;
begin
  Result.Top := ATop;
  Result.Left := ALeft;
  Result.Right := ALeft + AWidth;
  Result.Bottom := ATop + AHeight;
end;

function dxMakePDFPoint(X, Y: Double): TdxPSPDFPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

function dxConvertPointsToPDFPoints(const R: array of TPoint;
  const AWindowOrgOffset: TPoint; AScaleFactor: Double): TdxPSPDFPointArray;
var
  I: Integer;
begin
  SetLength(Result, Length(R));
  for I := 0 to Length(R) - 1 do
  begin
    Result[I].X := (R[I].X - AWindowOrgOffset.X) * AScaleFactor;
    Result[I].Y := (R[I].Y - AWindowOrgOffset.Y) * AScaleFactor;
  end;
end;

function dxConvertToPDFPoint(const P: TPoint; AScaleFactor: Double): TdxPSPDFPoint;
begin
  Result.X := P.X * AScaleFactor;
  Result.Y := P.Y * AScaleFactor;
end;

function dxConvertToPDFRect(const R: TRect; AScaleFactor: Double): TdxPSPDFRect;
begin
  Result.Top := R.Top * AScaleFactor;
  Result.Left := R.Left * AScaleFactor;
  Result.Right := R.Right * AScaleFactor;
  Result.Bottom := R.Bottom * AScaleFactor;
end;

function StrToHexArray(const AValue: AnsiString): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(AValue) do
    Result := Result + IntToHex(Byte(AValue[I]), 2);
end;

function StrToUnicodeHexArray(const AValue: string): string;
var
  I: Integer;
begin
  Result := 'FEFF';
  for I := 1 to Length(AValue) do
    Result := Result + IntToHex(Ord(AValue[I]), 4);
end;

function CheckForSpecialChars(const S: string): string;
begin
  Result := StringReplace(S, '\', '\\', [rfReplaceAll]);
  Result := StringReplace(Result, '(', '\(', [rfReplaceAll]);
  Result := StringReplace(Result, ')', '\)', [rfReplaceAll]);
  Result := StringReplace(Result, #13, '\r', [rfReplaceAll]);
  Result := StringReplace(Result, #10, '\n', [rfReplaceAll]);
end;

function dxPDFEncodeFloat(AFloat: Double): string;
var
  AFormat: TFormatSettings;
begin
  FillChar(AFormat, SizeOf(AFormat), 0);
  AFormat.DecimalSeparator := '.';
  Result := FormatFloat('0.00', AFloat, AFormat);
end;

function dxPDFEncodeColor(AColor: TColor): string;
var
  R, G, B: Double;
begin
  AColor := ColorToRGB(AColor);
  R := GetRValue(AColor) / 255;
  G := GetGValue(AColor) / 255;
  B := GetBValue(AColor) / 255;
  Result :=
    dxPDFEncodeFloat(R) + sdxPDFSpace +
    dxPDFEncodeFloat(G) + sdxPDFSpace + dxPDFEncodeFloat(B);
end;

function dxPDFLineTo(X, Y: Double): string;
begin
  Result := dxPDFEncodeFloat(X) + sdxPDFSpace + dxPDFEncodeFloat(Y) + sdxPDFSpace + 'l ';
end;

function dxPDFMoveTo(X, Y: Double): string;
begin
  Result := dxPDFEncodeFloat(X) + sdxPDFSpace + dxPDFEncodeFloat(Y) + sdxPDFSpace + 'm ';
end;

function dxPDFEncodeBounds(const R: TdxPSPDFRect; APageHeight: Double): string;
begin
  Result := dxPDFEncodeFloat(R.Left) + sdxPDFSpace +
    dxPDFEncodeFloat(APageHeight - R.Bottom) + sdxPDFSpace +
    dxPDFEncodeFloat(R.Right - R.Left) + sdxPDFSpace +
    dxPDFEncodeFloat(R.Bottom - R.Top) + sdxPDFSpace + 're ';
end;

procedure PopulatePassKey(const APassword: AnsiString; var AKey: TdxPDFPassKey);
var
  I: Integer;
begin
  if APassword <> '' then
    Move(APassword[1], AKey[0], Length(AKey));
  for I := 0 to Length(AKey) - Length(APassword) - 1 do
    AKey[I + Length(APassword)] := dxPDFPassKey[I];
end;

{ TdxPSPDFResources }

constructor TdxPSPDFResources.Create(ACatalog: TdxPSPDFCatalog);
begin
  inherited Create;
  FCatalog := ACatalog;
  FFontList := TdxPSPDFFontList.Create;
  FImageList := TdxPSPDFImageList.Create;
  FPatterns := TdxPSPDFPatternList.Create(Self);
end;

destructor TdxPSPDFResources.Destroy;
begin
  FreeAndNil(FPatterns);
  FreeAndNil(FFontList);
  FreeAndNil(FImageList);
  inherited Destroy;
end;

function TdxPSPDFResources.AddBitmap(ABitmap: TBitmap): Integer;
begin
  Result := ImageList.AddBitmap(ABitmap);
end;

procedure TdxPSPDFResources.Clear;
begin
  FontList.Clear;
  ImageList.Clear;
end;

function TdxPSPDFResources.GetUsedFontsLinks(AWriter: TdxPSPDFWriter): string;
var
  AFont: TdxPSPDFCustomFont;
  I: Integer;
begin
  Result := '';
  for I := 0 to FontList.Count - 1 do
  begin
    AFont := FontList.Items[I];
    Result := Result + '/' + AFont.Name + sdxPDFSpace + AWriter.MakeLinkToObject(AFont) + sdxPDFSpace;
  end;
end;

function TdxPSPDFResources.GetUsedImageLinks(AWriter: TdxPSPDFWriter): string;
var
  AImage: TdxPSPDFImage;
  I: Integer;
begin
  Result := '';
  for I := 0 to ImageList.Count - 1 do
  begin
    AImage := ImageList.Items[I];
    Result := Result + '/' + AImage.Name + sdxPDFSpace + AWriter.MakeLinkToObject(AImage)+ sdxPDFSpace;
  end;
end;

procedure TdxPSPDFResources.PopulateExportList(AList: TdxPSPDFObjectList);
begin
  inherited PopulateExportList(AList);
  FontList.PopulateExportList(AList);
  ImageList.PopulateExportList(AList);
  Patterns.PopulateExportList(AList);
end;

procedure TdxPSPDFResources.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  AWriter.WriteString('/Font << ' + GetUsedFontsLinks(AWriter) + ' >>');
  AWriter.WriteString('/ProcSet [/PDF /Text /ImageC]');
  AWriter.WriteString(sdxPDFXObject + ' << ' + GetUsedImageLinks(AWriter) +  ' >>');
  WritePatternsHeader(AWriter);
end;

procedure TdxPSPDFResources.WritePatternsHeader(AWriter: TdxPSPDFWriter);
var
  APattern: TdxPSPDFCustomPattern;
  I: Integer;
begin
  if Patterns.Count > 0 then
  begin
    AWriter.WriteString(sdxPDFPattern);
    AWriter.BeginParamsSet;
    try
      for I := 0 to Patterns.Count - 1 do
      begin
        APattern := Patterns.Items[I];
        AWriter.WriteString(APattern.Name + sdxPDFSpace + AWriter.MakeLinkToObject(APattern));
      end;
    finally
      AWriter.EndParamsSet;
    end;
  end;
end;

{ TdxPSPDFWriter }

constructor TdxPSPDFWriter.Create(
  AStream: TStream; AEncryptHelper: TdxPSPDFEncryptCustomHelper;
  ACompressStreams, AUseJPEGCompression: Boolean; AJPEGQuality: Integer);
begin
  inherited Create;
  FStream := AStream;
  FCurrentStream := AStream;
  FObjectsOffsets := TList.Create;
  FObjectsOffsets.Capacity := 1024;
  FCompressStreams := dxPDFCanCompressStreams and ACompressStreams;
  FUseJPEGCompression := dxPDFCanUseJPEGCompression and AUseJPEGCompression;
  FEncryptHelper := AEncryptHelper;
  FJPEGQuality := AJPEGQuality;
  BeginDocument;
end;

destructor TdxPSPDFWriter.Destroy;
begin
  EndDocument;
  FreeAndNil(FObjectsOffsets);
  inherited Destroy;
end;

procedure TdxPSPDFWriter.AddObjectOffset(AOffset: Integer);
begin
  ObjectsOffsets.Add(Pointer(AOffset));
end;

procedure TdxPSPDFWriter.BeginStream(AStreamType: TdxPSPDFStreamType);
begin
  WriteString('stream');
  FTempBufferStream := TMemoryStream.Create;
{$IFDEF DX_PDF_COMPRESS_STREAMS}
  if CompressStreams and (GetStreamEncoding(AStreamType) = pseFlate) then
    FCurrentStream := TCompressionStream.Create(clMax, FTempBufferStream)
  else
{$ENDIF}
    FCurrentStream := FTempBufferStream;
end;

procedure TdxPSPDFWriter.BeginDocument;
begin
  WriteString('%PDF-1.4');
  WriteString('%'#226#227#207#211);
end;

procedure TdxPSPDFWriter.BeginObject(AObject: TdxPSPDFCustomObject);
begin
  if (Catalog = nil) and (AObject is TdxPSPDFCatalog) then
    Catalog := TdxPSPDFCatalog(AObject);
  if (DocumentInfo = nil) and (AObject is TdxPSPDFDocumentInfo) then
    DocumentInfo := TdxPSPDFDocumentInfo(AObject);
  if (EncryptInfo = nil) and (AObject is TdxPSPDFEncryptCustomInfo) then
    EncryptInfo := TdxPSPDFEncryptCustomInfo(AObject);

  FCurrentObject := AObject;
  AddObjectOffset(Stream.Position);
  WriteString(IntToStr(AObject.Index) + ' 0 obj');
end;

procedure TdxPSPDFWriter.BeginParamsSet;
begin
  WriteString('<<');
end;

procedure TdxPSPDFWriter.EndDocument;
var
  AXrefOffset: Integer;
begin
  AXrefOffset := Stream.Position;
  WriteXrefSection;
  WriteTrailerSection;
  WriteString('startxref ' + IntToStr(AXrefOffset));
  WriteString('%%EOF', False);
end;

procedure TdxPSPDFWriter.EndObject;
begin
  FCurrentObject := nil;
  WriteString('endobj');
  WriteString('');
end;

procedure TdxPSPDFWriter.EndParamsSet;
begin
  WriteString('>>');
end;

procedure TdxPSPDFWriter.EndStream;
begin
  if CurrentStream <> TempBufferStream then
    FreeAndNil(FCurrentStream);
  EncryptHelper.EncryptStream(TempBufferStream, CurrentObject.Index);
  if Assigned(CurrentObject.FContentStreamLength) then
    CurrentObject.FContentStreamLength.Length := TempBufferStream.Size;
  TempBufferStream.Position := 0;
  Stream.CopyFrom(TempBufferStream, TempBufferStream.Size);
  FreeAndNil(FTempBufferStream);
  FCurrentStream := Stream;
  WriteString('');
  WriteString('endstream');
end;

function TdxPSPDFWriter.EncodeString(const S: string; AHexArray: Boolean = True): string;
var
  AAnsiStr: AnsiString;
begin
  if EncryptHelper.Enabled then
  begin
    AAnsiStr := dxStringToAnsiString(S);
    EncryptHelper.EncryptBuffer(@AAnsiStr[1], Length(AAnsiStr), CurrentObject.Index);
    Result := '(' + CheckForSpecialChars(dxAnsiStringToString(AAnsiStr)) + ')';
  end
  else
    if AHexArray then
      Result := '<' + StrToUnicodeHexArray(S) + '>'
    else
      Result := '(' + CheckForSpecialChars(S) + ')';
end;

function TdxPSPDFWriter.GetStreamEncoding(
  AStreamType: TdxPSPDFStreamType): TdxPSPDFStreamEncoding;
begin
  if UseJPEGCompression and (AStreamType = pstImage) then
    Result := pseDCT
  else
    Result := pseFlate;
end;

function TdxPSPDFWriter.MakeLinkToObject(AObject: TdxPSPDFCustomObject): string;
begin
  Result := IntToStr(AObject.Index) + ' 0 R';
end;

procedure TdxPSPDFWriter.WriteBitmap(ABitmap: TBitmap);

  procedure PrepareBitmapInfoHeader(var AHeader: TBitmapInfoHeader);
  begin
    AHeader.biSize := SizeOf(AHeader);
    AHeader.biWidth := ABitmap.Width;
    AHeader.biHeight := ABitmap.Height;
    AHeader.biPlanes := 1;
    AHeader.biBitCount := 24;
    AHeader.biCompression := BI_RGB;
  end;

  procedure RGBToBGR(AColors: PRGBTriple; ACount: Integer);
  var
    I, ABlueValue: Integer;
  begin
    for I := 0 to ACount - 1 do
    begin
      ABlueValue := AColors^.rgbtBlue;
      AColors^.rgbtBlue := AColors^.rgbtRed;
      AColors^.rgbtRed := ABlueValue;
      Inc(AColors);
    end;
  end;

  procedure WriteBitmapBits(AStream: TStream);
  var
    ABuffer: PRGBTriple;
    ABufferSize: Integer;
    AInfo: TBitmapInfo;
    DC: HDC;
    I: Integer;
  begin
    DC := GetDC(0);
    try
      FillChar(AInfo, SizeOf(AInfo), 0);
      PrepareBitmapInfoHeader(AInfo.bmiHeader);
      ABufferSize := ABitmap.Width * AInfo.bmiHeader.biBitCount div 8;
      ABuffer := AllocMem(ABufferSize);
      try
        for I := ABitmap.Height - 1 downto 0 do
        begin
          GetDIBits(DC, ABitmap.Handle, I, 1, ABuffer, AInfo, DIB_RGB_COLORS);
          RGBToBGR(ABuffer, ABitmap.Width);
          AStream.WriteBuffer(ABuffer^, ABufferSize);
        end;
      finally
        FreeMem(ABuffer);
      end;
    finally
      ReleaseDC(0, DC);
    end;                                             
  end;

{$IFDEF USEJPEGIMAGE}
  procedure WriteJPEGStream(AStream: TStream);
  var
    AJPEGImage: TJPEGImage;
  begin
    AJPEGImage := TJPEGImage.Create;
    try
      AJPEGImage.Assign(ABitmap);
      AJPEGImage.CompressionQuality := JPEGQuality;
      AJPEGImage.Compress;
      AJPEGImage.SaveToStream(AStream);
    finally
      AJPEGImage.Free;
    end;
  end;
{$ENDIF}

begin
{$IFDEF USEJPEGIMAGE}
  if UseJPEGCompression then
    WriteJPEGStream(CurrentStream)
  else
{$ENDIF}
    WriteBitmapBits(CurrentStream);
end;

procedure TdxPSPDFWriter.WriteStream(AStream: TStream);
begin
  CurrentStream.CopyFrom(AStream, AStream.Size);
end;

procedure TdxPSPDFWriter.WriteStreamHeader(AStreamType: TdxPSPDFStreamType);
var
  AEncoding: TdxPSPDFStreamEncoding;
begin
  AEncoding := GetStreamEncoding(AStreamType);
  if CompressStreams or (AEncoding = pseDCT) then
    WriteString(sdxPDFFilter + EncodeFilterMap[AEncoding]);
end;

procedure TdxPSPDFWriter.WriteString(const S: string; AWriteCrLf: Boolean = True);
const
  CRLF: AnsiString = #13#10;
begin
  WriteStringToStream(CurrentStream, dxStringToAnsiString(S));
  if AWriteCrLf then
    WriteStringToStream(CurrentStream, CRLF);
end;

procedure TdxPSPDFWriter.WriteTrailerSection;
begin
  WriteString('trailer');
  BeginParamsSet;
  try
    WriteString(sdxPDFSize + sdxPDFSpace + IntToStr(ObjectsOffsets.Count));
    if Assigned(Catalog) then
      WriteString(sdxPDFRoot + sdxPDFSpace + MakeLinkToObject(Catalog));
    if Assigned(DocumentInfo) then
      WriteString(sdxPDFInfo + sdxPDFSpace + MakeLinkToObject(DocumentInfo));
    if Assigned(EncryptInfo) then
    begin
      WriteString(sdxPDFEncrypt + sdxPDFSpace + MakeLinkToObject(EncryptInfo));
      WriteString(sdxPDFFileID + sdxPDFSpace +
        Format('[<%s><%s>]', [EncryptHelper.FileID, EncryptHelper.FileID]));
    end;
  finally
    EndParamsSet;
  end;
end;

procedure TdxPSPDFWriter.WriteXRefSection;
var
  I: Integer;
begin
  WriteString('xref');
  WriteString('0 ' + IntToStr(ObjectsOffsets.Count + 1));
  WriteString('0000000000 65535 f');
  for I := 0 to ObjectsOffsets.Count - 1 do
    WriteString(FormatFloat('0000000000', Integer(ObjectsOffsets.Items[I])) + ' 00000 n');
end;

{ TdxPSPDFCustomFont }

constructor TdxPSPDFCustomFont.Create(
  AOwner: TdxPSPDFFontList; AEmbed: Boolean; AFont: TFont);
begin
  inherited Create;
  FOwner := AOwner;
  FStyle := AFont.Style;
  FCharset := GetFontCharset(AFont);
  FEmbed := AEmbed and dxPDFCanEmbedFont(AFont);
  FFamilyName := AFont.Name;
  FFontIndex := AOwner.Count;
end;

function TdxPSPDFCustomFont.Compare(AFont: TFont): Boolean;
begin
  Result := (GetFontCharset(AFont) = Charset) and
    (AFont.Style = Style) and SameText(AFont.Name, FamilyName);
end;

function TdxPSPDFCustomFont.CreateFont: TFont;
begin
  Result := TFont.Create;
  Result.Charset := FCharset;
  Result.Style := Style;
  Result.Name := FamilyName;
end;

function TdxPSPDFCustomFont.EncodeFontName: string;
var
  AStyle: string;
begin
  AStyle := '';
  Result := StringReplace(FamilyName, sdxPDFSpace, '#20', [rfReplaceAll]);
  Result := StringReplace(Result, '(', '#28', [rfReplaceAll]);
  Result := StringReplace(Result, ')', '#29', [rfReplaceAll]);
  if fsBold in Style then
    AStyle := AStyle + 'Bold';
  if fsItalic in Style then
    AStyle := AStyle + 'Italic';
  if AStyle <> '' then
    Result := Result + ',' + AStyle;
end;

function TdxPSPDFCustomFont.GetFontCharset(AFont: TFont): Integer;
begin
  Result := AFont.Charset;
  if Result = DEFAULT_CHARSET then
    Result := GetDefFontCharSet;
end;

function TdxPSPDFCustomFont.GetCodePage: Integer;
begin
  Result := dxGetCodePageFromCharset(Charset);
end;

function TdxPSPDFCustomFont.GetName: string;
begin
  Result := 'F' + IntToStr(FontIndex);
end;

class function TdxPSPDFCustomFont.GetType: string;
begin
  Result := sdxPDFFont;
end;

procedure TdxPSPDFCustomFont.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString(sdxPDFName + ' /' + Name);
  AWriter.WriteString(sdxPDFBaseFont + sdxPDFSpace + '/' + EncodeFontName);
end;

{ TdxPSPDFFontList }

function TdxPSPDFFontList.Add(AFont: TFont; ACanUseCID, AEmbedFont: Boolean): Integer;
const
  FontClassMap: array[Boolean] of TdxPSPDFCustomFontClass = (
    TdxPSPDFTrueTypeFont, TdxPSPDFCIDFont
  );
var
  APDFFontClass: TdxPSPDFCustomFontClass;
begin
  Result := FindFont(AFont);
  if Result < 0 then
  begin
    APDFFontClass := FontClassMap[ACanUseCID and dxPDFCanCreateCIDFont(AFont)];
    Result := inherited Add(APDFFontClass.Create(Self, AEmbedFont, AFont));
  end;
end;

function TdxPSPDFFontList.FindFont(AFont: TFont): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].Compare(AFont) then
    begin
      Result := I;
      Break;
    end;
end;

function TdxPSPDFFontList.GetItem(Index: Integer): TdxPSPDFCustomFont;
begin
  Result := TdxPSPDFCustomFont(inherited Items[Index]);
end;

procedure TdxPSPDFFontList.RemoveUnusedFonts;
var
  I: Integer;
begin
  for I := Count - 1 downto 0 do
  begin
    if not Items[I].Used then
      Delete(I);
  end;
end;

{ TdxPSPDFFile }

constructor TdxPSPDFFile.Create;
begin
  inherited Create;
  FJPEGQuality := DefaultJPEGQuality;
  FCatalog := TdxPSPDFCatalog.Create(Self);
  FDocumentInfo := TdxPSPDFDocumentInfo.Create;
  FSecurityOptions := TdxPSPDFSecurityOptions.Create;
end;

destructor TdxPSPDFFile.Destroy;
begin
  FreeAndNil(FCatalog);
  FreeAndNil(FDocumentInfo);
  FreeAndNil(FSecurityOptions);
  inherited Destroy;
end;

function TdxPSPDFFile.AddFont(AFont: TFont): TdxPSPDFCustomFont;
var
  AIndex: Integer;
begin
  AIndex := FontList.Add(AFont, UseCIDFonts, EmbedFonts);
  if AIndex < 0 then
    Result := nil
  else
    Result := FontList.Items[AIndex];
end;

function TdxPSPDFFile.AddPage: TdxPSPDFPage;
begin
  Result := Catalog.PageList.AddPage;
end;

procedure TdxPSPDFFile.CalculateObjectsIndexes(
  AList: TdxPSPDFObjectList; AWriter: TdxPSPDFWriter);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    AList.Items[I].Index := I + 1;
end;

function TdxPSPDFFile.CreateEncryptHelper: TdxPSPDFEncryptCustomHelper;
const
  ClassMap: array[TdxPSPDFEncryptKeyLength] of TdxPSPDFEncryptCustomHelperClass =
    (TdxPSPDFEncrypt40Helper, TdxPSPDFEncrypt128Helper);
begin
  Result := ClassMap[SecurityOptions.KeyLength].Create(SecurityOptions);
end;

function TdxPSPDFFile.CreateExportList: TdxPSPDFObjectList;
begin
  Result := TdxPSPDFObjectList.Create(False);
  DocumentInfo.PopulateExportList(Result);
  Catalog.PopulateExportList(Result);
end;

function TdxPSPDFFile.CreateWriter(AOutStream: TStream;
  AEncryptHelper: TdxPSPDFEncryptCustomHelper): TdxPSPDFWriter;
begin
  Result := TdxPSPDFWriter.Create(AOutStream, AEncryptHelper,
    CompressStreams, UseJPEGCompression, JPEGQuality);
end;

function TdxPSPDFFile.GetFontClass: TdxPSPDFCustomFontClass;
begin
  if UseCIDFonts then
    Result := TdxPSPDFCIDFont
  else
    Result := TdxPSPDFTrueTypeFont;
end;

function TdxPSPDFFile.GetFontList: TdxPSPDFFontList;
begin
  Result := Catalog.Resources.FontList;
end;

procedure TdxPSPDFFile.Reset;
begin
  Catalog.Clear;
end;

procedure TdxPSPDFFile.SaveToFile(const AFileName: string);
var
  AStream: TStream;
begin
  AStream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TdxPSPDFFile.SaveToStream(AStream: TStream);
var
  AEncryptHelper: TdxPSPDFEncryptCustomHelper;
  AObjectList: TdxPSPDFObjectList;
  AWriter: TdxPSPDFWriter;
begin
  FontList.RemoveUnusedFonts;
  AObjectList := CreateExportList;
  AEncryptHelper := CreateEncryptHelper;
  try
    AEncryptHelper.PopulateExportList(AObjectList);
    AWriter := CreateWriter(AStream, AEncryptHelper);
    try
      CalculateObjectsIndexes(AObjectList, AWriter);
      AObjectList.SaveTo(AWriter);
    finally
      AWriter.Free;
    end;
  finally
    AEncryptHelper.Free;
    AObjectList.Free;
  end;
end;

procedure TdxPSPDFFile.SetSecurityOptions(AValue: TdxPSPDFSecurityOptions);
begin
  FSecurityOptions.Assign(AValue);
end;

procedure TdxPSPDFFile.SetJPEGQuality(AValue: Integer);
begin
  FJPEGQuality := Max(Min(AValue, 100), 0);
end;

{ TdxPSPDFObjectList }

function TdxPSPDFObjectList.GetItem(Index: Integer): TdxPSPDFCustomObject;
begin
  Result := TdxPSPDFCustomObject(inherited Items[Index]);
end;

procedure TdxPSPDFObjectList.PopulateExportList(AList: TdxPSPDFObjectList);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].PopulateExportList(AList);
end;

procedure TdxPSPDFObjectList.SaveTo(AWriter: TdxPSPDFWriter);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].SaveTo(AWriter);  
end;

{ TdxPSPDFCustomObject }

destructor TdxPSPDFCustomObject.Destroy;
begin
  FreeAndNil(FContentStreamLength);
  inherited Destroy;
end;

procedure TdxPSPDFCustomObject.BeginSave(AWriter: TdxPSPDFWriter); 
begin
  AWriter.BeginObject(Self);
end;

procedure TdxPSPDFCustomObject.EndSave(AWriter: TdxPSPDFWriter);
begin
  AWriter.EndObject;
end;

function TdxPSPDFCustomObject.GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean;
begin
  Result := False;
end;

procedure TdxPSPDFCustomObject.PopulateExportList(AList: TdxPSPDFObjectList);
var
  AStreamType: TdxPSPDFStreamType;
begin
  AList.Add(Self);
  if GetContentStreamType(AStreamType) then
  begin
    FContentStreamLength := TdxPSPDFLength.Create;
    FContentStreamLength.PopulateExportList(AList);
  end;
end;

procedure TdxPSPDFCustomObject.SaveTo(AWriter: TdxPSPDFWriter);
var
  AStreamType: TdxPSPDFStreamType;
begin
  BeginSave(AWriter);
  try
    AWriter.BeginParamsSet;
    WriteHeader(AWriter);
    if GetContentStreamType(AStreamType) then
    begin
      AWriter.WriteString(sdxPDFLength + sdxPDFSpace + AWriter.MakeLinkToObject(FContentStreamLength));
      AWriter.WriteStreamHeader(AStreamType);
      AWriter.EndParamsSet;
      AWriter.BeginStream(AStreamType);
      WriteContentStream(AWriter);
      AWriter.EndStream;
    end
    else
      AWriter.EndParamsSet;
  finally
    EndSave(AWriter);
  end;
end;

procedure TdxPSPDFCustomObject.WriteContentStream(AWriter: TdxPSPDFWriter);
begin
end;

procedure TdxPSPDFCustomObject.WriteHeader(AWriter: TdxPSPDFWriter);
begin
end;

{ TdxPSPDFObject }

class function TdxPSPDFObject.GetSubType: string;
begin
  Result := '';
end;

class function TdxPSPDFObject.GetType: string;
begin
  Result := '';
end;

procedure TdxPSPDFObject.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  if GetType <> '' then
    AWriter.WriteString(sdxPDFType + sdxPDFSpace + GetType);
  if GetSubType <> '' then
    AWriter.WriteString(sdxPDFSubType + sdxPDFSpace + GetSubType);
end;

{ TdxPSPDFDocumentInfo }

procedure TdxPSPDFDocumentInfo.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  AWriter.WriteString(sdxPDFTitle + sdxPDFSpace + AWriter.EncodeString(Title));
  AWriter.WriteString(sdxPDFAuthor + sdxPDFSpace + AWriter.EncodeString(Author));
  AWriter.WriteString(sdxPDFSubject + sdxPDFSpace + AWriter.EncodeString(Subject));
  AWriter.WriteString(sdxPDFProducer + sdxPDFSpace + AWriter.EncodeString(Producer));
  AWriter.WriteString(sdxPDFKeywords + sdxPDFSpace + AWriter.EncodeString(Keywords));
  AWriter.WriteString(sdxPDFCreator + sdxPDFSpace + AWriter.EncodeString(Creator));
  AWriter.WriteString(sdxPDFCreationDate + sdxPDFSpace +
    AWriter.EncodeString('D:' + FormatDateTime('YYYYMMDDHHmmSS', Now), False));
end;

{ TdxPSPDFCatalog }

constructor TdxPSPDFCatalog.Create(AParent: TdxPSPDFFile);
begin
  inherited Create;
  FParent := AParent;
  FPageList := TdxPSPDFPageList.Create(Self);
  FResources := TdxPSPDFResources.Create(Self);
end;

destructor TdxPSPDFCatalog.Destroy;
begin
  FreeAndNil(FResources);
  FreeAndNil(FPageList);
  inherited Destroy;
end;

class function TdxPSPDFCatalog.GetType: string;
begin
  Result := sdxPDFCatalog;
end;

procedure TdxPSPDFCatalog.Clear;
begin
  PageList.Clear;
  Resources.Clear;
end;

procedure TdxPSPDFCatalog.PopulateExportList(AList: TdxPSPDFObjectList);
begin
  inherited PopulateExportList(AList);
  Resources.PopulateExportList(AList);
  PageList.PopulateExportList(AList);   
end;

procedure TdxPSPDFCatalog.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString(sdxPDFPages +
    sdxPDFSpace + AWriter.MakeLinkToObject(PageList));
end;

{ TdxPSPDFPageList }

constructor TdxPSPDFPageList.Create(ACatalog: TdxPSPDFCatalog);
begin
  inherited Create;
  FCatalog := ACatalog;
  FList := TdxPSPDFObjectList.Create;
end;

destructor TdxPSPDFPageList.Destroy;
begin
  FreeAndNil(FList);
  inherited Destroy;
end;

function TdxPSPDFPageList.AddPage: TdxPSPDFPage;
begin
  Result := TdxPSPDFPage.Create(Self);
  FList.Add(Result);
end;

procedure TdxPSPDFPageList.Clear;
begin
  FList.Clear;
end;

function TdxPSPDFPageList.GetPage(Index: Integer): TdxPSPDFPage;
begin
  Result := TdxPSPDFPage(FList.Items[Index]);
end;

function TdxPSPDFPageList.GetPageCount: Integer;
begin
  Result := FList.Count;
end;

class function TdxPSPDFPageList.GetType: string;
begin
  Result := sdxPDFPages;
end;

procedure TdxPSPDFPageList.PopulateExportList(AList: TdxPSPDFObjectList);
begin
  inherited PopulateExportList(AList);
  FList.PopulateExportList(AList);
end;

procedure TdxPSPDFPageList.WriteHeader(AWriter: TdxPSPDFWriter);

  function GetPageIndexes: string;
  var
    APageIndex: Integer;
  begin
    Result := '';
    for APageIndex := 0 to PageCount - 1 do
      Result := Result + AWriter.MakeLinkToObject(Page[APageIndex]) + sdxPDFSpace;
  end;

begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString('/Kids [' + GetPageIndexes + '] /Count ' + IntToStr(PageCount));
end;

{ TdxPSPDFPage }

constructor TdxPSPDFPage.Create(AParent: TdxPSPDFPageList);
begin
  inherited Create;
  FParent := AParent; 
  FContent := TdxPSPDFPageContent.Create(Self);
  FPageHeight := DefaultPageHeight;
  FPageWidth := DefaultPageWidth;
end;

destructor TdxPSPDFPage.Destroy;
begin
  FreeAndNil(FContent);
  inherited Destroy;
end;

function TdxPSPDFPage.GetPageBounds: TRect;
begin
  Result := Rect(0, 0, PageWidth, PageHeight); 
end;

function TdxPSPDFPage.GetPageResources: TdxPSPDFResources;
begin
  Result := Parent.Catalog.Resources; 
end;

class function TdxPSPDFPage.GetType: string;
begin
  Result := sdxPDFSubTypePage;
end;

procedure TdxPSPDFPage.PopulateExportList(AList: TdxPSPDFObjectList);
begin
  inherited PopulateExportList(AList);
  Content.PopulateExportList(AList);
end;

procedure TdxPSPDFPage.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString(sdxPDFParent + sdxPDFSpace + AWriter.MakeLinkToObject(Parent));
  AWriter.WriteString(sdxPDFPageSize + Format(' [0 0 %d %d]', [PageWidth, PageHeight]));
  AWriter.WriteString(sdxPDFResources + sdxPDFSpace + AWriter.MakeLinkToObject(PageResources));
  AWriter.WriteString(sdxPDFContent + sdxPDFSpace + AWriter.MakeLinkToObject(Content));
end;

{ TdxPSPDFPageContent }

constructor TdxPSPDFPageContent.Create(APage: TdxPSPDFPage);
begin
  inherited Create;
  FParent := APage;
  FFontSize := 12;
  FFontColor := clBlack;
  FContentData := TMemoryStream.Create;
end;

destructor TdxPSPDFPageContent.Destroy;
begin
  FreeAndNil(FContentData);
  inherited Destroy;
end;

function TdxPSPDFPageContent.AddBitmap(ABitmap: TBitmap): Integer;
begin
  Result := Parent.PageResources.AddBitmap(ABitmap);
end;

procedure TdxPSPDFPageContent.AppendScript(const S: string);
begin
  WriteStringToStream(FContentData, dxStringToAnsiString(S + #13#10));
end;

procedure TdxPSPDFPageContent.ApplyFontStyle(
  const AStyle: TFontStyles; R: TdxPSPDFRect; X, Y: Double);
var
  ALineHeight: Double;
begin
  if [fsUnderLine, fsStrikeOut] * AStyle <> [] then
  begin
    ALineHeight := 0.5 * FontSize / 8;
    if fsStrikeOut in AStyle then
    begin
      R.Top := Y + FontSize / 2 + 1;
      R.Bottom := R.Top + ALineHeight;
      WriteRectangle(R);
    end;
    if fsUnderLine in AStyle then
    begin
      R.Top := Y + FontSize + 1;
      R.Bottom := R.Top + ALineHeight;
      WriteRectangle(R);
    end;
    Fill;
  end;
end;

procedure TdxPSPDFPageContent.ApplyClipping(
  AClipMode: TdxPSPDFPageContentClipMode = pcmAdd);
const
  ClipModeMap: array[TdxPSPDFPageContentClipMode] of string = ('W', 'W*');
begin
  AppendScript(ClipModeMap[AClipMode]);
  AppendScript('n');
end;

procedure TdxPSPDFPageContent.SelectBackColor(AColor: TColor);
begin
  AppendScript(dxPDFEncodeColor(AColor) + ' RG');
end;

procedure TdxPSPDFPageContent.SelectFont(AFont: TdxPSPDFCustomFont);
begin
  AppendScript(Format('/%s %s Tf', [AFont.Name, dxPDFEncodeFloat(FontSize)]));
  AFont.Used := True;
end;

procedure TdxPSPDFPageContent.SelectForeColor(AColor: TColor);
begin
  FForeColor := AColor;
  AppendScript(dxPDFEncodeColor(AColor) + ' rg');
end;

procedure TdxPSPDFPageContent.SelectLineWidth(ALineWidth: Double);
begin
  AppendScript(dxPDFEncodeFloat(ALineWidth) + ' w');
end;

procedure TdxPSPDFPageContent.AdjustFontSize(const AText: WideString; ATextWidth: Double);
var
  ATempWidth: Integer;
begin
  ATempWidth := Font.TextWidth(AText);
  if ATempWidth > 0 then
    FontSize := ATextWidth / (ATempWidth / 750);
end;

function TdxPSPDFPageContent.TextWidth(const AText: WideString): Double;
begin
  Result := Font.TextWidth(AText) * FontSize / 750;
end;

procedure TdxPSPDFPageContent.Pie(const R: TdxPSPDFRect;
  const APoint1, APoint2: TdxPSPDFPoint; AColor: TColor);
begin
  if AColor <> clNone then
  begin
    if AColor = clDefault then
      AColor := ForeColor;
    SelectForeColor(AColor);
    WritePie(R.Left, R.Top, R.Right, R.Bottom, APoint1.X, APoint1.Y, APoint2.X, APoint2.Y);
    AppendScript('b*');
  end;
end;

procedure TdxPSPDFPageContent.WritePie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);

  procedure CalcPoint(var P: TdxPSPDFPoint;
    ACenterX, ACenterY, ARadiusX, ARadiusY, AAngle: Double);
  begin
    P.X := ACenterX + ARadiusX * Cos(AAngle);
    P.Y := ACenterY - ARadiusY * Sin(AAngle);
  end;

  function CheckAngle(AAngle: Double): Double;
  begin
    if AAngle < 0 then
      Result := AAngle + 2 * PI
    else
      Result := AAngle;
  end;

  procedure WriteArcPart(ACenterX, ACenterY: Double;
    ARadiusX, ARadiusY, AStartAngle, ARotateAngle: Double);
  var
    P: array[0..2] of TdxPSPDFPoint;
  begin
    CalcPoint(P[0], ACenterX, ACenterY, ARadiusX, ARadiusY, AStartAngle + ARotateAngle * 1 / 3);
    CalcPoint(P[1], ACenterX, ACenterY, ARadiusX, ARadiusY, AStartAngle + ARotateAngle * 2 / 3);
    CalcPoint(P[2], ACenterX, ACenterY, ARadiusX, ARadiusY, AStartAngle + ARotateAngle);
    CurveTo(P[0].X, P[0].Y, P[1].X, P[1].Y, P[2].X, P[2].Y);
  end;

var
  ACenterX, ACenterY: Double;
  ARadiusX, ARadiusY: Double;
  ARotateAngle, ACounter: Double;
  AStartAngle, AFinishAngle: Double;
begin
  ACenterX := (X1 + X2) / 2;
  ACenterY := (Y1 + Y2) / 2;
  ARadiusX := Max(0, (Abs(X1 - X2) - 1) / 2);
  ARadiusY := Max(0, (Abs(Y1 - Y2) - 1) / 2);
  AStartAngle  := CheckAngle(ArcTan2((ACenterY - Y3) * ARadiusX, (X3 - ACenterX) * ARadiusY));
  AFinishAngle := CheckAngle(ArcTan2((ACenterY - Y4) * ARadiusX, (X4 - ACenterX) * ARadiusY));
  ACounter := CheckAngle(AFinishAngle - AStartAngle);

  MoveTo(ACenterX + ARadiusX * Cos(AStartAngle), ACenterY - ARadiusY * Sin(AStartAngle));
  while ACounter >= 0 do
  begin
    ARotateAngle := Min(PI / 12, ACounter);
    WriteArcPart(ACenterX, ACenterY, ARadiusX, ARadiusY, AStartAngle, ARotateAngle);
    AStartAngle := AStartAngle + ARotateAngle;
    ACounter := ACounter - PI / 12;
  end;
  LineTo(ACenterX, ACenterY);
end;

procedure TdxPSPDFPageContent.WriteEllipse(const R: TdxPSPDFRect);
var
  X, Y, H, W: Double;
begin
  X := R.Left;
  Y := R.Top;
  H := R.Bottom - R.Top;
  W := R.Right - R.Left;
  MoveTo(X, Y + H / 2);
  CurveTo(X, Y + H / 2 * dxCurveAngle1, X + W / 2 * dxCurveAngle1, Y, X + W / 2, Y);
  CurveTo(X + W / 2 * dxCurveAngle2, Y, X + W, Y + H / 2 * dxCurveAngle1, X + W, Y + H / 2);
  CurveTo(X + W, Y + H / 2 * dxCurveAngle2, X + W / 2 * dxCurveAngle2, Y + H, X + W / 2, Y + H);
  CurveTo(X + W / 2 * dxCurveAngle1, Y + H, X, Y + H / 2 * dxCurveAngle2, X, Y + H / 2);
end;

procedure TdxPSPDFPageContent.WriteRectangle(const R: TdxPSPDFRect);
begin
  AppendScript(dxPDFEncodeBounds(R, PageHeight));
end;

procedure TdxPSPDFPageContent.WriteRoundRect(
  const R: TdxPSPDFRect; AEllipseWidth, AEllipseHeight: Double);
begin
  // TopLeft
  MoveTo(R.Left, R.Top + AEllipseHeight);
  CurveTo(R.Left, R.Top + AEllipseHeight * dxCurveAngle1,
    R.Left + AEllipseWidth * dxCurveAngle1, R.Top, R.Left + AEllipseWidth, R.Top);
  LineTo(R.Right - AEllipseWidth, R.Top);
  // RightBottom
  CurveTo(R.Right - AEllipseWidth * (dxCurveAngle2 - 1), R.Top,
    R.Right, R.Top + AEllipseHeight * dxCurveAngle1,
    R.Right, R.Top + AEllipseHeight);
  LineTo(R.Right, R.Bottom - AEllipseHeight);
  // BottomRight Corner
  CurveTo(R.Right, R.Bottom - AEllipseHeight * (dxCurveAngle2 - 1),
    R.Right - AEllipseWidth * dxCurveAngle1, R.Bottom,
    R.Right - AEllipseWidth, R.Bottom);
  LineTo(R.Left + AEllipseWidth, R.Bottom);
  // BottomLeft
  CurveTo(R.Left + AEllipseWidth * dxCurveAngle1, R.Bottom,
    R.Left, R.Bottom - AEllipseHeight * (dxCurveAngle2 - 1),
    R.Left, R.Bottom - AEllipseHeight);
  LineTo(R.Left, R.Top + AEllipseHeight);
end;

function TdxPSPDFPageContent.CheckColor(var AColor: TColor): Boolean;
begin
  if AColor = clDefault then
    AColor := FontColor;
  Result := AColor <> clNone;
end;

procedure TdxPSPDFPageContent.Concat(A1, A2, A3, A4: Double; AOffsetX, AOffsetY: Double);
begin
  AppendScript(
    dxPDFEncodeFloat(A1) + sdxPDFSpace + dxPDFEncodeFloat(A2) + sdxPDFSpace +
    dxPDFEncodeFloat(A3) + sdxPDFSpace + dxPDFEncodeFloat(A4) + sdxPDFSpace +
    dxPDFEncodeFloat(AOffsetX) + sdxPDFSpace + dxPDFEncodeFloat(AOffsetY) + sdxPDFSpace + 'cm');
end;

function TdxPSPDFPageContent.CreateBitmap(AGraphic: TGraphic; var ANeedDestroy: Boolean): TBitmap;
begin
  ANeedDestroy := not (AGraphic is TBitmap);
  if AGraphic is TBitmap then
    Result := TBitmap(AGraphic)
  else
  begin
    Result := TcxBitmap.CreateSize(AGraphic.Width, AGraphic.Height);
    Result.Canvas.Brush.Color := IfThen(ForeColor = clDefault, clWindow, ForeColor);
    Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
    Result.Canvas.Draw(0, 0, AGraphic);
  end;
end;

procedure TdxPSPDFPageContent.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
begin
  AppendScript(
    dxPDFEncodeFloat(X1) + sdxPDFSpace + dxPDFEncodeFloat(PageHeight - Y1) + sdxPDFSpace +
    dxPDFEncodeFloat(X2) + sdxPDFSpace + dxPDFEncodeFloat(PageHeight - Y2) + sdxPDFSpace +
    dxPDFEncodeFloat(X3) + sdxPDFSpace + dxPDFEncodeFloat(PageHeight - Y3) + sdxPDFSpace + 'c');
end;

procedure TdxPSPDFPageContent.DrawGraphic(const R: TdxPSPDFRect; AGraphic: TGraphic);
var
  ABitmap: TBitmap;
  ANeedDestroy: Boolean;
begin
  if not AGraphic.Empty then
  begin
    SaveGraphicState;
    try
      ABitmap := CreateBitmap(AGraphic, ANeedDestroy);
      try
        Concat(R.Right - R.Left, 0, 0, R.Bottom - R.Top, R.Left, PageHeight - R.Bottom);
        AppendScript(sdxPDFImage + IntToStr(AddBitmap(ABitmap)) + ' Do');
      finally
        if ANeedDestroy then
          FreeAndNil(ABitmap);
      end;
    finally
      RestoreGraphicState;
    end;
  end;
end;

procedure TdxPSPDFPageContent.DrawFrame(const R: TdxPSPDFRect;
  ABorderWidth: Double; ABorderColor: TColor; ABorders: TcxBorders);

  function GetBorderBounds(ASide: TcxBorder): TdxPSPDFRect;
  begin
    Result := R;
    case ASide of
      bLeft:
        Result.Right := Result.Left + ABorderWidth;
      bTop:
        Result.Bottom := Result.Top + ABorderWidth;
      bRight:
        Result.Left := Result.Right - ABorderWidth;
      else //bBottom
        Result.Top := Result.Bottom - ABorderWidth;
    end;
  end;

var
  ASide: TcxBorder;
begin
  if (ABorders <> []) and not IsZero(ABorderWidth) and (ABorderColor <> clNone) then
  begin
    SelectForeColor(ABorderColor);
    for ASide := Low(TcxBorder) to High(TcxBorder) do
    begin
      if ASide in ABorders then
        WriteRectangle(GetBorderBounds(ASide));
    end;
    Fill;
  end;
end;

procedure TdxPSPDFPageContent.DrawFrame(const R: TdxPSPDFRect;
  ABorderWidth: Double; ATopLeftBorderColor, ARightBottomBorderColor: TColor;
  ABorders: TcxBorders);
begin
  DrawFrame(R, ABorderWidth, ATopLeftBorderColor, ABorders * [bLeft, bTop]);
  DrawFrame(R, ABorderWidth, ARightBottomBorderColor, ABorders * [bRight, bBottom]);
end;

procedure TdxPSPDFPageContent.Polyline(const APoints: TdxPSPDFPointArray;
  ALineWidth: Double; AColor: TColor = clDefault);
begin
  if (Length(APoints) > 1) and CheckColor(AColor) then
  begin
    SelectBackColor(AColor);
    SelectLineWidth(ALineWidth);
    WritePoints(APoints);
    MoveTo(APoints[0]);
    AppendScript('s');
  end;
end;

procedure TdxPSPDFPageContent.Polygon(const APoints: TdxPSPDFPointArray;
  ALineWidth: Double; AColor: TColor = clDefault; ABackgroundColor: TColor = clNone;
  AFillMode: Integer = ALTERNATE);
begin
  if Length(APoints) > 1 then
  begin
    SelectLineWidth(ALineWidth);
    WritePoints(APoints);
    FillPolygon(AColor, ABackgroundColor, AFillMode);
  end;
end;

procedure TdxPSPDFPageContent.LineTo(const P: TdxPSPDFPoint);
begin
  LineTo(P.X, P.Y);
end;

procedure TdxPSPDFPageContent.LineTo(X, Y: Double);
begin
  AppendScript(dxPDFLineTo(X, PageHeight - Y));
end;

procedure TdxPSPDFPageContent.MoveTo(const P: TdxPSPDFPoint);
begin
  MoveTo(P.X, P.Y);
end;

procedure TdxPSPDFPageContent.MoveTo(X, Y: Double);
begin
  AppendScript(dxPDFMoveTo(X, PageHeight - Y));
end;

procedure TdxPSPDFPageContent.Fill;
begin
  AppendScript('f');
end;

procedure TdxPSPDFPageContent.FillPolygon(AColor: TColor = clDefault;
  ABackgroundColor: TColor = clNone; AFillMode: Integer = ALTERNATE);
const
  FillModeMap: array[Boolean] of string = ('b', 'f');
  ModeSuffix: array[Boolean] of string = ('', '*');
begin
  if CheckColor(AColor) then
    SelectBackColor(AColor);
  if CheckColor(ABackgroundColor) then
    SelectForeColor(ABackgroundColor);
  if ABackgroundColor <> clNone then
    AppendScript(FillModeMap[AColor = clNone] + ModeSuffix[AFillMode = ALTERNATE])
  else
    AppendScript('s');
end;

procedure TdxPSPDFPageContent.FillRect(const R: TdxPSPDFRect; AColor: TColor = clDefault);
begin
  if not dxIsPDFRectEmpty(R) and CheckColor(AColor) then
  begin
    SelectForeColor(AColor);
    WriteRectangle(R);
    Fill;
  end;
end;

procedure TdxPSPDFPageContent.FillRectByBrush(
  const R: TdxPSPDFRect; AColor: TColor; AStyle: TBrushStyle = bsSolid);
begin
  case AStyle of
    bsClear:
      ;
    bsSolid:
      FillRect(R, AColor);
    else
      if CheckColor(AColor) then
        FillRectByPattern(R, PatternList.AddPattern(AStyle, AColor));
  end;
end;

procedure TdxPSPDFPageContent.FillRectByGraphic(
  const R: TdxPSPDFRect; AWidth, AHeight: Double; AGraphic: TGraphic);
var
  ABitmap: TBitmap;
  ANeedDestroy: Boolean;
begin
  if not AGraphic.Empty then
  begin
    ABitmap := CreateBitmap(AGraphic, ANeedDestroy);
    try
      FillRectByPattern(R, PatternList.AddPattern(AddBitmap(ABitmap), AWidth, AHeight));
    finally
      if ANeedDestroy then
        FreeAndNil(ABitmap);
    end;
  end;
end;

procedure TdxPSPDFPageContent.FillRectByPattern(
  const R: TdxPSPDFRect; APattern: TdxPSPDFCustomPattern);
begin
  AppendScript(sdxPDFPattern + sdxPDFSpace + 'cs');
  AppendScript(APattern.Name + sdxPDFSpace + 'scn');
  WriteRectangle(R);
  Fill;
end;

procedure TdxPSPDFPageContent.RestoreGraphicState;
begin
  AppendScript('Q');
end;

procedure TdxPSPDFPageContent.SaveGraphicState;
begin
  AppendScript('q');
end;

procedure TdxPSPDFPageContent.SelectClipRect(const R: TdxPSPDFRect);
begin
  WriteRectangle(R);
  ApplyClipping;
end;

procedure TdxPSPDFPageContent.SelectClipRegion(ARegion: HRGN; AScaleFactor: Double);
var
  ARgnData: PRgnData;
  ARgnDataSize: Integer;
  ARgnRect: PRect;
  I: Integer;
  R: TRect;
begin
  if GetRgnBox(ARegion, R) <> COMPLEXREGION then
    SelectClipRect(dxConvertToPDFRect(R, AScaleFactor))
  else
  begin
    ARgnDataSize := GetRegionData(ARegion, 0, nil);
    ARgnData := AllocMem(ARgnDataSize);
    try
      if GetRegionData(ARegion, ARgnDataSize, ARgnData) <> 0 then
      begin
        ARgnRect := PRect(@ARgnData^.Buffer[0]);
        for I := 0 to ARgnData^.rdh.nCount - 1 do
        begin
          WriteRectangle(dxConvertToPDFRect(ARgnRect^, AScaleFactor));
          Inc(ARgnRect);
        end;
        ApplyClipping;
      end;
    finally
      FreeMem(ARgnData, ARgnDataSize);
    end;
  end;
end;

procedure TdxPSPDFPageContent.DrawText(const AClipRect, ATextRect: TdxPSPDFRect;
  const AText: WideString; ARotateAngle: Double = 0; ACharsSpacing: Double = 0;
  AWordSpacing: Double = 0);

  function ExtractWord(AStart, AEnd: PWideChar): WideString;
  begin
    SetString(Result, AStart, (LongInt(AEnd) - LongInt(AStart)) div SizeOf(WideChar));
  end;

  procedure TextOut(const AText: WideString; X, Y: Double);
  var
    AStartScan, AEndScan, ATemp: PWideChar;
    AWordText: WideString;
  begin
    if IsZero(AWordSpacing) then
      WriteText(X, PageHeight - Y - FontSize, AText)
    else
    begin
      WriteText(X, PageHeight - Y - FontSize, ''); // Note: set content origin

      X := 0;
      AStartScan := PWideChar(AText);
      AEndScan := AStartScan + Length(AText);
      repeat
        while AStartScan < AEndScan do
        begin
          if not cxGetIsWordDelimeter(Font.CodePage, AStartScan^) then
            Break
          else
          begin
            X := X + (1 + ACharsSpacing) * TextWidth(AStartScan^);
            Inc(AStartScan);
          end;
        end;                  
        if AStartScan < AEndScan then
        begin
          ATemp := cxGetNextWordBreak(Font.CodePage, AStartScan, AEndScan);
          AWordText := ExtractWord(AStartScan, ATemp);
          WriteText(X, 0, AWordText);
          X := AWordSpacing + TextWidth(AWordText) / D2P + ACharsSpacing * Length(AWordText);
          AStartScan := ATemp;
        end;
      until (AStartScan >= AEndScan);
    end;
  end;

var
  R: TdxPSPDFRect;
  X, Y: Double;
begin
  if Font = nil then
    raise EdxPSPDFException.Create(sdxPDFFontNotSelected);

  SaveGraphicState;
  try
    R := ATextRect;
    SelectClipRect(AClipRect);
    WriteRotationParams(ARotateAngle, R, X, Y);
    SelectFont(Font);
    SelectForeColor(FontColor);

    AppendScript('BT');
    if not IsZero(ACharsSpacing) then
      AppendScript(dxPDFEncodeFloat(ACharsSpacing) + sdxPDFSpace + 'Tc');
    TextOut(AText, X, Y);
    AppendScript('ET');

    ApplyFontStyle(Font.Style, R, X, Y);
  finally
    RestoreGraphicState;
  end;
end;

function TdxPSPDFPageContent.GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean;
begin
  AType := pstText;
  Result := FContentData.Size > 0;
end;

function TdxPSPDFPageContent.GetPageHeight: Integer;
begin
  Result := Parent.PageHeight;
end;

function TdxPSPDFPageContent.GetPageWidth: Integer;
begin
  Result := Parent.PageWidth;
end;

function TdxPSPDFPageContent.GetPatternList: TdxPSPDFPatternList;
begin
  Result := Parent.PageResources.Patterns;
end;

procedure TdxPSPDFPageContent.SetFontColor(AValue: TColor);
begin
  if AValue <> clDefault then
  begin
    AValue := ColorToRGB(AValue);
    if AValue <> FFontColor then
    begin
      FFontColor := AValue;
      SelectForeColor(FontColor);
    end;
  end;
end;

procedure TdxPSPDFPageContent.WriteContentStream(AWriter: TdxPSPDFWriter);
begin
  FContentData.Position := 0;
  AWriter.WriteStream(FContentData);
end;

procedure TdxPSPDFPageContent.WritePoints(const APoints: TdxPSPDFPointArray);
var
  I: Integer;
begin
  if Length(APoints) > 0 then
  begin
    MoveTo(APoints[0]);
    for I := 1 to High(APoints) do
      LineTo(APoints[I]);
  end;
end;

procedure TdxPSPDFPageContent.WriteRotationParams(
  ARotationAngle: Double; var R: TdxPSPDFRect; out X, Y: Double); 
var
  ACos, ASin: Double;
begin
  X := R.Left;
  Y := R.Top;
  if not IsZero(ARotationAngle) then
  begin
    ACos := Cos(Pi * ARotationAngle / 180);
    ASin := Sin(Pi * ARotationAngle / 180);
    Concat(ACos, ASin, -ASin, ACos, X, PageHeight - Y);
    R := dxMakePDFBounds(0, PageHeight, R.Right - R.Left, R.Bottom - R.Top);
    Y := PageHeight;
    X := 0;
  end;
end;

procedure TdxPSPDFPageContent.WriteText(X, Y: Double; const AText: WideString);
begin
  AppendScript(dxPDFEncodeFloat(X) + sdxPDFSpace + dxPDFEncodeFloat(Y) + sdxPDFSpace + 'Td');
  if AText <> '' then
  begin
    WriteStringToStream(FContentData, Font.EncodeText(AText));
    AppendScript(sdxPDFSpace + 'Tj');
  end;
end;

{ TdxPSPDFImage }

constructor TdxPSPDFImage.Create(AOwner: TdxPSPDFImageList; ABitmap: TBitmap);
begin
  inherited Create;
  FOwner := AOwner;
  FBitmap := TBitmap.Create;
  FBitmap.Assign(ABitmap);
end;

destructor TdxPSPDFImage.Destroy;
begin
  FreeAndNil(FBitmap);
  inherited Destroy;
end;

function TdxPSPDFImage.Compare(ABitmap: TBitmap): Boolean;
begin
  Result := cxCompareBitmaps(ABitmap, Bitmap);
end;

function TdxPSPDFImage.GetImageIndex: Integer;
begin
  Result := Owner.IndexOf(Self);
end;

function TdxPSPDFImage.GetName: string;
begin
  Result := 'Im' + IntToStr(ImageIndex);
end;

function TdxPSPDFImage.GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean;
begin
  AType := pstImage;
  Result := not Bitmap.Empty;
end;

class function TdxPSPDFImage.GetSubType: string; 
begin
  Result := sdxPDFSubTypeImage;
end;

class function TdxPSPDFImage.GetType: string;
begin
  Result := sdxPDFXObject;
end;

procedure TdxPSPDFImage.WriteContentStream(AWriter: TdxPSPDFWriter);
begin
  AWriter.WriteBitmap(Bitmap);
end;

procedure TdxPSPDFImage.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString(sdxPDFWidth + sdxPDFSpace + IntToStr(Bitmap.Width));
  AWriter.WriteString(sdxPDFHeight + sdxPDFSpace  + IntToStr(Bitmap.Height));
  AWriter.WriteString(sdxPDFColorSpace + sdxPDFDeviceRGB + sdxPDFBitsPerComponent + ' 8');
  AWriter.WriteString(sdxPDFName + ' /' + Name);
end;

{ TdxPSPDFImageList }

function TdxPSPDFImageList.AddBitmap(ABitmap: TBitmap): Integer;
begin
  Result := FindBitmap(ABitmap);
  if Result < 0 then
    Result := Add(TdxPSPDFImage.Create(Self, ABitmap));
end;

function TdxPSPDFImageList.FindBitmap(ABitmap: TBitmap): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Items[I].Compare(ABitmap) then
    begin
      Result := I;
      Break;
    end;
end;

function TdxPSPDFImageList.GetItem(Index: Integer): TdxPSPDFImage;
begin
  Result := TdxPSPDFImage(inherited Items[Index]);
end;

{ TdxPSPDFLength }

procedure TdxPSPDFLength.SaveTo(AWriter: TdxPSPDFWriter);
begin
  BeginSave(AWriter);
  try
    AWriter.WriteString(IntToStr(Length));
  finally
    EndSave(AWriter);
  end;
end;

{ TdxPSPDFPattern }

constructor TdxPSPDFCustomPattern.Create(
  AOwner: TdxPSPDFPatternList; APatternWidth, APatternHeight: Double);
begin
  inherited Create;
  FPatternWidth := APatternWidth;
  FPatternHeight := APatternHeight;
  FOwner := AOwner;
end;

function TdxPSPDFCustomPattern.Compare(APattern: TdxPSPDFCustomPattern): Boolean;
begin
  Result := ContentData = APattern.ContentData;
end;

function TdxPSPDFCustomPattern.GetContentData: string;
begin
  Result := '';
end;

function TdxPSPDFCustomPattern.GetContentStreamType(out AType: TdxPSPDFStreamType): Boolean;
begin
  AType := pstText;
  Result := Length(ContentData) > 0;
end;

function TdxPSPDFCustomPattern.GetName: string;
begin
  Result := sdxPDFPattern + IntToStr(PatternIndex);
end;

function TdxPSPDFCustomPattern.GetPatternIndex: Integer;
begin
  Result := FOwner.IndexOf(Self);
end;

class function TdxPSPDFCustomPattern.GetType: string;
begin
  Result := sdxPDFPattern;
end;

procedure TdxPSPDFCustomPattern.WriteContentStream(AWriter: TdxPSPDFWriter);
begin
  AWriter.WriteString(ContentData, False);
end;

procedure TdxPSPDFCustomPattern.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString(sdxPDFPatternType + sdxPDFSpace + '1');
  AWriter.WriteString(sdxPDFPaintType + sdxPDFSpace + '1');
  AWriter.WriteString(sdxPDFTilingType + sdxPDFSpace + '1');
  AWriter.WriteString(sdxPDFBBox + sdxPDFSpace + '[0 0' +
    sdxPDFSpace + dxPDFEncodeFloat(PatternWidth) +
    sdxPDFSpace + dxPDFEncodeFloat(PatternHeight) + ']');
  AWriter.WriteString(sdxPDFXStep + sdxPDFSpace + dxPDFEncodeFloat(PatternWidth));
  AWriter.WriteString(sdxPDFYStep + sdxPDFSpace + dxPDFEncodeFloat(PatternHeight));
  AWriter.WriteString(sdxPDFResources);
  AWriter.BeginParamsSet;
  try
    WritePatternResources(AWriter);
  finally
    AWriter.EndParamsSet;
  end;
end;

procedure TdxPSPDFCustomPattern.WritePatternResources(AWriter: TdxPSPDFWriter);
begin
end;

{ TdxPSPDFImagePattern }

constructor TdxPSPDFImagePattern.Create(AOwner: TdxPSPDFPatternList;
  APatternWidth, APatternHeight: Double; AImageIndex: Integer);
begin
  inherited Create(AOwner, APatternWidth, APatternHeight);
  FImageIndex := AImageIndex;
end;

function TdxPSPDFImagePattern.Compare(APattern: TdxPSPDFCustomPattern): Boolean;
begin
  Result := (APattern is TdxPSPDFImagePattern) and
    (TdxPSPDFImagePattern(APattern).ImageIndex = ImageIndex) and
    SameValue(PatternHeight, APattern.PatternHeight) and
    SameValue(PatternWidth, APattern.PatternWidth);
end;

function TdxPSPDFImagePattern.GetContentData: string;
begin
  Result := 'q' + #13#10 +
    dxPDFEncodeFloat(PatternWidth) + sdxPDFSpace + '0 0' + sdxPDFSpace +
    dxPDFEncodeFloat(PatternHeight) + sdxPDFSpace + '0 0 cm' + #13#10 +
    sdxPDFImage + IntToStr(ImageIndex) + sdxPDFSpace + 'Do' + #13#10 + 'Q'
end;

function TdxPSPDFImagePattern.GetImage: TdxPSPDFImage;
begin
  Result := Owner.Resources.ImageList.Items[ImageIndex];
end;

procedure TdxPSPDFImagePattern.WritePatternResources(AWriter: TdxPSPDFWriter);
begin
  AWriter.WriteString(sdxPDFXObject + sdxPDFSpace + '<<' +
    sdxPDFImage + IntToStr(ImageIndex) + sdxPDFSpace +
    AWriter.MakeLinkToObject(Image) + '>>');
end;

{ TdxPSPDFBrushPattern }

constructor TdxPSPDFBrushPattern.Create(
  AOwner: TdxPSPDFPatternList; AStyle: TBrushStyle; AColor: TColor);
begin
  inherited Create(AOwner, 6, 6);
  FStyle := AStyle;
  FColor := AColor;
end;

function TdxPSPDFBrushPattern.Compare(APattern: TdxPSPDFCustomPattern): Boolean;
begin
  Result := (APattern is TdxPSPDFBrushPattern) and
    (TdxPSPDFBrushPattern(APattern).Style = Style) and
    (TdxPSPDFBrushPattern(APattern).Color = Color);
end;

function TdxPSPDFBrushPattern.GetContentData: string;

  function Line(X0, Y0, X1, Y1: Double): string;
  begin
    Result := dxPDFMoveTo(X0, Y0) + dxPDFLineTo(X1, Y1);
  end;

begin
  Result := '';
  if Style in [bsHorizontal, bsCross] then
    Result := Result + Line(0, PatternHeight / 2, PatternWidth, PatternHeight / 2);
  if Style in [bsVertical, bsCross] then
    Result := Result + Line(PatternWidth / 2, 0, PatternWidth / 2, PatternHeight);
  if Style in [bsFDiagonal, bsDiagCross] then
    Result := Result + Line(0, PatternHeight, PatternWidth, 0);
  if Style in [bsBDiagonal, bsDiagCross] then
    Result := Result + Line(0, 0, PatternWidth, PatternHeight);
  Result := '0.5 w ' + dxPDFEncodeColor(Color) + sdxPDFSpace + ' RG ' + Result + 'S';
end;

{ TdxPSPDFPatternList }

constructor TdxPSPDFPatternList.Create(AResources: TdxPSPDFResources);
begin
  inherited Create;
  FResources := AResources;
end;

function TdxPSPDFPatternList.AddPattern(
  ABrushStyle: TBrushStyle; AColor: TColor): TdxPSPDFCustomPattern;
begin
  Result := AddPattern(TdxPSPDFBrushPattern.Create(Self, ABrushStyle, AColor));
end;

function TdxPSPDFPatternList.AddPattern(AImageIndex: Integer;
  APatternWidth, APatternHeight: Double): TdxPSPDFCustomPattern;
begin
  Result := AddPattern(TdxPSPDFImagePattern.Create(
    Self, APatternWidth, APatternHeight, AImageIndex));
end;

function TdxPSPDFPatternList.AddPattern(APattern: TdxPSPDFCustomPattern): TdxPSPDFCustomPattern;
var
  APatternIndex: Integer;
begin
  APatternIndex := FindPattern(APattern);
  if APatternIndex < 0 then
    APatternIndex := Add(APattern)
  else
    FreeAndNil(APattern);

  Result := Items[APatternIndex];
end;

function TdxPSPDFPatternList.FindPattern(APattern: TdxPSPDFCustomPattern): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
  begin
    if Items[I].Compare(APattern) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TdxPSPDFPatternList.GetItem(Index: Integer): TdxPSPDFCustomPattern;
begin
  Result := TdxPSPDFCustomPattern(inherited Items[Index]);
end;

{ TdxPSPDFSecurityOptions }

constructor TdxPSPDFSecurityOptions.Create;
begin
  inherited Create;
  FKeyLength := pekl128;
  FAllowActions := dxPSPDFDefaultAllowedActions;
end;

procedure TdxPSPDFSecurityOptions.Assign(Source: TPersistent);
begin
  if Source is TdxPSPDFSecurityOptions then
  begin
    FAllowActions := TdxPSPDFSecurityOptions(Source).AllowActions;
    FOwnerPassword := TdxPSPDFSecurityOptions(Source).OwnerPassword;
    FUserPassword := TdxPSPDFSecurityOptions(Source).UserPassword;
    FKeyLength := TdxPSPDFSecurityOptions(Source).KeyLength;
    FEnabled := TdxPSPDFSecurityOptions(Source).Enabled;
  end;
end;

function TdxPSPDFSecurityOptions.GetIsAllowActionsStored: Boolean;
begin
  Result := FAllowActions <> dxPSPDFDefaultAllowedActions;
end;

{ TdxPSPDFEncryptCustomHelper }

constructor TdxPSPDFEncryptCustomHelper.Create(AOptions: TdxPSPDFSecurityOptions);
begin
  inherited Create;
  FInfo := CreateEncryptInfo;
  FEnabled := AOptions.Enabled;
  if Enabled then
  begin
    CalculateFileKey;
    FEncryptionFlags := CalculateEncryptionFlags(AOptions.AllowActions);
    FOwnerKey := CalculateOwnerKey(AOptions);
    CalculateKey(AOptions);
    FUserKey := CalculateUserKey(AOptions); // note: must be last;
  end;
end;

destructor TdxPSPDFEncryptCustomHelper.Destroy;
begin
  FreeAndNil(FInfo);
  inherited Destroy;
end;

procedure TdxPSPDFEncryptCustomHelper.EncryptStream(
  AStream: TMemoryStream; AObjectIndex: Integer);
begin
  EncryptBuffer(AStream.Memory, AStream.Size, AObjectIndex);
end;

procedure TdxPSPDFEncryptCustomHelper.CalculateFileKey;
var
  ATempValue: string;
  I: Integer;
begin
  ATempValue := LowerCase(dxMD5CalcStr('123'));
  for I := 0 to 15 do
    FFileKey[I] := StrToInt('$' + ATempValue[2 * I + 1] + ATempValue[2 * (I + 1)]);
  FFileID := dxStringToAnsiString(ATempValue);
end;

procedure TdxPSPDFEncryptCustomHelper.CalculateKeyMD5(
  AOptions: TdxPSPDFSecurityOptions; out ADigest: TdxMD5Byte16);
var
  AContext: TdxMD5Context;
  AKey: TdxPDFPassKey;
  AUserPass: AnsiString;
begin
  ZeroMemory(@AKey, SizeOf(AKey));
  AUserPass := Copy(dxStringToAnsiString(AOptions.UserPassword), 1, Length(AKey));
  StrLCopy(@AKey[0], PAnsiChar(AUserPass), Length(AUserPass));
  if Length(AUserPass) < 32 then
    Move(dxPDFPassKey[0], AKey[Length(AUserPass)], 32 - Length(AUserPass));

  dxMD5Init(AContext);
  try
    dxMD5Update(AContext, @AKey[0], SizeOf(AKey));
    dxMD5Update(AContext, OwnerKey);
    dxMD5Update(AContext, @EncryptionFlags, SizeOf(EncryptionFlags));
    dxMD5Update(AContext, @FileKey[0], SizeOf(FileKey));
  finally
    dxMD5Final(AContext, ADigest);
  end;
end;

procedure TdxPSPDFEncryptCustomHelper.PopulateExportList(AList: TdxPSPDFObjectList);
begin
  if Enabled then
    FInfo.PopulateExportList(AList);
end;

{ TdxPSPDFEncryptCustomInfo }

constructor TdxPSPDFEncryptCustomInfo.Create(AEncryptHelper: TdxPSPDFEncryptCustomHelper);
begin
  inherited Create;
  FEncryptHelper := AEncryptHelper;
end;

procedure TdxPSPDFEncryptCustomInfo.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString(sdxPDFFilter + sdxPDFSpace + sdxPDFStandard);
  AWriter.WriteString('/O <' + StrToHexArray(EncryptHelper.OwnerKey) + '>');
  AWriter.WriteString('/U <' + StrToHexArray(EncryptHelper.UserKey) + '>');
  AWriter.WriteString('/P' + sdxPDFSpace + IntToStr(EncryptHelper.EncryptionFlags));
end;

{ TdxPSPDFEncrypt40Info }

procedure TdxPSPDFEncrypt40Info.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString('/V 1');
  AWriter.WriteString('/R 2');
end;

{ TdxPSPDFEncrypt128Info }

procedure TdxPSPDFEncrypt128Info.WriteHeader(AWriter: TdxPSPDFWriter);
begin
  inherited WriteHeader(AWriter);
  AWriter.WriteString('/V 2');
  AWriter.WriteString('/R 3');
  AWriter.WriteString(sdxPDFLength + sdxPDFSpace + '128');
end;

{ TdxPSPDFEncrypt40Helper }

procedure TdxPSPDFEncrypt40Helper.CalculateKey(AOptions: TdxPSPDFSecurityOptions);
var
  ADigest: TdxMD5Byte16;
begin
  CalculateKeyMD5(AOptions, ADigest);
  Move(ADigest[0], FKey[0], Min(SizeOf(ADigest), SizeOf(FKey)));
end;

function TdxPSPDFEncrypt40Helper.CalculateEncryptionFlags(
  AAllowActions: TdxPSPDFDocumentActions): Integer;
begin
  Result := $7FFFFFE0 shl 1;
  if pdaPrint in AAllowActions then
    Result := Result or 4;
  if pdaContentEdit in AAllowActions then
    Result := Result or 8;
  if pdaContentCopy in AAllowActions then
    Result := Result or 16;
  if pdaComment in AAllowActions then
    Result := Result or 32;
end;

function TdxPSPDFEncrypt40Helper.CalculateOwnerKey(AOptions: TdxPSPDFSecurityOptions): AnsiString;
var
  ADigest: TdxMD5Byte16;
  AKey: TdxRC4Key;
  APassKey: TdxPDFPassKey;
begin
  SetLength(Result, SizeOf(APassKey));
  PopulatePassKey(dxStringToAnsiString(AOptions.OwnerPassword), APassKey);
  dxMD5Calc(@APassKey[0], SizeOf(APassKey), ADigest);
  dxRC4Initialize(AKey, @ADigest, 5);
  PopulatePassKey(dxStringToAnsiString(AOptions.UserPassword), APassKey);
  dxRC4Crypt(AKey, @APassKey[0], @Result[1], SizeOf(APassKey));
end;

function TdxPSPDFEncrypt40Helper.CalculateUserKey(AOptions: TdxPSPDFSecurityOptions): AnsiString;
var
  AKey: TdxRC4Key;
  ATemp: TdxPDFPassKey;
  I: Integer;
begin
  Result := '';
  dxRC4Initialize(AKey, @Key, SizeOf(Key));
  dxRC4Crypt(AKey, @dxPDFPassKey[0], @ATemp[0], SizeOf(dxPDFPassKey));
  for I := Low(ATemp) to High(ATemp) do
    Result := Result + AnsiChar(ATemp[I]);
end;

function TdxPSPDFEncrypt40Helper.CreateEncryptInfo: TdxPSPDFEncryptCustomInfo;
begin
  Result := TdxPSPDFEncrypt40Info.Create(Self);
end;

procedure TdxPSPDFEncrypt40Helper.EncryptBuffer(
  ABuffer: PByteArray; ABufferSize, AObjectIndex: Integer);
var
  ADigest: TdxMD5Byte16;
  AFullKey: array [0..20] of Byte;
  AKey: TdxRC4Key;
begin
  if Enabled then
  begin
    ZeroMemory(@AFullKey[0], SizeOf(AFullKey));
    Move(Key[0], AFullKey[0], SizeOf(Key));
    Move(AObjectIndex, AFullKey[SizeOf(Key)], SizeOf(AObjectIndex));
    dxMD5Calc(@AFullKey[0], 10, ADigest);
    dxRC4Initialize(AKey, @ADigest, 10);
    dxRC4Crypt(AKey, ABuffer, ABuffer, ABufferSize);
  end;
end;

{ TdxPSPDFEncrypt128Helper }

function TdxPSPDFEncrypt128Helper.CalculateEncryptionFlags(
  AAllowActions: TdxPSPDFDocumentActions): Integer;
begin
  Result := $7FFFF860 shl 1;
  if pdaPrint in AAllowActions then
    Result := Result or 4;
  if pdaContentEdit in AAllowActions then
    Result := Result or 8;
  if pdaContentCopy in AAllowActions then
    Result := Result or 16;
  if pdaComment in AAllowActions then
    Result := Result or 32;
  if pdaDocumentAssemble in AAllowActions then
    Result := Result or 1024;
  if pdaPrintHighResolution in AAllowActions then
    Result := Result or 2048;
end;

procedure TdxPSPDFEncrypt128Helper.CalculateKey(AOptions: TdxPSPDFSecurityOptions);
var
  ADigest: TdxMD5Byte16;
  I: Integer;
begin
  CalculateKeyMD5(AOptions, ADigest);
  for I := 0 to 49 do
    dxMD5Calc(@ADigest[0], SizeOf(ADigest), ADigest);
  Move(ADigest[0], FKey[0], Min(SizeOf(ADigest), SizeOf(FKey)));
end;

function TdxPSPDFEncrypt128Helper.CalculateOwnerKey(AOptions: TdxPSPDFSecurityOptions): AnsiString;
var
  ADigest: TdxMD5Byte16;
  AKey: TdxRC4Key;
  APassKey: TdxPDFPassKey;
  ATempDigest: TdxMD5Byte16;
  I, J: Integer;
begin
  SetLength(Result, SizeOf(APassKey));
  PopulatePassKey(dxStringToAnsiString(AOptions.OwnerPassword), APassKey);
  dxMD5Calc(@APassKey[0], SizeOf(APassKey), ADigest);

  for I := 0 to 49 do
    dxMD5Calc(@ADigest[0], SizeOf(ADigest), ADigest);

  dxRC4Initialize(AKey, @ADigest, 16);
  PopulatePassKey(dxStringToAnsiString(AOptions.UserPassword), APassKey);
  dxRC4Crypt(AKey, @APassKey[0], @Result[1], SizeOf(APassKey));

  for I := 1 to 19 do
  begin
    for J := 0 to 15 do
      ATempDigest[J] := ADigest[J] xor I;
    dxRC4Initialize(AKey, @ATempDigest[0], SizeOf(ATempDigest));
    dxRC4Crypt(AKey, @Result[1], @Result[1], SizeOf(APassKey));
  end;
end;

function TdxPSPDFEncrypt128Helper.CalculateUserKey(AOptions: TdxPSPDFSecurityOptions): AnsiString;
var
  AContext: TdxMD5Context;
  ADigest: TdxMD5Byte16;
  AKey: TdxRC4Key;
  I, J: Integer;
  K: TdxPSPDFEncrypt128BitKey;
begin
  Randomize;
  dxMD5Init(AContext);
  try
    dxMD5Update(AContext, @dxPDFPassKey[0], SizeOf(dxPDFPassKey));
    dxMD5Update(AContext, @FileKey[0], SizeOf(FileKey));
  finally
    dxMD5Final(AContext, ADigest);
  end;

  for I := 0 to 19 do
  begin
    for J := 0 to 15 do
      K[J] := Key[J] xor I;
    dxRC4Initialize(AKey, @K[0], 16);
    dxRC4Crypt(AKey, @ADigest, @ADigest, 16 );
  end;

  SetLength(Result, 32);
  Move(ADigest[0], Result [1], 16);
  for I := 17 to 32 do
    Result[I] := AnsiChar(Random(200) + 32);
end;

function TdxPSPDFEncrypt128Helper.CreateEncryptInfo: TdxPSPDFEncryptCustomInfo;
begin
  Result := TdxPSPDFEncrypt128Info.Create(Self);
end;

procedure TdxPSPDFEncrypt128Helper.EncryptBuffer(
  ABuffer: PByteArray; ABufferSize, AObjectIndex: Integer);
var
  ADigest: TdxMD5Byte16;
  AFullKey: array [0..20] of Byte;
  AKey: TdxRC4Key;
begin
  if Enabled then
  begin
    Move(Key[0], AFullKey[0], SizeOf(Key));
    Move(AObjectIndex, AFullKey[SizeOf(Key)], SizeOf(AObjectIndex));
    dxMD5Calc(@AFullKey[0], 21, ADigest);
    dxRC4Initialize(AKey, @ADigest, 16);
    dxRC4Crypt(AKey, ABuffer, ABuffer, ABufferSize);
  end;
end;

end.
