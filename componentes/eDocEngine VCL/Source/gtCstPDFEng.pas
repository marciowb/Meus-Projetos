{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

{$IFDEF gtActiveX}
  {$R eDocEngineX.res}
{$ENDIF}

{.$DEFINE ONEView}

unit gtCstPDFEng;

interface
uses
  Windows, Classes, Graphics, SysUtils, Forms, gtConsts, gtDocConsts,
  gtCstPlnEng, gtCstDocEng, gtDocUtils, gtdzlib, gtClasses, gtPDFFont,
  gtUtils, gtDocResStrs, gtPDFCrypt, jpeg;

type
  TgtPDFPattern = (pHorizontal, pVertical, pFDiagonal, pBDiagonal, pCross,
    pDCross);

  TgtAnnotBrushStyle = (absSolid, absDashed, absBeveled, absInset,
    absUnderline);

  TgtPathStatus = (psPathBegins, psPathEnds, psNoPath);

  (* Compression Levels *)
  TgtCompressionLevel = (clFastest, clNormal, clMaxCompress);

	(* Ellipse Control Points. *)
	TgtEllipseCtrlPoints = record
		X1, X2, X3, X4, X5,
		Y1, Y2, Y3, Y4, Y5: Double;
	end;

	(*
    Line Type: Underline or Strikeout.
    Indicates whether font style is underline/strikeout.
  *)
	TgtLineType = (ltUnderline, ltStrikeOut);

	(* PDF Font Encoding Types. *)
	TgtPDFFontEncoding = (feWinAnsiEncoding, feMacRomanEncoding,
		feMacExpertEncoding, feStandardEncoding, fePDFDocEncoding);

  TgtTransitionEffect = (teNone, teSplitHorizontalInward,
    teSplitHorizontalOutward, teSplitVerticalInward, teSplitVerticalOutward,
    teBlindsHorizontal, teBlindsVertical, teBoxInward, teBoxOutward,
    teWipeLeftToRight, teWipeBottomToTop, teWipeRightToLeft, teWipeTopToBottom,
    teDissolve, teGlitterLeftToRight, teGlitterTopToBottom,
    teGlitterTopLeftToBottomRight);

  TgtPresentationMode = class(TPersistent)
  private
    FDuration: Integer;
    FTransitionEffect: TgtTransitionEffect;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Duration: Integer read FDuration write FDuration default 1;
    property TransitionEffect: TgtTransitionEffect read FTransitionEffect
      write FTransitionEffect default teNone;
  end;

  TgtPageLayout = (plSinglePage, plOneColumn, plTwoColumnLeft,
    plTwoColumnRight);

  TgtPageMode = (pmUseNone, pmUseOutlines, pmUseThumbs, pmFullScreen);

  TgtNonFullScreenPageMode = (nfspmUseNone, nfspmUseOutlines, nfspmUseThumbs);

  TgtViewerPreferences = class(TPersistent)
  private
    FPageLayout: TgtPageLayout;
    FPageMode: TgtPageMode;
    FHideToolBar: Boolean;
    FHideMenuBar: Boolean;
    FHideWindowUI: Boolean;
    FFitWindow: Boolean;
    FCenterWindow: Boolean;
    FNonFullScreenPageMode: TgtNonFullScreenPageMode;
    FPresentationMode: TgtPresentationMode;
    procedure SetPresentationMode(AValue: TgtPresentationMode);
    procedure SetCenterWindow(const Value: Boolean);
    procedure SetFitWindow(const Value: Boolean);
    procedure SetHideMenuBar(const Value: Boolean);
    procedure SetHideToolBar(const Value: Boolean);
    procedure SetHideWindowUI(const Value: Boolean);
    procedure SetNonFullScreenPageMode(
      const Value: TgtNonFullScreenPageMode);
    procedure SetPageLayout(const Value: TgtPageLayout);
    procedure SetPageMode(const Value: TgtPageMode);
  public
    constructor Create;
    destructor Destroy; override;
    function GetViewerPreferences(APageMode: TgtPageMode;
      APageLayout: TgtPageLayout; ACenterWindow, AFitWindow, AHideWindowUI,
      AHideMenuBar, AHideToolBar: Boolean;
      ANonFullScreenPageMode: TgtNonFullScreenPageMode): String;
    function GetTransitionEffectAndDuration(ADuration: Integer;
      ATransitionEffect: TgtTransitionEffect): String;
  published
    property PageLayout: TgtPageLayout read FPageLayout write SetPageLayout
      default plOneColumn;
    property PageMode: TgtPageMode read FPageMode write SetPageMode
      default pmUseNone;
    property HideToolBar: Boolean read FHideToolBar write SetHideToolBar
      default False;
    property HideMenuBar: Boolean read FHideMenuBar write SetHideMenuBar
      default False;
    property HideWindowUI: Boolean read FHideWindowUI write SetHideWindowUI
      default False;
    property FitWindow: Boolean read FFitWindow write SetFitWindow
      default False;
    property CenterWindow: Boolean read FCenterWindow write SetCenterWindow
      default False;
    property NonFullScreenPageMode: TgtNonFullScreenPageMode
      read FNonFullScreenPageMode write SetNonFullScreenPageMode
      default nfspmUseNone;
    property PresentationMode: TgtPresentationMode
      read FPresentationMode write SetPresentationMode;
  end;

  (*
    Thumbnail Object similar to TgtImageItem.
    Thumbnails doesnot support image properties like -
      Center, Stretch or Autosize
  *)
  TgtPDFThumbnailItem = class;

  TgtPDFThumbnailItem = class(TgtDocumentItem)
  private
    FOutputImageFormat: TgtOutputImageFormat;
    FImagePixelFormat: TPixelFormat;
    FJPEGQuality: Integer;
    FIndexNo: Integer;
    FObjNo: Integer;
    procedure SetImagePixelFormat(const Value: TPixelFormat);
    procedure SetIndexNo(const Value: Integer);
    procedure SetJPEGQuality(const Value: Integer);
    procedure SetOutputImageFormat(const Value: TgtOutputImageFormat);
    procedure SetObjNo(const Value: Integer);

  public
    constructor Create;
    destructor Destroy; override;

    property OutputImageFormat: TgtOutputImageFormat read FOutputImageFormat
      write SetOutputImageFormat;
    property ImagePixelFormat: TPixelFormat read FImagePixelFormat
      write SetImagePixelFormat;
    property JPEGQuality: Integer read FJPEGQuality write SetJPEGQuality;
    property IndexNo: Integer read FIndexNo write SetIndexNo;
    property ObjNo: Integer read FObjNo write SetObjNo;
    function IsEqual(AThumbnail: TgtPDFThumbnailItem): Boolean;

  end;

  (*
    Required for reuse image.
    Holds the settings of an already rendered image along with its assigned
    object no.
  *)
  TgtPDFImageSettings = class(TgtImageSettings)
  private
    FObjNo: Integer;

    (* Next 4 fields Required for Center. *)
    FImageWidth, FImageHeight, FDisplayWidth, FDisplayHeight: Double;
    procedure SetObjNo(const Value: Integer);
    procedure SetDisplayHeight(const Value: Double);
    procedure SetDisplayWidth(const Value: Double);
    procedure SetImageHeight(const Value: Double);
    procedure SetImageWidth(const Value: Double);
  public
    constructor Create; override;
    destructor Destroy; override;
    (*
      This functions checks whether the existing image can be reuseable
      for current image.
    *)
    function IsEqual(AObject: TgtImageItem;
      AOriginalWidth, AOriginalHeight: Integer): Boolean;

    property ObjNo: Integer read FObjNo write SetObjNo;
    property ImageWidth: Double read FImageWidth write SetImageWidth;
    property ImageHeight: Double read FImageHeight write SetImageHeight;
    property DisplayWidth: Double read FDisplayWidth write SetDisplayWidth;
    property DisplayHeight: Double read FDisplayHeight write SetDisplayHeight;

  end;

  TgtTTFontEmbedding = (etfNone, etfFull, etfSubset);

{ TgtPDFPreferences }

  TgtPDFPreferences = class(TgtPlainSheetPreferences)
  private
    FEmbedTrueTypeFonts: TgtTTFontEmbedding;
    procedure SetEmbedTrueTypeFonts(const Value: TgtTTFontEmbedding);

  public
    constructor Create; override;
    destructor Destroy; override;

  published
    property EmbedTrueTypeFonts: TgtTTFontEmbedding read FEmbedTrueTypeFonts
      write SetEmbedTrueTypeFonts default etfNone;
      
  end;
  
{------------------------------------------------------------------------------}
                                {TgtPDFEngine}
{------------------------------------------------------------------------------}

  (*
    This class maintains ObjectNo, Width & Height of each page.
    This will be used in Outlines and other places in general.
  *)
  TgtPageInfo = class(TObject)
  private
    FObjNo: Integer;
    FWidth, FHeight: Double;
    procedure SetHeight(const Value: Double);
    procedure SetObjNo(const Value: Integer);
    procedure SetWidth(const Value: Double);
  public
    property ObjNo: Integer read FObjNo write SetObjNo;
    property Width: Double read FWidth write SetWidth;
    property Height: Double read FHeight write SetHeight;
    
  end;

  TgtCompression = class(TPersistent)
  private
    FEnabled: Boolean;
    FLevel: TgtCompressionLevel;
    procedure SetEnabled(const Value: Boolean);
    procedure SetLevel(const Value: TgtCompressionLevel);

  public
    constructor Create;
    destructor Destroy; override;
    
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Level: TgtCompressionLevel read FLevel write SetLevel
      default clMaxCompress;
      
  end;

  TgtCustomPDFEngine = class(TgtCustomPlainSheetEngine)
  private
    (* Actual Encryption Object which does Encryption. *)
    FPDFEncrypt: TgtPDFEncryption;
    FEncryptionObjNo: Integer;
    (*
      Reference to Outline Dictionary.
    *)
    FOutlines: Integer;
    FThumbnailList: TStringList;
    FThumbnailReuseList: array of TStringList;
    (* FStream is used throughout to write the contents *)
    FContentStream: TMemoryStream;
    (*
      XReference Table which contains object no and stream position of the
        object.
    *)
    FXRefTable: TStringList;
    (* Holds background image object no. index. *)
    FBGImageObj: Integer;
		FBackgroundImageWidth: Extended;
		FBackgroundImageHeight: Extended;
		FBackgroundImageLeft: Extended;
		FBackgroundImageTop: Extended;    
    (* Holds current page content object no. *)
		FContentsObjNo: Integer;
    (* Holds current page content stream length object no. *)
		FLengthObjNo: Integer;
    (* Holds the last object no. *)
    FLastObjNo: Integer;
    (* Holds the reference to and position of image object in FImageStream. *)
    FImageXRefList: TStringList;
    (*
      Required for image reuse.
      For each TGraphic object in FImageResourceList, list of different settings
      is maintained.
    *)
    FImageSettings: array of TList;
    (*
      Stream used to store image objects.
      On EndPage, contents of FImageStream will be moved to FStream and cleared.
    *)
    FImageStream: TStream;
    FPattern: TStringList;

    FFontEncoding: TgtPDFFontEncoding;
    FFontEmbedExcludeList: TStringList;
    FCompression: TgtCompression;
    FViewerPreferences: TgtViewerPreferences;
    FEncryption: TgtPDFEncryptionSettings;

    FIsClipState : Boolean;
    FPathStatus  : TgtPathStatus;
    FIsPathClosed: Boolean;
    FFirstPoint : Boolean;
    FInitialPos : TgtPoint;
    FPath : String;
    FIsClipPath : Boolean;
    FBiDi: Boolean;

    procedure SetFontEncoding(const Value: TgtPDFFontEncoding);

		procedure AppendXRef(APos, AObjNo: Integer);
    (*
      Gets the stroke and fill operator ( n, s, f, b* )
      based on Pen and Brush styles.
    *)
		function CompletePDFPath(APen: TPen; ABrush: TBrush;
      CloseAndStroke: Boolean = False): String;
		function DrawBorder(AObject: TgtImageItem): String;
		function EncodeImageObjectRef(AIndex: String;
      AObject: TgtImageItem): String;
    (*
      Since EncodeArc can be used for EncodeChord, EncodePie; EncodePDFArc is
        just a wraper which will be used in EncodeArc, EncodeChord & EncodePie.
    *)
    function EncodePDFArc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double; Pen: TPen): String;
		function GetEllipseCtrlPts(
      PosX1, PosY1, PosX2, PosY2: Double): TgtEllipseCtrlPoints;
    (* Gets PDF Line Dash Pattern. *)
		function GetLineStyle(AStyle: TPenStyle): String;
		function PDFCurveto(X1, Y1, X2, Y2, X3, Y3: Double): String;
		function PDFShortArc(X, Y, RX, RY: Double; Alpha, Beta: Double): String;
		procedure WriteBackground;
    procedure WritePattern;
    (* Function to write outlines. *)
    procedure WriteOutlines;
    (* Function to write thumbnails. *)
    procedure WriteThumbnails;
		function SaveImageContents(ABitmap: TBitmap): Integer;
    procedure SetFontEmbedExcludeList(const Value: TStringList);
    procedure SetCompression(const Value: TgtCompression);
    function GetPreferences: TgtPDFPreferences;
    procedure SetPreferences(const Value: TgtPDFPreferences);
    procedure SetVeiwerPreferences(const Value: TgtViewerPreferences);
    procedure SetEncryption(const Value: TgtPDFEncryptionSettings);
    procedure SetBiDi(const Value: Boolean);
    function ConvertDelimiters(AString: String): String;

  protected
    (* Fields that will be used in Pro. *)
    (*
      Contains a list of references to annots in current page.
      This is used in Page dictionary.
    *)
    FAnnots: String;
    (* List of fonts used in the PDF file. *)
    FFontTable: TList;
    (* Holds page object nos. *)
    FPageList: TList;
    (*
      Unit used in PDF is Points.
      Convert all pixels units to points.
    *)
    FPixelToPointMultiplier: Double;
    (* FOutputStream will be set to o/p file or to specified UserStream *)
    FOutputStream: TStream;
    FCreationTime: String;

    function ToUnicodeHex(AStr: WideString; AObjNo, AGenNo: Integer): String;

    procedure EncodeEOF(AObject: TgtEOFItem); override;
    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeImage(AObject: TgtImageItem); override;
    procedure EncodeClipRect(AObject: TgtClipItem); override;      
    procedure EncodePathItem(AObject :TgtPathItem); override;   
    procedure EncodePolyDraw(AObject: TgtPolyDrawItem); override;  
    procedure EncodeImageStream(ImgStream: TgtImageStream); override;
    procedure EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen); override;
    procedure EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
      IsClosed: Boolean; Pen: TPen; Brush: TBrush); override;
    procedure EncodePolyPolyline(AObject: TgtPolyShapeItem;
    	IsClosed: Boolean); override;
    procedure EncodePolyPolygon(AObject: TgtPolyPolygonItem); override;
    procedure EncodeArc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
       Pen: TPen); override;
    procedure EncodePie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
       Pen: TPen; Brush: TBrush); override;
    procedure EncodeChord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
       Pen: TPen; Brush: TBrush); override;
    procedure EncodePolyBezier(Points: TgtPoints; NoPoints: Integer;
      Pen: TPen); override;
    procedure EndPage; override;
    procedure BeginPage; override;
    procedure Start; override;
    procedure Finish; override;
    function CheckOutputImageFormat(Value: TgtOutputImageFormat;
      var S: String): Boolean; override;
    function ShowSetupModal: Word; override;
    function GetPreferencesClassName: TgtPreferencesClass; override;
    function GetPattern(AStyle: TBrushStyle): String;

    (* Methods that will be used in Pro. *)
    (* Compress stream using ZLib. *)
		function CompressStream(InputStream, OutputStream: TStream;
      ACompressed: Boolean = True;
      ACompressionLevel: TgtCompressionLevel = clMaxCompress): Integer;
    function GetAnnotBrushStyle(Width: Integer = 1;
      Style: TgtAnnotBrushStyle = absSolid): String;      
    function GetImageFilter(OutputImageFormat: TgtOutputImageFormat): String;
    function GetNativeText(AStr: String): String;
    function GetNativeXPos(X: Extended): Extended;
    function GetNativeYPos(Y: Extended; PageNo: Integer): Extended;
		function GetNewObjNo: Integer;
    (* Function to return bitmap GRB stream. *)
    function GetPDFBitmapStream(ABitmap: TBitmap): TMemoryStream;
		function MakeObjHead(AObjNo: Integer): String;
		function MakeObjRef(AObjNo: Integer): String;
    (* Get No. in the regional settings format. *)
		function NumToStr(AN: Extended): String;
		procedure WriteObj(const AStr: String; AObjNo: Integer;
			AIsObjectComplete: Boolean);

    (* Methods that will be overriden in Pro. *)
    function GetCatalogDictionary: String; virtual;
    function GetPageDictionary(AObjNo: Integer): String; virtual;
    procedure WriteEncryptionDictionary; virtual;
    function GetTrailer: String; virtual;
    procedure WritePDFStream(var InputStream: TMemoryStream;
      StreamSize, ObjNo, GenNo: Integer); virtual;
    function WritePDFString(InputString: String;
      ObjNo, GenNo: Integer): String; virtual;
    {$IFDEF gtPro}
    function GetBitmapAsCCITTStream(ABitmap: TBitmap;
      AFormat: TgtOutputImageFormat): TMemoryStream; virtual;
    {$ENDIF}
  published
    property BiDi: Boolean read FBiDi write SetBiDi default False;
    property FileExtension;
    property FileDescription;
    property BackgroundColor;
    property BackgroundImage;
    property BackgroundImageDisplayType;
		property TextEffects;
    property FontEmbedExcludeList: TStringList read FFontEmbedExcludeList
      write SetFontEmbedExcludeList;
    property Compression: TgtCompression read FCompression write SetCompression;
    property Preferences: TgtPDFPreferences read GetPreferences
      write SetPreferences;
    property ViewerPreferences: TgtViewerPreferences read FViewerPreferences
      write SetVeiwerPreferences;
    property FontEncoding: TgtPDFFontEncoding read FFontEncoding write
      SetFontEncoding;
    property Encryption: TgtPDFEncryptionSettings read FEncryption write
      SetEncryption;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure TextOutV(X, Y: Double; Text: widestring; TopDown: Boolean = True); override;
    procedure DrawJPEGDirect(ARect: TgtRect;
      AImagePixelWidth, AImagePixelHeight: Integer; AStream: TStream); override;
    procedure DrawJPEGDirect(ImageRect: TgtRect; AGraphic: TGraphic); override;
    function AddTOCItem(Title: WideString; ParentNode, PageNumber: Integer;
      Top: Double): Integer; override;
    function AddTOCItem(Title: WideString; ParentNode: Integer;
      URL: String): Integer; override;
    procedure AddThumbnailImage(AGraphic: TGraphic; PageNo: Integer); overload;
    procedure AddThumbnailImage(Index, PageNo: Integer); overload;
  end;

const
	PDFFontEncodeStrings: array[TgtPDFFontEncoding] of String = (
		'WinAnsiEncoding', 'MacRomanEncoding', 'MacExpertEncoding',
		'StandardEncoding', 'PDFDocEncoding');
  ImageFilter: array[TgtOutputImageFormat] of String = ('/FlateDecode',
    '/DCTDecode', '/LZWDecode', '', '' {$IFDEF gtPro}, '[/CCITTFaxDecode]', '[/CCITTFaxDecode]' {$ENDIF});

implementation

uses
  Math(* Required for Font Subsetting. *), gtPDFEngDlg;

{ TgtCustomPDFEngine }

procedure TgtCustomPDFEngine.AppendXRef(APos, AObjNo: Integer);
begin
	FXRefTable.AddObject(IntToStr(APos), TObject(AObjNo));
end;

procedure TgtCustomPDFEngine.BeginDoc;
begin
  inherited;
end;

procedure TgtCustomPDFEngine.BeginPage;
var
  LS: String;
  LATemp : AnsiString;
  LPageInfo: TgtPageInfo;
  LI: Integer;

begin
  inherited;
  FIsClipState := False;
  FPathStatus := psNoPath;
  FIsPathClosed := False;
  FFirstPoint := True;
  FIsClipPath := False;
  FPath := '';
  FImageXRefList.Clear;
  TMemoryStream(FImageStream).Clear;
  TMemoryStream(FContentStream).Clear;

  (*
  	resolution transformation matrix: 96/rx  0  0  96/ry  0  0
    rx - input x-resolution
    ry - input y-resolution
  *)
  LS := 'q ' + NumToStr(CPixelsPerInch / InputXRes) + ' 0 0 ' +
  	NumToStr(CPixelsPerInch / InputYRes) + ' 0 0 cm' + CRLF;
  LATemp := AnsiString(LS);
  FContentStream.Write(LATemp[1], Length(LS));

  LPageInfo := TgtPageInfo.Create;
  with LPageInfo do
  begin
    ObjNo := GetNewObjNo;
    Width := Pages[CurrentPage - 1].Settings.Width * FPixelToPointMultiplier;
    Height := Pages[CurrentPage - 1].Settings.Height * FPixelToPointMultiplier;
  end;

  LI := FPageList.Count;
  while (LI < CurrentPage) do
  begin
    FPageList.Add(nil);
    Inc(LI);
  end;
  FPageList.Items[CurrentPage - 1] := LPageInfo;

	FContentsObjNo := GetNewObjNo;
  FAnnots := '';
	FLengthObjNo := GetNewObjNo;

  WriteBackground;
end;

function TgtCustomPDFEngine.CompletePDFPath(APen: TPen; ABrush: TBrush;
  CloseAndStroke: Boolean): String;
begin
  (* n - No Filling/Stroking *)
	Result := 'n';

  (*
    If Brush Style <> bsClear AND Pen Style <> psClear then
      b* - Close, Fill & Stroke the path using even-odd rule.
    Else If Brush Style <> bsClear then
      f* - Fill path using even-odd rule. Applies to Complex Shapes.
      Note: Use f - Fill path using Nonzero Winding rule. For simple shapes.
    Else If Pen Style <> psClear then
      s - Close and Stroke path.
      S - Stroke path.
  *)
  if
    (ABrush <> nil) and
    (ABrush.Style <> bsClear) and
    (APen <> nil) and
    (APen.Style <> psClear) then
    Result := 'b*'
  else if
    (ABrush <> nil) and
    (ABrush.Style <> bsClear) then
    Result := 'f*'
  else if
    (APen <> nil) and
    (APen.Style <> psClear) then
    begin
      if CloseAndStroke then
        Result := 's'
      else
        Result := 'S';
    end
end;

function TgtCustomPDFEngine.CompressStream(InputStream,
  OutputStream: TStream; ACompressed: Boolean;
  ACompressionLevel: TgtCompressionLevel): Integer;
var
	LCmprStream: TCompressionStream;
begin
	Result := InputStream.Size;
  if ACompressed then
  begin
    // Create Compression Stream.
    LCmprStream := TCompressionStream.Create(
      TCompressionLevel(ACompressionLevel), OutputStream);
    try
      Result := OutputStream.Size;
      InputStream.Position := 0;
      LCmprStream.Write(TMemoryStream(InputStream).Memory^, InputStream.Size);
    finally
      FreeAndNil(LCmprStream);
      Result := OutputStream.Size - Result;
    end;
  end
  else
    OutputStream.CopyFrom(InputStream, 0);
end;

constructor TgtCustomPDFEngine.Create(AOwner: TComponent);
begin
  inherited;
  FileExtension := 'pdf';
  FileDescription := SPDFDescription;
  (* 1 pixel = 0.75 points *)
  FPixelToPointMultiplier := CInchesToPoints / CPixelsPerInch;
  FCompression := TgtCompression.Create;
  FFontEmbedExcludeList := TStringList.Create;
  Capabilities := [ckText, ckImage, ckShape, ckImageStretch, ckImageFrame, ckInputRes];
  FViewerPreferences := TgtViewerPreferences.Create;
  FEncryption := TgtPDFEncryptionSettings.Create;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 101);
{$ENDIF}
end;

destructor TgtCustomPDFEngine.Destroy;
begin
  if (FOutputStream <> nil) and (not Preferences.OutputToUserStream) then
    FreeAndNil(FOutputStream);
  FreeAndNil(FCompression);
  FreeAndNil(FFontEmbedExcludeList);
  FreeAndNil(FViewerPreferences);
  FreeAndNil(FEncryption);
  inherited;
end;

function TgtCustomPDFEngine.DrawBorder(AObject: TgtImageItem): String;
var
	LPath: String;
  DispWidth, DispHeight: Double;
  X1, Y1, X2, Y2, X3, Y3, X4, Y4, Diagonal, DSin, DCos, Alpha: Double;
begin
  Result := '';
  with AObject do
  begin
    X1 := GetNativeXPos(DisplayRect.Left);
    Y1 := GetNativeYPos(DisplayRect.Top, CurrentPage);
    DispWidth := (DisplayRect.Right - DisplayRect.Left) *
      FPixelToPointMultiplier;
    DispHeight := (DisplayRect.Bottom - DisplayRect.Top) *
      FPixelToPointMultiplier;

    DSin := Sin(DegreesToRadians(Settings.Inclination));
    DCos := Cos(DegreesToRadians(Settings.Inclination));

    X2 := X1 + DispHeight * DSin;
    Y2 := Y1 - DispHeight * DCos;

    X4 := X1 + DispWidth * DCos;
    Y4 := Y1 + DispWidth * DSin;

    if DispWidth = 0 then
      Alpha := DegreesToRadians(Settings.Inclination) - PI
    else
      Alpha := DegreesToRadians(Settings.Inclination) -
        ArcTan(DispHeight / DispWidth);
    Diagonal := Sqrt((DispHeight * DispHeight) + (DispWidth * DispWidth));

    X3 := X1 + Diagonal * Cos(Alpha);
    Y3 := Y1 + Diagonal * Sin(Alpha);

    LPath := NumToStr(X1) + ' ' + NumToStr(Y1) + ' m ' +
      NumToStr(X2) + ' ' + NumToStr(Y2) + ' l ' +
      NumToStr(X3) + ' ' + NumToStr(Y3) + ' l ' +
      NumToStr(X4) + ' ' + NumToStr(Y4) + ' l ' +
      NumToStr(X1) + ' ' + NumToStr(Y1) + ' l ';      
                
    (* Fill Rect. *)
    if (Brush <> nil) then
    begin
      if (Brush.Style = bsSolid) then
        Result := CRLF + 'q' + CRLF + ColorToPDFColor(Brush.Color) + ' rg' + 
          CRLF + LPath + CRLF + 'f' + CRLF + 'Q'
      else if (Brush.Style <> bsClear) then
        (*
          Select color space - cs.
          Select color for non-stroking pattern - scn.
        *)
        Result := CRLF + 'q' + CRLF +
          '/CSP cs ' +
          ColorToPDFColor(Brush.Color) + ' /' + GetPattern(Brush.Style) + ' scn' +
          CRLF + 'n' +
          CRLF + LPath + CRLF +
          'h' + CRLF +
          'f' + CRLF +
          'Q';
    end;

    if Settings.IsFrame and (Pen.Style <> psClear) then
    begin
      // Line Style.
      Result := Result + CRLF + 'q' + CRLF + GetLineStyle(Pen.Style);

      // Border width, spacing and color.
      Result := Result + NumToStr(Pen.Width * FPixelToPointMultiplier) +
        ' w' + CR + ColorToPDFColor(Pen.Color) + ' RG';

      with Frame do
      begin
        if IsLeft and IsTop and IsRight and IsBottom then
          // Left, Bottom, width, height encoded as strings.
          Result := Result + CRLF + LPath + CRLF + ' s Q'
        else
        begin
          if IsLeft then
            Result := Result + CRLF + NumToStr(X2) + ' ' + NumToStr(Y2) + ' m ' +
              CRLF + NumToStr(X1) + ' ' + NumToStr(Y1) + ' l ';
          if IsTop then
            Result := Result + CRLF + NumToStr(X1) + ' ' + NumToStr(Y1) + ' m ' +
              CRLF + NumToStr(X4) + ' ' + NumToStr(Y4) + ' l ';
          if IsRight then
            Result := Result + CRLF + NumToStr(X4) + ' ' + NumToStr(Y4) + ' m ' +
              CRLF + NumToStr(X3) + ' ' + NumToStr(Y3) + ' l ';
          if IsBottom then
            Result := Result + CRLF + NumToStr(X3) + ' ' + NumToStr(Y3) + ' m ' +
             CRLF + NumToStr(X2) + ' ' + NumToStr(Y2) + ' l ';
          Result := Result + CRLF + 'S' + CRLF + 'Q';
        end;
      end;
    end; (* End if Pen.Style <> psClear *)
  end;
end;

procedure TgtCustomPDFEngine.EncodeArc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
  Pen: TPen);
var
  LS: String;
  LATemp : AnsiString;
begin
  if ((Pen.Width = 0) or (Pen.Style = psClear)) then
    Exit;

  // Line style.
  LS := GetLineStyle(Pen.Style) +
  // Width, spacing and color.
		NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
    ColorToPDFColor(Pen.Color) + ' RG ' +
    EncodePDFArc(GetNativeXPos(X1), GetNativeYPos(Y1, CurrentPage),
			GetNativeXPos(X2), GetNativeYPos(Y2, CurrentPage),	GetNativeXPos(X3),
			GetNativeYPos(Y3, CurrentPage), GetNativeXPos(X4),
			GetNativeYPos(Y4, CurrentPage), Pen) + ' S';
    if FIsClipState then
      LS := CRLF + LS + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
    if (LS <> '') then
    begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
    end;
end;

procedure TgtCustomPDFEngine.EncodeChord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
  Pen: TPen; Brush: TBrush);
var
  LS, LPath: String;
  LATemp : AnsiString;
	LPosX1, LPosY1, LPosX2, LPosY2, LPosX3, LPosY3, LPosX4, LPosY4: Extended;
begin
  if ((Pen.Width = 0) or (Pen.Style = psClear)) and
    ((Brush = nil) or ((Brush <> nil) and (Brush.Style = bsClear))) then
    Exit;
	LS := '';
  LPosX1 := GetNativeXPos(X1);
  LPosY1 := GetNativeYPos(Y1, CurrentPage);
  LPosX2 := GetNativeXPos(X2);
  LPosY2 := GetNativeYPos(Y2, CurrentPage);
  LPosX3 := GetNativeXPos(X3);
  LPosY3 := GetNativeYPos(Y3, CurrentPage);
  LPosX4 := GetNativeXPos(X4);
  LPosY4 := GetNativeYPos(Y4, CurrentPage);

  LPath := EncodePDFArc(LPosX1, LPosY1, LPosX2, LPosY2,	LPosX3, LPosY3,
    LPosX4, LPosY4, Pen);

  if (Brush <> nil) then
  begin
    if (Brush.Style = bsSolid) then
      LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
    else if Brush.Style <> bsClear then
      (*
        Select color space - cs.
        Select color for non-stroking pattern - scn.
      *)
      LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) +
      	' /' + GetPattern(Brush.Style) + ' scn n ' +
        EncodePDFArc(LPosX1, LPosY1, LPosX2, LPosY2,	LPosX3, LPosY3,
          LPosX4, LPosY4, Pen) + ' f ';
  end;

  if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
  begin
    // Line style.
    LS := LS + GetLineStyle(Pen.Style) +
	    // Width, spacing and color.
      NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
  end;
  if (LS <> '') then
  begin
    if FIsClipState then
  	  LS := CRLF + LS+ CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
	EllipseCtrlPts: TgtEllipseCtrlPoints;
	LS, LPath: String;
  LATemp : AnsiString;
	LPosX1, LPosY1, LPosX2, LPosY2: Extended;
begin
  if FPathStatus <> psPathBegins then
  begin
    LS := '';
    LPosX1 := GetNativeXPos(X1);
    LPosY1 := GetNativeYPos(Y1, CurrentPage);
    LPosX2 := GetNativeXPos(X2);
    LPosY2 := GetNativeYPos(Y2, CurrentPage);

    EllipseCtrlPts := GetEllipseCtrlPts(LPosX1, LPosY1, LPosX2, LPosY2);
    with EllipseCtrlPts do
    begin
      // Move to starting point.
      LPath := NumToStr(X3) + ' ' + NumToStr(Y1) + ' m ' +
      // Draw four Bezier curves to approximate an Ellipse.
        PDFCurveto(X4, Y1, X5, Y2, X5, Y3) + ' ' +
        PDFCurveto(X5, Y4, X4, Y5, X3, Y5) + ' ' +
        PDFCurveto(X2, Y5, X1, Y4, X1, Y3) + ' ' +
        PDFCurveto(X1, Y2, X2, Y1, X3, Y1) + ' ';

      if Brush <> nil then
      begin
        if Brush.Style = bsSolid then
          LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
        else if Brush.Style <> bsClear then
          (*
            Select color space - cs.
            Select color for non-stroking pattern - scn.
          *)
          LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) +
            ' /' + GetPattern(Brush.Style) + ' scn n ' + LPath + ' f';
      end;

      if (Pen.Style <> psClear) then
      begin
        // Line Style.
        LS := LS + GetLineStyle(Pen.Style) +
        // Width, spacing and color.
          NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
          ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
      end;
      if (LS <> '') then
      begin
        if FIsClipState then
          LS := CRLF + LS + CRLF
        else
          LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
          LATemp := AnsiString(LS);
        FContentStream.Write(LATemp[1], Length(LS));
      end;
    end;
  end
  else
  begin
    EllipseCtrlPts := GetEllipseCtrlPts(X1, Y1, X2, Y2);
    with EllipseCtrlPts do
    begin
      if FFirstPoint then// Move to starting point.
      begin
        FPath := FPath + NumToStr(GetNativeXPos(X3)) + ' ' +
          NumToStr(GetNativeYPos(Y1, CurrentPage)) + ' m ';
        FInitialPos := gtPoint(X3, Y1);
        FFirstPoint := False;
      end;
      X1 := GetNativeXPos(X1);
      X2 := GetNativeXPos(X2);
      X3 := GetNativeXPos(X3);
      X4 := GetNativeXPos(X4);
      X5 := GetNativeXPos(X5);
      Y1 := GetNativeYPos(Y1, CurrentPage);
      Y2 := GetNativeYPos(Y2, CurrentPage);
      Y3 := GetNativeYPos(Y3, CurrentPage);
      Y4 := GetNativeYPos(Y4, CurrentPage);
      Y5 := GetNativeYPos(Y5, CurrentPage);

      FPath := FPath + // Draw four Bezier curves to approximate an Ellipse.
        PDFCurveto(X4, Y1, X5, Y2, X5, Y3) + ' ' +
        PDFCurveto(X5, Y4, X4, Y5, X3, Y5) + ' ' +
        PDFCurveto(X2, Y5, X1, Y4, X1, Y3) + ' ' +
        PDFCurveto(X1, Y2, X2, Y1, X3, Y1) + ' ';
    end;
  end;
end;

procedure TgtCustomPDFEngine.EncodeEOF(AObject: TgtEOFItem);
var
  LS: String;
  LATemp : AnsiString;
begin
	LS := '';
  if AObject.Status then
  begin
    if FIsClipState then
    begin
      LS := ' Q ';
      FIsClipState := False;
    end;
    if FIsClipPath then
      LS := LS + ' q ';
  end;
  if (LS <> '') then
    begin
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;
end;

procedure TgtCustomPDFEngine.EncodeImage(AObject: TgtImageItem);
var
  LS: String;
  LATemp : AnsiString;
  LBitmap: TBitmap;
  LPDFBitmap: TMemoryStream; (* Stores PDF GRB sequence. *)
  LImgStream: TMemoryStream; (* Holds the final Image Stream. *)
  ImgObjNo: Integer;
  ImageIndex: String;

  (* Required for image reuse. *)
  LI: Integer;
  LImageSettings: TgtPDFImageSettings;

begin
	LS := '';
  LBitmap := nil;
  LPDFBitmap := nil;
  LImgStream := nil;
  ImageIndex := '';

  try
    with AObject do
    begin
      if not (irImage in ItemsToRender) then
        Exit;

      if TGraphic(FImageResourceList[IndexNo]) = nil then
        Exit;

      if (TGraphic(FImageResourceList[IndexNo]) <> nil) and
        TGraphic(FImageResourceList[IndexNo]).Empty then
        Exit;

      (*
        Different image items can point to same TGraphic object in
        FImageResourceList, but can have different settings.
        Hence for each TGraphic object in FImageResourceList,
        check if an image stream is already written with same setting.
      *)
      if Length(FImageSettings) >= (IndexNo + 1) then
      begin
        if (FImageSettings[IndexNo] <> nil) then
		    begin
          with FImageSettings[IndexNo] do
            for LI := 0 to Count - 1 do
              if TgtPDFImageSettings(Items[LI]).IsEqual(AObject,
                GetGraphicResource(IndexNo).Width,
                GetGraphicResource(IndexNo).Height) then
              begin
                with TgtPDFImageSettings(Items[LI]) do
                  ImageIndex := IntToStr(IndexNo) + IntToStr(LI);
                Break;
              end;
        end
        (* 
        	If IndexNo is not in sorted order, then
          just create an empty list.
        *)
        else FImageSettings[IndexNo] := TList.Create;
      end
      else
      begin
        SetLength(FImageSettings, (IndexNo + 1));
        FImageSettings[IndexNo] := TList.Create;
      end;

      (* If new image setting, render new image stream. *)
      if ImageIndex = '' then
      begin
        case Settings.OutputImageFormat of
          ifBMP:
          begin
            LBitmap := GetImageAsBitmap(AObject);
            LPDFBitmap := GetPDFBitmapStream(LBitmap);
            LImgStream := TMemoryStream.Create;
            CompressStream(LPDFBitmap, LImgStream, Compression.Enabled,
              Compression.Level);
            LImgStream.Position := 0;
          end;
          ifJPEG:
          begin
            LBitmap := GetImageAsBitmap(AObject);
            LImgStream := TMemoryStream(GetBitmapAsJPGGIFStream(LBitmap, True,
              Settings.JPEGQuality));
            LImgStream.Position := 0;
          end;
          {$IFDEF gtPro} 
          ifCCITT3:
          begin
            TgtImageItem(AObject).Settings.ImagePixelFormat := pf1bit;
            LBitmap := GetImageAsBitmap(AObject);
            LImgStream := GetBitmapAsCCITTStream(LBitmap, ifCCITT3);
            LImgStream.Position := 0;
          end;     
          ifCCITT4:
          begin
            TgtImageItem(AObject).Settings.ImagePixelFormat := pf1bit;
            LBitmap := GetImageAsBitmap(AObject);
            LImgStream := GetBitmapAsCCITTStream(LBitmap, ifCCITT4);
            LImgStream.Position := 0;
          end;
          {$ENDIF}
        end;
        ImgObjNo := GetNewObjNo;

        ImageIndex := IntToStr(IndexNo);

        LImageSettings := TgtPDFImageSettings.Create;
        with LImageSettings do
        begin
          Assign(Settings);
          ObjNo := ImgObjNo;
          DisplayWidth := DisplayRect.Right - DisplayRect.Left;
          DisplayHeight := DisplayRect.Bottom - DisplayRect.Top;
          ImageWidth := Width;
          ImageHeight := Height;
        end;

        ImageIndex := ImageIndex +
          IntToStr(FImageSettings[IndexNo].Add(LImageSettings));

        // Add obj to list so it can be reused where possible.
        FImageXRefList.AddObject(IntToStr(FImageStream.Size),
          TObject(ImgObjNo));

        (* Write Image Dictionary. *)
        LS :=
          MakeObjHead(ImgObjNo) + CRLF + '<< ' +
          '/Type/XObject' +
          '/Subtype/Image' +
          '/Name/Img' + ImageIndex +
          '/Width ' + IntToStr(LBitmap.Width) +
          '/Height ' + IntToStr(LBitmap.Height) + '/BitsPerComponent ';
        {$IFDEF gtPro} 
        if (Settings.OutputImageFormat = ifCCITT3) or
            (Settings.OutputImageFormat = ifCCITT4) then
          LS := LS + '1'
        else
        {$ENDIF}
          LS := LS + '8';
        LS := LS + GetImageFilter(Settings.OutputImageFormat);

        {$IFDEF gtPro} 
        if (Settings.OutputImageFormat = ifCCITT3) or
          (Settings.OutputImageFormat = ifCCITT4) then
        begin
          LS := LS + '/ColorSpace/DeviceGray /DecodeParms [<</K ';
          if Settings.OutputImageFormat = ifCCITT3 then
            LS := LS + '0'
          else
            LS := LS + '-1';
          LS := LS + ' /Columns ' + IntToStr(LBitmap.Width)+ ' /Rows ' +
            IntToStr(LBitmap.Height) + ' >>]';
        end
        else
        {$ENDIF}
          LS := LS + '/ColorSpace/DeviceRGB';

        LS := LS + '/Length ' + IntToStr(LImgStream.Size) + '>>' + CRLF +
          'stream' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LATemp[1], Length(LS));
        LImgStream.Position := 0;
        WritePDFStream(LImgStream, LImgStream.Size, ImgObjNo, 0);

        (* Save the image to a temp stream to write later. *)
        FImageStream.CopyFrom(LImgStream, 0);
        LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LATemp[1], Length(LS));
      end; (* End If *)

      (*
        Get PDF Image rendering operators to be written into content.
        Also draw any frame if required.
      *)
      LS := EncodeImageObjectRef(ImageIndex, AObject);
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end; (* End with *)
  finally
    FreeAndNil(LBitmap);
    FreeAndNil(LPDFBitmap);
    FreeAndNil(LImgStream);
  end;
end;

function TgtCustomPDFEngine.EncodeImageObjectRef(AIndex: String;
  AObject: TgtImageItem): String;
var
  LCos, LSin: Double;
  ImageLeft, ImageBottom, ImageAlpha, ImageLeftDx, ImageBottomDy,
    ImageDglDst: Double;
begin
  Result := '';
  with AObject do
  begin
  	if Width = 0 then
    	Width := 1;
    if Height = 0 then
    	Height := 1;
    if (Settings.Inclination = 0) or (Settings.Inclination = 360) then
      Result := CRLF + 'q' + CRLF +
        NumToStr(Abs(Width) * FPixelToPointMultiplier *(InputXRes / CPixelsPerInch)) +
        ' 0 0 ' +
        NumToStr(Abs(Height) * FPixelToPointMultiplier * (InputYRes / CPixelsPerInch)) + ' ' +
        NumToStr(GetNativeXPos(X)) + ' ' +
        NumToStr(GetNativeYPos(Y + Abs(Height), CurrentPage)) + ' cm' +
      CRLF + '/Img' + AIndex + ' Do' + CRLF + 'Q'
    else
    begin
      ImageLeftDx := X - DisplayRect.Left;
      ImageBottomDy := (Y + Height) - DisplayRect.Top;
      ImageDglDst := Sqrt((ImageLeftDx * ImageLeftDx) +
        (ImageBottomDy * ImageBottomDy));
      if ImageBottomDy = 0 then
        ImageAlpha := DegreesToRadians(Settings.Inclination) + PI
      else
        ImageAlpha := DegreesToRadians(Settings.Inclination) +
          ArcTan(ImageLeftDx / ImageBottomDy);
      ImageLeft := DisplayRect.Left + (ImageDglDst * Sin(ImageAlpha));
      ImageBottom := DisplayRect.Top + (ImageDglDst * Cos(ImageAlpha));

      LCos := Cos(DegreesToRadians(Settings.Inclination));
      LSin := Sin(DegreesToRadians(Settings.Inclination));

      // Translate
      Result := CRLF + 'q 1 0 0 1 ' + NumToStr(GetNativeXPos(ImageLeft)) + ' ' +
        NumToStr(GetNativeYPos(ImageBottom, CurrentPage)) +
        ' cm' + CR;

      // Rotate
      Result := Result + NumToStr(LCos) + ' ' +
                NumToStr(LSin) + ' ' +
                NumToStr(-LSin) + ' ' +
                NumToStr(LCos) + ' ' +
                '0 0' + ' cm' + CR;

      // Scale
      Result := Result +
        NumToStr(Abs(Width) * FPixelToPointMultiplier *(InputXRes / CPixelsPerInch)) + ' ' +
        NumToStr(0) + ' ' +
        NumToStr(0) + ' ' +
        NumToStr(Abs(Height) * FPixelToPointMultiplier *(InputYRes / CPixelsPerInch)) + ' ' +
        '0 0 cm' + CR;

      Result := Result + ' /Img' + AIndex + ' Do' + CRLF + 'Q';
    end;

    if Settings.IsFrame then
      Result := DrawBorder(AObject) + CRLF + Result;
  end;
end;

procedure TgtCustomPDFEngine.EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen);
var
  LS: String;
  LATemp : AnsiString;
{$IFDEF ONEView}
	LX, LY: Double;
{$ENDIF}
begin
  // Line Style.
{$IFDEF ONEView}
  if (X2 < X1) then
  begin
    LX := X2; LY := Y2;
    X2 := X1; Y2 := Y1;
    X1 := LX; Y1 := LY;
  end;
  if(X1 > (Page.Width - Page.LeftMargin)) then
    Exit;
  if (X2 > (Page.Width - Page.LeftMargin)) then
    X2 := (Page.Width - Page.LeftMargin);
{$ENDIF}
  if FPathStatus <> psPathBegins then
  begin
    if Pen.Style = psClear then
      Exit;

    if FIsClipState then
      LS := CRLF
    else
      LS := CRLF + 'q ';
      LS := LS + GetLineStyle(Pen.Style) +
    // Line width, spacing and color.
      NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' +
      NumToStr(GetNativeXPos(X1)) + ' ' +
      NumToStr(GetNativeYPos(Y1, CurrentPage)) + ' m ' +
      NumToStr(GetNativeXPos(X2)) + ' ' +
      NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' l ' +
      CompletePDFPath(Pen, nil);
    if FIsClipState then
      LS := LS + CRLF
    else
      LS := LS + CRLF + 'Q';
    if (LS <> '') then
    begin
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;
  end
  else
  begin
    if FFirstPoint then
    begin
      FPath := FPath + NumToStr(GetNativeXPos(X1)) + ' ' +
        NumToStr(GetNativeYPos(Y1, CurrentPage)) + ' m ' +
        NumToStr(GetNativeXPos(X2)) + ' ' +
        NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' l ';
      FInitialPos := gtPoint(X1,X2);
      FFirstPoint := False;
    end
    else
      FPath := FPath + NumToStr(GetNativeXPos(X2)) + ' ' +
        NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' l '
    end; 
end;

function TgtCustomPDFEngine.EncodePDFArc(
	X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double; Pen: TPen): String;

	function CalculateAngle(XCenter, YCenter, X, Y: Double): Double;
	begin
		if X > XCenter then
		begin
			Result := 360.0 + RadiansToDegrees(ArcTan((Y - YCenter) / (X - XCenter)));
			If Result >= 360.0 then
				Result := Result - 360.0;
		end
		else if X < XCenter then
			Result := 180.0 + RadiansToDegrees(ArcTan((Y - YCenter) / (X - XCenter)))
		else
		begin
			if Y > YCenter then
				Result := 90.0
			else
				Result := 270.0;
		end;
	end;

var
	XCenter, YCenter, RadiusX, RadiusY, StartX, StartY: Double;
	Alpha, Beta, TempAngle: Double;

begin
	// Calculate center & radius.
	XCenter := (X1 + X2) / 2.0;
	YCenter := (Y1 + Y2) / 2.0;
	RadiusX := Abs(X1 - X2) / 2.0;
	RadiusY := Abs(Y1 - Y2) / 2.0;

	Alpha := CalculateAngle(XCenter, YCenter, X3, Y3) + 180;
	Beta := CalculateAngle(XCenter, YCenter, X4, Y4) + 180;

	while (Beta <= Alpha) do
		Beta := Beta + 360;

	// Get starting point.
	StartX := XCenter - RadiusX * cos(DegreesToRadians(Alpha));
	StartY := YCenter - RadiusY * sin(DegreesToRadians(Alpha));

  if Pen.Style <> psClear then
  begin
    // Line style.
    Result := GetLineStyle(Pen.Style) +
    	// Width, spacing and color.
    	NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ';
  end;
  
	// Move to starting point.
	Result := Result + NumToStr(StartX) + ' ' + NumToStr(StartY) + ' m';

	while (Beta - Alpha > 90) do
	begin
		TempAngle := Alpha + 90;
		Result := Result + ' ' + PDFShortArc(XCenter, YCenter, RadiusX, RadiusY,
			Alpha, TempAngle);
		Alpha := TempAngle;
	end;
	if (Alpha <> Beta) then
		Result := Result + ' ' + PDFShortArc(XCenter, YCenter, RadiusX, RadiusY,
			Alpha, Beta);
end;

procedure TgtCustomPDFEngine.EncodePie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
  Pen: TPen; Brush: TBrush);
var
	LS, LPath: String;
  LATemp : AnsiString;
	LPosX1, LPosY1, LPosX2, LPosY2, LPosX3, LPosY3, LPosX4, LPosY4: Extended;
begin
  if ((Pen.Width = 0) or (Pen.Style = psClear)) and
  		((Brush = nil) or (Brush.Style = bsClear)) then
    Exit;
	LS := '';
  LPosX1 := GetNativeXPos(X1);
  LPosY1 := GetNativeYPos(Y1, CurrentPage);
  LPosX2 := GetNativeXPos(X2);
  LPosY2 := GetNativeYPos(Y2, CurrentPage);
  LPosX3 := GetNativeXPos(X3);
  LPosY3 := GetNativeYPos(Y3, CurrentPage);
  LPosX4 := GetNativeXPos(X4);
  LPosY4 := GetNativeYPos(Y4, CurrentPage);

  LPath := EncodePDFArc(LPosX1, LPosY1, LPosX2, LPosY2, LPosX3, LPosY3,
    LPosX4, LPosY4, Pen) + ' ' + NumToStr((LPosX1 + LPosX2) / 2.0) + ' ' +
    NumToStr((LPosY1 + LPosY2) / 2.0) + ' l';

  if Brush <> nil then
  begin
    if Brush.Style = bsSolid then
      LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
    else if Brush.Style <> bsClear then
      (*
        Select color space - cs.
        Select color for non-stroking pattern - scn.
      *)
      LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) +
      	' /' + GetPattern(Brush.Style) + ' scn n ' + LPath + ' f ';
  end;

  if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
  begin
    // Line Style.
    LS := LS + GetLineStyle(Pen.Style) +
	    // Width, spacing and color.
    	NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
  end;
  if (LS <> '') then
  begin
    if FIsClipState then
  	  LS := CRLF + LS+ CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyBezier(Points: TgtPoints;
  NoPoints: Integer; Pen: TPen);
var
  LI, LMax: Integer;
  LS: String;
  LATemp : AnsiString;
begin
  LI := 1;
  LMax := ((High(Points) div 3) * 3);
  if FPathStatus <> psPathBegins then
  begin
    if ((Pen.Width = 0) or (Pen.Style = psClear)) then
      Exit;
  LS := '';

	// Line style.
	LS := GetLineStyle(Pen.Style);
	// Width, spacing and color.
  if ((Pen.Width = 0) or (Pen.Style = psClear)) then
    LS := LS + NumToStr(0) + ' w ' + ColorToPDFColor(BackgroundColor) + ' RG '
  else
    LS := LS + NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
    	ColorToPDFColor(Pen.Color) + ' RG ';

  LS := LS + NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
    NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';

  while LI <= LMax do
  begin
    LS := LS + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
      NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' ' +
      NumToStr(GetNativeXPos(Points[LI + 1].X)) + ' ' +
      NumToStr(GetNativeYPos(Points[LI + 1].Y, CurrentPage)) + ' ' +
      NumToStr(GetNativeXPos(Points[LI + 2].X)) + ' ' +
      NumToStr(GetNativeYPos(Points[LI + 2].Y, CurrentPage)) + ' c ';
    LI := LI + 3;
  end;
  if FIsClipState then
    LS := CRLF + LS + 'S' + CRLF
  else
    LS := CRLF + 'q' + CRLF + LS + 'S' + CRLF + 'Q';
  if (NoPoints > 3) then
  begin
    if (LS <> '') then
      begin
      LATemp := AnsiString(LS);
      FContentStream.Write(LAtemp[1], Length(LS));
      end;
  end;
   end
   else
   begin
    if FFirstPoint then
    begin
      FPath := FPath + NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
      FInitialPos := gtPoint(Points[0].X,Points[0].Y);
      FFirstPoint := False;
    end;
    while LI <= LMax do
    begin
      FPath := FPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' ' +
        NumToStr(GetNativeXPos(Points[LI + 1].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI + 1].Y, CurrentPage)) + ' ' +
        NumToStr(GetNativeXPos(Points[LI + 2].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI + 2].Y, CurrentPage)) + ' c ';
      LI := LI + 3;
    end;

   end;
end;

procedure TgtCustomPDFEngine.EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
  IsClosed: Boolean; Pen: TPen; Brush: TBrush);
var
	LI: Integer;
	LS, LPath: String;
  LATemp : AnsiString;
    Stroke: Boolean;
    Fill: Boolean;
begin
  if FPathStatus <> psPathBegins then
  begin
    if IsClosed then
    begin
      if ((Pen.Width = 0) and (Pen.Style = psClear)) then
        if ((Brush = nil) or (Brush.Style = bsClear)) then
          Exit;
      LS := '';
	    LPath := NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
  	    NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
	    for LI := 1 to NoPoints - 1 do
		    LPath := LPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
    	    NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' l ';
      LPath := LPath + NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' l ';
      Stroke := False;
      Fill := False;
      if (Brush <> nil) then
      begin
        if Brush.Style = bsSolid then
        begin
          LS := LS + ColorToPDFColor(Brush.Color) + ' rg ';
          Fill := True;
        end
        else if Brush.Style <> bsClear then
          (*
            Select color space - cs.
            Select color for non-stroking pattern - scn.
          *)
          LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) +
            ' /' + GetPattern(Brush.Style) + ' scn n ' ;
      end;
      if ((Pen.Style <> psClear)) then
      begin
          // Line Style.
        LS := LS + GetLineStyle(Pen.Style) +
    	    // Line width, spacing and color.
			    NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
          ColorToPDFColor(Pen.Color) + ' RG ';
        Stroke := True;
      end;
      if Stroke then
      begin
        if Fill then
          LS := LS + LPath + ' B '
        else
          LS := LS + LPath + ' S '
      end
      else
      if Fill then
        LS := LS + LPath + ' f ';
    end
    else
    begin
      if Pen.Style = psClear then Exit;
      LS := '';
	    LPath := NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
  	    NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
	    for LI := 1 to NoPoints - 1 do
		    LPath := LPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
    	    NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' l ';
          // Line Style.
      LS := LS + GetLineStyle(Pen.Style) +
    	   // Line width, spacing and color.
			   NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
         ColorToPDFColor(Pen.Color) + ' RG ';
      LS := LS + LPath + ' S ';
    end;
    if (LS <> '') then
    begin
      if FIsClipState then
        LS := CRLF + LS + CRLF
      else
        LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;
  end
  else
  begin
    if FFirstPoint then
    begin
      LPath := NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
      FInitialPos := gtPoint(Points[0].X,Points[0].Y);
      FFirstPoint := False;
    end;
    for LI := 1 to NoPoints - 1 do
      LPath := LPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' l ';
    FPath := FPath + LPath;
  end;
end;

procedure TgtCustomPDFEngine.EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
  LS, LPath: String;
  LATemp :AnsiString;
begin
  LS := '';
  LPath := '';
  if FPathStatus <> psPathBegins then
  begin
    LPath := NumToStr(GetNativeXPos(X1)) + ' ' +
      NumToStr(GetNativeYPos(Y2 , CurrentPage)) + ' ' +
      NumToStr((X2 - X1) * FPixelToPointMultiplier * ( InputXRes /CPixelsPerInch)) + ' ' +
      NumToStr((Y2 - Y1) * FPixelToPointMultiplier* ( InputYRes /CPixelsPerInch)) + ' re';

    if (Brush <> nil) then
    begin
      if (Brush.Style = bsSolid) then
        LS := ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
      else if Brush.Style <> bsClear then
        (*
          Select color space - cs.
          Select color for non-stroking pattern - scn.
        *)
        LS := '/CSP cs ' + ColorToPDFColor(Brush.Color) +
          ' /' + GetPattern(Brush.Style) + ' scn n ' + LPath + ' f ';
    end;

    (* If Pen style is psClear, set stroke color (RG) to background color. *)
    if (Pen.Style <> psClear) then
    begin
      // Line Style.
      LS := LS + GetLineStyle(Pen.Style) +
        // Border width, spacing and color.
        NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
        ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
    end;
    if (LS <> '') then
    begin
      if FIsClipState then
        LS := CRLF + LS + CRLF
      else
        LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;
  end
  else
  begin
    LPath := NumToStr(GetNativeXPos(X1)) + ' ' +
      NumToStr(GetNativeYPos(Y2 , CurrentPage)) + ' ' +
      NumToStr((X2 - X1) * FPixelToPointMultiplier * ( InputXRes /CPixelsPerInch)) + ' ' +
      NumToStr((Y2 - Y1) * FPixelToPointMultiplier* ( InputYRes /CPixelsPerInch)) + ' re';

    FPath := FPath + LPath;
  end;
end;

procedure TgtCustomPDFEngine.EncodeClipRect(AObject : TgtClipItem);
var
  LTempRect : TRect;
  LI,LNo,LK,LJ : Integer;
  LS, LPath: String;
  LATemp : AnsiString;
  LClipPoints : array of TgtPoint;
begin
  LS := ' ';
  LPath := ' ';
  if not AObject.Restore then
  begin
    LNo := AObject.NoRects ;
    if LNo > 1 then
    begin
      SetLength(LClipPoints,LNo * 5);
      LK := 0;
      for LI := 1 to LNo - 1 do
      begin
        LTempRect := AObject.GetRects(LI);
        LClipPoints[LK] := gtPoint(LTempRect.Left,LTempRect.Top);
        LClipPoints[LK+1] := gtPoint(LTempRect.Right,LTempRect.Top);
        LClipPoints[LK+2] := gtPoint(LTempRect.Right,LTempRect.Bottom);
        LClipPoints[LK+3] := gtPoint(LTempRect.Left,LTempRect.Bottom);
        LClipPoints[LK+4] := gtPoint(LTempRect.Left,LTempRect.Top);
        LK := LK + 5;
      end;
      LJ := 0;
      for LK := 0 to LNo - 1 do
      begin
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LJ].Y, CurrentPage)) + ' m '+ CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ+1].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LJ+1].Y, CurrentPage)) + ' l '+ CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ+2].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LJ+2].Y, CurrentPage)) + ' l '+ CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ+3].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LJ+3].Y, CurrentPage)) + ' l '+ CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ+4].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LJ+4].Y, CurrentPage)) + ' l '+ CRLF;
        LJ := LJ + 5;
      end;
    end
    else
    begin
      LK := 0;
      LTempRect := AObject.GetRects(0);
      SetLength(LClipPoints , 5);

      LClipPoints[LK] := gtPoint(LTempRect.Left,LTempRect.Top);
      LClipPoints[LK+1] := gtPoint(LTempRect.Right,LTempRect.Top);
      LClipPoints[LK+2] := gtPoint(LTempRect.Right,LTempRect.Bottom);
      LClipPoints[LK+3] := gtPoint(LTempRect.Left,LTempRect.Bottom);
      LClipPoints[LK+4] := gtPoint(LTempRect.Left,LTempRect.Top);

      LK := 0;

      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LK].Y, CurrentPage)) + ' m '+ CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK+1].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LK+1].Y, CurrentPage)) + ' l '+ CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK+2].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LK+2].Y, CurrentPage)) + ' l '+ CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK+3].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LK+3].Y, CurrentPage)) + ' l '+ CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK+4].X)) + ' ' + NumToStr(GetNativeYPos(LClipPoints[LK+4].Y, CurrentPage)) + ' l '+ CRLF;
    end;
    if FIsClipState then
    begin
      if AObject.Mode = RGN_AND then
      begin
        if AObject.NoRects > 1 then
          LS := ' q ' + LPath + ' W* n ' + CRLF
        else
          LS := '';
      end
      else if AObject.Mode = RGN_COPY then
      begin
        LS := '';
      end;
    end
    else
    begin
      if AObject.Mode = RGN_AND then
      begin
          LS := ' q ' + LPath + ' W* n ' + CRLF
      end
      else if AObject.Mode = RGN_COPY then
      begin
        LS := ' q ' + LPath + ' W* n ' + CRLF;
      end;
      FIsClipState := True;
    end;
  end
  else
  begin
    if FIsClipState then
    begin
      LS := ' Q ' + CRLF;
      FIsClipState := False;
    end;
  end;
  if (LS <> '') then
  begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1],Length(LS) );
  end;
end;


procedure TgtCustomPDFEngine.EncodePathItem(AObject :TgtPathItem);
var
  LS: String;
  LATemp : AnsiString;
begin
  LS := '';
  with AObject do
  begin
    case PathOperation of
      poBeginPath :
      begin
        FPathStatus := psPathBegins;
        FFirstPoint := True;
        FPath := '';
      end;
      poEndPath :
      begin
        //Added...
        if FPathStatus = psPathBegins then
        begin
          FIsPathClosed := False;
          FPathStatus := psPathEnds;
        end;
      end;
      poCloseFigure :
      begin
        if FPathStatus = psPathBegins then
        //Added...
        begin
          FIsPathClosed := True;
          FPathStatus := psPathEnds;
        end;
      end;
      poAbortPath :
      begin
        FPath := ' n ' + CRLF;
        FPathStatus := psNoPath;
        LS := FPath;
      end;
      poFillPath :
      begin
        if FillAlternate then
          FPath := FPath + 'h f*' + CRLF
        else
          FPath := FPath + 'h f' + CRLF;
        FPathStatus := psNoPath;
        if Pen.Style = psClear then
          LS := ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF + FPath
        else
        begin
          if Brush.Style = bsClear then
          begin
            LS :=  GetLineStyle(Pen.Style) + NumToStr(Pen.Width * FPixelToPointMultiplier) +
              ' w ' + ColorToPDFColor(Pen.Color) + ' RG ' + CRLF + FPath;
          end
          else
          begin
            LS :=  GetLineStyle(Pen.Style) + NumToStr(Pen.Width * FPixelToPointMultiplier) +
              ' w ' + ColorToPDFColor(Pen.Color) + ' RG ' + ColorToPDFColor(Brush.Color) +
              ' rg ' + CRLF + FPath;
          end;
        end;
        FPath := '';
      end;
      poStrokeAndFillPath :
      begin
    {
        if FIsPathClosed then
        begin
          if FillAlternate then
            FPath := FPath + 'b* + CRLF'
          else
            FPath := FPath + 'b' + CRLF;
        end
        else
        begin
          if FillAlternate then
            FPath := FPath + 'B*' + CRLF
          else
            FPath := FPath + 'B' + CRLF;
        end;
    }
        FPathStatus := psNoPath;
        if Pen.Style = psClear then
        begin
          if FIsPathClosed then
          begin
            if FillAlternate then
              FPath := FPath + 'f* + CRLF'
            else
              FPath := FPath + 'f' + CRLF;
          end
          else
          begin
            if FillAlternate then
              FPath := FPath + 'F*' + CRLF
            else
              FPath := FPath + 'F' + CRLF;
          end;
          LS := ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF + FPath;
        end
        else
        begin
          if Brush.Style = bsClear then
          begin
            if FIsPathClosed then
            begin
              if FillAlternate then
                FPath := FPath + 's* + CRLF'
              else
                FPath := FPath + 's' + CRLF;
            end
            else
            begin
              if FillAlternate then
                FPath := FPath + 'S*' + CRLF
              else
                FPath := FPath + 'S' + CRLF;
            end;
            LS :=  GetLineStyle(Pen.Style) + NumToStr(Pen.Width * FPixelToPointMultiplier) +
              ' w ' + ColorToPDFColor(Pen.Color) + ' RG ' + CRLF + FPath;
          end
          else
          begin
            if FIsPathClosed then
            begin
              if FillAlternate then
                FPath := FPath + 'b* + CRLF'
              else
                FPath := FPath + 'b' + CRLF;
            end
            else
            begin
              if FillAlternate then
                FPath := FPath + 'B*' + CRLF
              else
                FPath := FPath + 'B' + CRLF;
            end;
            LS :=  GetLineStyle(Pen.Style) + NumToStr(Pen.Width * FPixelToPointMultiplier) +
              ' w ' + ColorToPDFColor(Pen.Color) + ' RG ' + ColorToPDFColor(Brush.Color) +
              ' rg ' + CRLF + FPath;
          end;
        end;
        FPath := '';
      end;
      poStrokePath :
      begin
        if FIsPathClosed then
          FPath := FPath + 's' + CRLF
        else
          FPath := FPath + 'S' + CRLF;
        FPathStatus := psNoPath;
        if Pen.Style = psClear then
          LS := ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF + FPath
        else
        begin
          if Brush.Style = bsClear then
          begin
            LS :=  GetLineStyle(Pen.Style) + NumToStr(Pen.Width * FPixelToPointMultiplier) +
              ' w ' + ColorToPDFColor(Pen.Color) + ' RG ' + CRLF + FPath;
          end
          else
          begin
            LS :=  GetLineStyle(Pen.Style) + NumToStr(Pen.Width * FPixelToPointMultiplier) +
              ' w ' + ColorToPDFColor(Pen.Color) + ' RG ' + ColorToPDFColor(Brush.Color) +
              ' rg ' + CRLF + FPath;
          end;
        end;
        FPath := '';
      end;
      poSelectClipPath :
      begin
        if FIsPathClosed then
            FPath := FPath + NumToStr(GetNativeXPos(FInitialPos.X)) + ' ' +
        NumToStr(GetNativeYPos(FInitialPos.Y, CurrentPage)) + ' l ';
        if Mode = RGN_COPY then
        begin
          if FIsClipPath then
            FPath := CRLF + ' Q q ' + CRLF + FPath + ' W* n ' + CRLF
          else
          begin
            FPath := CRLF + FPath + ' W* n ' + CRLF;
            FIsClipPath := True;
          end;
        end
        else if Mode = RGN_AND then
        //The new clipping region includes the intersection (overlapping areas)
        //of the current clipping region and the current path.
        //This means use non-zero winding rule. 
        begin
          if FIsClipPath then
            FPath := CRLF + ' q ' + CRLF + FPath + ' W n ' + CRLF
          else
          begin
            FPath := CRLF + FPath + ' W* n ' + CRLF;
            FIsClipPath := True;
          end;
        end;
        FIsClipState := True;
        FPathStatus := psNoPath;
        LS := FPath;
	FPath := '';
      end;
    end;
    if (LS <> '') then
    begin
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1],Length(LS));
    end;
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyDraw(AObject: TgtPolyDrawItem);
var
  LI: Integer;
begin
  with AObject do
  begin
    LI := 0;
    if FPathStatus = psPathBegins then
    begin
      while LI < FNoPoints  do
      begin
        case FOperations[LI] of
          PT_MOVETO:
          begin
            FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' + NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) + ' m '+ CRLF;
            LI := LI + 1;
          end;
          PT_LINETO:
          begin
            FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' + NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) + ' l '+ CRLF;
            LI := LI + 1;
          end;
          PT_BEZIERTO:
          begin
            FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' +
              NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) + ' ' +
              NumToStr(GetNativeXPos(FPoints[LI + 1].X)) + ' ' +
              NumToStr(GetNativeYPos(FPoints[LI + 1].Y, CurrentPage)) + ' ' +
              NumToStr(GetNativeXPos(FPoints[LI + 2].X)) + ' ' +
              NumToStr(GetNativeYPos(FPoints[LI + 2].Y, CurrentPage)) + ' c ';
            LI := LI + 3;
            if (FOperations[LI] = (PT_BEZIERTO or PT_CLOSEFIGURE)) then FIsPathClosed := True;
          end;
          PT_LINETO or PT_CLOSEFIGURE:
          begin
            FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' + NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) + ' l '+ CRLF;
            FIsPathClosed := True;
            LI := LI + 1;
          end;
          PT_BEZIERTO or PT_CLOSEFIGURE:
          begin
            LI := LI + 1;
          end;
        end;
      end;
    end;
  end;
end;


procedure TgtCustomPDFEngine.EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
  Pen: TPen; Brush: TBrush);
var
	EllipseCtrlPts: TgtEllipseCtrlPoints;
	LS, LPath: String;
  LATemp : AnsiString;
	RoundRectLineWidth, RoundRectLineHeight: Extended;
	LPosX1, LPosY1, LPosX3, LPosY3: Extended;
begin
	LS := '';
  if (Abs(Y2 - Y1) < Y3) then
    Y3 := Abs(Y2 - Y1) + 1;
  if (Abs(X2 - X1) < X3) then
    X3 := Abs(X2 - X1) + 1;
  LPosX1 := GetNativeXPos(X1);
  LPosY1 := GetNativeYPos(Y1, CurrentPage);
  LPosX3 := GetNativeXPos(X1 + X3);
  LPosY3 := GetNativeYPos(Y1 + Y3, CurrentPage);

  EllipseCtrlPts := GetEllipseCtrlPts(LPosX1, LPosY1, LPosX3, LPosY3);
  RoundRectLineWidth := GetNativeXPos(X2 - X1 - X3);
  RoundRectLineHeight := (Y2 - Y1 - Y3) * FPixelToPointMultiplier * ( InputYRes /CPixelsPerInch);

  with EllipseCtrlPts do
  begin
    // Move to starting point.
    LPath := NumToStr(X3) + ' ' + NumToStr(Y1) + ' m ' +
    // Draw RoundRect.
    	NumToStr(X3 + RoundRectLineWidth) + ' ' + NumToStr(Y1) + ' l ' +
    	PDFCurveto(X4 + RoundRectLineWidth, Y1, X5 + RoundRectLineWidth, Y2,
      	X5 + RoundRectLineWidth, Y3) + ' ' +
      NumToStr(X5 + RoundRectLineWidth) + ' ' +
      NumToStr(Y3 - RoundRectLineHeight) + ' l ' +
      PDFCurveto(X5 + RoundRectLineWidth, Y4 - RoundRectLineHeight,
      	X4 + RoundRectLineWidth, Y5 - RoundRectLineHeight,
        X3 + RoundRectLineWidth, Y5 - RoundRectLineHeight) + ' ' +
      NumToStr(X3) + ' ' + NumToStr(Y5 - RoundRectLineHeight) + ' l ' +
      PDFCurveto(X2, Y5 - RoundRectLineHeight, X1, Y4 - RoundRectLineHeight,
      	X1, Y3 - RoundRectLineHeight) + ' ' +
      NumToStr(X1) + ' ' + NumToStr(Y3) + ' l ' +
      PDFCurveto(X1, Y2, X2, Y1, X3, Y1);
  end;

  if Brush <> nil then
  begin
    if Brush.Style = bsSolid then
      LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
    else if Brush.Style <> bsClear then
      (*
        Select color space - cs.
        Select color for non-stroking pattern - scn.
      *)
    LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) +
    	' /' + GetPattern(Brush.Style) + ' scn n ' + LPath + ' f ';
  end;

  if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
  begin
    // Line Style.
    LS := LS + GetLineStyle(Pen.Style) +
    	// width, spacing and color.
    	NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
  end;
  if (LS <> '') then
  begin
    if FIsClipState then
      LS := CRLF + LS + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodeText(AObject: TgtTextItem);
var
  CosA, SinA: Double;
  LI, LK, FontIdx, LFontTableIndex, FontObjR, LCharVal: Integer;
  LTextSize: TSize;
  LS: String;
  LATemp : AnsiString;
  LOriginalText: WideString;
  TempStr: String;
  LUnicodeString: String;
  LString: WideString;
  LTempFontName: String;
  LTempCharSpace: array of Extended;
{$IFDEF ONEView}
  LTextWidth: Double;
{$ENDIF}
  ParseEncodeText, LinkText: String;
 LinkObjNo: Integer;
  StartPos: Integer;
  StartPt, EndPt: Extended;
  LPDFFont: TgtPDFFont;

  LSysFonts: TStringList;
 

  CharSpace: Extended;
  LCharSpace, {LCharCount, }LCalcSpace : Double;
  LCharCodeIndex, LCIDVal : Integer;

 

  SX1, SY1, SX2, SY2, SX3, SY3, SX4, SY4, SW, SH, SAlpha, SDgl: Double;
  TxtX1, TxtY1, TxtLeft, TxtBottom, TxtAlpha, TxtDgl, TxtDx, TxtDy: Double;
  LTextMetric1: tagTEXTMETRIC;

 

 function EncodeTextDecor(ALineType: TgtLineType): String;
 var
  W, Y: Extended;
    LX1, LY1, LLeftX, LLeftY, LRightX, LRightY, LDx, LDy, LDgl,
      LAlpha: Double;
    LFontInfo: TgtPDFFont;
 begin
    LFontInfo := TgtPDFFont.Create(AObject.Font, 0);
    try
      // Get accurate line width and position for underscore and strikeout, using
      // GDI functions. Enhanced in version 2.0.
      if ALineType = ltUnderline then
      begin
        W := LFontInfo.FontInfo.FfiUnderscoreSize;
        Y := LFontInfo.FontInfo.FfiUnderscorePosition;
      end
      else
      begin
        W := LFontInfo.FontInfo.FfiStrikeoutSize;
        Y := LFontInfo.FontInfo.FfiStrikeoutPosition;
      end;
      LX1 := TxtX1;
      LY1 := TxtY1 + Y;

 

      (* Calculate Left X, Y *)
      LDy := GetNativeYPos(AObject.Y, CurrentPage) - LY1;
      LDgl := LDy;
      LAlpha := DegreesToRadians(AObject.RotationAngle);
      LLeftX := LX1 + (LDgl * Sin(LAlpha));
      LLeftY := GetNativeYPos(AObject.Y, CurrentPage) - (LDgl * Cos(LAlpha));

 

      (* Calculate Right X, Y *)
      LDx := LTextSize.cx * FPixelToPointMultiplier;
      if not (AObject.IsFromMetafile) then
        LDx := LDx * 96 /CPixelsPerInch;
      LDy := GetNativeYPos(AObject.Y, CurrentPage) - LY1;
      LDgl := Sqrt((LDx * LDx) + (LDy * LDy));
      if LDy = 0 then
        LAlpha := DegreesToRadians(AObject.RotationAngle) + PI
      else
        LAlpha := DegreesToRadians(AObject.RotationAngle) + ArcTan(LDx / LDy);
      LRightX := LX1 + (LDgl * Sin(LAlpha));
      LRightY := GetNativeYPos(AObject.Y, CurrentPage) - (LDgl * Cos(LAlpha));

 

      Result :=  NumToStr(W) + ' w ' + NumToStr(LLeftX) + ' ' +
       NumToStr(LLeftY) + ' m ' + NumToStr(LRightX) + ' ' +
        NumToStr(LRightY) + ' l S';
    finally
      FreeAndNil(LFontInfo);
    end;
 end;

 

 function GetTextEffect: String;
  begin
  Result := '';
  with AObject.TextEffects do
    begin
      case TextRenderMode of
        trmFill: Result := Result + '0 Tr';
        trmStroke: Result := Result + '1 Tr';
        trmFillStroke: Result := Result + '2 Tr';
      end;
      case TextRise of
       trSuperscript: Result := Result + ' ' +
         NumToStr(AObject.Font.Size / 2) + ' Ts';
       trSubscript: Result := Result + ' ' +
         NumToStr(-AObject.Font.Size / 2) + ' Ts'
      end;
    end;
  end;

 

  function ShadeText: String;
  var
    LPath: String;
  begin
    Result := '';
    LPath := NumToStr(SX2) + ' ' + NumToStr(SY2) + ' m ' +
        NumToStr(SX3) + ' ' + NumToStr(SY3) + ' l ' +
        NumToStr(SX4) + ' ' + NumToStr(SY4) + ' l ' +
        NumToStr(SX1) + ' ' + NumToStr(SY1) + ' l ';

 

    with AObject do
    begin
      if (Brush.Style = bsSolid) then
      begin
        Result := CRLF + 'q' + CRLF + ColorToPDFColor(Brush.Color) + ' rg ' +
          LPath + ' f' + CRLF + 'Q'
      end
      else if (Brush.Style <> bsClear) then
        (*
          Select color space - cs.
          Select color for non-stroking pattern - scn.
        *)
        Result := CRLF + 'q' + CRLF +
         '/CSP cs ' + ColorToPDFColor(Brush.Color) +
         ' /' + GetPattern(Brush.Style) + ' scn n ' + LPath + ' f' +
          CRLF + 'Q';
    end;
  end;

 

 function GetPDFCharSpacing(AText: AnsiString): Extended;
 var
  I: Integer;
 begin
  Result := 0;
  if AText = '' then Exit;
  for I := 1 to Length(AText) do
    begin
      if (Ord(AText[I]) >= Low(LPDFFont.FontInfo.FfiWidths)) then
       Result := Result + LPDFFont.FontInfo.FfiWidths[Ord(AText[I])];
    end;
  Result := Result * AObject.Font.Size / 1000;
  Result := PixelsToPoints(LTextSize.cx) - Result;
  if Result = 0 then Exit;
  Result := Result / Length(AText);
 end;

 

  procedure Initialize;
  begin
    with AObject do
    begin
      TxtDx := 0;
      TxtDy := GetNativeYPos(Y, CurrentPage) - TxtY1;
      TxtDgl := TxtDy;
      TxtAlpha := DegreesToRadians(RotationAngle);
      TxtLeft := TxtX1 + (TxtDgl * Sin(TxtAlpha));
      TxtBottom := GetNativeYPos(Y, CurrentPage) - (TxtDgl * Cos(TxtAlpha));

 

      SX1 := GetNativeXPos(X);
      SY1 := GetNativeYPos(Y, CurrentPage);
      SW := LTextSize.cx * FPixelToPointMultiplier;
      SH := LTextSize.cy * FPixelToPointMultiplier;
      SX2 := SX1 + SH * SinA;
      SY2 := SY1 - SH * CosA;
      SX4 := SX1 + SW * CosA;
      SY4 := SY1 + SW * SinA;
      if SW = 0 then
        SAlpha := DegreesToRadians(RotationAngle) - PI
      else
        SAlpha := DegreesToRadians(RotationAngle) - ArcTan(SH / SW);
      SDgl := Sqrt((SH * SH) + (SW * SW));
      SX3 := SX1 + SDgl * Cos(SAlpha);
      SY3 := SY1 + SDgl * Sin(SAlpha);
    end;
  end;

 

{$IFDEF ONEView}
  function GetTextForWidth(AWidth: Double): String;
  var
    LI: Integer;
  begin
    Result := '';
    with AObject do
      for LI := 1 to Length(Lines[0]) do
      begin
        if TextSize(Result, Font).cx <= AWidth then
          Result := Result + Lines[0][LI]
        else
          Break;
      end;
  end;
{$ENDIF}

 

  function GetTextCilpRect: String;
  var
    LWd, LHt: Double;
  begin
     Result := '';
    with AObject do
    begin
      if (not IsClipRect) then
       Exit;
      LWd := ((ClipRect.Right - ClipRect.Left) * FPixelToPointMultiplier *(InputXRes / CPixelsPerInch));
      LHt := ((ClipRect.Bottom - ClipRect.Top) * FPixelToPointMultiplier * (InputYRes / CPixelsPerInch));
      Result := NumToStr(GetNativeXPos(ClipRect.Left)) + ' ' +
        NumToStr(GetNativeYPos(ClipRect.Bottom, CurrentPage)) + ' ' +
        NumToStr(LWd) + ' ' + NumToStr(LHt) + ' re W n' + CRLF;
    end;
  end;
                                            
begin
  with AObject do
  begin
    LOriginalText := Lines.Strings[0];
    if BiDi then
      Lines.Strings[0] := R2LString(Lines.Strings[0]);

 

    Lines.Strings[0] := ReplacePlaceHolders(Lines.Strings[0], True);
{$IFDEF ONEView}
    LTextwidth := (Page.Width - X - Page.LeftMargin);
    if LTextWidth < 0 then
    begin
      LTextWidth := 0;
      Lines[0] := '';
    end;
    if (((X + Page.LeftMargin + TextSize(Lines[0], Font).cx) >
      (Page.Width)) and (LTextWidth > 0)) then
      Lines[0] := GetTextForWidth(LTextwidth);
{$ENDIF}
    LSysFonts := TStringList.Create;
    try
      LSysFonts.AddStrings(Screen.Fonts);
      for LI := 0 to LSysFonts.Count - 1 do
    begin
        LTempFontName := LowerCase(LSysFonts.Strings[LI]);
      if (CompareStr(LTempFontName,LowerCase(AObject.Font.Name)) = 0) then
      begin
          AObject.Font.Name := LSysFonts.Strings[LI];
        Break;
      end;
      end;
    finally
      FreeAndNil(LSysFonts);
    end;
    FontIdx := -1;
    for LI := 0 to FFontTable.Count - 1 do
    begin
      if (TgtPDFFont(FFontTable.Items[LI]).IsEqual(Font)) then
        FontIdx := LI;
    end;

    if FontIdx = -1 then
    begin
      FontObjR := GetNewObjNo;
      LPDFFont := TgtPDFFont.Create(Font, FontObjR,
        (Preferences.EmbedTrueTypeFonts = etfSubset));

      FontIdx := FFontTable.Add(LPDFFont);
    end
    else
      LPDFFont := TgtPDFFont(FFontTable.Items[FontIdx]);

    LTextSize := TextSize(RemoveTerminalCRLF(AnsiString(Lines.Strings[0])), Font);
    CharSpace := GetPDFCharSpacing(RemoveTerminalCRLF(AnsiString(Lines.Strings[0])));

(*    if ((Font.Charset = ANSI_CHARSET) or (Font.Charset = SYMBOL_CHARSET)
      or ((Font.Charset = DEFAULT_CHARSET) and (GetACP = CANSIWinCode))) then
          LCharSpace := 0;*)
    (*
      Render the text at LX, LY; LY indicates the Baseline of the text.
      Font.Size gives the whole text size including underline.
      To confirm this -
      Ex.: Draw a Text and a Line at (x, y) to a Bitmap and compare the results.
    *)
    TxtX1 := GetNativeXPos(X);
    TxtY1 := GetNativeYPos(Y, CurrentPage);
    {ToDo: Add LPDFFont.FontInfo.FfiUnderscoreSize for underlined fonts???}
    TxtY1 := TxtY1 - Font.Size;
    //if IsFromMetafile then
    //  TxtY1 := TxtY1 + LPDFFont.FontInfo.FfiUnderscoreSize ;

    CosA := Cos(DegreesToRadians(RotationAngle));
    SinA := Sin(DegreesToRadians(RotationAngle));

    Initialize;

    LS := CRLF + ShadeText + CRLF;
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));

    LFontTableIndex := -1;
    for LK := 0 to FFontTable.Count - 1 do
    begin
      if (TgtPDFFont(FFontTable.Items[LK]).IsEqual(Font)) then
      begin
        LFontTableIndex := LK;
        Break;
      end;
    end;

    (* If font charset is ANSI_CHARSET. *)
    if ((Font.Charset = ANSI_CHARSET) or (Font.Charset = SYMBOL_CHARSET)
      or ((Font.Charset = DEFAULT_CHARSET) and (GetACP = CANSIWinCode))) then
    begin
      LS := CRLF + ' q ' + GetTextCilpRect + 'BT' + CRLF + GetTextEffect + CRLF +
        ColorToPDFColor(Font.Color) + ' rg'  + CRLF;
      if (CPixelsPerInch = 96) or (IsFromMetafile) then
      begin
        if(IsFromMetafile) then
        begin
          CharSpace := 0;
        end;
        LS := LS + Format('/F%d %s Tf', [FontIdx, NumToStr(Font.Size)])+ CRLF +
          Format(' %s Tc ', [NumToStr(CharSpace)]);
      end   //Is from Metafile
      else
      begin
        LS := LS + Format('/F%d %s Tf',
          [FontIdx, NumToStr(Font.Size/(CPixelsPerInch/96))]) + CRLF +
        Format(' %s Tc ', [NumToStr(CharSpace/(CPixelsPerInch/96))]);
      end;
      LS := LS + '0 Tw' + CRLF;
      if (RotationAngle <> 0) and (RotationAngle <> 360) then
        LS := LS + Format('%s %s %s %s %s %s Tm ' + CRLF + '(%s) Tj',
      [NumToStr(CosA), NumToStr(SinA),
        NumToStr(-SinA), NumToStr(CosA), NumToStr(TxtLeft),
        NumToStr(TxtBottom),
            StringToEscapeString(String(RemoveTerminalCRLF(AnsiString(Lines.Strings[0]))))])+
            CRLF + 'ET Q '
      else
      if IsFromMetafile then
      begin
        LS := LS + Format('%s %s Td' + CRLF , [NumToStr(TxtLeft),
              NumToStr(TxtBottom)]);

		Lines.Strings[0] := ReplaceString(Lines.Strings[0], #9, ' ');              

        LString := StringToEscapeString(String(RemoveTerminalCRLF(AnsiString(Lines.Strings[0]))));
        SetLength(LTempCharSpace,Length(Lines.Strings[0]));
        //LTemp1 := TxtX1;
        for LI := 0 to Length(Lines.Strings[0]) - 1 do
        begin  
          if(LFontTableIndex > -1) then
          begin
            LCharVal := ord(Lines.Strings[0][LI+1]);
            if(LCharVal > 255) then
            begin
              //LCalcSpace := TgtPDFFont(FFontTable.Items[LFontTableIndex]).FontInfo.FfiAvgWidth * Font.Size /1000
              LCalcSpace := TextSize(Lines.Strings[0][LI+1], Font).cx * FPixelToPointMultiplier ;
            end
            else
              LCalcSpace :=  (TgtPDFFont(FFontTable.Items[LFontTableIndex]).FontInfo.FfiWidths[ord(LOriginalText[LI+1])] * Font.Size /1000);
          end
          else
            LCalcSpace :=  Textsize(Lines.Strings[0][LI+1], Font).cx;
         LTempCharSpace[LI] := (LCalcSpace - (FCharSpaceArray[LI]* FPixelToPointMultiplier))/Font.Size *1000;
        end;

        LS := LS + '[' ;
        LK := 0;
        TempStr := '';
        for LI := 0 to Length(Lines.Strings[0]) - 1 do
        begin
          if LString[LK + 1] = '\' then
          begin
            TempStr := TempStr + LString[LK + 1] + LString[LK + 2]  ;
            LK := LK + 1;
          end
          else
            TempStr := TempStr + LString[LK + 1] ;
          LK := LK + 1;
          if (LTempCharSpace[LI] <> 0) or (LI = (Length(Lines.Strings[0]) - 1)) then
          begin
            if(LI =  Length(Lines.Strings[0]) - 1) then
              LS := LS + '(' + TempStr + ')'
            else
              LS := LS + '(' + TempStr + ')' + NumToStr(LTempCharSpace[LI]) ;
            TempStr := '';
          end;
        end;
        LS := LS + ' ]TJ ' + CRLF + 'ET Q ';
      end
      else
        LS := LS + Format('%s %s Td' + CRLF + '(%s) Tj', [NumToStr(TxtLeft),
          NumToStr(TxtBottom), StringToEscapeString(String(RemoveTerminalCRLF(AnsiString(Lines.Strings[0]))))]) +
          CRLF + 'ET Q ';
      if (Preferences.EmbedTrueTypeFonts = etfSubset) and
          (TgtPDFFont(FFontTable.Items[FontIdx]).FontInfo.FfiType = ftTrueType) and
          (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
        LUnicodeString :=
          TgtPDFFont(FFontTable.Items[FontIdx]).GetGlyphIndiciesA(
            Lines.Strings[0], Font.Charset);
    end
    else   //If Non- ANSI
      if (TgtPDFFont(FFontTable.Items[FontIdx]).FontInfo.FfiType =
        ftTrueType) then
    (* For Non-ANSI_CHARSET fonts, get CID values for text. *)
    begin //tab
    if(IsFromMetafile) then
    begin
      //LCharCount := Length(Lines.Strings[0]);
      LCharSpace := 0;
      LCalcSpace := 0;
      SetLength(LTempCharSpace,Length(Lines.Strings[0]));
      //Calculate the width of the String.
      for LI := 0 to Length(Lines.Strings[0]) - 1 do
      begin
        if(LFontTableIndex > -1) then
        begin
          LCharVal := ord(Lines.Strings[0][LI+1]);
          //Get Index from FCharCode list for the respective Char value.
          if((TgtPDFFont(FFontTable.Items[LFontTableIndex]).FCharCode <> nil) and
              (TgtPDFFont(FFontTable.Items[LFontTableIndex]).FCID <> nil) and
              (TgtPDFFont(FFontTable.Items[LFontTableIndex]).FWidths <> nil)) then
          begin
            LCharCodeIndex := Integer((TgtPDFFont(FFontTable.Items[LFontTableIndex]).FCharCode.IndexOf(TObject(LCharVal))));
            if((LCharCodeIndex <> -1) and (LCharCodeIndex <=
                TgtPDFFont(FFontTable.Items[LFontTableIndex]).FCID.Count)) then
            begin
              //Use that Index to point to FCID list to get CID value.
              LCIDVal := Integer(TgtPDFFont(FFontTable.Items[LFontTableIndex]).FCID[LCharCodeIndex]);
              //Get the width from the /W (FWidths) array.
              if(LCIDVal <= TgtPDFFont(FFontTable.Items[LFontTableIndex]).FWidths.Count) then
                LCalcSpace :=  Integer(TgtPDFFont(FFontTable.Items[LFontTableIndex]).FWidths.Objects[LCIDVal]) * Font.Size /1000;
            end //if LCharCodeIndex is valid
            else
              LCalcSpace := Textsize(Lines.Strings[0][LI+1], Font).cx * FPixelToPointMultiplier;
          end //if the list is not null
          else
            LCalcSpace := Textsize(Lines.Strings[0][LI+1], Font).cx * FPixelToPointMultiplier;
        end//if LFontTableIndex > -1
        else
          LCalcSpace := Textsize(Lines.Strings[0][LI+1], Font).cx * FPixelToPointMultiplier;
        //Calculate PDF spaceing TJ
        LTempCharSpace[LI] := (LCalcSpace - (FCharSpaceArray[LI]* FPixelToPointMultiplier))/Font.Size *1000;
      end;//For
      (*
      //calculate the space in which text item has to fit in from FCharSpaceArray..
      for LI := 0 to Length(Lines.Strings[0]) - 2 do
      begin
        LCharSpace := LCharSpace +  FCharSpaceArray[LI];
      end;
      LCharSpace :=  LCharSpace + TextSize(Lines.Strings[0][Length(Lines.Strings[0])], Font).cx ;
      //substract the text item width from the exact space.
      LCharSpace := (LCharSpace * FPixelToPointMultiplier) - LCalcSpace;
      //remaining space is devided for each character. This is the value of Tc.
      LCharSpace := LCharSpace /LCharCount;
      *)
       if(LCharSpace <> 0) then
          CharSpace := LCharSpace ;
    end;
(*        LUnicodeString := TgtPDFFont(FFontTable.Items[FontIdx]).GetGlyphIndiciesForNonANSI(
            Lines.Strings[0], Font.Charset);    

        LI := 0;
        for LJ := 1 to Length(LUnicodeString)  do
        begin
          LS := LS + LUnicodeString[LJ];
          if((LUnicodeString[LJ] = '>') and (LJ <> Length(LUnicodeString)) ) then
          begin
            LS := LS + NumToStr(LTempCharSpace[LI]) ;
            LI := LI + 1;
          end;
        end;
        CharSpace := 0;
        LS := Format('%s %s Td [%s] TJ', [NumToStr(TxtLeft),
          NumToStr(TxtBottom {- LTextMetric1.tmAscent}), LS]) + CRLF + 'ET Q ';
        LS := NumToStr(CharSpace) + ' Tc' + CRLF + LS;
        LS := '0 Tw' + CRLF + LS;
        //LS := '1. 0. 0. -1. 0. 0. Tm'+ CRLF + LS;
        LS := CRLF + ' q ' + GetTextCilpRect + 'BT' + CRLF + GetTextEffect + CRLF +
          ColorToPDFColor(Font.Color) + ' rg' + CRLF +
            Format('/F%d %d Tf', [FontIdx, Font.Size]) + CRLF + LS;

 
*)

      if (TgtPDFFont(FFontTable.Items[FontIdx]).FontInfo.FfiType =
        ftTrueType) then
    (* For Non-ANSI_CHARSET fonts, get CID values for text. *)
    begin
      LUnicodeString :=
        TgtPDFFont(FFontTable.Items[FontIdx]).GetGlyphIndiciesW(
          Lines.Strings[0], Font.Charset);
      LS := LUnicodeString;
      // Done after v2.11: Rotation for non ansi charset texts
      if (RotationAngle <> 0) and (RotationAngle <> 360) then
        LS := Format('%s %s %s %s %s %s Tm ' + CRLF + '<%s> Tj',
				  [NumToStr(CosA), NumToStr(SinA),
				    NumToStr(-SinA), NumToStr(CosA), NumToStr(TxtLeft),
				    NumToStr(TxtBottom),
            LS]) +
            CRLF + 'ET Q '
      else
        LS := Format('%s %s Td <%s> Tj', [NumToStr(TxtLeft),
          NumToStr(TxtBottom), LS]) + CRLF + 'ET Q ';
      //LS := '0 Tc' + CRLF + LS;
	  LS := NumToStr(CharSpace) + ' Tc' + CRLF + LS;
      LS := '0 Tw' + CRLF + LS;
      LS := CRLF + ' q ' + GetTextCilpRect + 'BT' + CRLF + GetTextEffect + CRLF +
      	ColorToPDFColor(Font.Color) + ' rg' + CRLF +
          Format('/F%d %d Tf', [FontIdx, Font.Size]) + CRLF + LS;
    end;

    end;
//    {$ELSE}
//      ;
//    {$ENDIF}
  // Draw your own underlines and strikeouts, no help from PDF here!
  if fsUnderline in Font.Style then
   LS := LS + CRLF + 'q' + CRLF + ColorToPDFColor(Font.Color) + ' RG ' +
        EncodeTextDecor(ltUnderline) + CRLF + 'Q';
  if fsStrikeOut in Font.Style then
      LS := LS + CRLF + 'q' + CRLF + ColorToPDFColor(Font.Color) + ' RG ' +
     EncodeTextDecor(ltStrikeOut) + CRLF + 'Q';
    LS := LS + CRLF;
  if (LS <> '') then
  begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end; //tab
    if Preferences.ActiveHyperLinks and (RotationAngle mod 360 = 0) then
    begin
      // Code for link annotation follows
      ParseEncodeText := String(RemoveTerminalCRLF(AnsiString(Lines.Strings[0])));
      StartPt := SX1;
      EndPt := SX1;
      while (ParseEncodeText <> '') do
      begin
        LinkText := GetHyperLinkText(ParseEncodeText, StartPos);
        if LinkText <> '' then
        begin

 

          LinkObjNo := GetNewObjNo;

 

          // Add the link annotation object no. to String
          FAnnots := FAnnots + ' ' + MakeObjRef(LinkObjNo);

 

          LTextSize := TextSize(System.Copy(ParseEncodeText, 0, StartPos - 1),
            Font);

 

          StartPt := StartPt + (LTextSize.cx * FPixelToPointMultiplier);
          EndPt := EndPt + (LTextSize.cx  * FPixelToPointMultiplier) +
            (TextSize(Trim(LinkText), Font).cx * FPixelToPointMultiplier);

 

          LS := '/Type/Annot' +
            '/Border []' +
            '/H/I' +
            '/Subtype/Link' +
            '/F 0' +
            '/C [11 00 01]' +
            '/Rect [' + NumToStr(StartPt) +
              ' ' + NumToStr(GetNativeYPos(Y, CurrentPage))
              + ' ' + NumToStr(EndPt) + ' '
              + NumToStr(SY3) + ']' + CRLF +
            '/A' + CRLF + '<<' + CRLF ;
          if (AnsiPos('@', LinkText) <> 0) then
            LS := LS + '/S/URI /URI<' +
              String(GetHexOfStr(AnsiString(WritePDFString(Trim('mailto:' + LinkText), LinkObjNo, 0)))) +
              '>' + CRLF
          else if (AnsiPos(':\',LinkText) <> 0) then
          begin
            TempStr := StringReplace(LinkText ,':\','/',[rfIgnoreCase]);
            TempStr := StringReplace(TempStr,'\','/',[rfReplaceAll]);
            if( AnsiPos('/',TempStr) <> 0 ) and ( AnsiPos('..',TempStr) = 0 ) then
              TempStr :=  '/' + TempStr;
            LS := LS + '/Type /Action/S /Launch/F (' + TempStr + ') /NewWindow true';
          end
          else
            LS := LS + '/S/URI /URI<' +
              String(GetHexOfStr(AnsiString(WritePDFString(Trim(LinkText), LinkObjNo, 0)))) +
              '>' + CRLF;
          LS := LS + '>>';

 

          WriteObj(LS, LinkObjNo, True);
        end;
        if LinkText <> '' then
        begin
          StartPt := EndPt;
          ParseEncodeText := System.Copy(ParseEncodeText,
            StartPos + Length(LinkText),
            (Length(ParseEncodeText) - (StartPos + Length(LinkText) - 1)));
          StartPos := 0;
          LinkText := '';
        end
        else
          Break;
      end;
    end;
    Lines.Strings[0] := LOriginalText;
  end;
end;

procedure TgtCustomPDFEngine.EndDoc;
begin
  inherited;
end;

procedure TgtCustomPDFEngine.EndPage;
var
  LS: String;
  LATemp : AnsiString;
  LStreamSize, LImgOffset: Int64;
  (* Required for encryption. *)
  LStream: TMemoryStream;

  LI, LJ, LThumbnailObj: Integer;
  LThumbnail, LCThumbnail: TgtPDFThumbnailItem;
begin
  LThumbnail := nil;
  LCThumbnail := nil;

  (* Set object no. for thumbnail items checking for reuse of image. *)
  if FThumbnailList.IndexOf(InttoStr(CurrentPage)) <> - 1 then
  begin
    LCThumbnail := TgtPDFThumbnailItem.Create;
    with TgtPDFThumbnailItem(FThumbnailList.Objects[
      FThumbnailList.IndexOf(InttoStr(CurrentPage))]) do
    begin
      LCThumbnail.OutputImageFormat := OutputImageFormat;
      LCThumbnail.ImagePixelFormat := ImagePixelFormat;
      LCThumbnail.JPEGQuality := JPEGQuality;
      LCThumbnail.IndexNo := IndexNo;
    end;

    LThumbnailObj := 0;
    (*
      Loop through the already rendered pages to check if the image is
        already used.
    *)
    for LI := 1 to CurrentPage - 1 do
    begin
      if LThumbnailObj <> 0 then
        Break;

      (* If Page LI has no thumbnail image, continue the search. *)
      if FThumbnailList.IndexOf(IntToStr(LI)) <> -1 then
        LThumbnail := TgtPDFThumbnailItem(FThumbnailList.Objects[
          FThumbnailList.IndexOf(IntToStr(LI))])
      else
        Continue;

      (*
        If the image is already used, then compare settings.
      *)
      if LThumbnail.IndexNo = LCThumbnail.IndexNo then
      begin
        (*
          Loop through the ImageIndex setting list.
        *)
        if Length(FThumbnailReuseList) >= LCThumbnail.IndexNo + 1 then
          with FThumbnailReuseList[LThumbnail.IndexNo] do
            for LJ := 0 to Count - 1 do
              if TgtPDFThumbnailItem(Objects[LJ]).IsEqual(LCThumbnail) then
                LThumbnailObj := StrToInt(Strings[LJ]);
      end;
    end;
    if LThumbnailObj = 0 then
    begin
      LThumbnailObj := GetNewObjNo;
      if Length(FThumbnailReuseList) < LCThumbnail.IndexNo + 1 then
      begin
        SetLength(FThumbnailReuseList, LCThumbnail.IndexNo + 1);
      end;
      if FThumbnailReuseList[LCThumbnail.IndexNo] = nil then
        FThumbnailReuseList[LCThumbnail.IndexNo] := TStringList.Create;
      LCThumbnail.ObjNo := LThumbnailObj;
      TgtPDFThumbnailItem(FThumbnailList.Objects[FThumbnailList.IndexOf(
        InttoStr(CurrentPage))]).ObjNo := LThumbnailObj;
      FThumbnailReuseList[LCThumbnail.IndexNo].AddObject(IntToStr(LThumbnailObj),
        LCThumbnail);
    end
    else
    begin
      TgtPDFThumbnailItem(FThumbnailList.Objects[FThumbnailList.IndexOf(
        InttoStr(CurrentPage))]).ObjNo := LThumbnailObj;
      FreeAndNil(LCThumbnail);
    end;
  end;

	(* Write Page object. *)
  LS := GetPageDictionary(TgtPageInfo(FPageList.Items[FPageList.Count - 1]).ObjNo);
  LS := LS + CRLF;
  WriteObj(LS, TgtPageInfo(FPageList.Items[FPageList.Count - 1]).ObjNo, True);

	(*
    Write
    Page Length object.
    Compression Filter if ZLib turned on.
  *)
	LS := '/Length ' + MakeObjRef(FLengthObjNo);
  if Compression.Enabled then
    LS := LS + '/Filter /FlateDecode';
  LS := LS + CRLF;
	WriteObj(LS, FContentsObjNo, False);

	(* Write actual page Content Stream. *)

  (* resolution ends *)
  LS := CRLF + 'Q' + CRLF;
  LATemp := AnsiString(LS);
  FContentStream.Write(LATemp[1], Length(LS));

	LS := 'stream' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));
  
  LStream := TMemoryStream.Create;
  try
    if Compression.Enabled then
      LStreamSize := CompressStream(FContentStream, LStream, Compression.Enabled,
        Compression.Level)
    else
    begin
      LStream.CopyFrom(FContentStream, 0);
      LStreamSize := LStream.Size;
    end;
    WritePDFStream(LStream, LStream.Size, FContentsObjNo, 0);
    FOutputStream.CopyFrom(LStream, 0);
  finally
    FreeAndNil(LStream);
  end;

	LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));

	(* Write page stream length object. *)
  LS := '0';
	LS := IntToStr(LStreamSize);
	WriteObj(LS, FLengthObjNo, True);
  
	(*
    Offset all image XRefs by (page + page length object sizes)
    and add to XRef list.
  *)
	for LI := 0 to FImageXRefList.Count - 1 do
	begin
		LImgOffset := StrToIntDef(FImageXRefList[LI], 0);
		Inc(LImgOffset, FOutputStream.Size);
		AppendXRef(LImgOffset, Integer(FImageXRefList.Objects[LI]));
	end;
	// Write all saved images to main stream.
	if FImageStream.Size > 0 then
		FOutputStream.CopyFrom(FImageStream, 0);
  inherited;
end;

function TgtCustomPDFEngine.GetEllipseCtrlPts(PosX1, PosY1, PosX2,
  PosY2: Double): TgtEllipseCtrlPoints;
var
	cpFactor: Double;
begin
	// cpFactor := 4/3 * (1-cos 45∞)/sin 45∞ := 4/3 * sqrt(2) - 1
	cpFactor := (4.0 / 3.0) * (Sqrt(2) - 1.0);

	with Result do
	begin
		if PosX1 < PosX2 then
			X1 := PosX1
		else
			X1 := PosX2;
		if PosX1 > PosX2 then
			X5 := PosX1
		else
			X5 := PosX2;
		X3 := (PosX1 + PosX2) / 2.0;
		X2 := X3 - cpFactor * (X3 - X1);
		X4 := X3 + cpFactor * (X3 - X1);

		if PosY1 < PosY2 then
			Y5 := PosY1
		else
			Y5 := PosY2;
		if PosY1 > PosY2 then
			Y1 := PosY1
		else
			Y1 := PosY2;
		Y3 := (PosY1 + PosY2) / 2.0;
		Y2 := Y3 - cpFactor * (Y3 - Y1);
		Y4 := Y3 + cpFactor * (Y3 - Y1);
	end;
end;

function TgtCustomPDFEngine.GetImageFilter(
  OutputImageFormat: TgtOutputImageFormat): String;
begin
  Result := '';
  if (OutputImageFormat = ifJPEG) then
    Result := '/Filter' + ImageFilter[OutputImageFormat]
  else if (OutputImageFormat = ifBMP) and (Compression.Enabled) then
    Result := '/Filter' + ImageFilter[OutputImageFormat]
  {$IFDEF gtPro} 
  else if (OutputImageFormat = ifCCITT3) then
    Result := '/Filter' + ImageFilter[OutputImageFormat]
  else if (OutputImageFormat = ifCCITT4) then
    Result := '/Filter' + ImageFilter[OutputImageFormat];
  {$ENDIF}
end;

function TgtCustomPDFEngine.GetLineStyle(AStyle: TPenStyle): String;
const
    {$IFDEF gtBDS2006}
	LineType: array[TPenStyle] of String = ('[]0', '[16 8]0', '[3 4]0',
		'[8 4 2 4]0', '[8 4 2 4 2 8]0', '', '', '', '');
     {$ELSE}
	LineType: array[TPenStyle] of String = ('[]0', '[16 8]0', '[3 4]0',
		'[8 4 2 4]0', '[8 4 2 4 2 8]0', '', '');
    {$ENDIF}
begin
	Result := LineType[AStyle];
	if Result <> '' then
		Result := Result + ' d ';
  case FPenJoin of
    pjsBevel:
      Result := Result +  '2 j ';
    pjsMiter :
      Result := Result + '0 j ';
    pjsRound:
      Result := Result + '1 j ';
  end;
  case FPenCap of
    pcsRound:
      Result := Result + '1 J ';
    pcsSquare:
      Result := Result + '2 J ';
    pcsFlat:
      Result := Result + '0 J ';
  end;
end;

function TgtCustomPDFEngine.GetNativeXPos(X: Extended): Extended;
begin
  Result := X * FPixelToPointMultiplier * (InputXRes / CPixelsPerInch);
end;

function TgtCustomPDFEngine.GetNativeYPos(Y: Extended; PageNo: Integer): Extended;
begin
	Result := Y * FPixelToPointMultiplier * (InputYRes /CPixelsPerInch ); // Convert from pixels to points.
	// Y0 is at bottom of screen in PDF.
  if (FPageList.Count >= PageNo) and (FPageList.Items[PageNo - 1] <> nil) and
    	(TgtPageInfo(FPageList.Items[PageNo - 1]).Height <> 0) then
    Result := TgtPageInfo(FPageList.Items[PageNo - 1]).Height *
      (InputXRes / CPixelsPerInch) - Result;
end;

function TgtCustomPDFEngine.GetNewObjNo: Integer;
begin
	Inc(FLastObjNo);
	Result := FLastObjNo;
end;

function TgtCustomPDFEngine.GetPDFBitmapStream(ABitmap: TBitmap): TMemoryStream;
var
  LX, LY: Integer;
  ScanLine: PByteArray;
  LByte: Byte;
  LBitmap: TBitmap;
begin
  Result := TMemoryStream.Create;
  LBitmap := TBitmap.Create;
  try
    LBitmap.Assign(ABitmap);
    LBitmap.PixelFormat := pf24Bit;
    
    Result.Size := LBitmap.Width * LBitmap.Height * 3;
    for LY := 0 to LBitmap.Height - 1 do
    begin
      ScanLine := LBitmap.ScanLine[LY];
      LX := 0;
      while LX < (LBitmap.Width * 3 - 1) do
      begin
        LByte := ScanLine[LX];
        ScanLine[LX] := ScanLine[LX + 2];
        ScanLine[LX + 2] := LByte;
        Inc(LX, 3);
      end;
      Result.Write(ScanLine[0], (LBitmap.Width * 3));
    end;
  finally
    FreeAndNil(LBitmap);
  end;
end;

function TgtCustomPDFEngine.MakeObjHead(AObjNo: Integer): String;
begin
	Result := IntToStr(AObjNo) + ' 0 obj';
end;

function TgtCustomPDFEngine.MakeObjRef(AObjNo: Integer): String;
begin
	Result := IntToStr(AObjNo) + ' 0 R';
end;

function TgtCustomPDFEngine.NumToStr(AN: Extended): String;
begin
	// Convert to native String.
	Result := FloatToStrF(AN, ffFixed, 18, 4);
	// Regional settings! convert without changing DecimalSeparator.
	if DecimalSeparator <> '.' then
		Result := ReplaceString(Result, DecimalSeparator, '.');
end;

function TgtCustomPDFEngine.PDFCurveto(X1, Y1, X2, Y2, X3, Y3: Double): String;
begin
	// Second control point coincides with final point.
	if (X2 = X3) and (Y2 = Y3) then
    (*
      The curve extends from the current point to the point (x3, y3),
        using (x1, y1) and (x3, y3) as the BÈzier control points
    *)
		Result := Format('%s %s %s %s y', [NumToStr(X1), NumToStr(Y1),
			NumToStr(X3), NumToStr(Y3)])
	else
    (*
      The curve extends from the current point to the point (x3, y3),
        using (x1, y1) and (x2, y2) as the BÈzier control points
    *)
		Result := Format('%s %s %s %s %s %s c', [NumToStr(X1), NumToStr(Y1),
			NumToStr(X2), NumToStr(Y2), NumToStr(X3), NumToStr(Y3)]);
end;

function TgtCustomPDFEngine.PDFShortArc(X, Y, RX, RY, Alpha, Beta: Double): String;
var
	cpFactor: Double;
	AlphaRad, BetaRad, cosAlpha, cosBeta, sinAlpha, sinBeta: Double;
begin
	// Convert from degrees to radians.
	AlphaRad := DegreesToRadians(Alpha);
	BetaRad  := DegreesToRadians(Beta);
	// This factor is used to calculate control points.
	cpFactor := (4.0/3 * (1 - cos((BetaRad - AlphaRad)/2)) /
		sin((BetaRad - AlphaRad) / 2));

	sinAlpha := sin(AlphaRad);
	sinBeta := sin(BetaRad);
	cosAlpha := cos(AlphaRad);
	cosBeta := cos(BetaRad);

	Result := PDFCurveto(
		X - RX * (cosAlpha - cpFactor * sinAlpha),			// X1.
		Y - RY * (sinAlpha + cpFactor * cosAlpha),			// Y1.
		X - RX * (cosBeta + cpFactor * sinBeta),				// X2.
		Y - RY * (sinBeta - cpFactor * cosBeta),				// Y2.
		X - RX * cosBeta,																// X3.
		Y - RY * sinBeta);															// Y3.
end;

procedure TgtCustomPDFEngine.SetFontEncoding(const Value: TgtPDFFontEncoding);
begin
  FFontEncoding := Value;
end;

procedure TgtCustomPDFEngine.WriteObj(const AStr: String; AObjNo: Integer;
  AIsObjectComplete: Boolean);
var
	LObjText: String;
  LATemp : AnsiString;
begin
	LObjText := AStr;
	if System.Pos(CRLF, LObjText) <> 0 then
		LObjText := '<<' + CRLF + LObjText + '>>';
	LObjText := MakeObjHead(AObjNo) + CRLF + LObjText + CRLF;
	if AIsObjectComplete then
		LObjText := LObjText + 'endobj' + CRLF;
	AppendXRef(FOutputStream.Size, AObjNo);
  LATemp := AnsiString(LObjText);
  FOutputStream.Write(LATemp[1], Length(LObjText));
end;

function TgtCustomPDFEngine.GetNativeText(AStr: String): String;
begin
  Result := AStr;
  Result := ReplaceString(Result, '(', '\(');
  Result := ReplaceString(Result, ')', '\)');  
end;

function TgtCustomPDFEngine.CheckOutputImageFormat(Value: TgtOutputImageFormat;
  var S: String): Boolean;
begin
  Result := False;
	if (Value in [ifBMP, ifJPEG {$IFDEF gtPro}, ifCCITT3, ifCCITT4 {$ENDIF}]) then
    Result := True
  else
    S := SUnsupportedPDFImageFormat;
end;

procedure TgtCustomPDFEngine.Finish;
var
  LStartXRef, LI, LJ: Integer;
  LS, LS1: String;
  LATemp : AnsiString;
  LCompStream: TMemoryStream;
  LStream: TgtExtMemStream;

  (* Required for TrueType Font Embedding. *)
  LFontFile2, LStreamLengthObj: Integer;
  LFont: TFont;
  LStreamSize: Int64;

  (* Required for Fonts. *)
  DescriptorObjNo: Integer;
  DesFontsObjNo, ToUnicodeObjNo: Integer;

	PatternObjNo: Integer;
  (* Function to get the formated cross-reference entrie values. *)
	function MakeXRef(AOffset: Integer; AGenNum: Integer; Afn: Char): String;
	begin
		Result := Format('%.10d %.5d %s', [AOffset, AGenNum, Afn]);
	end;

begin
  inherited;
  // Write Root object.
  LS := GetCatalogDictionary;
  LS := LS + CRLF;
  WriteObj(LS, cRootObjNo, True);

  if FThumbnailList.Count > 0 then
    WriteThumbnails;
  if FTOCItemList.Count > 0 then
    WriteOutlines;

  for LI := 0 to FThumbnailList.Count -1 do
    TgtPDFThumbnailItem(FThumbnailList.Objects[LI]).Free;
  FreeAndNil(FThumbnailList);

  for LI := 0 to Length(FThumbnailReuseList) - 1 do
    if FThumbnailReuseList[LI] <> nil then
    begin
      with FThumbnailReuseList[LI] do
        for LJ := 0 to Count - 1 do
          TgtPDFThumbnailItem(Objects[LJ]).Free;
      FreeAndNil(FThumbnailReuseList[LI]);
    end;
  SetLength(FThumbnailReuseList, 0);

  ToUnicodeObjNo := -1;
  LFontFile2 := 0;
  LStreamLengthObj := 0;
  (* Write Pages Dictionary. *)
  LS1 := '';
  LJ := 0;
  for LI := 0 to FPageList.Count - 1 do
    if FPageList.Items[LI] <> nil then
    begin
      LS1 := LS1 + ' ' + MakeObjRef(TgtPageInfo(FPageList.Items[LI]).ObjNo);
      Inc(LJ);
    end;
	LS :=
    '/Type/Pages' +
		'/Count ' + IntToStr(LJ) +
		'/Kids [' + Trim(LS1) + ']' + CRLF;    
	WriteObj(LS, CPagesTreeObjNo, True);

	LS := '';
	if (BackgroundImage.Graphic <> nil) and
    (not BackgroundImage.Graphic.Empty) then
	begin
		PatternObjNo := GetNewObjNo;
    FPattern.AddObject('PI', TObject(PatternObjNo));
	end;

  if FPattern.Count > 0 then
  begin
    LS := '/ColorSpace <</CSP [/Pattern /DeviceRGB]>>';
    LS := LS + CRLF + '/Pattern <<';
    for LI := 0 to FPattern.Count - 1 do
      LS := LS + '/' + FPattern.Strings[LI] + ' ' +
        MakeObjRef(Integer(FPattern.Objects[LI]));
     LS := LS + '>>' + CRLF;
  end;
  
  (* Write Resource Dictionary *)
  (* Font Resource *)
	if (FFontTable.Count > 0) then
	begin
		LS := LS + '/Font <<';
		with FFontTable do
			for LI := 0 to Count - 1 do
				LS := LS + '/F' + IntToStr(LI) + ' ' +
					MakeObjRef(TgtPDFFont(Items[LI]).FontInfo.FfiFontObjRef) +
            ' ';
		// Procset & Image references.
		LS := LS + '>>' + CRLF;
	end;
  (* ProcSet Reference *)
	LS := LS + '/ProcSet ' + MakeObjRef(CProcSetObjNo);
  (* Image Resource *)
	if (Length(FImageSettings) > 0) or
    ((BackgroundImage.Graphic <> nil) and
      (not BackgroundImage.Graphic.Empty)) then
	begin
		LS := LS + '/XObject <<';
    for LI := Low(FImageSettings) to High(FImageSettings) do
      if FImageSettings[LI] <> nil then
      for LJ := 0 to FImageSettings[LI].Count - 1 do
        LS := LS + '/Img' + IntToStr(LI) + IntToStr(LJ)
          + ' ' +
          MakeObjRef(TgtPDFImageSettings(FImageSettings[LI].Items[LJ]).ObjNo);

    if (BackgroundImage.Graphic <> nil) and
      (not BackgroundImage.Graphic.Empty) then
      LS := LS + ' /Img0 ' + MakeObjRef(FBGImageObj);
		LS := LS + ' >>';
	end;
  LS := LS + CRLF;
	WriteObj(LS, CResourcesObjNo, True);

	(* ProcSet object. *)
	LS := '[/PDF';
  if (irText in ItemsToRender) then
    LS := LS + ' /Text';
	if (irImage in ItemsToRender) then
    LS := LS + ' /ImageC';
	LS := LS + ']';
	WriteObj(LS, CProcSetObjNo, True);

  WritePattern;

  (* Write Font Data *)
  with FFontTable do
    for LI := 0 to Count - 1 do
    begin
      LS1 := '';
      with TgtPDFFont(Items[LI]) do
      begin
        (*
          ANSI Charset Font Encoding.
        *)
        if ((Font.Charset = ANSI_CHARSET) or
          ((Font.Charset = DEFAULT_CHARSET) and (GetACP = CANSIWinCode))) or
          (Font.Charset = SYMBOL_CHARSET) then
        begin
        DescriptorObjNo := GetNewObjNo;
        (* If not fixed pitch font, write /W widths value. *)
          for LJ := Low(FontInfo.FfiWidths) to High(FontInfo.FfiWidths) do
            LS1 := LS1 + IntToStr(FontInfo.FfiWidths[LJ]) + ' ';
            
          (* If TrueType write TrueType font dictionary. *)
          if FontInfo.FfiType = ftTrueType then
          begin
            (* TrueType Font Dictionary *)
            LS :=
              '/Type /Font' +
              '/Subtype /TrueType' +
              '/Name /F' + IntToStr(LI);
            (* If embed subset prefix fontname with some random 6 characters. *)
            if (Preferences.EmbedTrueTypeFonts = etfSubset) and
                (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
              LS := LS +
                '/BaseFont /WYOIAS+' + ConvertDelimiters(BaseFont)
            else
              LS := LS +
              '/BaseFont /' + ConvertDelimiters(BaseFont);
            LS := LS +
              ' /Encoding /' + PDFFontEncodeStrings[FontEncoding] +
              '/FirstChar ' + IntToStr(Low(FontInfo.FfiWidths)) +
              '/LastChar ' + IntToStr(High(FontInfo.FfiWidths));
            LS := LS +
              '/Widths ' + '[' + Trim(LS1) + ']';
            LS := LS +
              '/FontDescriptor ' + MakeObjRef(DescriptorObjNo) +
              CRLF;
            WriteObj(LS, FontInfo.FfiFontObjRef, True);

            (* Font Descriptor Dictionary *)
            with FontInfo do
            begin
              LS :=
                '/Type /FontDescriptor';
              (*
                If embed subset prefix fontname with some random 6 characters.
              *)
              if (Preferences.EmbedTrueTypeFonts = etfSubset) and
                  (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
                LS := LS +
                '/FontName /WYOIAS+' + ConvertDelimiters(BaseFont)
              else
                LS := LS +
                  '/FontName /' + ConvertDelimiters(BaseFont);
              LS := LS +
                ' /Flags ' + IntToStr(FfiFlags) +
                Format('/FontBBox' + '[%d %d %d %d]', [
                  FfiFontBBox.Left,
                  FfiFontBBox.Bottom,
                  FfiFontBBox.Right,
                  FfiFontBBox.Top ]) +
                '/Ascent ' + FloatToStrLocale(FfiAscent) +
                '/Descent ' + FloatToStrLocale(FfiDescent) +
                '/CapHeight ' + FloatToStrLocale(FfiCapHeight) +
                '/AvgWidth ' + IntToStr(FfiAvgWidth) +
                '/MaxWidth ' + IntToStr(FfiMaxWidth) +
                '/MissingWidth ' + IntToStr(FfiMaxWidth) +                
                '/StemH ' + IntToStr(FfiStemV) +
                '/StemV ' + IntToStr(FfiStemV) +
                '/ItalicAngle ' + IntToStr(FfiItalicAngle);
              if (Preferences.EmbedTrueTypeFonts <> etfNone) and
                (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
              begin
                LFontFile2 := GetNewObjNo;
                LS := LS + '/FontFile2 ' +
                MakeObjRef(LFontFile2);
              end;
              LS := LS + CRLF;
              WriteObj(LS, DescriptorObjNo, True);
            end;
          end (* End TrueType font dictionary. *)
          else
          (* If font is not TrueType, write Type1 font dictionary. *)
          begin
            LS :=
              '/Type /Font' +
              '/Subtype /Type1' +
              '/Name /F' + IntToStr(LI) +
              '/BaseFont /' + ConvertDelimiters(BaseFont) +
              '/Encoding /' + PDFFontEncodeStrings[FontEncoding] +
              '/FirstChar ' + IntToStr(Low(FontInfo.FfiWidths)) +
              '/LastChar ' + IntToStr(High(FontInfo.FfiWidths));
            //if not FontInfo.FfiIsFixedPitch then
              LS := LS +
                '/Widths ' + '[' + Trim(LS1) + ']';
            LS := LS +
              '/FontDescriptor ' + MakeObjRef(DescriptorObjNo) +
              CRLF;
            WriteObj(LS, FontInfo.FfiFontObjRef, True);

            (* Font Descriptor Dictionary *)
            with FontInfo do
            begin
              LS :=
                '/Type /FontDescriptor' +
                '/FontName /' + ConvertDelimiters(BaseFont) +
                '/Flags ' + IntToStr(FfiFlags) +
                Format('/FontBBox' + '[%d %d %d %d]', [
                  FfiFontBBox.Left,
                  FfiFontBBox.Bottom,
                  FfiFontBBox.Right,
                  FfiFontBBox.Top ]) +
                '/Ascent ' + FloatToStrLocale(FfiAscent) +
                '/Descent ' + FloatToStrLocale(FfiDescent) +
                '/CapHeight ' + FloatToStrLocale(FfiCapHeight) +
                '/AvgWidth ' + IntToStr(FfiAvgWidth) +
                '/MaxWidth ' + IntToStr(FfiMaxWidth) +
                '/StemH ' + IntToStr(FfiStemV) +
                '/StemV ' + IntToStr(FfiStemV);
{
              if Preferences.EmbedTrueTypeFonts then
              begin
                LFontFile2 := GetNewObjNo;
                LS := LS + '/FontFile2 ' +
                MakeObjRef(LFontFile2);
              end;
}
              LS := LS + CRLF;
              WriteObj(LS, DescriptorObjNo, True);
            end;

          end;
        end (* End ANSI Charset Font Encoding. *)
        else
        (*
          CID Font Encoding.
        *)
        begin
          if FontInfo.FfiType = ftTrueType then
          begin
            if (ToUnicodeObjNo = -1) then
              ToUnicodeObjNo := GetNewObjNo;

            DesFontsObjNo := GetNewObjNo;
            LS := GetType0FontDictionary(LI, MakeObjRef(ToUnicodeObjNo),
              MakeObjRef(DesFontsObjNo));
            WriteObj(LS, FontInfo.FfiFontObjRef, True);

            DescriptorObjNo := GetNewObjNo;
            LS := GetCIDFontDictionary(MakeObjRef(DescriptorObjNo));
            //LS := ReplaceString(LS,'(Adobe)',  '<' + GetHexOfStr(WritePDFString('Adobe',
            //DesFontsObjNo, 0)) + '>');
            //LS := ReplaceString(LS,'(Identity)', '<' + GetHexOfStr(
            //WritePDFString('Identity', DesFontsObjNo, 0)) + '>');
            WriteObj(LS, DesFontsObjNo, True);

            if (Preferences.EmbedTrueTypeFonts <> etfNone) and
              (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
            begin
              LFontFile2 := GetNewObjNo;
              LS := GetFontDescriptor(MakeObjRef(LFontFile2));
            end
            else
              LS := GetFontDescriptor('');
            WriteObj(LS, DescriptorObjNo, True);
            if (ToUnicodeObjNo <> -1) then
            begin
              LStream := TgtExtMemStream.Create;
              try
                TgtPDFFont(FFontTable.Items[LI]).GetCMap(LStream);

                LStreamLengthObj := GetNewObjNo;
                LS := '/Length' + CRLF + MakeObjRef(LStreamLengthObj);
                if Compression.Enabled then
                  LS := LS + '/Filter/FlateDecode';
                WriteObj(LS, ToUnicodeObjNo, False);

                LS := 'stream' + CRLF;
                LATemp := AnsiString(LS);
                FOutputStream.Write(LATemp[1], Length(LS));
                LCompStream := TMemoryStream.Create;
                LStreamSize := CompressStream(LStream, LCompStream,
                  Compression.Enabled, Compression.Level);
                WritePDFStream(LCompStream, LStreamSize, ToUnicodeObjNo, 0);
                FOutputStream.CopyFrom(LCompStream, 0);
                LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
                LATemp := AnsiString(LS);
                FOutputStream.Write(LATemp[1], Length(LS));
                LS := '0';
                LS := IntToStr(LStreamSize);
                WriteObj(LS, LStreamLengthObj, True);
              finally
                LStream.Free;
                LCompStream.Free;
              end;
            end;

          end(* End if TrueType. *)
          else
          begin
            LS :=
              '/Type/Font' +
              '/Subtype /Type1' +
              '/Name /F' + IntToStr(LI) +
              '/BaseFont /' + ConvertDelimiters(BaseFont) +
              '/Encoding /' + PDFFontEncodeStrings[FontEncoding] +
              CRLF;
            WriteObj(LS, FontInfo.FfiFontObjRef, True);
          end; (* End else for CID. *)
        end;(* End CID. *)

        if (FontEmbedExcludeList.IndexOf(Font.Name) = -1) and
          (FontInfo.FfiType = ftTrueType) and
          (Preferences.EmbedTrueTypeFonts <> etfNone) then
        begin
          LStream := TgtExtMemStream.Create;
          LFont := TFont.Create;
          LFont.Assign(Font);
          if Preferences.EmbedTrueTypeFonts = etfFull then
            GetFontFile2(TMemoryStream(LStream))
          else
            GetFontFile2Subset(LStream);
          try
            LStreamSize := LStream.Size;
            LStream.Position := 0;

            LS := '/Length1 ' + IntToStr(LStreamSize);
            if Compression.Enabled then
            begin
              LStreamLengthObj := GetNewObjNo;
              LS := LS + '/Length' + CRLF + MakeObjRef(LStreamLengthObj);
              LS := LS + '/Filter/FlateDecode';
            end
            else
              LS := LS + '/Length' + CRLF + IntToStr(LStreamSize);

            WriteObj(LS, LFontFile2, False);

            LS := 'stream' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));
            LCompStream := TMemoryStream.Create;
            LStreamSize := CompressStream(LStream, LCompStream,
              Compression.Enabled, Compression.Level);
            WritePDFStream(LCompStream, LStreamSize, LFontFile2, 0);
            FOutputStream.CopyFrom(LCompStream, 0);
            LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));

            LS := '0';
            LS := IntToStr(LStreamSize);
            WriteObj(LS, LStreamLengthObj, True);
          finally
            FreeAndNil(LStream);
            FreeAndNil(LFont);
            FreeAndNil(LCompStream);
          end;
        end; (* End EmbedTrueTypeFont *)
      end; (* End With *)
    end; (* End PDF Fonts Processing. *)

  WriteEncryptionDictionary;

  (* Document Info object. *)
  LS := '';

  LS := LS + '/CreationDate <';
  LS := LS + String(GetHexOfStr(AnsiString(WritePDFString(FCreationTime, CInfoObjNo, 0)))) + '>';

  LS := LS + '/ModDate <';
  LS := LS + String(GetHexOfStr(AnsiString(WritePDFString(FCreationTime, CInfoObjNo, 0)))) + '>';

  LS := LS + '/Producer <';
  LS1 := 'Gnostice eDocEngine V' + CVersion;
  LS := LS + ToUnicodeHex(LS1, CInfoObjNo, 0) + '>';

  if (Trim(DocInfo.Author) <> '') then
  begin
    LS := LS + '/Author <' + ToUnicodeHex(DocInfo.Author, CInfoObjNo, 0) + '>';
  end;

  if (Trim(DocInfo.Keywords) <> '') then
  begin
    LS := LS + '/Keywords <' + ToUnicodeHex(DocInfo.Keywords, CInfoObjNo, 0) + '>';
  end;

  if (Trim(DocInfo.Creator) <> '') then
  begin
    LS := LS + '/Creator <' + ToUnicodeHex(DocInfo.Creator, CInfoObjNo, 0) + '>';
  end;

  if (Trim(DocInfo.Title) <> '') then
  begin
    LS := LS + '/Title <' + ToUnicodeHex(DocInfo.Title, CInfoObjNo, 0) + '>';
  end;

  if (Trim(DocInfo.Subject) <> '') then
  begin
    LS := LS + '/Subject <' + ToUnicodeHex(DocInfo.Subject, CInfoObjNo, 0) + '>';
  end;
  LS := LS + CRLF;
  WriteObj(LS, CInfoObjNo, True);

	LStartXRef := FOutputStream.Size;

	(* XRef table. *)
  (* Write Default First cross-reference entry. *)
	LS := 'xref' + CRLF + '0 ' + IntToStr(FLastObjNo + 1) + CRLF +
		MakeXRef(0, 65535, 'f') + CRLF;
	with FXRefTable do
		for LI := 0 to FLastObjNo - 1 do
      if IndexOfObject(TObject(LI + 1)) <> -1 then
			  LS := LS + MakeXRef(
          StrToIntDef(Strings[IndexOfObject(TObject(LI + 1))], 0), 0, 'n') +
          CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));

	(* Trailer *)
	LS := 'trailer' + CRLF + '<<' + CRLF;
  LS := LS + GetTrailer + CRLF;
  LS := LS  + '>>' + CRLF +
		'startxref' + CRLF + IntToStr(LStartXRef) + CRLF +
    '%%EOF';
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));

  (* Code to free resources continues... *)
  (* Free cross-reference table *)
  FreeAndNil(FXRefTable);

  FreeAndNil(FPattern);

  (* Free font information list *)
  for LI := 0 to FFontTable.Count - 1 do
    TgtPDFFont(FFontTable.Items[LI]).Free;
  FreeAndNil(FFontTable);

  (* Free image cross-reference table. *)
  FreeAndNil(FImageXRefList);
  for LI := 0 to Length(FImageSettings) - 1 do
  begin
    if FImageSettings[LI] <> nil then
    with FImageSettings[LI] do
      for LJ := 0 to Count - 1 do
        TgtImageSettings(Items[LJ]).Free;
    FreeAndNil(FImageSettings[LI]);
  end;

  for LI := 0 to FPageList.Count - 1 do
    TgtPageInfo(FPageList.Items[LI]).Free;
  FreeAndNil(FPageList);

  FreeAndNil(FImageStream);
  FreeAndNil(FContentStream);

  if not Preferences.OutputToUserStream then
    FreeAndNil(FOutputStream);  
  FreeAndNil(FPDFEncrypt);
end;

procedure TgtCustomPDFEngine.Start;
var
  LS: String;
  LTmZone: TTimeZoneInformation;
  LATemp: AnsiString;
begin
  inherited;

  FThumbnailList := TStringList.Create;

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;

	FXRefTable := TStringList.Create;
  FImageXRefList := TStringList.Create;
  SetLength(FImageSettings, 0);
  FImageStream := TMemoryStream.Create;
  FContentStream := TMemoryStream.Create;
  FPageList := TList.Create;

  FFontTable := TList.Create;

  FPattern := TStringList.Create;
	FLastObjNo := CLastReservedObjNo;
  FBGImageObj := -1;

  // Get Creation Date-Time
  GetTimeZoneInformation(LTmZone);
	LS := Format('%.2d', [LTmZone.Bias div -60]);
	if LS[1] <> '-' then
	begin
		LS := '+' + LS;
		LTmZone.Bias := LTmZone.Bias * -1;
	end;
	LS := LS + '''' + Format('%.2d', [LTmZone.Bias mod 60]) + '''';
  FCreationTime := 'D:' + FormatDateTime('yyyymmddhhnnss', Now) + LS;

  if (Encryption.Enabled) then
    FPDFEncrypt := TgtPDFEncryption.Create(AnsiString((FileName + FileExtension)),
      AnsiString(FCreationTime), Encryption);

  // Write header.
  LS := '%PDF-1.4' + CRLF + '%‚„œ”' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LATemp));
end;

procedure TgtCustomPDFEngine.WritePDFStream(var InputStream: TMemoryStream;
  StreamSize, ObjNo, GenNo: Integer);
begin
  if Encryption.Enabled then
    FPDFEncrypt.EncryptStream(InputStream, StreamSize, ObjNo, GenNo);
end;

function TgtCustomPDFEngine.WritePDFString(InputString: String; ObjNo,
  GenNo: Integer): String;
var
  LStr: TgtExtMemStream;
  LSize: Integer;
begin
  Result := '';
  LSize := Length(InputString);
  SetLength(Result, LSize);
  if Encryption.Enabled then
  begin
    LStr := TgtExtMemStream.Create;
    try
      LStr.WriteString(AnsiString(InputString));
      LStr.Position := 0;
      FPDFEncrypt.EncryptStream(TMemoryStream(LStr), LSize, ObjNo, GenNo);
      LStr.Position := 0;
      Result := String(LStr.ReadString(LSize));
    finally
      LStr.Free;
    end;
  end
  else
    Result := InputString;
end;

function TgtCustomPDFEngine.GetPageDictionary(AObjNo: Integer): String;
var
  LPageWidth, LPageHeight: Double;
begin
  (* Current Page Dimensions. *)
  LPageWidth := Pages[CurrentPage - 1].Settings.Width *
    FPixelToPointMultiplier;
  LPageHeight := Pages[CurrentPage - 1].Settings.Height *
    FPixelToPointMultiplier;

  Result := '';
	Result :=
    '/Type/Page' +
		'/Parent ' + MakeObjRef(CPagesTreeObjNo) +
		'/MediaBox [0 0 ' + NumToStr(LPageWidth) + ' ' + NumToStr(LPageHeight) + ']' +
		'/Resources ' + MakeObjRef(CResourcesObjNo) +
		'/Contents ' + MakeObjRef(FContentsObjNo);
  if Preferences.ActiveHyperLinks and (FAnnots <> '') then
    Result := Result + '/Annots [' + Trim(FAnnots) + ']';
  with ViewerPreferences do
    Result := Result + GetTransitionEffectAndDuration(PresentationMode.Duration,
        PresentationMode.TransitionEffect);
  (* Write Thumbnail. *)
  with FThumbnailList do
  begin
    if (Count > 0) and (IndexOf(IntToStr(CurrentPage)) > -1) then
    begin
      Result := Result + '/Thumb ' +
        MakeObjRef(TgtPDFThumbnailItem(Objects[
          IndexOf(IntToStr(CurrentPage))]).ObjNo);
    end;
  end;
end;

procedure TgtCustomPDFEngine.WriteEncryptionDictionary;
var
  LS: String;
begin
  if Encryption.Enabled then
  begin
    LS := '';
    FEncryptionObjNo := GetNewObjNo;
    case Encryption.Level of
      el40bit:
        begin
          LS := LS + '/V 1';
          LS := LS + '/R 2';
        end;
      el128bit:
        begin
          LS := LS + '/V 2';
          LS := LS + '/R 3';
        end
    end;
  {
      EncryptionPermission := Not EncryptionPermission;
      EncryptionPermission := EncryptionPermission + 1;
  }
      LS := LS + '/P ' + IntToStr(FPDFEncrypt.PermissionValue);

      if Encryption.Level = el128bit then
        LS := LS + '/Length 128';
      LS := LS + '/Filter/Standard' +
        '/O <' + String(GetHexOfStr(FPDFEncrypt.OwnerKey)) + '>' +
        '/U <' + String(GetHexOfStr(FPDFEncrypt.UserKey)) + '>';
      LS := LS + CRLF;
      WriteObj(LS, FEncryptionObjNo, True);
  end;
end;

function TgtCustomPDFEngine.GetTrailer: String;
begin
  Result := '/Root ' + MakeObjRef(CRootObjNo) +
		'/Info ' + MakeObjRef(CInfoObjNo) +
    '/Size ' + IntToStr(FLastObjNo + 1);
  if Encryption.Enabled then
  begin
    Result := Result + '/ID [<' + String(GetHexOfStr(FPDFEncrypt.FileID)) + '><' +
      String(GetHexOfStr(FPDFEncrypt.FileID)) + '>]';
    Result := Result + '/Encrypt ' + MakeObjRef(FEncryptionObjNo);
  end;
end;

function TgtCustomPDFEngine.GetCatalogDictionary: String;
begin
  Result := '/Type/Catalog' +
    '/Pages ' + MakeObjRef(cPagesTreeObjNo);
  (* Outlines Dictionary Reference. *)
  if FTOCItemList.Count > 0 then
  begin
    FOutlines := GetNewObjNo;
    Result := Result + '/Outlines ' + MakeObjRef(FOutlines);
  end;
  with ViewerPreferences do
    Result := Result + GetViewerPreferences(PageMode, PageLayout, CenterWindow,
      FitWindow, HideWindowUI, HideMenuBar, HideToolBar,
      NonFullScreenPageMode);
end;

function TgtCustomPDFEngine.GetAnnotBrushStyle(Width: Integer;
  Style: TgtAnnotBrushStyle): String;
const
  BS: array[TgtAnnotBrushStyle] of String = ('S', 'D', 'B', 'I', 'U');
begin
  Result := '';
  Result := '/BS << ';
  Result := Result +
    '/W ' + IntToStr(Width);
  Result := Result +
    '/S /' + BS[Style];
  Result := Result + ' >>';
end;

procedure TgtCustomPDFEngine.WriteBackground;
var
	LS: String;
  LATemp : AnsiString;
	PaperWidth, PaperHeight, PaperWidthCenter, PaperHeightCenter: Extended;
	LTop, LLeft, LWidth, LHeight: Double;
	Bmp: TBitmap;
begin
  PaperWidth := TgtPageInfo(FPageList.Items[FPageList.Count - 1]).Width;
  PaperHeight := TgtPageInfo(FPageList.Items[FPageList.Count - 1]).Height;
	PaperWidthCenter := PaperWidth / 2.0;
	PaperHeightCenter := PaperHeight / 2.0;
	LTop := 0;	// For dtTile, dtTopLeft, dtTopCenter, dtTopRight
	LLeft := 0;	// For dtTile, dtTopLeft, dtCenterLeft, dtBottomLeft
	LWidth := PaperWidth;
	LHeight := PaperHeight;
  if (BackgroundColor <> Graphics.clNone) then
    LS := ColorToPDFColor(BackgroundColor) + ' rg n ' + NumToStr(0) + ' ' +
      NumToStr(0) + ' ' + NumToStr(LWidth) + ' ' + NumToStr(LHeight) +
      ' re f ' + CRLF
  else
    LS := '';

	if (BackgroundImage.Graphic <> nil) and
			(not BackgroundImage.Graphic.Empty) then
		with BackgroundImage do
		begin
			if BackgroundImageDisplayType <> dtTile then
			begin
				LWidth := Width;
				LHeight := Height;
			end;
			if BackgroundImageDisplayType in
        	[dtCenterLeft, dtCenter, dtCenterRight] then
      	LTop := PaperHeightCenter - (Height / 2.0)
			else if BackgroundImageDisplayType in
        	[dtTopCenter, dtTopRight, dtTopLeft] then
      	LTop := PaperHeight - Height;

			if BackgroundImageDisplayType in
					[dtTopCenter, dtCenter, dtBottomCenter] then
				LLeft := PaperWidthCenter - (Width / 2.0)
			else if BackgroundImageDisplayType in
					[dtTopRight, dtCenterRight, dtBottomRight] then
				LLeft := PaperWidth - Width;
      if CurrentPage = 1 then
      begin
        Bmp := TBitmap.Create;
      try
        Bmp.Width := Width;
        Bmp.Height := Height;
        Bmp.Canvas.Draw(0, 0, Graphic);
        FBGImageObj := SaveImageContents(Bmp);
      finally
        Bmp.Free;
      end;
		end;
		FBackgroundImageWidth := Width;
		FBackgroundImageHeight := Height;
		FBackgroundImageLeft := LLeft;
		FBackgroundImageTop := LTop;
    LS := LS + '/CSP cs /PI scn n ' + NumToStr(LLeft) + ' ' +	NumToStr(LTop) +
			' ' + NumToStr(LWidth) + ' ' + NumToStr(LHeight) + ' re f';
	end;
  LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
  LATemp := AnsiString(LS);
	FContentStream.Write(LATemp[1], Length(LS));
end;

function TgtCustomPDFEngine.SaveImageContents(ABitmap: TBitmap): Integer;
var
	S: String;
  LATemp : AnsiString;
	BmpStream, Stream: TStream;
	ImageObjNo: integer;

  // For Encryption
  StreamSize: Integer;
	TmpStream: TMemoryStream;
begin
	S := '';
  BmpStream := nil;
	if ImageSettings.OutputImageFormat <> ifBMP then
		Stream := GetBitmapAsJpgGifStream(ABitmap,
      (ImageSettings.OutputImageFormat = ifJPEG), ImageSettings.JPEGQuality)
	else
	begin
		Stream := TMemoryStream.Create;
    try
      BmpStream := GetPDFBitmapStream(ABitmap);
      CompressStream(BmpStream, Stream, Compression.Enabled, Compression.Level)
		finally
			FreeAndNil(BmpStream);
		end;
	end;

	try
		ImageObjNo := GetNewObjNo;
    Result := ImageObjNo;
    FImageXRefList.AddObject(IntToStr(FImageStream.Size), TObject(ImageObjNo));

		Stream.Position := 0;

		S := MakeObjHead(ImageObjNo) + CRLF + '<<' + CRLF +
			'/Type/XObject' +
      '/Subtype/Image' +
			'/Name/Img0' +
			'/Width ' + IntToStr(ABitmap.Width) +
			'/Height ' + IntToStr(ABitmap.Height) +
			'/BitsPerComponent 8' +
			'/ColorSpace/DeviceRGB' +
			Trim(GetImageFilter(ImageSettings.OutputImageFormat)) +
			'/Length ' + IntToStr(Stream.Size) + CRLF + '>>' + CRLF +
			'stream' + CRLF;
    LATemp := AnsiString(S);
		FImageStream.Write(LATemp[1], Length(S));

    TmpStream := TMemoryStream.Create;
    TmpStream.CopyFrom(Stream, 0);
    StreamSize := TmpStream.Size;
    WritePDFStream(TmpStream, StreamSize, ImageObjNo, 0);

    FImageStream.CopyFrom(TmpStream, 0);

		S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
    LATemp := AnsiString(S);
		FImageStream.Write(LATemp[1], Length(S));
	finally
		Stream.Free;
    TmpStream.Free;
	end;
end;

function TgtCustomPDFEngine.ShowSetupModal: Word;
begin
  with TgtPDFEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

procedure TgtCustomPDFEngine.SetFontEmbedExcludeList(const Value: TStringList);
begin
  FFontEmbedExcludeList.Assign(Value);
end;

procedure TgtCustomPDFEngine.SetCompression(const Value: TgtCompression);
begin
  FCompression := Value;
end;

function TgtCustomPDFEngine.GetPreferences: TgtPDFPreferences;
begin
  Result := TgtPDFPreferences(inherited Preferences);
end;

procedure TgtCustomPDFEngine.SetPreferences(
  const Value: TgtPDFPreferences);
begin
  inherited Preferences := Value;
end;

function TgtCustomPDFEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtPDFPreferences;
end;

function TgtCustomPDFEngine.GetPattern(AStyle: TBrushStyle): String;
begin
  Result := '';
  case AStyle of
    bsHorizontal:
    begin
      Result := 'PH';
      if FPattern.IndexOf('PH') = -1 then
        FPattern.AddObject('PH', TObject(GetNewObjNo));
    end;
    bsVertical:
    begin
      Result := 'PV';
      if FPattern.IndexOf('PV') = -1 then
        FPattern.AddObject('PV', TObject(GetNewObjNo));
    end;
    bsFDiagonal:
    begin
      Result := 'PFD';
      if FPattern.IndexOf('PFD') = -1 then
        FPattern.AddObject('PFD', TObject(GetNewObjNo));
    end;
    bsBDiagonal:
    begin
      Result := 'PBD';
      if FPattern.IndexOf('PBD') = -1 then
        FPattern.AddObject('PBD', TObject(GetNewObjNo));
    end;
    bsCross:
    begin
      Result := 'PC';
      if FPattern.IndexOf('PC') = -1 then
        FPattern.AddObject('PC', TObject(GetNewObjNo));
    end;
    bsDiagCross:
    begin
      Result := 'PDC';
      if FPattern.IndexOf('PDC') = -1 then
        FPattern.AddObject('PDC', TObject(GetNewObjNo));
    end;
  end;
end;

procedure TgtCustomPDFEngine.WritePattern;
var
  I, LStreamSize: Integer;
  StreamLengthObj: Integer;
  LDict, LStr: String;
  LATemp : AnsiString;
  LStream, LCompStream: TMemoryStream;
begin
  LDict :=
    '/Type /Pattern' + CRLF +
    '/Resources << /ProcSet [/PDF ] >>' + CRLF +
    '/PatternType 1' + CRLF +
    '/PaintType 2' + CRLF +
    '/TilingType 1' + CRLF +
    '/BBox [0 0 5 5]' + CRLF +
    '/XStep 5' + CRLF +
    '/YStep 5' + CRLF;       
  for I := 0 to FPattern.Count - 1 do
  begin
    if FPattern.Strings[I] = 'PH' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 5 2.5 l S'
    else if FPattern.Strings[I] = 'PV' then
      LStr := '2 J 2 j 0.3 w 2.5 0 m 2.5 5 l S'
    else if FPattern.Strings[I] = 'PFD' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 2.5 0 l 5 2.5 m 2.5 5 l S'
    else if FPattern.Strings[I] = 'PBD' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 2.5 5 l 2.5 0 m 5 2.5 l S'
    else if FPattern.Strings[I] = 'PC' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 5 2.5 l 2.5 0 m 2.5 5 l S'
    else if FPattern.Strings[I] = 'PDC' then
      LStr := '2 J 2 j 0.3 w 2.5 0 m 5 2.5 l 2.5 5 l 0 2.5 l s'
    else if FPattern.Strings[I] = 'PI' then
    begin
      LStr := CRLF + 'q' + CRLF +
        NumToStr(FBackgroundImageWidth) + ' 0 0 ' +
        NumToStr(FBackgroundImageHeight) + ' 0 0 ' + 'cm' + CRLF +
        '/Img0' + ' Do' + CRLF + 'Q';
      LDict :=
		    '/Type/Pattern' +
        '/PatternType 1' +
        '/PaintType 1' +
        '/Resources << ' +
          '/ProcSet [/PDF /ImageC] /XObject << /Img0 ' +
            MakeObjRef(FBGImageObj) + ' >> ' + CRLF +
        '>>' +
        '/TilingType 1' +
        '/BBox [0 0 ' + NumToStr(FBackgroundImageWidth) + ' ' +
          NumToStr(FBackgroundImageHeight) + ']' +
        '/Matrix [1 0 0 1 ' + NumToStr(FBackgroundImageLeft) +
          ' ' + NumToStr(FBackgroundImageTop) + ']' +
        '/XStep ' + NumToStr(FBackgroundImageWidth) +
        '/YStep ' + NumToStr(FBackgroundImageHeight);       
    end;
    LStream := TMemoryStream.Create;
    LCompStream := TMemoryStream.Create;
    LATemp := AnsiString(LStr);
    LStream.Write(LATemp[1], Length(LStr));
    try
      StreamLengthObj := -1;
      if Compression.Enabled then
      begin
        StreamLengthObj := GetNewObjNo;
        LDict := LDict + '/Length' + CRLF + MakeObjRef(StreamLengthObj);
        LDict := LDict + '/Filter/FlateDecode';
      end;
      LDict := LDict + '/Length ' + IntToStr(LStream.Size) + CRLF;
      WriteObj(LDict, Integer(FPattern.Objects[I]), False);
		  LStr := 'stream' + CRLF;
      LATemp := AnsiString(LStr);
      FOutputStream.Write(LATemp[1], Length(LStr));
      LStreamSize := LStream.Size;
      if Compression.Enabled then
        LStreamSize := CompressStream(LStream, LCompStream, Compression.Enabled,
          Compression.Level)
      else
        LCompStream.CopyFrom(LStream, 0);
      WritePDFStream(LCompStream, LStreamSize, Integer(FPattern.Objects[I]), 0);
      FOutputStream.CopyFrom(LCompStream, 0);
      LStr := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(LStr);
      FOutputStream.Write(LATemp[1], Length(LStr));
      if Compression.Enabled then
      begin
        LStr := IntToStr(LStreamSize);
        if LStr = '' then
          LStr := '0';
        WriteObj(LStr, StreamLengthObj, True);
      end;
    finally
      FreeAndNil(LStream);
      FreeAndNil(LCompStream);
    end;
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyPolyline(AObject: TgtPolyShapeItem;
  IsClosed: Boolean);
var
	LJ, LI: Integer;
  LS, LPath: String;
  LATemp : AnsiString;
  LPoints: TgtPoints;
begin
	if (AObject.Shapes.Count = 0) then Exit;

  with TgtShapeItem(AObject.Shapes.Items[0]) do
    if ((Pen.Width = 0) or (Pen.Style = psClear)) then
    begin
      if (IsClosed and ((Brush = nil) or (Brush.Style = bsClear))) then
        Exit
      else if (IsClosed = False) then
        Exit;
    end;
  for LJ := 0 to AObject.Shapes.Count - 1 do
  begin
  	with TgtShapeItem(AObject.Shapes.Items[LJ]) do
    begin
      SetLength(LPoints, NoPoints);
    	LPoints := GetPoints;
    	for LI := 0 to NoPoints - 1 do
      begin
      	LPath := LPath + NumToStr(GetNativeXPos(LPoints[LI].X)) + ' ' +
        	NumToStr(GetNativeYPos(LPoints[LI].Y, CurrentPage)) + ' ';
      	if (LI = 0) then LPath := LPath + 'm '
        else LPath := LPath + 'l ';
      end;
      if IsClosed then
      begin
      	LPath := LPath + NumToStr(GetNativeXPos(LPoints[0].X)) + ' ' +
        	NumToStr(GetNativeYPos(LPoints[0].Y, CurrentPage)) + ' l '
      end;
    end;
  end;
  with TgtShapeItem(AObject.Shapes.Items[0]) do
  begin
  	LS := '';
    if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
    	LS := LS + GetLineStyle(Pen.Style) +
      	NumToStr(Pen.Width * FPixelToPointMultiplier) +	' w ' +
        ColorToPDFColor(Pen.Color) + ' RG ';
    if (IsClosed and (Brush <> nil) and (Brush.Style = bsSolid)) then
    begin
    	LS := LS + ColorToPDFColor(Brush.Color) + ' rg' + CRLF + LPath + CRLF;
      if (AObject.FillAlternate) then
      	LS := LS + 'f*'
      else
      	LS := LS + 'f';
    end
    else if (Brush.Style <> bsClear) then
    begin
    	LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
      	GetPattern(Brush.Style) + ' scn n' + CRLF + LPath + CRLF;
      if (AObject.FillAlternate) then
      	LS := LS + 'f*'
      else
      	LS := LS + 'f';
    end;
  end;
  //Added...
  LS := LS + LPath + 's';
  if FIsClipState then
    LS := LS + CRLF
  else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
  if (LS <> '') then
  begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyPolygon(AObject: TgtPolyPolygonItem);
var
	LJ, LI, LK: Integer;
  LS, LPath: String;
  LATemp : AnsiString;
begin
  LS := CRLF;
  LPath := '';
  LK := 0;
  LI := 0;
  for LJ := 0 to AObject.FNoPoints[0] - 1 do
  begin
    LPath := LPath + NumToStr(GetNativeXPos(AObject.FPoints[LJ].X)) + ' ' +
      NumToStr(GetNativeYPos(AObject.FPoints[LJ].Y, CurrentPage)) + ' ';
    if (LJ = 0) or (LK = AObject.FNoPoints[LI+1]) then
    begin
      LPath := LPath + 'm '+ CRLF;
      if (LJ <> 0) then
      begin
        LI := LI + 1;
        LK := 0;
      end;
    end
    else LPath := LPath + 'l '+ CRLF;
    LK := LK + 1;
  end;
  LPath := LPath + CRLF;

  if (AObject.Brush <> nil) and (AObject.Brush.Style = bsSolid) then
  begin
    LS := LS + ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF + LPath + CRLF;
    if (AObject.FillAlternate) then
      LS := LS + 'f*'
    else
     	LS := LS + 'f';
  end
  else if (AObject.Brush.Style <> bsClear) then
  begin
    LS := LS + '/CSP cs ' + ColorToPDFColor(AObject.Brush.Color) + ' /' +
     	GetPattern(AObject.Brush.Style) + ' scn n' + CRLF + LPath + CRLF;
    if (AObject.FillAlternate) then
    LS := LS + 'f*'
    else
    LS := LS + 'f';
  end;
  if (AObject.Pen.Style <> psClear) then
  begin
    // Line Style.
    LS := LS + GetLineStyle(AObject.Pen.Style) +
      // Border width, spacing and color.
      NumToStr(AObject.Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(AObject.Pen.Color) + ' RG ' + LPath + ' s';
  end;

  if (LS <> '') then
  begin
    if FIsClipState then
      LS := CRLF + LS + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

(* Encoding Direct JPEG stream given *)
procedure TgtCustomPDFEngine.EncodeImageStream(ImgStream: TgtImageStream);
var
  LS: String;
  LATemp : AnsiString;
  ImgObjNo: Integer;
  ImageIndex: String;
  LStream: TMemoryStream;
  LImageSettings: TgtPDFImageSettings;
  LImgItem: TgtImageItem;
  LColorSpace, LPixelFormat: String;

  procedure GetImageProperties;
  var
    LImage: TJPEGImage;
  begin
    if LStream <> nil then
    begin
      LImage := TJPEGImage.Create;
      try
        LStream.Position := 0;
        LImage.LoadFromStream(LStream);
        if LImage.Grayscale then
          LColorSpace := 'DeviceGray'
        else
          LColorSpace := 'DeviceRGB';
        (* TJPEGImage does not consider PixelFormat while loading.
        case LImage.PixelFormat of
          jf24Bit: LPixelFormat := '24';
          jf8Bit: LPixelFormat := '8';
        else
          LPixelFormat := '8';
        end;
        *)
        LPixelFormat := '8';
      finally
        LImage.Free;
      end;
    end;
  end;
begin
  LImgItem := TgtImageItem.Create;
  LStream := TMemoryStream.Create;
  try
    ImgStream.Stream.Position := 0;
    LStream.LoadFromStream(ImgStream.Stream);
    LImgItem.X := ImgStream.X;
    LImgItem.Y := ImgStream.Y;
    LImgItem.Width := ImgStream.Width;
    LImgItem.Height := ImgStream.Height;

    LImgItem.IndexNo := ImgStream.IndexNo;
    LImgItem.Settings := ImgStream.Settings;

    LS := '';
    ImageIndex := '';

    if not (irImage in ItemsToRender) then
      Exit;

    with LImgItem do
    begin
        SetLength(FImageSettings, (IndexNo + 1));
        FImageSettings[IndexNo] := TList.Create;

      (* If new image setting, render new image stream. *)
      if ImageIndex = '' then
      begin
        LStream.Position := 0;

        ImgObjNo := GetNewObjNo;

        ImageIndex := IntToStr(IndexNo);
        LImageSettings := TgtPDFImageSettings.Create;
        with LImageSettings do
        begin
          Assign(Settings);
          ObjNo := ImgObjNo;
          DisplayWidth := DisplayRect.Right - DisplayRect.Left;
          DisplayHeight := DisplayRect.Bottom - DisplayRect.Top;
          ImageWidth := Width;
          ImageHeight := Height;
        end;

        ImageIndex := ImageIndex +
          IntToStr(FImageSettings[IndexNo].Add(LImageSettings));

        // Add obj to list so it can be reused where possible.
        FImageXRefList.AddObject(IntToStr(FImageStream.Size),
          TObject(ImgObjNo));

        (* Get the ColorSpace and the BitsPerComponent properties *)
        GetImageProperties;
        (* Write Image Dictionary. *)
        LS :=
          MakeObjHead(ImgObjNo) + CRLF + '<< ' +
          '/Type/XObject' +
          '/Subtype/Image' +
          '/Name/Img' + ImageIndex +
          '/Width ' + IntToStr(ImgStream.ImageWidth) +
          '/Height ' + IntToStr(ImgStream.ImageHeight) +
          '/BitsPerComponent ' + LPixelFormat +
          '/ColorSpace/' + LColorSpace +
          GetImageFilter(ifJPEG);
        LS := LS + '/Length ' + IntToStr(LStream.Size) + '>>' + CRLF +
          'stream' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LAtemp[1], Length(LS));
        LStream.Position := 0;
        WritePDFStream(LStream, LStream.Size, ImgObjNo, 0);
        (* Save the image to a temp stream to write later. *)
        FImageStream.CopyFrom(LStream, 0);

        LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LATemp[1], Length(LS));
      end; (* End If *)

      (*
        Get PDF Image rendering operators to be written into content.
        Also draw any frame if required.
      *)
      LS := EncodeImageObjectRef(ImageIndex, LImgItem);
      if LS <> '' then
      begin
        LATemp := AnsiString(LS);
        FContentStream.Write(LATemp[1], Length(LS));
      end;
    end; (* End with *)
  finally
    LStream.Free;
    LImgItem.Free;
  end;
end;

procedure TgtCustomPDFEngine.DrawJPEGDirect(ARect: TgtRect;
  AImagePixelWidth, AImagePixelHeight: Integer; AStream: TStream);
begin
  inherited;
end;
{$IFDEF gtPro} 
function TgtCustomPDFEngine.GetBitmapAsCCITTStream(ABitmap:TBitmap; AFormat: TgtOutputImageFormat): TMemoryStream;
begin
  Result := nil;
end;
{$ENDIF}
function TgtCustomPDFEngine.AddTOCItem(Title: WideString; ParentNode,
  PageNumber: Integer; Top: Double): Integer;
begin
  Result := inherited AddTOCItem(Title, ParentNode, PageNumber, Top);
end;

function TgtCustomPDFEngine.AddTOCItem(Title: WideString; ParentNode: Integer;
  URL: String): Integer;
begin
  Result := inherited AddTOCItem(Title, ParentNode, URL);
end;

procedure TgtCustomPDFEngine.WriteOutlines;
var
  LStr: String;
  LInt, LCnt: Integer;

  function FindNextOutline(AStartIndex, AParent: Integer): Integer;
  var
    LFN: Integer;
  begin
    Result := -1;
    with FTOCItemList do
      for LFN := AStartIndex to Count - 1 do
        if TgtTOCItem(Items[LFN]).ParentNode = AParent then
        begin
          Result := LFN;
          Break;
        end;
  end;

  function BuildOutline(CurOutlineIndex, ParentObjNo,
    PrevObjNo: Integer; var LastObjNo, OpenCount: Integer): Integer;
  var
    LS: String;
    LTOCItem: TgtTOCItem;
    Child, Next, LLast, LCount: Integer;
  begin
    LTOCItem := TgtTOCItem(FTOCItemList.Items[CurOutlineIndex]);
    Result := GetNewObjNo;
    LastObjNo := Result;

    LS := LS + '/Title <' + ToUnicodeHex(LTOCItem.Title, Result, 0) + '>';

    if LTOCItem.URL <> '' then
    begin
    (* Point 2 URL *)
      LS := LS +
        '/A <</S /URI /URI<' +
          String(GetHexOfStr(AnsiString(WritePDFString(Trim(LTOCItem.URL), Result, 0)))) +
          '> >>';
    end
    else
    (* Point to a location in file. *)
    (* To include zoom replace null with values from 1 to 16. *)
    if (FPageList.Count >= LTOCItem.PageNumber) and
      (FPageList.Items[LTOCItem.PageNumber - 1] <> nil) then
      LS := LS +
        '/Dest [' + MakeObjRef(
          TgtPageInfo(FPageList.Items[LTOCItem.PageNumber - 1]).ObjNo) +
          ' /XYZ ' + NumToStr(GetNativeXPos(LTOCItem.X)) + ' ' +
          NumToStr(GetNativeYPos(LTOCItem.Y, LTOCItem.PageNumber)) + ' null]';

    (*
      Include the below code to add
        /F 1 - Italic
        /F 2 - Bold
        /F 3 - Bold+Italic.
        /C Color.
    LS := LS + '/F 3' + '/C [1 0 0]';
    *)

    if ParentObjNo <> -1 then
      LS := LS + '/Parent ' + MakeObjRef(ParentObjNo);

    if PrevObjNo <> -1 then
      LS := LS + '/Prev ' + MakeObjRef(PrevObjNo);

    (* Find Next Outline Item. *)
    Next := FindNextOutline(CurOutlineIndex + 1, LTOCItem.ParentNode);
    if Next <> -1 then
    begin
      Inc(OpenCount);
      LS := LS + '/Next ' +
        MakeObjRef(BuildOutline(Next, ParentObjNo, Result, LastObjNo, OpenCount));
    end;

    (* Find Next Child Outline Item. *)
    Child := FindNextOutline((CurOutlineIndex + 1), CurOutlineIndex);
    if Child <> -1 then
    begin
      LLast := Result;
      LCount := 1;
      LS := LS + '/First ' +
        MakeObjRef(BuildOutline(Child, Result, -1, LLast, LCount));
      LS := LS + '/Last ' + MakeObjRef(LLast);
      (*
        Check if current node is the topmost node; if yes write +ve value for
        count such that the root nodes will be expanded and set to -ve to not
        expand the node.
      *)
      if LTOCItem.ParentNode = -1 then
        LS := LS + '/Count ' + IntToStr(LCount)
      else
        LS := LS + '/Count -' + IntToStr(LCount)
    end;

    LS := LS + CRLF;
    WriteObj(LS, Result, True);
  end;
begin
  LInt := FOutlines;
  LCnt := 1;
  LStr := '/First ' +
    MakeObjRef(BuildOutline(FindNextOutline(0, -1), FOutlines, -1, LInt, LCnt));
  LStr := LStr + '/Last ' + MakeObjRef(LInt);
  LStr := LStr + '/Count ' + IntToStr(LCnt);
  LStr := LStr + CRLF;
  WriteObj(LStr, FOutlines, True);
end;

function TgtCustomPDFEngine.ToUnicodeHex(AStr: WideString;
  AObjNo, AGenNo: Integer): String;
var
  LStr: String;
  LI: Integer;
  LByte: Byte;
begin
  Result := '';
  for LI :=1 to Length(AStr) do
  begin
    LStr := LStr + IntToHex((Ord(AStr[LI])),4);
  end;
  LI := 1;
  while (LI <= Length(LStr)) do
  begin
    HexToByteValue(LStr[LI] + LStr[LI+1], LByte);
    Result := Result + Char(LByte);
    Inc(LI, 2);
  end;
  Result := String(GetHexOfStr(AnsiString(WritePDFString(#254#255 + Result, AObjNo, AGenNo))));
end;

procedure TgtCustomPDFEngine.SetVeiwerPreferences(
  const Value: TgtViewerPreferences);
begin
  FViewerPreferences := Value;
end;

procedure TgtCustomPDFEngine.AddThumbnailImage(AGraphic: TGraphic;
  PageNo: Integer);
begin
  if FIsDocumentStarted = False then
    Exit;
  AddThumbnailImage(AddImageAsResource(AGraphic,
    Preferences.UseImagesAsResources), PageNo);
end;

procedure TgtCustomPDFEngine.AddThumbnailImage(Index, PageNo: Integer);
var
  LThumbnail: TgtPDFThumbnailItem;
begin
  if FIsDocumentStarted = False then
    Exit;

  LThumbnail := TgtPDFThumbnailItem.Create;
  with LThumbnail do
  begin
    OutputImageFormat := ImageSettings.OutputImageFormat;
    ImagePixelFormat := ImageSettings.ImagePixelFormat;
    JPEGQuality := ImageSettings.JPEGQuality;
    IndexNo := Index;
  end;

  (*
    If ProcessAfterEachPage = True,
      new image cannot be set for already rendered page.
    If ProcessAfterEachPage = False, thumbnail for a page can be changed.
  *)
  if Preferences.ProcessAfterEachPage = False then
  begin
    if (FThumbnailList.IndexOf(IntToStr(PageNo)) <> -1) then
    begin
      TgtPDFThumbnailItem(FThumbnailList.Objects[FThumbnailList.IndexOf(
        IntToStr(PageNo))]).Free;
      FThumbnailList.Delete(FThumbnailList.IndexOf(IntToStr(PageNo)));
    end;
    FThumbnailList.AddObject(IntToStr(PageNo), LThumbnail);
  end
  else if (FThumbnailList.IndexOf(IntToStr(PageNo)) = -1) then
    FThumbnailList.AddObject(IntToStr(PageNo), LThumbnail);
end;

procedure TgtCustomPDFEngine.WriteThumbnails;
var
  LI: Integer;
  LProcessedObjs: TList;
  LStream, LCompressedStream: TMemoryStream;
  LBitmap: TBitmap;
  LS: String;
  LATemp : AnsiString;
begin
  LProcessedObjs := TList.Create;
  LCompressedStream := TMemoryStream.Create;
  LBitmap := TBitmap.Create;
  try
    (* Write Thumbnail Content. *)
    with FThumbnailList do
      for LI := 0 to Count - 1 do
      begin
        LCompressedStream.Clear;
        with TgtPDFThumbnailItem(Objects[LI]) do
          if LProcessedObjs.IndexOf(TObject(ObjNo)) = -1 then
          begin
            LProcessedObjs.Add(TObject(ObjNo));
            case OutputImageFormat of
              ifBMP:
              begin
                LBitmap.Assign(GetGraphicResource(IndexNo));
                LBitmap.PixelFormat := ImagePixelFormat;
                LStream := GetPDFBitmapStream(LBitmap);
                CompressStream(LStream, LCompressedStream, Compression.Enabled,
                  Compression.Level);
                LCompressedStream.Position := 0;
                if (LStream <> nil) then
                  LStream.Clear;
              end;
              ifJPEG:
              begin
                LBitmap.Assign(GetGraphicResource(IndexNo));
                LBitmap.PixelFormat := ImagePixelFormat;
                LCompressedStream :=
                  TMemoryStream(GetBitmapAsJPGGIFStream(LBitmap, True,
                  JPEGQuality));
                LCompressedStream.Position := 0;
              end;
            end; (* End case. *)
            WritePDFStream(LCompressedStream, LCompressedStream.Size,
              ObjNo, 0);
            LS :=
              '/Width ' + IntToStr(LBitmap.Width) +
              '/Height ' + IntToStr(LBitmap.Height) +
              '/ColorSpace /DeviceRGB ' +
              '/BitsPerComponent 8 ' +
              '/Length ' + IntToStr(LCompressedStream.Size);
            LS := LS +
              GetImageFilter(OutputImageFormat);
            LS := LS + CRLF;
            WriteObj(LS, ObjNo, False);
            LS := 'stream' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));
            FOutputStream.CopyFrom(LCompressedStream, 0);
            LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));
          end; (* End found Index. *)
      end;
  finally
    FreeAndNil(LProcessedObjs);
    if (LStream <> nil) then
	    FreeAndNil(LStream);
    FreeAndNil(LCompressedStream);
    FreeAndNil(LBitmap);
  end;
end;

procedure TgtCustomPDFEngine.SetEncryption(
  const Value: TgtPDFEncryptionSettings);
begin
  FEncryption := Value;
end;

procedure TgtCustomPDFEngine.TextOutV(X, Y: Double; Text: widestring;
  TopDown: Boolean);
begin
  inherited;

end;

procedure TgtCustomPDFEngine.SetBiDi(const Value: Boolean);
begin
  FBiDi := Value;
end;

procedure TgtCustomPDFEngine.DrawJPEGDirect(ImageRect: TgtRect;
  AGraphic: TGraphic);
begin
  inherited;

end;

function TgtCustomPDFEngine.ConvertDelimiters(AString: String): String;
const
  CDelimiters: array[1..10] of Char = ('(', ')', '<', '>', '[', ']', '{', '}',
    '/', '%');
var
  LI: Integer;
begin
  Result := AString;
  for LI := Low(CDelimiters) to High(CDelimiters) do
  begin
    Result := ReplaceString(Result, CDelimiters[LI], '#' +
      IntToHex(Ord(CDelimiters[LI]), 2));
  end;
end;

{ TgtPDFImageSettings }

constructor TgtPDFImageSettings.Create;
begin
  inherited;
  FObjNo := 0;
end;

destructor TgtPDFImageSettings.Destroy;
begin
  inherited;
end;

function TgtPDFImageSettings.IsEqual(AObject: TgtImageItem; AOriginalWidth,
  AOriginalHeight: Integer): Boolean;
begin
  Result := False;
  with AObject do
  begin
    (* Image settings are different. *)
    if OutputImageFormat = Settings.OutputImageFormat then
    begin
      if (OutputImageFormat = ifJPEG) and
        (JPEGQuality <> Settings.JPEGQuality) then
        Exit;
    end
    else
      Exit;
    if ImagePixelFormat <> Settings.ImagePixelFormat then
      Exit;
    if SourceDPI <> Settings.SourceDPI then
      Exit;
    if AutoSize <> Settings.AutoSize then
      Exit;
    (*
      Stretch will include the original image.
      Hence if one is Stretch and other is Center/AutoSize/OriginalImage.
    *)
    if Stretch <> Settings.Stretch then
    begin
      (*
        If existing image is stretched, then check the dimensions of the
        current image to check if the current width and height is equal to
        original image width and height respectively.
      *)
      if Stretch then
      begin
        if (Width = AOriginalWidth) or
          (Height = AOriginalHeight) then
          Result := True;
        Exit;
      end
      else
      (*
        If current image is stretched, then check the dimensions of the
        existing image to check if the existing width and height is equal to
        original image width and height respectively. 
      *)
      begin
        if (ImageWidth = AOriginalWidth) or
          (ImageHeight = AOriginalHeight) then
          Result := True;
        Exit;
      end;
    end
    else if (Stretch) and (Settings.Stretch) then
    begin
      Result := True;
      Exit;
    end;
    if Center <> Settings.Center then
    begin
      (*
        If either existing/current image is centered, then
        if width & height of both images is equal to original image, reuse.
      *)

      if (ImageWidth <> Width) or (ImageHeight <> Height) or
        (ImageWidth <> AOriginalWidth) or
        (ImageHeight <> AOriginalHeight) then
        Exit;
    end
    else if (Center) and (Settings.Center) then
    begin
      (*
        If both current & existing images are centered.
      *)
      (*
        If existing image is the original image AND
        if current image width and height is equal to original image width and
        height, then reuse.
      *)
      if (ImageWidth = AOriginalWidth) and
        (ImageHeight = AOriginalHeight) then
      begin
        if (Width < AOriginalWidth) or
          (Height < AOriginalHeight) then
          Exit;
      end
      else
      (*
        If existing image is not the original image, i.e., the existing image
        is clipped, then compare the clipped rectangle (display rectangle) to
        determine whether both the clipped images are the same.
      *)
      begin
        if (ImageWidth <> Width) or (ImageHeight <> Height) then
          Exit;
      end;
    end;
    (* All settings are false. *)
    if (ImageWidth <> Width) or (ImageHeight <> Height) then
      Exit;

    Result := True;
  end;
end;

procedure TgtPDFImageSettings.SetDisplayHeight(const Value: Double);
begin
  FDisplayHeight := Value;
end;

procedure TgtPDFImageSettings.SetDisplayWidth(const Value: Double);
begin
  FDisplayWidth := Value;
end;

procedure TgtPDFImageSettings.SetImageHeight(const Value: Double);
begin
  FImageHeight := Value;
end;

procedure TgtPDFImageSettings.SetImageWidth(const Value: Double);
begin
  FImageWidth := Value;
end;

procedure TgtPDFImageSettings.SetObjNo(const Value: Integer);
begin
  FObjNo := Value;
end;

{ TgtPageInfo }

procedure TgtPageInfo.SetHeight(const Value: Double);
begin
  FHeight := Value;
end;

procedure TgtPageInfo.SetObjNo(const Value: Integer);
begin
  FObjNo := Value;
end;

procedure TgtPageInfo.SetWidth(const Value: Double);
begin
  FWidth := Value;
end;

{ TgtCompression }

constructor TgtCompression.Create;
begin
  FEnabled := True;
  FLevel := clMaxCompress;
end;

destructor TgtCompression.Destroy;
begin

  inherited;
end;

procedure TgtCompression.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TgtCompression.SetLevel(const Value: TgtCompressionLevel);
begin
  FLevel := Value;
end;

{ TgtPDFPreferences }

constructor TgtPDFPreferences.Create;
begin
  inherited;
  FEmbedTrueTypeFonts := etfNone;
end;

destructor TgtPDFPreferences.Destroy;
begin

  inherited;
end;

procedure TgtPDFPreferences.SetEmbedTrueTypeFonts(
  const Value: TgtTTFontEmbedding);
begin
  FEmbedTrueTypeFonts := Value;
end;

{ TgtPresentationMode }

constructor TgtPresentationMode.Create;
begin
  FDuration := 1;
  FTransitionEffect := teNone;
end;

destructor TgtPresentationMode.Destroy;
begin
  inherited;
end;

constructor TgtViewerPreferences.Create;
begin
  FPageLayout := plOneColumn;
  FPageMode := pmUseNone;
  FHideToolBar := False;
  FHideMenuBar := False;
  FHideWindowUI := False;
  FFitWindow := False;
  FCenterWindow := False;
  FNonFullScreenPageMode := nfspmUseNone;
  FPresentationMode := TgtPresentationMode.Create;
end;

destructor TgtViewerPreferences.Destroy;
begin
  FreeAndNil(FPresentationMode);
  inherited;
end;

function TgtViewerPreferences.GetTransitionEffectAndDuration(
  ADuration: Integer; ATransitionEffect: TgtTransitionEffect): String;
begin
  Result := '';
  Result := '/Dur ' + IntToStr(ADuration);
  Result := Result + '/Trans <<';
  Result := Result +
    '/Type/Trans' +
    '/D ' + IntToStr(ADuration) +
    '/S';
  case ATransitionEffect of
    teSplitHorizontalInward:
        Result := Result + '/Split' +
          '/Dm/H' +
          '/M/I';
    teSplitHorizontalOutward:
        Result := Result + '/Split' +
          '/Dm/H' +
          '/M/O';
    teSplitVerticalInward:
        Result := Result + '/Split' +
          '/Dm/V' +
          '/M/I';
    teSplitVerticalOutward:
        Result := Result + '/Split' +
          '/Dm/V' +
          '/M/O';
    teBlindsHorizontal:
        Result := Result + '/Blinds' +
          '/Dm/H';
    teBlindsVertical:
        Result := Result + '/Blinds' +
          '/Dm/V';
    teBoxInward:
        Result := Result + '/Box' +
          '/M/I';
    teBoxOutward:
        Result := Result + '/Box' +
          '/M/O';
    teWipeLeftToRight:
        Result := Result + '/Wipe' +
          '/Di 0';
    teWipeRightToLeft:
        Result := Result + '/Wipe' +
          '/Di 180';
    teWipeBottomToTop:
        Result := Result + '/Wipe' +
          '/Di 90';
    teWipeTopToBottom:
        Result := Result + '/Wipe' +
          '/Di 270';
    teDissolve:
        Result := Result + '/Dissolve';
    teGlitterLeftToRight:
        Result := Result + '/Glitter' +
          '/Di 0';
    teGlitterTopToBottom:
        Result := Result + '/Glitter' +
          '/Di 270';
    teGlitterTopLeftToBottomRight:
        Result := Result + '/Glitter' +
          '/Di 315';
    else
      Result := Result + '/R';
  end;
  Result := Result + ' >>';
end;

function TgtViewerPreferences.GetViewerPreferences(APageMode: TgtPageMode;
  APageLayout: TgtPageLayout; ACenterWindow, AFitWindow, AHideWindowUI,
  AHideMenuBar, AHideToolBar: Boolean;
  ANonFullScreenPageMode: TgtNonFullScreenPageMode): String;
begin
  Result := '';
  Result := '/PageMode';
  case APageMode of
    pmUseOutlines:
      Result := Result + '/UseOutlines';
    pmUseThumbs:
      Result := Result + '/UseThumbs';
    pmFullScreen:
      Result := Result + '/FullScreen';
    else
      Result := Result + '/UseNone';
  end;
  Result := Result + '/PageLayout';
  case PageLayout of
    plSinglePage:
      Result := Result + '/SinglePage';
    plTwoColumnLeft:
      Result := Result + '/TwoColumnLeft';
    plTwoColumnRight:
      Result := Result + '/TwoColumnRight';
    else
      Result := Result + '/OneColumn';
  end;
  Result := Result + '/ViewerPreferences <<';
  if ACenterWindow then
    Result := Result + '/CenterWindow true';
  if AFitWindow then
    Result := Result + '/FitWindow true';
  if AHideWindowUI then
    Result := Result + '/HideWindowUI true';
  if AHideMenuBar then
    Result := Result + '/HideMenubar true';
  if AHideToolBar then
    Result := Result + '/HideToolbar true';
  if (APageMode = pmFullScreen) then
  begin
    Result := Result + '/NonFullScreenPageMode';
    case ANonFullScreenPageMode of
      nfspmUseOutlines:
        Result := Result + '/UseOutlines';
      nfspmUseThumbs:
        Result := Result + '/UseThumbs';
      else
        Result := Result + '/UseNone';
    end;
  end;
  Result := Result + ' >>';
end;

procedure TgtViewerPreferences.SetCenterWindow(const Value: Boolean);
begin
  FCenterWindow := Value;
end;

procedure TgtViewerPreferences.SetFitWindow(const Value: Boolean);
begin
  FFitWindow := Value;
end;

procedure TgtViewerPreferences.SetHideMenuBar(const Value: Boolean);
begin
  FHideMenuBar := Value;
end;

procedure TgtViewerPreferences.SetHideToolBar(const Value: Boolean);
begin
  FHideToolBar := Value;
end;

procedure TgtViewerPreferences.SetHideWindowUI(const Value: Boolean);
begin
  FHideWindowUI := Value;
end;

procedure TgtViewerPreferences.SetNonFullScreenPageMode(
  const Value: TgtNonFullScreenPageMode);
begin
  FNonFullScreenPageMode := Value;
end;

procedure TgtViewerPreferences.SetPageLayout(const Value: TgtPageLayout);
begin
  FPageLayout := Value;
end;

procedure TgtViewerPreferences.SetPageMode(const Value: TgtPageMode);
begin
  FPageMode := Value;
end;

procedure TgtViewerPreferences.SetPresentationMode(
  AValue: TgtPresentationMode);
begin
  FPresentationMode := AValue;
end;

{ TgtPDFThumbnailItem }

constructor TgtPDFThumbnailItem.Create;
begin
  inherited;
  FObjNo := 0;
  FIndexNo := -1;
  FOutputImageFormat := ifBMP;
  FImagePixelFormat := pf24bit;
  FJPEGQuality := 100;
end;

destructor TgtPDFThumbnailItem.Destroy;
begin
  inherited;
end;

function TgtPDFThumbnailItem.IsEqual(
  AThumbnail: TgtPDFThumbnailItem): Boolean;
begin
  Result := True;

  if (ImagePixelFormat <> AThumbnail.ImagePixelFormat) or
    (OutputImageFormat <> AThumbnail.OutputImageFormat) then
    Result := False;
  if (OutputImageFormat = AThumbnail.OutputImageFormat) and
    (OutputImageFormat = ifJPEG) and (JPEGQuality <> AThumbnail.JPEGQuality) then
    Result := False;
end;

procedure TgtPDFThumbnailItem.SetImagePixelFormat(
  const Value: TPixelFormat);
begin
  FImagePixelFormat := Value;
end;

procedure TgtPDFThumbnailItem.SetIndexNo(const Value: Integer);
begin
  FIndexNo := Value;
end;

procedure TgtPDFThumbnailItem.SetJPEGQuality(const Value: Integer);
begin
  FJPEGQuality := Value;
end;

procedure TgtPDFThumbnailItem.SetObjNo(const Value: Integer);
begin
  FObjNo := Value;
end;

procedure TgtPDFThumbnailItem.SetOutputImageFormat(
  const Value: TgtOutputImageFormat);
begin
  FOutputImageFormat := Value;
end;

end.
