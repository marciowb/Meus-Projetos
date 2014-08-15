{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppUtils;

interface                                                                        

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants, MaskUtils,{$ENDIF}
  {$IFDEF Unicode}AnsiStrings,{$ENDIF}
  Windows, Registry, Messages, Classes, Graphics, Mask, ExtCtrls,
  SysUtils, TypInfo, Dialogs, Forms, ShellAPI,
  ActiveX,

  ppTypes,
  ppCharacter,
  ppDisplayFormat;

type

  {@TppFont  }
  TppFont = class(TFont)
  public
    class function Clone(aFont: TFont): TFont;
    class function Compare(aFont1, aFont2: TFont): Boolean;
    
    function EqualTo(aFont: TFont): Boolean;

  published
    property Height stored False;
    property Size stored True;

  end; {class, TppFont }

  {@TppFontInfo }
  TppFontInfo = class
  private
    FCharSet: TFontCharSet;
    FFontName: TFontName;
    FFontType: Byte;

  public
    function IsDeviceFont: Boolean;
    function IsTrueTypeFont: Boolean;
    property CharSet: TFontCharSet read FCharSet write FCharSet;
    property FontName: TFontName read FFontName write FFontName;
    property FontType: Byte read FFontType write FFontType;

  end; {class, TppFontInfo}



  {@TppFontList }
  TppFontList = class(TStringList)
  private

    function GetFontInfo(aIndex: Integer): TppFontInfo;

  public
    constructor CreateList(aDC: HDC);
    destructor Destroy; override;

    property FontInfo[Index: Integer]: TppFontInfo read GetFontInfo;


  end; {class, TppFontList }


  {@TppRegListSubscriber }
  TppRegListSubscriber = class
  private
    FOnListChanged: TNotifyEvent;

  protected

  public

    procedure RegisterListChanged; virtual;

    property OnListChanged: TNotifyEvent read FOnListChanged write FOnListChanged;

  end; {class, TppRegListSubscriber}


 {@TppRegList }
  TppRegList = class(TStringList)
  private
    FNotifyList: TList;

    procedure RegChanged;

  public
    destructor Destroy; override;

    procedure AddNotify(aRegListSubscriber: TppRegListSubscriber);
    procedure RemoveNotify(aRegListSubscriber: TppRegListSubscriber);

    function  AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Delete(Index: Integer); override;

  end; {class, TppRegList}



 {@TppResourceManager }

  TppResourceManagerClass = class of TppResourceManager;

  TppResourceManager = class(TObject)
    private
      FLanguageExt: String;
      FLanguageName: String;
      FResourceModules: TStringList;
      FResModuleCount: Integer;
      FResourceFilesLoaded: Boolean;

      procedure LoadResourceModule(aIndex: Integer);
      procedure UnLoadResourceModule(aIndex: Integer);

      function LoadStrFromModule(aIdent: Longint): String;

      procedure LoadResourceModules;
      procedure FreeResourceModules;

      procedure AddResFileName(aResFileName: String);
      procedure RemoveResFileName(aResFileName: String);

    public
      constructor Create; virtual;
      destructor Destroy; override;

      class procedure RegisterResourceManagerClass(aResourceManagerClass: TppResourceManagerClass);

      class procedure RegisterFileName(aResFileName: String);
      class procedure UnregisterFileName(aResFileName: String);

      function LoadStr(aIdent: Longint): String; virtual;
      function SetLanguage(aLanguageName, aLanguageExt: String): Boolean; virtual;

      property LanguageExt: String read FLanguageExt;
      property LanguageName: String read FLanguageName;

    end; {class, TppResourceManager}

  TppMetaFileCanvas = class(TMetaFileCanvas)
  private
    FPixelsPerInch: TPoint;
  public
    constructor CreateCanvas(AMetafile: TMetafile; ReferenceDevice: HDC);
    procedure Changing; override;
    procedure CreateHandle; override;
    procedure UpdateDeviceContext;
    property PixelsPerInch: TPoint read FPixelsPerInch;
  end;


  {@TppDeviceCompatibleCanvas }
  TppDeviceCompatibleCanvas = class(TCanvas)
  private
    FReferenceDC: HDC;
    FCompatibleDC: HDC;
    FCompatibleBitmap: HBitmap;
    FOldBitmap: HBitmap;
    FWidth: Integer;
    FHeight: Integer;
    FSavePalette: HPalette;
    FRestorePalette: Boolean;

  protected
    procedure CreateHandle; override;
    procedure Changing; override;
    procedure UpdateFont;

  public
    constructor Create(aReferenceDC: HDC; aWidth, aHeight: Integer; aPalette: HPalette);
    destructor Destroy; override;

    procedure RenderToDevice(aDestRect: TRect; aPalette: HPalette; aCopyMode: TCopyMode);

    property Height: Integer read FHeight;
    property Width: Integer read FWidth;


  end; {class, TppDeviceCompatibleCanvas }

  {TppHReaderUtils

   Utilities used to extract ident property values for property conversion.}

  TppHReaderUtils = class
    private
      class function FindPropName(aReader: TReader; aPropName: String): Boolean;
      class procedure SkipChildObjects(aReader: TReader);
      class procedure SkipProperty(aReader: TReader);
      class procedure SkipToNextObject(aReader: TReader);
{$IFNDEF Delphi5}
      class procedure SkipSetBody(aReader: TReader);
      class procedure SkipValue(aReader: TReader);
{$ENDIF}

    public
      class function ExtractIdentPropValue(aReader: TReader; aPropName: String): String;
      class procedure ExtractChildIdentValues(aReader: TReader; aPropName: String; aValues: TStrings);

    end; {class, TppHReaderUtils}


  TppDebugLog = class(TStringList)
  public
    procedure WriteMessage(aMessage: String);

  end;

  {@TppPersistent}

  TppPersistent = class(TPersistent)
    private
      FOnChange: TNotifyEvent;
      FOwner: TComponent;

    protected
      procedure BeforePropertyChange(aPropertyName: String); virtual;
      procedure DoOnChange; virtual;

    public
      constructor Create(aOwner: TComponent); virtual;
      procedure Assign(aSource: TPersistent); override;

      property Owner: TComponent read FOwner;
      property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end;


  {@TppBorder

    The TppBorder object represents the properties given to the border of a report
    object that has this capability.  Use the BorderPositions property to assign
    the specific sides of the component that should contain a border.  Set the
    TppBorder.All property to True to automatically assign all borders at one time.  }

  {@TppBorder.All

    Automatically enables all four sides of the component's border.  If you would
    like to disable all border sides, use the TppBorder.None property.  Setting
    this property to False has no effect.  }

  {@TppBorder.BorderPositions

    Represents the sides of a border that are currently visible.  If this set is
    empty, the border's visiblity is automatically set to False.  }

  {@TppBorder.Color

    Defines the color of the border lines.  }

  {@TppBorder.None

    Automatically disables all four sides of the component's border.  If you
    would like to enable all border sides, use the TppBorder.All property.
    Setting this property to False has no effect.  }

  {@TppBorder.Style

    Defines the style of the border lines.  }

  {@TppBorder.Weight

    Defines the thickness of the border lines in points.  }

  TppBorder = class(TppPersistent)
    private
      FBorderPositions: TppBorderPositions;
      FPreviousBorderPositions: TppBorderPositions;
      FColor: TColor;
      FStyle: TPenStyle;
      FVisible: Boolean;
      FWeight: Single;

      function  GetColor: TColor;
      function  GetStyle: TPenStyle;
      function  GetMMWeight: Integer;
      function  GetSPWeight: Integer;
      function  GetAll: Boolean;
      function  GetNone: Boolean;
      procedure SetBorderPositions(const Value: TppBorderPositions);
      procedure SetColor(const Value: TColor);
      procedure SetMMWeight(const Value: Integer);
      procedure SetStyle(const Value: TPenStyle);
      procedure SetVisible(const Value: Boolean);
      procedure SetWeight(const Value: Single);
      procedure SetAll(const Value: Boolean);
      procedure SetNone(const Value: Boolean);

    protected
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class procedure DrawBorder(aCanvas: TCanvas; aRect: TRect; aBorder: TppBorder);
      class function AdjustRotatedText(aBorder: TppBorder; aAngle, aLeft, aTop: Integer; aPrinter: TObject): TPoint;

      procedure Assign(aSource: TPersistent); override;
      function EqualTo(aBorder: TppBorder): Boolean;

      property All: Boolean read GetAll write SetAll;
      property None: Boolean read GetNone write SetNone;
      property MMWeight: Integer read GetMMWeight write SetMMWeight;
      property SPWeight: Integer read GetSPWeight;
      property PreviousBorderPositions: TppBorderPositions read FPreviousBorderPositions write FPreviousBorderPositions;

    published
      property BorderPositions: TppBorderPositions read FBorderPositions write SetBorderPositions;
      property Color: TColor read GetColor write SetColor;
      property Style: TPenStyle read GetStyle write SetStyle;
      property Visible: Boolean read FVisible write SetVisible;
      property Weight: Single read FWeight write SetWeight;
  end;

  {@TppGradient

    The Gradient object defines the properties to control the gradient fill of
    shape component.  Adjust the StartColor, EndColor, and Style properties
    to fill a shape with a gradient effect.}

  {@TppGradient.StartColor

    The first color to be used in the gradient fill effect of a shape.  This
    will be the top color for a vertical style gradient and the left color for
    a horizontal style gradient.}

  {@TppGradient.EndColor

    The second color to be used in the gradient fill effect of a shape.  This
    will be the bottom color for a vertical style gradient and the right color
    for a horizontal style gradient.}

  {@TppGradient.Style

    Defines whether the gradient fill uses a vertical or horizontal effect.}

  TppGradient = class(TppPersistent)
  private
    FEndColor: TColor;
    FStartColor: TColor;
    FStyle: TppGradientStyle;

    procedure SetEndColor(Value: TColor);
    procedure SetStartColor(Value: TColor);
    procedure SetStyle(Value: TppGradientStyle);

  public
    constructor Create(aOwner: TComponent); override;

    class procedure FillGradient(aCanvas: TCanvas; aGradient: TppGradient; aShapeType: TShapeType; aRect: TRect; aCorner: TPoint); overload;
    class procedure FillGradient(aCanvas: TCanvas; aGradient: TppGradient; aRect: TRect); overload;

    procedure Assign(Source: TPersistent); override;
    function IsEqualTo(aGradient: TppGradient): Boolean;

  published
    property EndColor: TColor read FEndColor write SetEndColor;
    property StartColor: TColor read FStartColor write SetStartColor;
    property Style: TppGradientStyle read FStyle write SetStyle;

  end;

{******************************************************************************
 *
 ** G E N E R A L   F U N C T I O N S
 *
{******************************************************************************}

  function ppAnsiCompareStrWithStringSort(aString1, aString2: String): Integer;
  function ppAnsiCompareTextWithStringSort(aString1, aString2: String): Integer;
  function ppAnsiCompareVariant(aVar1, aVar2: Variant): Integer;
  function ppBinaryCompareString(aString1: AnsiString; aString2: AnsiString; aIsCaseSensitive: Boolean = True): Integer;
  function ppVariantTypeToDataType(aVarType: Integer): TppDataType;
  function ppVariantIsString(aValue: Variant): Boolean;
  function  ppBitmapFromResource(aBitmapName: String): THandle;
  procedure ppBeginOutlinePreviewing;
  procedure ppEndOutlinePreviewing;
  procedure ppBeginBackgroundPrinting;
  procedure ppEndBackgroundPrinting;
  function  ppCalcAspectRatio(aSourceWidth, aSourceHeight, aDestWidth, aDestHeight: Single): Single;
  function  ppCapitalize(const aString: String): String;
  function  ppCheckPropInfo(aObject: TObject; aPropName: String): Boolean;
  function  ppCompareGuid(const aGuid1, aGuid2: TGuid): Integer;
  function  ppCompareGuidMSSQLServer(const aGuid1, aGuid2: TGuid): Integer;
  function  ppCompareVariant(aVar1, aVar2: Variant): Integer;
  function  ppCopyPalette(aPalette: HPalette): HPalette;
  procedure ppDebugMessage(aClassName, aProcName, aComment: String; aShowMessage: Boolean);
  procedure ppDecimalSeparatorToPeriod(aList: TStrings);
  procedure ppDisplayHelp(aKeyList: Char; aHelpFile, aKeyPhrase: String);
{$IFDEF Delphi9}
  procedure ppDisplayHelp2(aKeyList: Char; aHelpFile, aKeyPhrase: String);
{$ENDIF}
  function ppGetHelpFilePath: String;
  procedure ppDisplayWinHelp(aKeyList: Char; aHelpFile, aKeyPhrase: String);
  function  ppDisplayWidthToPixels(aDisplayWidth: Integer; aCanvas: TCanvas): Integer;
  function  ppDebugLog: TppDebugLog;
  procedure ppDrawDIBitmap(aCanvas: TCanvas; const aRect: TRect; aBitmap: TBitmap; aCopyMode: TCopyMode);
  procedure ppDrawTransparentDIBitmap(aCanvas: TCanvas; const aRect: TRect; aBitmap: TBitmap; aCopyMode: TCopyMode);
  function  ppFixText(Text: String; TargetLength: Integer; Alignment: TAlignment): String;
  procedure ppFormToScreenCenter(aHeight, aWidth: Integer; var aLeft, aTop: Integer);
  function  ppFormat(const aDisplayFormat: String; aDataType: TppDataType; aValue: Variant): String;
  function  ppFormatCalcValue(aCalcType: TppCalcType; aPageNo, aPageCount: Longint; aPrintDateTime: TDateTime; aLanguageIndex: Longint; aPrinting: Boolean): String;
  function  ppFormatVarValue(aVarType: TppVarType; aPageNo, aPageCount: Longint; aPrintDateTime: TDateTime; aLanguageIndex: Longint; aPrinting: Boolean): String;
  function  ppGetDIB(aHBitmap: HBITMAP; aPalette: HPALETTE; var aBitmapInfo; var aBits): Boolean;
  procedure ppGetDIBSizes(aHBitmap: HBITMAP; var aInfoHeaderSize: Integer; var aImageSize: DWORD);
  procedure ppGetDisplayFormats(aDataType: TppDataType; aFormatList: TStrings);
  function  ppGetEnumName(aEnumType: PTypeInfo; aOrd: Integer): String;
  procedure ppGetEnumNames(aEnumType: PTypeInfo; aValues: TStrings);
  function ppGetEnumValue(aEnumType: PTypeInfo; const aEnum: String): Integer;
  function  ppGetOrdPropValue(aObject: TObject; aPropName: String): Longint;
  function  ppGetStringPropValue(aObject: TObject; aPropName: String): String;
  function  ppGetSystemDefaultLanguage: TppLanguageType;
  function  ppInMainThread: Boolean;
  procedure ppSetOrdPropValue(aObject: TObject; aPropName: String; aValue: Longint);
  procedure ppSetStringPropValue(aObject: TObject; aPropName: String; aValue: String);
  procedure ppSetMethodPropValue(aObject: TObject; aPropName: String; aValue: TMethod);
  function  ppEqual(const aString1, aString2: String): Boolean;
  function  ppExtractNamingNumber(aNamingPrefix: String; aComponent: TComponent; var aNamingNo: Integer): Boolean;
  function  ppExtractQuotedStr(aQuotedStr: String): String;
  function  ppFindMethod(aObject: TObject; aMethodName: String): TMethod;
  function  ppFixUpFloatString(const aFloatString, aDisplayFormat: String): String;
  function  ppGetScreenRes: TPoint;
  function  ppGetStdNamingPrefix(aComponent: TComponent): String;
  function  ppGetSystemDirectory: String;
  function  ppGetUserNamePrefix(aComponent: TComponent): String;
  function  ppGetDelphiPath: String;
  function  ppGetDelphiRegistryKey: String;
  function  ppGetTempFileName(aPath: String; aPrefix: String): String;
  function  ppGetTempPath: String;
  function  ppGetUniqueName(aOwner: TComponent; aNamingPrefix: String; aComponent: TComponent): String;
  function  ppGetUniqueNameForComponents(aNamingPrefix: String; aComponent: TComponent; aComponentList: TList): String;
  function  ppGetUniqueNamingNumber(aNumberList: TStringList): Integer;
  function  ppMessageDlg(const Caption, Msg: String; AType: TMsgDlgType; AButtons: TMsgDlgButtons; aBitmapHandle: THandle): Word;
  function  ppRect(aLeft, aTop, aRight, aBottom: Longint): TppRect;
  function  ppReadIntegerPropValue(Reader: TReader): LongInt;
  function  ppRemoveCharacter(aCharacter: Char; const aString: String): String;
  function  ppCombineStrings(aStrings: TStrings): String;
  function  ppPadNumberString(aNumber, aDigits: Integer; const aPadChar: Char; aPadLeft: Boolean): String;
  procedure ppParseString(const aString: String; aStrings: TStrings);
  procedure ppPeriodToDecimalSeparator(aList: TStrings);
  function  ppSetMessageParameters(const aMessage: String): String;
  function  ppLoadStrWithParms(aStringID: Integer; const aParameters: array of const): String;
  function  ppLoadStrWithEllipses(aStringID: Integer): String;
  procedure ppStringsToStream(aStrings: TStrings; aMemoryStream: TMemoryStream);
  function  ppStripOffPath(Value: String): String;
  function  ppTextToIdentifier(const aString: String): String;
  procedure ppTextToPageList(const aString: String; aPageList: TStrings; aTrimPages: Boolean);
  function  ppVersionToInt(aVersion: String): Integer;
  function  ppCalcTextHeight(aFont: TFont): Integer;
  function  ppGetSpTextWidth(aFont: TFont; aText: String): Integer;
  function  ppGetSpTextHeight(aFont: TFont; aText: String): Integer;
  function  ppVarEventToEvent(aVarEvent: TppVarEventType): Integer;
  function  ppEventToVarEvent(aEvent: Integer): TppVarEventType;
  function  ppCalcTypeToVarType(aCalcType: TppCalcType): TppVarType;
  function  ppLoadStr(aIdent: Longint): String;
  function  ppResourceManager: TppResourceManager;
  function  ppFromMMTenths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Single;
  function  ppToMMTenths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Longint;
  function  ppFromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Single;  overload;
  function ppFromMMThousandths(Value: Longint; aUnits: TppUnitType; aPixelsPerInch: Integer): Single;  overload;
  function  ppToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Longint; overload;
  function ppToMMThousandths(Value: Single; aUnits: TppUnitType; aPixelsPerInch: Integer): Longint; overload;
  function  ppToScreenPixels(aValue: Single; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Integer;
  function  ppFromScreenPixels(aScreenPixels: Integer; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Single;
  procedure ppStripOffTableName(aRawTableName: String; var aTableName: String; var aExtension: String; var aIsFileBased: Boolean);
  function  ppStripUnderscores(const aString: String): String;
  procedure ppStringsFromMMThousandths(aStringList: TStrings; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject);
  procedure ppStringsToMMThousandths(aStringList: TStrings; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject);
  function ppStrToDateTime(aValue: String): TDateTime;
  function ppValidDate: Boolean;
  function ppIsWinXP: Boolean;
  function ppShellExec(const aPathStr, aCmdStr, aDirStr: string; aShow: Word): Boolean;
  {$IFNDEF Delphi9}
  function GradientFill(DC: HDC; Vertex: PTriVertex; NumVertex: ULONG; Mesh: Pointer; NumMesh, Mode: ULONG): BOOL; stdcall;
  procedure ppGradientFillCanvas(const ACanvas: TCanvas; const AStartColor, AEndColor: TColor; const ARect: TRect; const Direction: TppGradientDirection);
  {$ENDIF}

  function ppCreateGuidString: String;

var
  gcDisplayFormat: TppDisplayFormatClass;
  gbDesignTime: Boolean;

implementation

uses
  Controls,
  Consts,
  GraphUtil,
  ppDsIntf,
  ppComm,
  ppPrintr,
  ppDesignEventHub;

var
  uResourceManager: TppResourceManager;
  uResourceManagerClass: TppResourceManagerClass = TppResourceManager;
  uOutlinePreviewing: Integer = 0;
  uBackgroundPrinting: Integer = 0;
  uDebugLog: TppDebugLog;
  uFinalized: Boolean;
  uIsWinXP: Boolean;


{******************************************************************************
 *
 ** F O N T L I S T
 *
{******************************************************************************}

function TppFontInfo.IsDeviceFont: Boolean;
begin
  Result := ((FFontType and DEVICE_FONTTYPE) > 0) and not(IsTrueTypeFont);
end;

function TppFontInfo.IsTrueTypeFont: Boolean;
begin
  Result := (FFontType and TRUETYPE_FONTTYPE) > 0;
end;


{------------------------------------------------------------------------------}
{ EnumFontFamiliesExProc }

function EnumFontFamiliesExProc(var LogFontEx: TEnumLogFontEx; var TextMetric: TTextMetric; FontType: Integer; Data: Pointer): Integer; stdcall;
var
  lFontInfo: TppFontInfo;
  lStrings: TStrings;
  liIndex: Integer;
  lsFontName: string;
begin

  Result := 1;

  lStrings := TStrings(Data);

  lsFontName := String(LogFontEx.elfLogFont.lfFaceName);

  // check whether font name already in the list
  if lStrings.Count = 0 then
    liIndex := -1
  else if AnsiCompareText(lStrings[lStrings.Count-1], lsFontName) = 0 then
    liIndex := lStrings.Count-1
  else
    liIndex := -1;
//  else
//    liIndex := lStrings.IndexOf(lsFontName);

  if (liIndex < 0) then  // add font
    begin

      lFontInfo := TppFontInfo.Create;

      lFontInfo.FontName := lsFontName;
      lFontInfo.FontType := FontType;
      lFontInfo.CharSet  := TFontCharSet(LogFontEx.elfLogFont.lfCharSet);
      lStrings.AddObject(lFontInfo.FontName, lFontInfo);

    end
  else
    begin
      //when font name enumerated multiple times, set charset to DEFAULT_CHARSET
      // and let system choose
      TppFontInfo(lStrings.Objects[liIndex]).CharSet := DEFAULT_CHARSET;
    end;


end;

{------------------------------------------------------------------------------}
{ TppFontList.CreateList }

constructor TppFontList.CreateList(aDC: HDC);
var
  lDC: HDC;
   lLogFont: TLogFont;

begin
  inherited Create;

  {get a device context}
  if (aDC = 0) then
    lDC := GetDC(0)
  else
    lDC := aDC;

  {initialize LogFont structure
    - DEFAULT_CHARSET will get all font families }
  FillChar(lLogFont, SizeOf(lLogFont), 0);
  lLogFont.lfCharset := DEFAULT_CHARSET;

  {retrieve the fonts
    - pass callback procedure and Self as parameters}
  EnumFontFamiliesEx(lDC, lLogFont, @EnumFontFamiliesExProc, LongInt(Self), 0);

  if (aDC = 0) then
    ReleaseDC(0, lDC);

  {sort the list}
  Sorted := True;


end;  {constructor, CreateList}

{------------------------------------------------------------------------------}
{ TppFontList.Destroy }

destructor TppFontList.Destroy;
var
  liIndex: Integer;

begin

  for liIndex := 0 to Count-1 do
    Objects[liIndex].Free;


  inherited Destroy;

end;   {destructor, Destroy}


{------------------------------------------------------------------------------}
{ TppFontList.GetFontInfo }

function TppFontList.GetFontInfo(aIndex: Integer): TppFontInfo;
begin

  Result := TppFontInfo(Objects[aIndex]);

end;  {function, GetFontInfo}




{******************************************************************************
 *
 ** R E G  L I S T
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRegList.Destroy }

destructor TppRegList.Destroy;
begin

  FNotifyList.Free;

  inherited Destroy;

end; {destructor,  Destroy}


{------------------------------------------------------------------------------}
{ TppRegList.AddNotify }

procedure TppRegList.AddNotify(aRegListSubscriber: TppRegListSubscriber);
begin

  if (FNotifyList = nil) then
    FNotifyList := TList.Create;

  FNotifyList.Add(aRegListSubscriber);

end; {procedure,  AddNotify}


{------------------------------------------------------------------------------}
{ TppRegList.RemoveNotify }

procedure TppRegList.RemoveNotify(aRegListSubscriber: TppRegListSubscriber);
begin


  FNotifyList.Remove(aRegListSubscriber);

  if (FNotifyList.Count = 0) then
    begin
      FNotifyList.Free;
      FNotifyList := nil;
    end;


end; {procedure,  RemoveNotify}


{------------------------------------------------------------------------------}
{ TppRegList.AddObject }

function  TppRegList.AddObject(const S: string; aObject: TObject): Integer;
begin

  Result := inherited AddObject(S, aObject);

  RegChanged;

end; {function,  AddObject}


{------------------------------------------------------------------------------}
{ TppRegList.Delete }

procedure TppRegList.Delete(Index: Integer);
begin
  inherited Delete(Index);

  RegChanged;

end; {procedure,  Delete}


{------------------------------------------------------------------------------}
{ TppRegList.RegChanged }

procedure TppRegList.RegChanged;
var
  liObject: Integer;
  lRegListSubscriber: TppRegListSubscriber;

begin

  inherited Changed;

  if (FNotifyList = nil) then Exit;

  for liObject := 0 to FNotifyList.Count-1 do
    begin

      lRegListSubscriber := TppRegListSubscriber(FNotifyList[liObject]);
      lRegListSubscriber.RegisterListChanged;
    end;

end; {procedure,  RegChanged}


{******************************************************************************
 *
 ** R E G   L I S T   S U B S C R I B E R
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppRegListSubscriber.RegisterListChanged }

procedure TppRegListSubscriber.RegisterListChanged;
begin

  if Assigned(FOnListChanged) then FOnListChanged(Self);

end; {procedure,  RegisterListChanged}




{******************************************************************************
 *
 ** R E S O U R C E M A N A G E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppResourceManager.Create }

constructor TppResourceManager.Create;
begin
  inherited Create;

  FLanguageExt := 'dft';

  FResourceModules := TStringList.Create;

  FResModuleCount := 0;
  FResourceFilesLoaded := False;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppResourceManager.Destroy }

destructor TppResourceManager.Destroy;
begin

  FreeResourceModules;
  FResourceModules.Free;
  FResourceModules := nil;

  inherited Destroy;

end; {destructor,  Destroy}

{------------------------------------------------------------------------------}
{ TppResourceManager.SetLanguage }

function TppResourceManager.SetLanguage(aLanguageName, aLanguageExt: String): Boolean;
var
  lSaveLanguageExt: String;
  lSaveLanguageName: String;
begin

  lSaveLanguageExt := FLanguageExt;
  lSaveLanguageName := FLanguageName;

  FLanguageExt := aLanguageExt;
  FLanguageName := aLanguageName;

  if (FLanguageExt <> lSaveLanguageExt) then
    FResourceFilesLoaded := False;

  LoadResourceModules;

  Result := (FLanguageExt = 'dft') or (FResModuleCount > 0);

  if not Result then
    begin
      FLanguageExt := lSaveLanguageExt;
      FLanguageName := lSaveLanguageName;
    end;


end; {procedure,  SetLanguage}

{------------------------------------------------------------------------------}
{ TppResourceManager.AddResFileName }

procedure TppResourceManager.AddResFileName(aResFileName: String);
var
  liIndex: Integer;
begin

  if FResourceModules.IndexOf(aResFileName) > 0 then Exit;

  liIndex := FResourceModules.Add(aResFileName);

  LoadResourceModule(liIndex);

end; {procedure,  AddResFileName}

{------------------------------------------------------------------------------}
{ TppResourceManager.RegisterResourceManagerClass }

class procedure TppResourceManager.RegisterResourceManagerClass(aResourceManagerClass: TppResourceManagerClass);
begin

  if aResourceManagerClass <> nil then
    begin
      uResourceManagerClass := aResourceManagerClass;

      // free existing res manager
      uResourceManager.Free;
      uResourceManager := nil;
      
    end;

end;

{------------------------------------------------------------------------------}
{ TppResourceManager.RegisterFileName }

class procedure TppResourceManager.RegisterFileName(aResFileName: String);
begin

  ppResourceManager.AddResFileName(aResFileName);

end; {procedure,  AddResFileName}

{------------------------------------------------------------------------------}
{ TppResourceManager.RemoveResFileName }

procedure TppResourceManager.RemoveResFileName(aResFileName: String);
var
  liIndex: Integer;

begin
  liIndex := FResourceModules.IndexOf(aResFileName);

  if liIndex < 0 then Exit;

  UnLoadResourceModule(liIndex);

  FResourceModules.Delete(liIndex);

end; {procedure,  RemoveResFileName}


{------------------------------------------------------------------------------}
{ TppResourceManager.LoadStr }

function TppResourceManager.LoadStr(aIdent: Longint): String;
begin

  if FResModuleCount = 0 then
    Result := SysUtils.LoadStr(aIdent)
  else
    begin
      Result := LoadStrFromModule(aIdent);

      if Result = '' then
        Result := SysUtils.LoadStr(aIdent);

    end;

end; {function,  LoadStr}

{------------------------------------------------------------------------------}
{ TppResourceManager.LoadStrFromModule }

function TppResourceManager.LoadStrFromModule(aIdent: Longint): String;
var
  lBuffer: array[0..1023] of Char;
  liIndex: Integer;

begin

  Result := '';
  liIndex := 0;

  while (Result = '') and (liIndex < FResourceModules.Count) do
    begin

      if (FResourceModules.Objects[liIndex] <> nil) and
         (LoadString(THandle(FResourceModules.Objects[liIndex]), aIdent, lBuffer, Length(lBuffer)) > 0) then

        Result := String(lBuffer);

      Inc(liIndex);

    end;

end; {function,  LoadStrFromModule}

{------------------------------------------------------------------------------}
{ TppResourceManager.LoadResourceModules }

procedure TppResourceManager.LoadResourceModules;
var
  liIndex: Integer;

begin

  if FResourceFilesLoaded then Exit;

  FreeResourceModules;

  for liIndex := 0 to FResourceModules.Count-1 do
    LoadResourceModule(liIndex);

  FResourceFilesLoaded := True;

end; {procedure,  LoadResourceModules}

{------------------------------------------------------------------------------}
{ TppResourceManager.FreeResourceModules }

procedure TppResourceManager.FreeResourceModules;
var
  liIndex: Integer;
begin

  for liIndex := 0 to FResourceModules.Count-1 do
    UnLoadResourceModule(liIndex);

end; {procedure,  FreeResourceModules}

{------------------------------------------------------------------------------}
{ TppResourceManager.LoadResourceModule }

procedure TppResourceManager.LoadResourceModule(aIndex: Integer);
var
  lsResFileName: String;
  lResInstance: THandle;
begin

  lsResFileName := FResourceModules[aIndex] + '.' + FLanguageExt;

  lResInstance := LoadLibraryEx(PChar(lsResFileName), 0, LOAD_LIBRARY_AS_DATAFILE);

  FResourceModules.Objects[aIndex] := Pointer(lResInstance);

  if lResInstance <> 0 then
    Inc(FResModuleCount);


end; {function,  LoadResourceModule}

{------------------------------------------------------------------------------}
{ TppResourceManager.UnregisterFileName }

class procedure TppResourceManager.UnregisterFileName(aResFileName: String);
begin

  if (uResourceManager <> nil) then
    uResourceManager.RemoveResFileName(aResFileName);

end;


{------------------------------------------------------------------------------}
{ TppResourceManager.UnLoadResourceModule }

procedure TppResourceManager.UnLoadResourceModule(aIndex: Integer);
begin

  if (FResourceModules.Objects[aIndex] = nil) then Exit;

  FreeLibrary(THandle(FResourceModules.Objects[aIndex]));
  FResourceModules.Objects[aIndex] := nil;

  Dec(FResModuleCount);


end; {function,  LoadResourceModule}



{******************************************************************************
 *
 ** D e v i c e  C o m p a t i b l e  C a n v a s
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppDeviceCompatibleCanvas.Create }

constructor TppDeviceCompatibleCanvas.Create(aReferenceDC: HDC; aWidth, aHeight: Integer; aPalette: HPalette);
begin
  inherited Create;

  FReferenceDC := aReferenceDC;
  FWidth  := aWidth;
  FHeight := aHeight;


  FSavePalette := 0;
  FRestorePalette := False;

  FCompatibleDC := CreateCompatibleDC(FReferenceDC);


  FCompatibleBitmap := CreateCompatibleBitmap(FReferenceDC, aWidth, aHeight);

  FOldBitMap := SelectObject(FCompatibleDC, FCompatibleBitmap);


  if aPalette <> 0 then
    begin
      FSavePalette := SelectPalette(FCompatibleDC, aPalette, False);
      RealizePalette(FCompatibleDC);
      FRestorePalette := True;
    end
  else
    begin
      FSavePalette := SelectPalette(FCompatibleDC, SystemPalette16, False);
      RealizePalette(FCompatibleDC);
      FRestorePalette := True;
    end;


  PatBlt(FCompatibleDC, 0, 0, aWidth, aHeight, WHITENESS);
  SetMapMode(FCompatibleDC, MM_TEXT);

end;

{------------------------------------------------------------------------------}
{ TppDeviceCompatibleCanvas.Destroy }

destructor TppDeviceCompatibleCanvas.Destroy;
begin

  if FRestorePalette then
    SelectPalette(FReferenceDC, FSavePalette, False);

  FReferenceDC := 0;

  Handle := 0;
  
  if FCompatibleDC <> 0 then
    begin
      SelectObject(FCompatibleDC, FOldBitMap);
      DeleteObject(FCompatibleBitmap);

      DeleteDC(FCompatibleDC);
    end;

  inherited Destroy;

end;



{------------------------------------------------------------------------------}
{ TppDeviceCompatibleCanvas.CreateHandle }

procedure TppDeviceCompatibleCanvas.CreateHandle;
begin
  UpdateFont;


  {assign to canvas handle }
  Handle := FCompatibleDC;

end;

{------------------------------------------------------------------------------}
{ TppDeviceCompatibleCanvas.Changing }

procedure TppDeviceCompatibleCanvas.Changing;
begin
  inherited Changing;
  UpdateFont;
end;

{------------------------------------------------------------------------------}
{ TppDeviceCompatibleCanvas.UpdateFont }

procedure TppDeviceCompatibleCanvas.UpdateFont;
var
  lFontSize: Integer;
  liDevicePixelsPerInch: Integer;
  
begin

  liDevicePixelsPerInch := GetDeviceCaps(FReferenceDC, LOGPIXELSY);

  if (liDevicePixelsPerInch <> Font.PixelsPerInch) then
    begin
      lFontSize := Font.Size;
      Font.PixelsPerInch := liDevicePixelsPerInch;
      Font.Size := lFontSize;
    end;

end;


{------------------------------------------------------------------------------}
{ TppDeviceCompatibleCanvas.RenderToDevice }

procedure TppDeviceCompatibleCanvas.RenderToDevice(aDestRect: TRect; aPalette: HPalette; aCopyMode: TCopyMode);
var
 lSavePalette: HPalette;
 lbRestorePalette: Boolean;


begin

  lSavePalette := 0;
  lbRestorePalette := False;

  if aPalette <> 0 then
    begin
      lSavePalette := SelectPalette(FReferenceDC, aPalette, False);
      RealizePalette(FReferenceDC);
      lbRestorePalette := True;
    end;


  {copy the bits to the device }
  BitBlt(FReferenceDC,
             aDestRect.Left, aDestRect.Top, aDestRect.Right - aDestRect.Left, aDestRect.Bottom - aDestRect.Top,
             FCompatibleDC,
             0, 0, aCopyMode);


  if lbRestorePalette then
    SelectPalette(FReferenceDC, lSavePalette, False);


end; {prodedure, RenderToDevice}

{******************************************************************************
 *
 ** H R E A D E R   U T I L S
 *
{******************************************************************************}

type

  {TppHReader
    - used to access protected methods of TReader}
  TppHReader = class(TReader)
  end;

{------------------------------------------------------------------------------}
{ TppHReaderUtils.FindPropName }

class function TppHReaderUtils.FindPropName(aReader: TReader; aPropName: String): Boolean;
begin

  Result := False;

  {try to find the PropName in the stream}
  while not(Result) and not(aReader.EndOfList) do
    if aReader.ReadStr = aPropName then
      Result := True
    else
{$IFDEF Delphi5}
      TppHReader(aReader).SkipValue;
{$ELSE}
      SkipValue(aReader);
{$ENDIF}

end; {class function, FindPropName}

{------------------------------------------------------------------------------}
{ TppHReaderUtils.ExtractIdentPropValue }

class function TppHReaderUtils.ExtractIdentPropValue(aReader: TReader; aPropName: String): String;
var
  liPosition: Integer;
begin

  {save the current reader position}
  liPosition := aReader.Position;
  Result := '';

  try
    {find the property name and read the ident value}
    if FindPropName(aReader, aPropName) and (aReader.NextValue = vaIdent) then
      begin
        Result := aReader.ReadIdent;

        {strip off any prefixes}
        while Pos('.', Result) > 0 do
          Result := Copy(Result,Pos('.', Result)+1, Length(Result));
      end;


  finally
    {restore the saved position}
    aReader.Position := liPosition;

  end;

end; {class function, ExtractIdentPropValue}




{------------------------------------------------------------------------------}
{ TppHReaderUtils.ExtractChildIdentValues }

class procedure TppHReaderUtils.ExtractChildIdentValues(aReader: TReader; aPropName: String; aValues: TStrings);
var
  liPosition: Integer;
  lsPropValue: String;
  lsClassName: String;
  lsObjectName: String;
  lFilerFlags: TFilerFlags;
  liChildPos: Integer;
begin

  {save the current reader position}
  liPosition := aReader.Position;

  try

    {skip over prop values for this component}
    TppHReaderUtils.SkipToNextObject(aReader);

    while not aReader.EndOfList do
      begin
        lsClassName  := aReader.ReadStr;
        lsObjectName := aReader.ReadStr;

        {extract the property value}
        if FindPropName(aReader, aPropName) and (aReader.NextValue = vaIdent) then
          lsPropValue := aReader.ReadIdent
        else
          lsPropValue := '';

        if lsPropValue <> '' then
          begin

            {strip off any prefixes}
            while Pos('.', lsPropValue) > 0 do
              lsPropValue := Copy(lsPropValue,Pos('.', lsPropValue)+1, Length(lsPropValue));

            aValues.Add(lsObjectName + '=' + lsPropValue);
          end;

        // skip remaining props
        TppHReaderUtils.SkipToNextObject(aReader);

        // skip child objects as needed
        if not(aReader.EndOfList) then
          SkipChildObjects(aReader);

        {read end of list marker and read prefix for next child object}
        if aReader.EndOfList then
          begin
            aReader.ReadListEnd;
            liChildPos := 0;
            lFilerFlags := [];
            aReader.ReadPrefix(lFilerFlags, liChildPos);
          end;

      end;


  finally
    {restore the saved position}
    aReader.Position := liPosition;

  end;


end; {class procedure, ExtractChildIdentValues}

{------------------------------------------------------------------------------}
{ TppHReaderUtils.SkipToNextObject }

class procedure TppHReaderUtils.SkipToNextObject(aReader: TReader);
begin

  while not aReader.EndOfList do
    TppHReaderUtils.SkipProperty(aReader);

  aReader.ReadListEnd;

end; {class procedure, SkipToNextObject}

{------------------------------------------------------------------------------}
{ TppHReaderUtils.SkipChildObjects }

class procedure TppHReaderUtils.SkipChildObjects(aReader: TReader);
var
  liChildPos: Integer;
  lFilerFlags: TFilerFlags;
begin

  // read prefix
  liChildPos := 0;
  lFilerFlags := [];
  aReader.ReadPrefix(lFilerFlags, liChildPos);
  aReader.ReadStr;
  aReader.ReadStr;

  // skip properties
  while not aReader.EndOfList do
    TppHReaderUtils.SkipProperty(aReader);

  // end of properties
  aReader.ReadListEnd;

  // skip more objects
  if not aReader.EndOfList then
    SkipChildObjects(aReader);

  // end of parent object
  aReader.ReadListEnd;

end; {class procedure, SkipToNextObject}


{------------------------------------------------------------------------------}
{ TppHReaderUtils.SkipProperty }

class procedure TppHReaderUtils.SkipProperty(aReader: TReader);
begin
  aReader.ReadStr; {read prop name}
{$IFDEF Delphi5}
  TppHReader(aReader).SkipValue;
{$ELSE}
  SkipValue(aReader);
{$ENDIF}
end; {class procedure, SkipProperty}

{$IFNDEF Delphi5}

{------------------------------------------------------------------------------}
{ TppHReaderUtils.SkipSetBody }

class procedure TppHReaderUtils.SkipSetBody(aReader: TReader);
begin
  while aReader.ReadStr <> '' do begin end;
end; {class procedure, SkipSetBody}

{------------------------------------------------------------------------------}
{ TppHReaderUtils.SkipValue }

class procedure TppHReaderUtils.SkipValue(aReader: TReader);

  procedure SkipList;
  begin
    while not aReader.EndOfList do
      SkipValue(aReader);
    aReader.ReadListEnd;
  end;

  procedure SkipBytes(aCount: Longint);
  var
    lBytes: array[0..255] of Byte;
  begin
    while aCount > 0 do
      if aCount > SizeOf(lBytes) then
        begin
          aReader.Read(lBytes, SizeOf(lBytes));
          Dec(aCount, SizeOf(lBytes));
        end
      else
        begin
          aReader.Read(lBytes, aCount);
          aCount := 0;
        end;
  end;

  procedure SkipBinary;
  var
    lCount: Longint;
  begin
    aReader.Read(lCount, SizeOf(lCount));
    SkipBytes(lCount);
  end;

  procedure SkipCollection;
  begin
    while not aReader.EndOfList do
      begin

        if aReader.NextValue in [vaInt8, vaInt16, vaInt32] then
          SkipValue(aReader);

        SkipBytes(1);

        while not aReader.EndOfList do
          SkipProperty(aReader);

        aReader.ReadListEnd;
      end;

    aReader.ReadListEnd;
  end;

begin
  case aReader.ReadValue of
    vaNull: begin end;
    vaList: SkipList;
    vaInt8: SkipBytes(1);
    vaInt16: SkipBytes(2);
    vaInt32: SkipBytes(4);
    vaExtended: SkipBytes(SizeOf(Extended));
    vaString, vaIdent: aReader.ReadStr;
    vaFalse, vaTrue: begin end;
    vaBinary: SkipBinary;
    vaSet: SkipSetBody(aReader);
    vaCollection: SkipCollection;
  end;
end; {class procedure, SkipValue}

{$ENDIF}

{******************************************************************************
 *
 ** T P P P E R S I S T E N T
 *
{******************************************************************************}

constructor TppPersistent.Create(aOwner: TComponent);
begin
  inherited Create;

  FOwner := aOwner;

end;

procedure TppPersistent.Assign(aSource: TPersistent);
var
  lPersistent: TppPersistent;
begin

  if not(aSource is TppPersistent) then
    inherited Assign(aSource);

  lPersistent := TppPersistent(aSource);

  FOwner := lPersistent.Owner;

end;

procedure TppPersistent.BeforePropertyChange(aPropertyName: String);
var
  lEventHub: TppDesignEventHub;
  lEventParams: TppPropertyChangeEventParams;
begin

  if (FOwner <> nil) and (FOwner is TppCommunicator) then
    lEventHub := TppDesignEventHub(TppCommunicator(FOwner).DesignEventHub)
  else
    lEventHub := nil;

  if lEventHub <> nil then
    begin
      lEventParams := lEventHub.ComponentEvents.GetPropertyChangeEventParams(Owner, aPropertyName);
      lEventHub.ComponentEvents.mcBeforePropertyChange.Notify(Self, lEventParams);
    end;

end;

procedure TppPersistent.DoOnChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);

end;

{******************************************************************************
 *
 ** B O R D E R S
 *
{******************************************************************************}

constructor TppBorder.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FBorderPositions := [];
  FColor := clBlack;
  FStyle := psSolid;
  FVisible := False;
  FWeight := 0;

end;

destructor TppBorder.Destroy;
begin

  inherited Destroy;
end;

procedure TppBorder.Assign(aSource: TPersistent);
var
  lBorder: TppBorder;
begin

  if not(aSource is TppBorder) then
    inherited Assign(aSource);

  lBorder := TppBorder(aSource);

  BorderPositions := lBorder.FBorderPositions;
  Color           := lBorder.Color;
  Style           := lBorder.Style;
  Visible         := lBorder.Visible;
  Weight          := lBorder.Weight;

end;

class function TppBorder.AdjustRotatedText(aBorder: TppBorder; aAngle, aLeft, aTop: Integer; aPrinter: TObject): TPoint;
var
  liXBorderWidth: Integer;
  liYBorderWidth: Integer;
begin

  Result.X := aLeft;
  Result.Y := aTop;

  if (aPrinter <> nil) and (aPrinter is TppPrinter) then
    begin
      liXBorderWidth := Round(aBorder.Weight * TppPrinter(aPrinter).PixelsPerInch.X / 72);
      liYBorderWidth := Round(aBorder.Weight * TppPrinter(aPrinter).PixelsPerInch.Y / 72);
    end
  else
    begin
      liXBorderWidth := aBorder.SPWeight;
      liYBorderWidth := liXBorderWidth;
    end;

  if (aAngle > 0) and (aAngle <= 90) then
    begin
      if bpLeft in aBorder.BorderPositions then
        Result.X := aLeft + liXBorderWidth;

      if bpBottom in aBorder.BorderPositions then
        Result.Y := aTop - liYBorderWidth;
    end
  else if (aAngle > 90) and (aAngle <= 180) then
    begin
      if bpRight in aBorder.BorderPositions then
        Result.X := aLeft - liXBorderWidth;

      if bpBottom in aBorder.BorderPositions then
        Result.Y := aTop - liYBorderWidth;
    end
  else if (aAngle > 180) and (aAngle <= 270) then
    begin
      if bpRight in aBorder.BorderPositions then
        Result.X := aLeft - liXBorderWidth;

      if bpTop in aBorder.BorderPositions then
        Result.Y := aTop + liYBorderWidth;
    end
  else
    begin
      if bpLeft in aBorder.BorderPositions then
        Result.X := aLeft + liXBorderWidth;

      if bpTop in aBorder.BorderPositions then
        Result.Y := aTop + liYBorderWidth;
    end;
end;

class procedure TppBorder.DrawBorder(aCanvas: TCanvas; aRect: TRect; aBorder: TppBorder);
var
  liPixelsPerInch: TPoint;
  liXPenWidth: Integer;
  liYPenWidth: Integer;
  liOffset: Integer;
begin

  aCanvas.Pen.Style := aBorder.Style;
  aCanvas.Pen.Color := aBorder.Color;

  liPixelsPerInch.X := GetDeviceCaps(aCanvas.Handle, LOGPIXELSX);
  liPixelsPerInch.Y := GetDeviceCaps(aCanvas.Handle, LOGPIXELSY);

 liXPenWidth := Round(aBorder.Weight * liPixelsPerInch.X / 72);
  if liXPenWidth = 0 then
    liXPenWidth := 1;

  liYPenWidth := Round(aBorder.Weight *liPixelsPerInch.Y / 72);
  if liYPenWidth = 0 then
    liYPenWidth := 1;

  for liOffset := 0 to liXPenWidth - 1 do
    begin
      if bpLeft in aBorder.BorderPositions then
        begin
          aCanvas.MoveTo(aRect.Left + liOffset, aRect.Top);
          aCanvas.LineTo(aRect.Left + liOffset, aRect.Bottom);
        end;

      if bpRight in aBorder.BorderPositions then
        begin
          aCanvas.MoveTo(aRect.Right - liOffset, aRect.Top);
          aCanvas.LineTo(aRect.Right - liOffset, aRect.Bottom);
        end;

    end;

   for liOffset := 0 to liYPenWidth - 1 do
    begin
      if bpTop in aBorder.BorderPositions then
        begin
          aCanvas.MoveTo(aRect.Left, aRect.Top + liOffset);
          aCanvas.LineTo(aRect.Right, aRect.Top + liOffset);
        end;

      if bpBottom in aBorder.BorderPositions then
        begin
          aCanvas.MoveTo(aRect.Left, aRect.Bottom - liOffset);
          aCanvas.LineTo(aRect.Right, aRect.Bottom - liOffset);
        end;

    end;


end;

function TppBorder.EqualTo(aBorder: TppBorder): Boolean;
begin
  Result := (FBorderPositions = aBorder.BorderPositions) and
            (FColor = aBorder.Color) and
            (FStyle = aBorder.Style) and
            (FVisible = aBorder.Visible) and
            (FWeight = aBorder.Weight);
end;

function TppBorder.GetColor: TColor;
begin
  Result := FColor;
end;

function TppBorder.GetStyle: TPenStyle;
begin
  Result := FStyle;
end;

procedure TppBorder.SetBorderPositions(const Value: TppBorderPositions);
begin

  BeforePropertyChange('Border.Positions');

  if Value = [] then
    FVisible := False
  else
    FVisible := True;

  FPreviousBorderPositions := FBorderPositions;

  FBorderPositions := Value;

  DoOnChange;
end;

procedure TppBorder.SetColor(const Value: TColor);
begin
  BeforePropertyChange('Border.Color');
  FColor := Value;

  DoOnChange;
end;

procedure TppBorder.SetStyle(const Value: TPenStyle);
begin
  BeforePropertyChange('Border.Style');
  FStyle := Value;

  DoOnChange;
end;

procedure TppBorder.SetVisible(const Value: Boolean);
begin
  BeforePropertyChange('Border.Visible');
  FVisible := Value;

  DoOnChange;
end;

procedure TppBorder.SetWeight(const Value: Single);
begin
  BeforePropertyChange('Border.Weight');
  FWeight := Value;

  DoOnChange;
end;

function TppBorder.GetMMWeight: Integer;
var
  lInches: Single;
begin

  lInches := FWeight / 72;
  Result := ppToMMThousandths(lInches, utInches, pprtHorizontal, nil);
end;

function TppBorder.GetSPWeight: Integer;
begin
  Result := Trunc(FWeight * Screen.PixelsPerInch / 72);

  if Result = 0 then
    Result := 1;

end;

procedure TppBorder.SetMMWeight(const Value: Integer);
var
  lInches: Single;
begin

  lInches := ppFromMMThousandths(Value, utInches, pprtHorizontal, nil);
  FWeight := lInches * 72;

end;

function TppBorder.GetAll: Boolean;
begin
  Result := (BorderPositions = [bpLeft, bpTop, bpRight, bpBottom]);

end;

function TppBorder.GetNone: Boolean;
begin
  Result := (BorderPositions = []);

end;

procedure TppBorder.SetAll(const Value: Boolean);
begin
  if Value then
    SetBorderPositions([bpLeft, bpTop, bpRight, bpBottom]);

end;

procedure TppBorder.SetNone(const Value: Boolean);
begin
  if Value then
    SetBorderPositions([]);
    
end;

{******************************************************************************
 *
 ** G R A D I E N T
 *
{******************************************************************************}

constructor TppGradient.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FStartColor := clWhite;
  FEndColor := clWhite;
  FStyle := gsNone;

end;

class procedure TppGradient.FillGradient(aCanvas: TCanvas; aGradient: TppGradient; aShapeType: TShapeType; aRect: TRect; aCorner: TPoint);
var
  lDirection: Integer;
begin

  aCanvas.Brush.Style := bsClear;

  if aGradient.Style = gsHorizontal then
    lDirection := Ord(gdHorizontal)
  else
    lDirection := Ord(gdVertical);

  Windows.BeginPath(aCanvas.Handle);

  case aShapeType of
    stRectangle, stSquare:
      Windows.Rectangle(aCanvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
    stEllipse, stCircle:
      Windows.Ellipse(aCanvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom);
    stRoundRect, stRoundSquare:
      Windows.RoundRect(aCanvas.Handle, aRect.Left, aRect.Top, aRect.Right, aRect.Bottom, aCorner.x, aCorner.y);
  end;

  Windows.EndPath(aCanvas.Handle);
  Windows.SelectClipPath(aCanvas.Handle, RGN_COPY);

  {$IFDEF Delphi9}
  GradientFillCanvas(aCanvas, aGradient.StartColor, aGradient.EndColor, aRect, TGradientDirection(lDirection));
  {$ELSE}
  ppGradientFillCanvas(aCanvas, aGradient.StartColor, aGradient.EndColor, aRect, TppGradientDirection(lDirection));
  {$ENDIF}

  //Reset the clipping path to the original
  Windows.SelectClipRgn(aCanvas.Handle, 0);

end;

procedure TppGradient.Assign(Source: TPersistent);
var
  lGradient: TppGradient;
begin

  lGradient := TppGradient(Source);

  FStartColor := lGradient.StartColor;
  FEndColor := lGradient.EndColor;
  FStyle := lGradient.Style;

end;

class procedure TppGradient.FillGradient(aCanvas: TCanvas; aGradient: TppGradient; aRect: TRect);
begin

  TppGradient.FillGradient(aCanvas, aGradient, stRectangle, aRect, Point(0, 0));

end;

function TppGradient.IsEqualTo(aGradient: TppGradient): Boolean;
begin

  Result := (FStyle = aGradient.FStyle) and
            (FStartColor = aGradient.FStartColor) and
            (FEndColor = aGradient.FEndColor);

end;

procedure TppGradient.SetEndColor(Value: TColor);
begin
  BeforePropertyChange('Gradient.EndColor');
  FEndColor := Value;

  DoOnChange;

end;

procedure TppGradient.SetStartColor(Value: TColor);
begin
  BeforePropertyChange('Gradient.StartColor');
  FStartColor := Value;

  DoOnChange;

end;

procedure TppGradient.SetStyle(Value: TppGradientStyle);
begin
  BeforePropertyChange('Gradient.Style');
  FStyle := Value;

  DoOnChange;

end;


{******************************************************************************
 *
 ** G E N E R A L   F U N C T I O N S
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ ppStripOffTableName }

procedure ppStripOffTableName(aRawTableName: String; var aTableName: String; var aExtension: String; var aIsFileBased: Boolean);
var
  liPosition: Integer;
  lsString1: String;
  lsString2: String;
  lsExtension: String;
begin

  if (Length(aRawTableName) > 0) and (aRawTableName[1] = '"') then
    raise EDataError.Create('ppStripOffTableName: TableName (' + aRawTableName + ') should not be enquoted.')
  else
    aTableName := aRawTableName;

  aExtension := '';
  aIsFileBased := False;

  liPosition := Pos('.', aTableName);

  if (liPosition > 0) then
    begin
      lsString1 := Copy(aTableName, 1, liPosition - 1);
      lsString2 := Copy(aTableName, liPosition + 1, Length(aTableName));

      aIsFileBased := ((CompareText(lsString2, 'DB') = 0) or
                       (CompareText(lsString2, 'DBF') = 0) or
                       (CompareText(lsString2, 'MDB') = 0) or
                       (CompareText(lsString2, 'DAT') = 0));

      lsExtension := Uppercase(lsString2);

      if aIsFileBased then
        begin
          aTableName := lsString1;
          aExtension := lsString2;
        end
      else
        begin
          aTableName := lsString2;
          aExtension := lsString1;
        end;
    end;

end;  {function, ppStripOffTableName}


{------------------------------------------------------------------------------}
{ ppExtractQuotedStr }

function ppExtractQuotedStr(aQuotedStr: String): String;
var
  lpcQuotedStr: PChar;
begin

  lpcQuotedStr := PChar(aQuotedStr);

  Result := AnsiExtractQuotedStr(lpcQuotedStr, '"');

end; {function, ppExtractQuotedStr}


{------------------------------------------------------------------------------}
{ ppCombineStrings }

function ppCombineStrings(aStrings: TStrings): String;
var
  liIndex: Integer;
begin

  Result := '';

  for liIndex := 0 to aStrings.Count - 1 do
    begin
      Result := Result + aStrings[liIndex];

      if (liIndex < aStrings.Count - 1) then
        Result := Result + ',';
    end;

end; {function, ppCombineStrings}


{------------------------------------------------------------------------------}
{ ppPadNumberString }

function ppPadNumberString(aNumber, aDigits: Integer; const aPadChar: Char; aPadLeft: Boolean): String;
begin

  Result := IntToStr(aNumber);

  if (Length(Result) < aDigits) then
    if aPadLeft then
      begin
        while (Length(Result) < aDigits) do
          Result := aPadChar + Result;
      end

    else
      begin
        while (Length(Result) < aDigits) do
          Result := Result + aPadChar;
      end;

end; {function, ppPadNumberString}


{------------------------------------------------------------------------------}
{ ppParseString }

procedure ppParseString(const aString: String; aStrings: TStrings);
var
  lsString: String;
  liPosition: Integer;
begin

  aStrings.Clear;
  
  lsString := aString;

  liPosition := Pos(',', lsString);

  while (liPosition <> 0) do
    begin
      aStrings.Add(Copy(lsString, 1, liPosition - 1));

      lsString := Copy(lsString, liPosition + 1, Length(lsString));

      liPosition := Pos(',', lsString);
    end;

  if (Length(lsString) > 0) then
    aStrings.Add(lsString);

end; {procedure, ppParseString}

{------------------------------------------------------------------------------}
{ ppCalcTypeToVarType }

function ppCalcTypeToVarType(aCalcType: TppCalcType): TppVarType;
begin

  case aCalcType of
    ctDate:          Result := vtDate;
    ctDateTime:      Result := vtDateTime;
    ctPrintDateTime: Result := vtPrintDateTime;
    ctPageCount:     Result := vtPageCount;
    ctPageSet:       Result := vtPageSet;
    ctPageSetDesc:   Result := vtPageSetDesc;
    ctPageNo:        Result := vtPageNo;
    ctPageNoDesc:    Result := vtPageNoDesc;
    ctTime:          Result := vtTime;
  else
    Result := vtDate;
  end; {case}

end; {function, ppCalcTypeToVarType}

{------------------------------------------------------------------------------}
{ ppEventToVarEvent }

function ppEventToVarEvent(aEvent: Integer): TppVarEventType;
begin

  case aEvent of
    ciTraversal:              Result := veTraversal;
    ciPipelineTraversal:      Result := veDataPipelineTraversal;
    ciEngineStart:            Result := veReportStart;
    ciEngineEnd:              Result := veReportEnd;
    ciEngineStartColumn:      Result := veColumnStart;
    ciEngineEndColumn:        Result := veColumnEnd;
    ciEngineStartPage:        Result := vePageStart;
    ciEngineEndPage:          Result := vePageEnd;
    ciGroupBeforeGroupBreak:  Result := veGroupStart;
    ciGroupAfterGroupBreak:   Result := veGroupEnd;
    ciGroupBeforeHeader:      Result := veGroupBeforeHeader;
    ciGroupBeforeFooter:      Result := veGroupBeforeFooter;
    else
      Result := veTraversal;
  end; {case}

end; {function, ppEventToVarEvent}

{------------------------------------------------------------------------------}
{ ppVarEventToEvent }

function ppVarEventToEvent(aVarEvent: TppVarEventType): Integer;
begin

  case aVarEvent of
    veTraversal:              Result := ciTraversal;
    veDataPipelineTraversal:  Result := ciPipelineTraversal;
    veReportStart:            Result := ciEngineStart;
    veReportEnd:              Result := ciEngineEnd;
    veColumnStart:            Result := ciEngineStartColumn;
    veColumnEnd:              Result := ciEngineEndColumn;
    vePageStart:              Result := ciEngineStartPage;
    vePageEnd:                Result := ciEngineEndPage;
    veGroupStart:             Result := ciGroupBeforeGroupBreak;
    veGroupEnd:               Result := ciGroupAfterGroupBreak;
    veGroupBeforeHeader:      Result := ciGroupBeforeHeader;
    veGroupBeforeFooter:      Result := ciGroupBeforeFooter;
    else
      Result := ciTraversal;
  end; {case}

end; {function, ppVarEventToEvent}

{------------------------------------------------------------------------------}
{ ppMessageDlg }

function ppMessageDlg(const Caption, Msg: String; AType: TMsgDlgType; AButtons: TMsgDlgButtons; aBitmapHandle: THandle): Word;
var
  lDialog: TForm;
  lImage: TComponent;
begin

  if (AType = mtCustom) then
    AType := mtError;

  lDialog := CreateMessageDialog(Msg, AType, AButtons);

  if (Caption <> '') then
    lDialog.Caption := Caption;

  if (aBitmapHandle <> 0) then
    begin
      lImage := lDialog.FindComponent('Image');

      if (lImage <> nil) then
        begin
          TImage(lImage).Picture.Bitmap.Handle := aBitmapHandle;
          TImage(lImage).Transparent := True;
        end;
    end;

  Result := lDialog.ShowModal;

  lDialog.Free;

end; {function, ppMessageDlg}

{------------------------------------------------------------------------------}
{ ppDisplayHelp }

procedure ppDisplayHelp(aKeyList: Char; aHelpFile, aKeyPhrase: String);
begin

{$IFDEF Delphi9}

  if gbDesignTime then
    ppDisplayHelp2(aKeyList, aHelpFile, aKeyPhrase)
  else
    ppDisplayWinHelp(aKeyList, aHelpFile, aKeyPhrase);

{$ELSE}
  ppDisplayWinHelp(aKeyList, aHelpFile, aKeyPhrase);

{$ENDIF}


end; {procedure, ppDisplayHelp}

{$IFDEF Delphi9}
{------------------------------------------------------------------------------}
{ ppDisplayHelp2 }

procedure ppDisplayHelp2(aKeyList: Char; aHelpFile, aKeyPhrase: String);
var
  lsKeyPhrase: String;
begin

  lsKeyPhrase := StringReplace(aKeyPhrase, ';', '', [rfIgnoreCase]);

  if Pos('_Object', lsKeyPhrase) > 0 then
    lsKeyPhrase := StringReplace(lsKeyPhrase, '_Object', '', [rfIgnoreCase])
  else
    lsKeyPhrase := StringReplace(lsKeyPhrase, '_', '.', [rfIgnoreCase]);

//  ShowMessage(lsKeyPhrase);

  TppHelp2.DisplayTopicFromKeyword(lsKeyPhrase);

end;

{$ENDIF}

{------------------------------------------------------------------------------}
{ ppDisplayWinHelp }

procedure ppDisplayWinHelp(aKeyList: Char; aHelpFile, aKeyPhrase: String);
var
  lsAppHelpFile: String;
  lMultiKeyHelp: TppMultiKeyHelp;
begin

  lsAppHelpFile := Application.HelpFile;

  if not(gbDesignTime) then
    Application.Helpfile := aHelpFile;

  try
    if (aKeyPhrase = '') then
      Application.HelpCommand(HELP_FINDER, 0)

    else
      begin
        lMultiKeyHelp.mkSize := SizeOf(TppMultiKeyHelp);
        lMultiKeyHelp.mkKeyList := aKeyList;
        StrPCopy(lMultiKeyHelp.szKeyphrase, aKeyPhrase);
//        Application.HelpCommand(HELP_MULTIKEY, Integer(@lMultiKeyHelp));
        Application.HelpCommand(HELP_PARTIALKEY, Integer(PChar(aKeyPhrase)));

      end;

  finally
    {restore App's help file}
    Application.Helpfile := lsAppHelpFile;

  end;

end; {procedure, ppDisplayWinHelp}

{------------------------------------------------------------------------------}
{ function ppCompareGuid }

function ppCompareGuid(const aGuid1, aGuid2: TGuid): Integer;
type
  TGuidParts = array [0..3] of LongWord;
var
  lGuid1: TGuidParts absolute aGuid1;
  lGuid2: TGuidParts absolute aGuid2;
  liIndex: Integer;
begin

  Result := 0;
  liIndex := 0;

  // compare all bytes
  while (Result = 0) and (liIndex < 4) do
    begin
      if lGuid1[liIndex] > lGuid2[liIndex] then
        Result := 1
      else if (lGuid1[liIndex] < lGuid2[liIndex]) then
        Result := -1 ;

      Inc(liIndex);
    end;

end;

{------------------------------------------------------------------------------}
{ function ppCompareGuidMSSQLServer }

function ppCompareGuidMSSQLServer(const aGuid1, aGuid2: TGuid): Integer;
var
  liIndex: Integer;
begin

  Result := 0;
  liIndex := 2;

  // MS SQL Sever compatibility - compare the last 6 bytes
  while (Result = 0) and (liIndex <= 7) do
    begin
      if aGuid1.D4[liIndex] > aGuid2.D4[liIndex] then
        Result := 1
      else if (aGuid1.D4[liIndex] < aGuid2.D4[liIndex]) then
        Result := -1 ;

        Inc(liIndex);
    end;

end;

{------------------------------------------------------------------------------}
{ function ppCompareVariant }

function ppCompareVariant(aVar1, aVar2: Variant): Integer;
var
  lbVar1Null: Boolean;
  lbVar2Null: Boolean;
  lVarResult: TVariantRelationship;
begin

  lbVar1Null := VarIsNull(aVar1);
  lbVar2Null := VarIsNull(aVar2);

  Result := 0;

  if (lbVar1Null or lbVar2Null) then
    begin
      if lbVar1Null and lbVar2Null then
        Result := 0

      else if lbVar1Null and not(lbVar2Null) then
        Result := -1

      else if not(lbVar1Null) and lbVar2Null then
        Result := 1;
    end
  else
    begin
      lVarResult := VarCompareValue(aVar1, aVar2);

      if (lVarResult = vrEqual) then
        Result := 0
      else if (lVarResult = vrLessThan) then
        Result := -1
      else if (lVarResult = vrGreaterThan) then
        Result := 1;
    end;

end;


{------------------------------------------------------------------------------}
{ function ppAnsiCompareStrWithStringSort }

function ppAnsiCompareStrWithStringSort(aString1, aString2: String): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, SORT_STRINGSORT, PChar(aString1), Length(aString1), PChar(aString2), Length(aString2)) - 2;
end;

{------------------------------------------------------------------------------}
{ function ppAnsiCompareTextWithStringSort }

function ppAnsiCompareTextWithStringSort(aString1, aString2: String): Integer;
begin
  Result := CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE + SORT_STRINGSORT, PChar(aString1), Length(aString1), PChar(aString2), Length(aString2)) - 2;

end;


{------------------------------------------------------------------------------}
{ function ppBinaryCompareString }

function ppBinaryCompareString(aString1: AnsiString; aString2: AnsiString; aIsCaseSensitive: Boolean = True): Integer;
var
  liIndex: Integer;
  liCharLen1: Integer;
  liCharLen2: Integer;
  liCharLen: Integer;
  lpString1: PAnsiChar;
  lpString2: PAnsiChar;
begin

  // calc length of each char
  liCharLen1 := Length(aString1);
  liCharLen2 := Length(aString2);

  // handle empty string conditions
  if (liCharLen1 = 0) and (liCharLen2 = 0) then
    Result := 0
  else if (liCharLen1 = 0) then
    Result := -1
  else if (liCharLen2 = 0) then
    Result := 1
  else // compare ord value of each char
     begin

       Result := 0;
       liIndex := 0;

       // calc min length
       if (liCharLen1 < liCharLen2) then
         liCharLen := liCharLen1
       else
         liCharLen := liCharLen2;

       // convert to uppercase if not case sensitive
{$IFDEF Unicode}
       if not(aIsCaseSensitive) then
         begin
           aString1 := AnsiStrings.AnsiUpperCase(aString1);
           aString2 := AnsiStrings.AnsiUpperCase(aString2);
         end;
{$ELSE}
       if not(aIsCaseSensitive) then
         begin
           aString1 := AnsiUpperCase(aString1);
           aString2 := AnsiUpperCase(aString2);
         end;
{$ENDIF}

       lpString1 := PAnsiChar(aString1);
       lpString2 := PAnsiChar(aString2);

       // compare each character
       while (Result = 0) and (liIndex < liCharLen) do
         begin

           // compare ord values
           if Ord(lpString1^) < Ord(lpString2^) then
             Result := -1
           else if Ord(lpString1^) > Ord(lpString2^) then
             Result := 1;

           // increment pointers, index
           Inc(lpString1, 1);
           Inc(lpString2, 1);
           Inc(liIndex);

         end;

       // handle case in which first x chars are equal, but one string is longer
       if (Result = 0) then
         if (liCharLen1 < liCharLen2) then
           Result := -1
         else if (liCharLen1 > liCharLen2) then
           Result := 1;

     end;

end;


{------------------------------------------------------------------------------}
{ function ppAnsiCompareVariant }

function ppAnsiCompareVariant(aVar1, aVar2: Variant): Integer;
var
  lbVar1Null: Boolean;
  lbVar2Null: Boolean;
begin

  lbVar1Null := VarIsNull(aVar1);
  lbVar2Null := VarIsNull(aVar2);

  if ppVariantIsString(aVar1) and ppVariantIsString(aVar2) then
    Result := CompareText(aVar1, aVar2)

  else if lbVar1Null and not(lbVar2Null) then
    Result := -1

  else if not(lbVar1Null) and lbVar2Null then
    Result := 1

  else if lbVar1Null and lbVar2Null then
    Result := 0

  else if aVar1 < aVar2 then
    Result := -1

  else if aVar1 > aVar2 then
    Result := 1

  else
    Result := 0;

end; {function, ppAnsiCompareVariant}

function ppVariantIsString(aValue: Variant): Boolean;
begin

  case VarType(aValue) of
{$IFDEF Delphi12}
  varString, varUString, varOleStr: Result := True;
{$ELSE}
    varString, varOleStr: Result := True;
{$ENDIF}
  else
    Result := False;
  end;

end;

{------------------------------------------------------------------------------}
{ ppVariantTypeToDataType }

function ppVariantTypeToDataType(aVarType: Integer): TppDataType;
begin

  case aVarType of
    varByte,
    varWord,
    varLongWord,
    varSmallint,
    varShortInt,
    varInteger: Result := dtInteger;
    varInt64: Result := dtLargeInt;
    varSingle: Result := dtSingle;
    varDouble: Result := dtDouble;
    varCurrency: Result := dtCurrency;
    varDate: Result := dtDateTime;
    varBoolean: Result := dtBoolean;
{$IFDEF Delphi12}
    varUString, varString, varOleStr, varStrArg: Result := dtString;
{$ELSE}
    varString, varOleStr, varStrArg: Result := dtString;
{$ENDIF}
  else
    Result := dtNotKnown;

  end;


end; {function, ppVariantTypeToDataType}

{------------------------------------------------------------------------------}
{ ppCalcTextHeight }

function ppCalcTextHeight(aFont: TFont): Integer;
var
  lBitMap: TBitmap;

begin

  lBitmap := TBitmap.Create;

  Result := lBitmap.Canvas.TextHeight('H');

  lBitmap.Free;

end;

{------------------------------------------------------------------------------}
{ ppReadIntegerPropValue }

function ppReadIntegerPropValue(Reader: TReader): LongInt;
begin
  {note: this function is used to read Longint properties because of a bug in Delphi's streaming logic }
  if Reader.NextValue = vaExtended then
    Result := Trunc(Reader.ReadFloat)
  else
   Result := Reader.ReadInteger;
end;

{------------------------------------------------------------------------------}
{ ppRect }

function ppRect(aLeft, aTop, aRight, aBottom: Longint): TppRect;
var
  lRect: TppRect;
begin

  lRect.Left   := aLeft;
  lRect.Top    := aTop;
  lRect.Right  := aRight;
  lRect.Bottom := aBottom;

  Result := lRect;

end; {procedure, ppRect}

{------------------------------------------------------------------------------}
{ ppDebugMessage }

procedure ppDebugMessage(aClassName, aProcName, aComment: String; aShowMessage: Boolean);
begin
{$IFDEF DEBUG}
  if aShowMessage then
    ShowMessage(aClassName + '.'+ aProcName + ': ' + aComment);
{$ENDIF}
end;

{------------------------------------------------------------------------------}
{ ppLoadStrWithEllipses}

function ppLoadStrWithEllipses(aStringID: Integer): String;
begin
  Result := ppLoadStr(aStringID);

  if (Pos('...', Result) = 0) then
    Result := Result + '...';

end; {function, ppLoadStrWithEllipses}

{------------------------------------------------------------------------------}
{ ppLoadStr}

function ppLoadStr(aIdent: Longint): String;
begin
  Result := ppResourceManager.LoadStr(ciBaseNumber + aIdent);
end; {function, ppLoadString}

{------------------------------------------------------------------------------}
{ ppFindMethod }

function ppFindMethod(aObject: TObject; aMethodName: String): TMethod;
begin
  Result.Code := aObject.MethodAddress(aMethodName);
  Result.Data := aObject;
end;

{------------------------------------------------------------------------------}
{ ppCheckPropInfo }

function ppCheckPropInfo(aObject: TObject; aPropName: String): Boolean;
begin
  if aObject = nil then
    Result := False
  else
    Result := (GetPropInfo(aObject.ClassInfo, aPropName) <> nil);
end;


{------------------------------------------------------------------------------}
{ ppGetOrdPropValue }

function ppGetOrdPropValue(aObject: TObject; aPropName: String): Longint;
begin

  if not ppCheckPropInfo(aObject, aPropName) then
    Result := 0
  else
    Result := GetOrdProp(aObject, GetPropInfo(aObject.ClassInfo, aPropName));

end;

{------------------------------------------------------------------------------}
{ ppGetStringPropValue }

function ppGetStringPropValue(aObject: TObject; aPropName: String): String;
begin

  if not ppCheckPropInfo(aObject, aPropName) then
    Result := ''
  else
    Result := GetStrProp(aObject, GetPropInfo(aObject.ClassInfo, aPropName));

end;

{------------------------------------------------------------------------------}
{ ppSetOrdPropValue }

procedure ppSetOrdPropValue(aObject: TObject; aPropName: String; aValue: Longint);
begin

  if not ppCheckPropInfo(aObject, aPropName) then Exit;

  SetOrdProp(aObject, GetPropInfo(aObject.ClassInfo, aPropName), aValue);

end;

{------------------------------------------------------------------------------}
{ ppSetStrPropValue }

procedure ppSetStringPropValue(aObject: TObject; aPropName: String; aValue: String);
begin

  if not ppCheckPropInfo(aObject, aPropName) then Exit;

  SetStrProp(aObject, GetPropInfo(aObject.ClassInfo, aPropName), aValue);

end;


{------------------------------------------------------------------------------}
{ ppSetMethodPropValue }
procedure ppSetMethodPropValue(aObject: TObject; aPropName: String; aValue: TMethod);
begin

  if not ppCheckPropInfo(aObject, aPropName) then Exit;

  SetMethodProp(aObject, GetPropInfo(aObject.ClassInfo, aPropName), aValue);

end;


{------------------------------------------------------------------------------}
{ ppLoadStrWithParms - convert all parms to '%s' }

function  ppLoadStrWithParms(aStringID: Integer; const aParameters: array of const): String;
begin

  Result := ppSetMessageParameters(ppLoadStr(aStringID));

  Result := Format(Result, aParameters);

end; {function, ppLoadStrWithParms}

{------------------------------------------------------------------------------}
{ ppSetMessageParameters - convert all parms to '%s' }

function ppSetMessageParameters(const aMessage: String): String;
var
 lParameters: TStringList;
 liPos: Integer;
 lsParameter: String;
 lsMessage: String;
 liParameter: Integer;
 liParameters: Integer;
begin
  lsMessage := aMessage;

  lParameters := TStringList.Create;

  lParameters.Add('<page>');
  lParameters.Add('<pagecount>');
  lParameters.Add('<documentname>');
  lParameters.Add('<printername>');
  lParameters.Add('<columnno>');
  lParameters.Add('<filename>');
  lParameters.Add('<minbarwidth>');
  lParameters.Add('<maxbarwidth>');
  lParameters.Add('<character>');
  lParameters.Add('<identifier>');
  lParameters.Add('<name>');
  lParameters.Add('<count>');
  lParameters.Add('<message>');
  lParameters.Add('<length>');
  lParameters.Add('<no>');

  liParameters := lParameters.Count;
  liParameter := 0;
  liPos := 0;

  while (liParameter < liParameters) and (liPos = 0) do
    begin
      lsParameter := lParameters[liParameter];

      liPos := Pos(lsParameter, lsMessage);

      while (liPos <> 0) do
        begin
          Delete(lsMessage, liPos, Length(lsParameter));
          Insert('%s', lsMessage, liPos);
          liPos := Pos(lsParameter, lsMessage);
        end;

      Inc(liParameter);
    end;

  Result := lsMessage;

  lParameters.Free;

end;

{------------------------------------------------------------------------------}
{ ppGetEnumValue }

function ppGetEnumValue(aEnumType: PTypeInfo; const aEnum: String): Integer;
begin

  Result := TypInfo.GetEnumValue(aEnumType, aEnum);

end; {ppGetEnumValue}

{------------------------------------------------------------------------------}
{ ppGetEnumName }

function ppGetEnumName(aEnumType: PTypeInfo; aOrd: Integer): String;
begin
  Result := TypInfo.GetEnumName(aEnumType, aOrd);
end;

{------------------------------------------------------------------------------}
{ ppGetEnumNames }

procedure ppGetEnumNames(aEnumType: PTypeInfo; aValues: TStrings);
var
  liValue: Integer;
  lTypeData: TTypeData;

begin

  aValues.Clear;

  lTypeData := GetTypeData(aEnumType)^;

  for liValue := lTypeData.MinValue to lTypeData.MaxValue do
    aValues.Add(ppGetEnumName(aEnumType, liValue));

end;


{------------------------------------------------------------------------------}
{ ppBitmapFromResource }

function ppBitmapFromResource(aBitmapName: String): THandle;
var
  lpLibModule: PLibModule;

begin

  Result := 0;

  // if running on XP, try adding an XP suffix to the bitmap name}
{  if uIsWinXP and (Copy(aBitmapName, Length(aBitmapName)-1, 2) <> 'XP') then
    begin
      Result := ppBitmapFromResource(aBitmapName + 'XP');

      if Result <> 0 then Exit;

    end;
}
  lpLibModule := LibModuleList;

  while (lpLibModule <> nil) and (Result = 0) do
    begin
      Result := LoadBitmap(lpLibModule.ResInstance, PChar(aBitmapName));

      if (Result = 0) then
        Result := LoadBitmap(lpLibModule.Instance, PChar(aBitmapName));

      lpLibModule := lpLibModule.Next;
    end;

end;

{------------------------------------------------------------------------------}
{ ppDisplayWidthToPixels                                                       }

function ppDisplayWidthToPixels(aDisplayWidth: Integer; aCanvas: TCanvas): Integer;
var
  liCharWidth : Integer;
begin
  liCharWidth := aCanvas.TextWidth('0');
  Result := (aDisplayWidth * liCharWidth) + liCharWidth;
end; {procedure, DisplayWidthToPixels}


{------------------------------------------------------------------------------}
{ ppStripOffPath}

function ppStripOffPath(Value: String): String;
var
  liPos: Integer;
  liLastPos: Integer;
  lsOldValue: String;
begin
  Result := '';
  lsOldValue := Value;
  liLastPos := 0;

  repeat
    liPos := Pos('\', Value);
    if liPos > 0 then
      begin
        Value[liPos] := 'X';
        liLastPos := liPos;
      end;
  until (liPos = 0);

  if (liLastPos <> 0) then
    Result := Copy(lsOldValue, 1, liLastPos);

end;

{------------------------------------------------------------------------------}
{ ppFixUpFloatString}

function ppFixUpFloatString(const aFloatString, aDisplayFormat: String): String;
var
  lFloat: Double;
  lcDecimalSeparator: Char;
  lsFormat: String;
  liDigits: Integer;
  liPos: Integer;
begin

  {strip out any thousand separators}
  Result := ppRemoveCharacter(ThousandSeparator, aFloatString);

  {convert criteria to float}
  try
    StrToFloat(Result);
  except on EConvertError do
    begin
      Result := '';

      Exit;
    end;
  end; {try, except}

  lFloat := StrToFloat(Result);

  if (Length(aDisplayFormat) > 0) then
    begin
      Result := FormatFloat(aDisplayFormat, lFloat);
      
      Exit;
    end;

  {count digits in search criteria}
  liPos := Pos(DecimalSeparator, Result);

  if (liPos <> 0) then
    liDigits := Length(Result) - liPos
  else
    liDigits := 0;

  {create format}
  if (liDigits > 0) then
    lsFormat := '0.' + StringOfChar('#', liDigits)
  else
    lsFormat := '0';

  {convert float to string}
  lcDecimalSeparator := DecimalSeparator;

  DecimalSeparator := '.';

  try
    Result := FormatFloat(lsFormat, lFloat)
  finally
    DecimalSeparator := lcDecimalSeparator;
  end;

end; {ppFixUpFloatString}

{------------------------------------------------------------------------------}
{ ppRemoveCharacter}

function ppRemoveCharacter(aCharacter: Char; const aString: String): String;
var
  liPos: Integer;
begin
  Result := aString;

  liPos := Pos(aCharacter, Result);

  while (liPos <> 0) do
    begin
      Result := Copy(Result, 1, liPos - 1) + Copy(Result, liPos + 1, Length(Result));

      liPos := Pos(aCharacter, Result);
    end;

end; {function, ppRemoveCharacter}

{------------------------------------------------------------------------------}
{ ppFormToScreenCenter}

procedure ppFormToScreenCenter(aHeight, aWidth: Integer; var aLeft, aTop: Integer);
begin

  aLeft := Trunc((Screen.Width / 2) - (aWidth / 2));
  aTop := Trunc((Screen.Height / 2) - (aHeight / 2));

end; {procedure, ppFormToScreenCenter}

{------------------------------------------------------------------------------}
{ ppGetDisplayFormats }

procedure ppGetDisplayFormats(aDataType: TppDataType; aFormatList: TStrings);
begin
  gcDisplayFormat.GetDisplayFormats(aDataType, aFormatList);
end; {procedure, ppGetDisplayFormats}

{------------------------------------------------------------------------------}
{ ppFormat }

function ppFormat(const aDisplayFormat: String; aDataType: TppDataType; aValue: Variant): String;
begin
  Result := gcDisplayFormat.Format(aDisplayFormat, aDataType, aValue);
end; {function, ppFormat}

{------------------------------------------------------------------------------}
{ ppValidDate }

function ppValidDate: Boolean;
begin

  if (ciAltBaseNumber = 54000) then
    Result := True
  else
    Result := False;

end; {function, ppValidDate}

{------------------------------------------------------------------------------}
{ ppIsWinXP }

function ppIsWinXP: Boolean;
begin
 Result := uIsWinXP;
end;

{------------------------------------------------------------------------------}
{ ppShellExec }

function ppShellExec(const aPathStr, aCmdStr, aDirStr: string; aShow: Word): Boolean;
var
  lhInst: THandle;
  lpOperation: array[0..5] of Char;
begin

  StrPCopy(lpOperation, 'open');

  lhInst := ShellExecute(0, lpOperation, PChar(aPathStr), PChar(aCmdStr), PChar(aDirStr), aShow);

  { If 32 or less, an error occurred }
  Result := (lhInst > 32);

end;

{------------------------------------------------------------------------------}
{ ppEqual }

function ppEqual(const aString1, aString2: String): Boolean;
begin
  Result := (CompareText(aString1, aString2) = 0);
end; {funciton, ppEqual}

{------------------------------------------------------------------------------}
{ ppStringsToStream - use this becuase TStrings.SaveStream has a memory link }

procedure ppStringsToStream(aStrings: TStrings; aMemoryStream: TMemoryStream);
var
  lTextBuf: PChar;
begin
  if (aStrings = nil) or (aMemoryStream = nil) then Exit;

  aMemoryStream.Clear;

  lTextBuf := aStrings.GetText;

  aMemoryStream.WriteBuffer(Pointer(lTextBuf)^, StrLen(lTextBuf) * SizeOf(Char));

  {TString.GetText returns a PChar, so must dispose }
  StrDispose(lTextBuf);

end;

{------------------------------------------------------------------------------}
{ ppGetStdNamingPrefix }

function ppGetStdNamingPrefix(aComponent: TComponent): String;
begin

  {compute standard naming prefix for this Component: ex. TppLabel is ppLabel }
  Result := Copy(aComponent.ClassName,2,Length(aComponent.ClassName));

end; {function, ppGetStdNamingPrefix}

{------------------------------------------------------------------------------}
{ ppGetUserNamePrefix }

function ppGetUserNamePrefix(aComponent: TComponent): String;
begin

  {compute user name prefix for this Component: ex TppLabel is Label }
  Result := Copy(aComponent.ClassName,4,Length(aComponent.ClassName));

end; {function, ppGetUserNamePrefix}

{------------------------------------------------------------------------------}
{ ppGetUniqueName - assign unique name for given ppComponent}

function ppGetUniqueName(aOwner: TComponent; aNamingPrefix: String; aComponent: TComponent): String;
var
  liIndex: Integer;
  lComponent: TComponent;
  lComponents: TList;
begin

  Result := aNamingPrefix;

  if (aOwner = nil) then Exit;

  lComponents := TList.Create;

  try

    for liIndex := 0 to (aOwner.ComponentCount - 1) do
      begin
        lComponent := aOwner.Components[liIndex];

         {determine whether component is same class type}
        if (lComponent <> aComponent) and (lComponent is aComponent.ClassType) then
          lComponents.Add(lComponent);

      end;

    Result := ppGetUniqueNameForComponents(aNamingPrefix, aComponent, lComponents);

  finally
    lComponents.Free;

  end;

end; {function, ppGetUniqueName}

{------------------------------------------------------------------------------}
{ ppGetUniqueNameForComponents - assign unique name for Component within a given Component List}

function ppGetUniqueNameForComponents(aNamingPrefix: String; aComponent: TComponent; aComponentList: TList): String;
var
  liIndex,
  liNameNo: Integer;
  lNumberList: TStringList;
  lComponent: TComponent;

begin

  Result := aNamingPrefix;

  {store currently used naming numbers to lNumberList}
  lNumberList := TStringList.Create;

  try

    for liIndex := 0 to aComponentList.Count-1 do
      begin
        lComponent := aComponentList[liIndex];

        {determine whether component is same class type}
        if (lComponent <> aComponent) and (lComponent is aComponent.ClassType) then

          if ppExtractNamingNumber(aNamingPrefix,  lComponent, liNameNo) then
            lNumberList.Add(Format('%8d',[liNameNo]));

      end;

    Result := aNamingPrefix + IntToStr(ppGetUniqueNamingNumber(lNumberList));

  finally
    lNumberList.Free;

  end;

end; {function, ppGetUniqueNameForComponents}


{------------------------------------------------------------------------------}
{ ppExtractNamingNumber }

function ppExtractNamingNumber(aNamingPrefix: String; aComponent: TComponent; var aNamingNo: Integer): Boolean;
var
  lsComponentNo: String;

begin

  Result := False;

  {determine whether component name has standard prefix}
  if not ( Pos(aNamingPrefix, aComponent.Name) = 1) then Exit;

  {get name suffix}
  lsComponentNo := Copy(aComponent.Name, (Length(aNamingPrefix) + 1),
                                          Length(aComponent.Name));

  {determine whether name suffix is an integer}
  aNamingNo := StrToIntDef(lsComponentNo, 0);

  Result := (aNamingNo > 0);


end; {function, ppExtractNamingNumber}


{------------------------------------------------------------------------------}
{ ppGetUniqueNamingNumber }

function ppGetUniqueNamingNumber(aNumberList: TStringList): Integer;
var
  lbFound: Boolean;

begin

  aNumberList.Sort;

  Result  := 0;
  lbFound := False;

  {get first unused number in sequence from 1 to ... }
  while not lbFound and (Result < aNumberList.Count) do
    begin

      if (Result + 1) <> StrToInt(aNumberList[Result]) then
        lbFound := True;

      Inc(Result);

    end;

  {if no name found, used next number in sequence}
  if not lbFound then
    Inc(Result);

end;


{------------------------------------------------------------------------------}
{ ppFixText }

function ppFixText(Text: String; TargetLength: Integer; Alignment: TAlignment): String;
var
  liDifference: Integer;
  lsPadding: String;
  liLength: Integer;
  liSpace: Integer;
  lsPaddingLeft: String;
  lsPaddingRight: String;

begin
  liLength := Length(Text);

  if liLength = TargetLength then
    Result := Text

  else if (liLength > TargetLength) then
    Result := Copy(Text, 1, TargetLength)

  else if (liLength < TargetLength) then
    begin
      liDifference := TargetLength - liLength;

      lsPadding := '';
      for liSpace := 1 to liDifference do
        lsPadding := lsPadding + ' ';

      case Alignment of

        taLeftJustify:
          Result := Text + lsPadding;

        taRightJustify:
          Result := lsPadding + Text;

        taCenter:
          begin
            lsPaddingLeft  := Copy(lsPadding, 1, Trunc(liDifference/2));
            lsPaddingRight := Copy(lsPadding, 1, liDifference - Trunc(liDifference/2));
            Result := lsPaddingLeft + Text + lsPaddingRight;
          end;

      end;

    end;


end; {function, ppFixText}

{------------------------------------------------------------------------------}
{ ppFromMMTenths }

function ppFromMMTenths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Single;
var
  llMMThousandths: Longint;
  llScreenPixels: Longint;


begin

  llMMThousandths := Value*100;

  case aUnits of

    utScreenPixels, utPrinterPixels:
      Result := ppFromMMThousandths(llMMThousandths, aUnits, aResolution, aPrinter);

    utInches:
      begin
        llScreenPixels := ppToScreenPixels(llMMThousandths, utMMThousandths, aResolution, aPrinter);
        Result := ppFromScreenPixels(llScreenPixels, utInches, aResolution, aPrinter);
      end;

    utMillimeters:
      Result := Round(Value/10);

    utMMThousandths:
      Result := llMMThousandths;

    else
      Result := 0;

  end; {case, Units}

end;

{------------------------------------------------------------------------------}
{ ppToMMTenths }

function ppToMMTenths(Value: Single; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Longint;
var
  llScreenPixels: Longint;

begin

  case aUnits of

    utScreenPixels, utPrinterPixels:
      Result := ppToMMThousandths(Value, aUnits, aResolution, aPrinter) div 100;

    utInches:
      begin
        llScreenPixels := ppToScreenPixels(Value, utInches, aResolution, aPrinter);
        Result := Trunc(ppFromScreenPixels(llScreenPixels, utMMThousandths, aResolution, aPrinter) / 100);
      end;

    utMillimeters:
      Result := Round(Value*10);

    utMMThousandths:
      Result := Round(Value/100);

    else
      Result := 0;
  end;


end;

{------------------------------------------------------------------------------}
{ ppPeriodToDecimalSeparator }

procedure ppPeriodToDecimalSeparator(aList: TStrings);
var
  liSeparatorPos: Integer;
  liLine: Integer;
  lsLine: String;

begin

  for liLine := 0 to aList.Count-1 do
    begin
      lsLine := aList[liLine];

      liSeparatorPos := Pos('.', lsLine);

      if liSeparatorPos > 0 then
        begin
          lsLine[liSeparatorPos] := DecimalSeparator;

          aList[liLine] := lsLine;
        end;

    end; {for each line}

end;


{------------------------------------------------------------------------------}
{ ppDecimalSeparatorToPeriod }

procedure ppDecimalSeparatorToPeriod(aList: TStrings);
var
  liSeparatorPos: Integer;
  liLine: Integer;
  lsLine: String;

begin

  for liLine := 0 to aList.Count-1 do
    begin
      lsLine := aList[liLine];

      liSeparatorPos := Pos(DecimalSeparator, lsLine);

      if liSeparatorPos > 0 then
        begin
          lsLine[liSeparatorPos] := '.';
          
          aList[liLine] := lsLine;
        end;

    end; {for each line}

end;

{------------------------------------------------------------------------------}
{ ppGetTempPath }

function ppGetTempPath: String;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetTempPath(MAX_PATH, PChar(Result)));
end;

{------------------------------------------------------------------------------}
{ ppGetSystemDirectory }

function ppGetSystemDirectory: String;
begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, Windows.GetSystemDirectory(PChar(Result), MAX_PATH));
end;

{------------------------------------------------------------------------------}
{ ppGetTempFileName}

function ppGetTempFileName(aPath: String; aPrefix: String): String;
begin

  SetLength(Result, MAX_PATH);

  // this function does not return the length of the result like GetTempPath does
  Windows.GetTempFileName(PChar(aPath), PChar(aPrefix), 0, PChar(Result));

  Result := StrPas(PChar(Result));

end;

{------------------------------------------------------------------------------}
{ ppGetDelphiRegistryKey }

function ppGetDelphiRegistryKey: String;
var
  lsVersion: String;
  lsKey: String;
begin
{$IFDEF Delphi14}
  lsVersion := '7.0';  //  Delphi 14 = BDS 7.0
{$ELSE}{$IFDEF Delphi12}
  lsVersion := '6.0';  //  Delphi 12 = BDS 6.0
{$ELSE} {$IFDEF Delphi11}
  lsVersion := '5.0';  //  Delphi 11 = BDS 5.0
{$ELSE} {$IFDEF Delphi10}
  lsVersion := '4.0';  //  Delphi 10 = BDS 4.0
{$ELSE} {$IFDEF Delphi9}
  lsVersion := '3.0';  //  Delphi 9 = BDS 3.0
{$ELSE} {$IFDEF Delphi7}
  lsVersion := '7.0';
{$ELSE}
  lsVersion := '6.0';
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$IFDEF Delphi12}
  lsKey := '\SOFTWARE\CodeGear\BDS\' + lsVersion;
{$ELSE}{$IFDEF Delphi9}
  lsKey := '\SOFTWARE\Borland\BDS\' + lsVersion;
{$ELSE}
  lsKey := '\SOFTWARE\Borland\Delphi\' + lsVersion;
{$ENDIF}
{$ENDIF}

  Result := lsKey;

end;

{------------------------------------------------------------------------------}
{ ppGetDelphiPath }

function ppGetDelphiPath: String;
var
  lRegistry: TRegistry;
  lsKey: String;
begin

  lRegistry := TRegistry.Create;
  lRegistry.RootKey := HKEY_LOCAL_MACHINE;

  lsKey := ppGetDelphiRegistryKey();

  if lRegistry.OpenKeyReadOnly(lsKey) then
    Result := lRegistry.ReadString('RootDir')
  else
    Result := '';

{$IFDEF Delphi9}
  Result := System.Copy(Result, 1, Length(Result)-1);
{$ENDIF}

  lRegistry.Free;

end; {function, ppGetDelphiPath}

{------------------------------------------------------------------------------}
{ ppGetScreenRes }

function ppGetScreenRes: TPoint;
var
  lDC: HDC;

begin

 lDC := GetDC(0);

 Result.X := GetDeviceCaps(lDC, HORZRES);
 Result.Y := GetDeviceCaps(lDC, VERTRES);

 ReleaseDC(0, lDC);

end;

{------------------------------------------------------------------------------}
{ ppTextToIdentifier }

function ppTextToIdentifier(const aString: String): String;
var
  liIndex: Integer;
begin

  Result := aString;

  // must start with a letter, therefore remove leading digits and other symbols
  while (Length(Result) > 0) and (TppCharacter.IsDigit(Result[1]) or not TppCharacter.IsLetter(Result[1])) do
    Delete(Result, 1, 1);

  if Length(Result) = 0 then Exit;

  liIndex := 2;

  // replace invalid characters with an underline
  while (liIndex <= Length(Result)) do
    begin

      if TppCharacter.IsLetterOrDigit(Result[liIndex]) then
        Inc(liIndex)

      else if (Result[liIndex - 1] <> '_') then
        begin
          Result[liIndex] := '_';

          Inc(liIndex);
        end

      else
        Delete(Result, liIndex, 1);

    end;

end; {function, ppTextToIdentifier}

{------------------------------------------------------------------------------}
{ ppTextToPageList }

procedure ppTextToPageList(const aString: String; aPageList: TStrings; aTrimPages: Boolean);
var
  lsChar          : Char;
  liChar          : Integer;
  liChars         : Integer;
  liPage          : Integer;
  lsNumber        : String;
  lbInteger       : Boolean;
  lbNumberFound   : Boolean;
  lbRangeStarted  : Boolean;
  liRangeStart    : Integer;
  liRangeEnd      : Integer;
  lsFormattedNumber: String;
  liIndex: Integer;
begin

  aPageList.Clear;

  lsNumber       := '';
  lbNumberFound  := False;
  lbRangeStarted := False;
  liRangeStart   := 0;

  liChars := Length(aString);

  {look at each character in string}
  for liChar := 1 to liChars do
    begin
      lsChar    := aString[liChar];
      lbInteger := StrToIntDef(lsChar,-1) <> -1;

      if lbInteger then
        {build number characters into number}
        lsNumber := lsNumber + lsChar;

      if (not(lbInteger) and (Length(lsNumber) > 0)) or
         ((liChar = liChars) and (Length(lsNumber) > 0)) then

        {current character non-numeric, save number}
        begin
          lbNumberFound := True;

          lsFormattedNumber := Format('%8d',[StrToInt(lsNumber)]);

          if aPageList.IndexOf(lsFormattedNumber) = -1 then
            aPageList.Add(lsFormattedNumber);

          {save number for range calculations}
          if not(lbRangeStarted) then
            liRangeStart := StrToInt(lsNumber) + 1;

        end;

      {if number found and range started, this is range end number}
      if lbNumberFound and lbRangeStarted then

        begin
          lbRangeStarted := False;
          liRangeEnd := StrToInt(lsNumber) - 1;
          for liPage := liRangeStart to liRangeEnd do
            begin
              lsFormattedNumber := Format('%8d',[liPage]);

              if aPageList.IndexOf(lsFormattedNumber) = -1 then
                aPageList.Add(lsFormattedNumber);
            end;
          liRangeStart := 0;
        end;

      {reset to collect next number}
      if lbNumberFound then
        begin
          lsNumber := '';
          lbNumberFound := False;
        end;

      {if hyphen, next number indicates end of range}
      if (lsChar = '-') and (liRangeStart <> 0) then
        lbRangeStarted := True;

    end; {for, each character in pages string}

    {sort list}
    TStringList(aPageList).Sort;

    {trim spaces from list}
    if aTrimPages then
      for liIndex := 0 to aPageList.Count - 1 do
        aPageList[liIndex] := TrimLeft(aPageList[liIndex]);

end; {procedure, ppTextToPageList}

{------------------------------------------------------------------------------}
{ ppFromMMThousandths }

function ppFromMMThousandths(Value: Longint; aUnits: TppUnitType; aResolution: TppResolutionType;
                             aPrinter: TObject): Single;
var
  liDPI: Integer;
begin

  case aUnits of

    utScreenPixels:
      Result := Round(((Value / 1000) * InchPerMM) * Screen.PixelsPerInch);

    utInches:
      Result := Round( ( ( (Value / 1000) * InchPerMM) * 10000) ) / 10000;

    utMillimeters:
      Result := Value / 1000;

    utPrinterPixels:
      begin

        if (aPrinter is TppPrinter) then
          begin

            if (aResolution = pprtVertical) then
              liDPI := TppPrinter(aPrinter).PixelsPerInch.Y
            else
              liDPI := TppPrinter(aPrinter).PixelsPerInch.X;

          end

        else
          liDPI := Screen.PixelsPerInch;

        Result := Round( ((Value / 1000) * InchPerMM) * liDPI);

      end;

    utMMThousandths:
      Result := Value;

  else
    Result := 0;

  end; {case, unit type}

end; {procedure, ppFromMMThousandths}

{------------------------------------------------------------------------------}
{ ppToMMThousandths }

function ppToMMThousandths(Value: Single; aUnits: TppUnitType; aResolution:
    TppResolutionType; aPrinter: TObject): Longint;
var
  liDPI: Integer;
begin

  case aUnits of

    utScreenPixels:
      Result := Round( ((Value / Screen.PixelsPerInch) / InchPerMM) * 1000);

    utInches:
      Result := Round( (Value / InchPerMM) * 1000);

    utMillimeters:
      Result := Round(Value * 1000);

    utPrinterPixels:
      begin

        if (aPrinter is TppPrinter) then
          begin
          
            if (aResolution = pprtVertical) then
              liDPI := TppPrinter(aPrinter).PixelsPerInch.Y
            else
              liDPI := TppPrinter(aPrinter).PixelsPerInch.X;

          end
        else
          liDPI := Screen.PixelsPerInch;

        Result := Round( ((Value / liDPI) / InchPerMM) * 1000)
      end;

    utMMThousandths:
      Result := Trunc(Value);

  else
    Result := 0;

  end; {case, unit type}

end; {procedure, ppToMMThousandths}


{------------------------------------------------------------------------------}
{ ppFromScreenPixels }

function ppFromScreenPixels(aScreenPixels: Integer; aUnits: TppUnitType; aResolution: TppResolutionType;
                                                                         aPrinter: TObject): Single;

var
 llMMThousandths: Longint;
begin

  llMMThousandths := ppToMMThousandths(aScreenPixels, utScreenPixels, aResolution, aPrinter);

  Result := ppFromMMThousandths(llMMThousandths, aUnits, aResolution, aPrinter);

end;

{------------------------------------------------------------------------------}
{ ppToScreenPixels }

function ppToScreenPixels(aValue: Single; aUnits: TppUnitType; aResolution: TppResolutionType; aPrinter: TObject): Integer;

var
 llMMThousandths: Longint;
begin

  llMMThousandths := ppToMMThousandths(aValue, aUnits, aResolution, aPrinter);

  Result := Trunc(ppFromMMThousandths(llMMThousandths, utScreenPixels, aResolution, aPrinter));

end;

{------------------------------------------------------------------------------}
{ ppGetSpTextWidth }

function ppGetSpTextWidth(aFont: TFont; aText: String): Integer;
var
  lBitmap: TBitmap;

begin
  lBitmap := TBitmap.Create;
  lBitmap.Canvas.Font := aFont;
  Result := lBitmap.Canvas.TextWidth(aText);

  lBitmap.Free;

end; {function, ppGetSpTextWidth}

{------------------------------------------------------------------------------}
{ ppGetSpTextHeight }

function ppGetSpTextHeight(aFont: TFont; aText: String): Integer;
var
  lBitmap: TBitmap;

begin
  lBitmap := TBitmap.Create;
  lBitmap.Canvas.Font := aFont;
  Result := lBitmap.Canvas.TextHeight(aText);

  lBitmap.Free;

end; {function, ppGetSpTextHeight}

{------------------------------------------------------------------------------}
{ ppVersionToInt }

function ppVersionToInt(aVersion: String): Integer;
  {define a set of valid version characters }
const
  lVersionChars = ['0'..'9', '.'];
var
  lsVersionNo: String;
  liChar: Integer;
  liDecimalPos: Integer;
  liLength: Integer;
begin

  {convert to a ShortString, which is an array of chars }
  lsVersionNo := aVersion;

  {traverse chars until end of version no. subString is found}
  liChar := 1;

  {note: VersionNoMaxLength is a constant }
  while liChar <= Length(lsVersionNo) do
    if ppCharInSet(lsVersionNo[liChar], lVersionChars) and (liChar < VersionNoMaxLength) then
      Inc(liChar)
    else
      Break;

  Dec(liChar);

  {copy the version no substring}
  lsVersionNo := Copy(lsVersionNo,1,liChar);

  {find the decimal point position}
  liDecimalPos := Pos('.', lsVersionNo);

  liLength := liDecimalPos + 2; // 5 for ver 10.x and later

  {get rid of the decimal point }
  Delete(lsVersionNo, liDecimalPos, 1);

  while Length(lsVersionNo) < liLength do
    lsVersionNo := lsVersionNo + '0';

  Result:= StrToInt(lsVersionNo);


end; {function, ppVersionToInt}

{------------------------------------------------------------------------------}
{ ppStringsFromMMThousandths }

procedure ppStringsFromMMThousandths(aStringList: TStrings; aUnits: TppUnitType;
                                     aResolution: TppResolutionType; aPrinter: TObject);
var
  lrValue: Single;
  llValue: Longint;
  liString: Integer;
  liStrings: Integer;
begin

  llValue := 0;

  liStrings := aStringList.Count;

  for liString := 0 to liStrings - 1 do
    begin
      try
        llValue := StrToInt(aStringList[liString]);
      except on EConvertError do
        llValue := 0;
      end; {try, except}

      lrValue := ppFromMMThousandths(llValue, aUnits, aResolution, aPrinter);

      try
        aStringList[liString] := FloatToStrF(lrValue, ffGeneral, 7, 0);
      except on EConvertError do
        aStringList[liString] := '0.0';
      end; {try, except}

    end; {for, each column}

end; {procedure, ppStringsFromMMThousandths}

{------------------------------------------------------------------------------}
{ ppStringsFromMMThousandths }

procedure ppStringsToMMThousandths(aStringList: TStrings; aUnits: TppUnitType;
                                   aResolution: TppResolutionType; aPrinter: TObject);
var
  lrValue: Single;
  llValue: Longint;
  liString: Integer;
  liStrings: Integer;
begin

  lrValue := 0;

  liStrings := aStringList.Count;

  for liString := 0 to liStrings - 1 do
    begin
      try
        lrValue := StrToFloat(aStringList[liString]);
      except on EConvertError do
        lrValue := 0;
      end; {try, except}

      llValue := ppToMMThousandths(lrValue, aUnits, aResolution, aPrinter);

      try
        aStringList[liString] := IntToStr(llValue);
      except on EConvertError do
        aStringList[liString] := '0';
      end; {try, except}

    end; {for, each column}

end; {procedure, ppStringsToMMThousandths}

{------------------------------------------------------------------------------}
{ ppFormatCalcValue }

function ppFormatCalcValue(aCalcType: TppCalcType; aPageNo, aPageCount: Longint;
                           aPrintDateTime: TDateTime; aLanguageIndex: Longint; aPrinting: Boolean): String;
var
  lVarType: TppVarType;
begin

  lVarType := TppVarType(Ord(aCalcType));

  Result := ppFormatVarValue(lVarType, aPageNo, aPageCount, aPrintDateTime, aLanguageIndex, aPrinting);

end; {function, ppFormatCalcValue}

{------------------------------------------------------------------------------}
{ ppFormatVarValue }

function ppFormatVarValue(aVarType: TppVarType; aPageNo, aPageCount: Longint;
                          aPrintDateTime: TDateTime; aLanguageIndex: Longint; aPrinting: Boolean): String;
var
  liPageCount: Integer;
  liPage: Integer;
begin

  case aVarType of

    vtDate:
      Result := DateTimeToStr(Date);

    vtDateTime:
      Result := DateTimeToStr(Now);

    vtPageCount:
      begin

        if (aPrinting) then
           liPageCount := aPageCount
        else
           liPageCount := 1;

        Result := IntToStr(liPageCount);

      end;

    vtPageSet, vtPageSetDesc:

      begin

        if (aVarType = vtPageSet) then
          Result := ''
        else
          Result := ppLoadStr(18) + ' ';

        {get page no}
        if (aPrinting) then
          liPage := aPageNo
        else
          liPage := 1;

        Result := Result + IntToStr(liPage);

        {get page count}
        if (aPrinting) then
          liPageCount := aPageCount
        else
          liPageCount := 1;


        Result := Result + ' ' + ppLoadStr(16) + ' ' + IntToStr(liPageCount);

      end;

   vtPageNo, vtPageNoDesc:
      begin

        if (aPrinting) then
          liPage := aPageNo
        else
          liPage := 1;

        if (aVarType = vtPageNo) then
          Result := IntToStr(liPage)
        else
          Result :=  ppLoadStr(18) + ' ' + IntToStr(liPage);

      end;

    vtPrintDateTime:
      begin

        if (aPrinting) then
           Result := DateTimeToStr(aPrintDateTime)
        else
           Result := DateTimeToStr(Now);

      end;

    vtTime:
      Result := TimeToStr(Time);


  end; {case, vartype}

end; {procedure, ppFormatVarValue}

{------------------------------------------------------------------------------}
{ ppCalcAspectRatio}

function ppCalcAspectRatio(aSourceWidth, aSourceHeight, aDestWidth, aDestHeight: Single): Single;
var
  lfScaleHeight: Single;
  lfScaleWidth:  Single;

begin

  Result := 0;

  if (aSourceWidth <=0) or (aSourceHeight <= 0) then Exit;

  lfScaleHeight := aDestWidth  / aSourceWidth;
  lfScaleWidth  := aDestHeight / aSourceHeight;

  {scale by the lesser of the two factors }
  if lfScaleHeight > lfScaleWidth then
    Result := lfScaleWidth
  else
    Result := lfScaleHeight;

end;

function ppBytesPerScanline(aPixelsPerScanline, aBitsPerPixel, aAlignment: Longint): Longint;
var
  liBitsPerScanLine: Longint;

begin
  Dec(aAlignment);
  liBitsPerScanLine := aPixelsPerScanline * aBitsPerPixel;
  Result := (liBitsPerScanLine + aAlignment) and not aAlignment;
  Result := Result div 8;
end;

{------------------------------------------------------------------------------}
{ ppGetDIBitmapInfo }

procedure ppGetDIBitmapInfo(aHBitmap: HBITMAP; var aBitmapInfoHeader: TBitmapInfoHeader);
var
 lBitmapDescription: Windows.TBitmap;
begin

  {get bitmap description (i.e. organization)}
  GetObject(aHBitmap, SizeOf(lBitmapDescription), @lBitmapDescription);

  {initialize DIB bitmap header info}
  aBitmapInfoHeader.biSize     := SizeOf(TBitmapInfoHeader);
  aBitmapInfoHeader.biWidth    := lBitmapDescription.bmWidth;
  aBitmapInfoHeader.biHeight   := lBitmapDescription.bmHeight;
  aBitmapInfoHeader.biBitCount := lBitmapDescription.bmBitsPixel * lBitmapDescription.bmPlanes;

  aBitmapInfoHeader.biPlanes        := 1;
  aBitmapInfoHeader.biXPelsPerMeter := 0;
  aBitmapInfoHeader.biYPelsPerMeter := 0;
  aBitmapInfoHeader.biClrUsed       := 0;
  aBitmapInfoHeader.biClrImportant  := 0;
  aBitmapInfoHeader.biCompression   := BI_RGB;

  if aBitmapInfoHeader.biBitCount in [16, 32] then
    aBitmapInfoHeader.biBitCount := 24;


  aBitmapInfoHeader.biSizeImage := ppBytesPerScanLine(aBitmapInfoHeader.biWidth, aBitmapInfoHeader.biBitCount, 32)
                                                               * Abs(aBitmapInfoHeader.biHeight);

end;

{------------------------------------------------------------------------------}
{ ppGetDIBSizes }

procedure ppGetDIBSizes(aHBitmap: HBITMAP; var aInfoHeaderSize: Integer; var aImageSize: DWORD);
var
  lBitmapInfoHeader: TBitmapInfoHeader;
begin

  ppGetDIBitmapInfo(aHBitmap, lBitmapInfoHeader);

  if lBitmapInfoHeader.biBitCount > 8 then
    aInfoHeaderSize := SizeOf(TBitmapInfoHeader)
  else
    aInfoHeaderSize := SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) * (1 shl lBitmapInfoHeader.biBitCount);

  aImageSize := lBitmapInfoHeader.biSizeImage;

end;

{------------------------------------------------------------------------------}
{ ppGetDIB }

function ppGetDIB(aHBitmap: HBITMAP; aPalette: HPALETTE; var aBitmapInfo; var aBits): Boolean;
var
  lDC: HDC;

begin

  ppGetDIBitmapInfo(aHBitmap, TBitmapInfoHeader(aBitmapInfo));

  lDC := CreateCompatibleDC(0);

  try

    {realize palette}
    if aPalette <> 0 then
      begin
        SelectPalette(lDC, aPalette, False);
        RealizePalette(lDC);
      end;

    Result := GetDIBits(lDC, aHBitmap, 0, TBitmapInfoHeader(aBitmapInfo).biHeight, @aBits,
                                          TBitmapInfo(aBitmapInfo), DIB_RGB_COLORS) <> 0;

  finally

    DeleteDC(lDC);

  end;

end;




{------------------------------------------------------------------------------}
{ ppGetHBitmap }

function ppGetHBitmap(aBitmap: TBitmap): HBITMAP;
var
 lHBitmap: HBITMAP;
 lSaveHBitmap: HBITMAP;
 lMemDC, lDC: HDC;
 lSavePalette: HPALETTE;
 lbRestorePalette: Boolean;

begin


  aBitmap.IgnorePalette := False;

  lDC := GetDC(0);

  lMemDC := CreateCompatibleDC(lDC);

  lHBitmap := CreateCompatibleBitmap(lDC, aBitmap.Width, aBitmap.Height);

  ReleaseDC(0, lDC);

  lSaveHBitmap := SelectObject(lMemDC, lHBitmap);

  lbRestorePalette := False;
  lSavePalette := 0;

  if aBitmap.Palette <> 0 then
    begin
      lSavePalette := SelectPalette(lMemDC, aBitmap.Palette, False);
      RealizePalette(lMemDC);
      lbRestorePalette := True;
    end
  else
    begin
      SelectPalette(lMemDC, SystemPalette16, False);
      RealizePalette(lMemDC);

    end;


  BitBlt(lMemDC, 0, 0, aBitmap.Width, aBitmap.Height,
         aBitmap.Canvas.Handle, 0, 0, cmSrcCopy);


  {restore original bitmap}
  SelectObject(lMemDC, lSaveHBitmap);

  {restore palette}
  if lbRestorePalette then
    SelectPalette(lMemDC, lSavePalette, False);

  {delete mem DC}
  DeleteDC(lMemDC);

  Result := lHBitmap;

end; {function, ppGetHBitmap}

{------------------------------------------------------------------------------}
{ ppTransparentStretchBlt }

function ppTransparentStretchBlt(aDstDC: HDC; aDstX, aDstY, aDstW, aDstH: Integer;
  aSrcDC: HDC; aSrcX, aSrcY, aSrcW, aSrcH: Integer; aMaskDC: HDC; aMaskX, aMaskY: Integer): Boolean;

var
  lMemDC: HDC;
  lMemBmp: HBITMAP;
  lSaveBmp: HBITMAP;
  lSavePal: HPALETTE;
  lSaveTextColor, lSaveBkColor: TColorRef;

begin

  Result := True;

  lSavePal := 0;

  {create compatible device context}
  lMemDC := CreateCompatibleDC(aSrcDC);

  try

    {create compatible bitmap and select into compatible DC}
    lMemBmp := CreateCompatibleBitmap(aSrcDC, aSrcW, aSrcH);
    lSaveBmp := SelectObject(lMemDC, lMemBmp);

    {get the current palette}
    lSavePal := SelectPalette(aSrcDC, SystemPalette16, False);

    SelectPalette(aSrcDC, lSavePal, False);

    {initialize memDC with appropriate palette}
    if lSavePal <> 0 then
      lSavePal := SelectPalette(lMemDC, lSavePal, True)
    else
      lSavePal := SelectPalette(lMemDC, SystemPalette16, True);

    RealizePalette(lMemDC);

    {copy the mask to the memDC and then copy the source using SrcErase }
    StretchBlt(lMemDC, 0, 0, aSrcW, aSrcH, aMaskDC, aMaskX, aMaskY, aSrcW, aSrcH, SrcCopy);
    StretchBlt(lMemDC, 0, 0, aSrcW, aSrcH, aSrcDC, aSrcX, aSrcY, aSrcW, aSrcH, SrcErase);

    {set text and background color for destination DC}
    lSaveTextColor := SetTextColor(aDstDC, $0);
    lSaveBkColor   := SetBkColor(aDstDC, $FFFFFF);

    {copy mask to destDC and then copy the MemDC using SrcInvert}
    StretchBlt(aDstDC, aDstX, aDstY, aDstW, aDstH, aMaskDC, aMaskX, aMaskY, aSrcW, aSrcH, SrcAnd);
    StretchBlt(aDstDC, aDstX, aDstY, aDstW, aDstH, lMemDC, 0, 0, aSrcW, aSrcH, SrcInvert);

    {restore the text and background colors}
    SetTextColor(aDstDC, lSaveTextColor);
    SetBkColor(aDstDC,   lSaveBkColor);

    {restore the mem bmp}
    if lSaveBmp <> 0 then
      SelectObject(lMemDC, lSaveBmp);

    {delete the memDbmp}
    DeleteObject(lMemBmp);

  finally
  
    {restore the palette and delete the memDC}
    if lSavePal <> 0 then
      SelectPalette(lMemDC, lSavePal, False);
    DeleteDC(lMemDC);

  end;


end;  {function, ppTransparentStretchBlt}

{------------------------------------------------------------------------------}
{ ppDrawTransparentDIBitmapUsingStretchBlt }

procedure ppDrawTransparentDIBitmapUsingStretchBlt(aCanvas: TCanvas; const aRect: TRect; aBitmap: TBitmap; aCopyMode: TCopyMode);
var
  liDrawWidth: Integer;
  liDrawHeight: Integer;
  liBitmapWidth: Integer;
  liBitmapHeight: Integer;
  lMaskBmp: TBitmap;
  lMaskCanvas: TppDeviceCompatibleCanvas;
  lMemCanvas: TppDeviceCompatibleCanvas;
  liDeviceBPP: Integer;

begin


  liDrawWidth := aRect.Right  - aRect.Left;
  liDrawHeight:= aRect.Bottom - aRect.Top;

  {get device bitmap bits per pixel}
  liDeviceBPP := GetDeviceCaps(aCanvas.Handle, BITSPIXEL) * GetDeviceCaps(aCanvas.Handle, PLANES);

  {if device is monochrome, size bitmap based on printer pixels,
                            otherwise use screen pixels (to minimize memory}
  if (liDeviceBPP = 1) then
    begin
     liBitmapWidth  := aRect.Right  - aRect.Left;
     liBitmapHeight := aRect.Bottom - aRect.Top;

    end
  else
    begin
     liBitmapWidth  := aBitmap.Width;
     liBitmapHeight := aBitmap.Height;

    end;

  {create a device compatible canvas in memory - with the required dimensions}
  lMemCanvas := TppDeviceCompatibleCanvas.Create(aCanvas.Handle, liBitmapWidth, liBitmapHeight,
                                                 aBitmap.Palette);

  {draw the bmp to the mem canvas}
  ppDrawDIBitmap(lMemCanvas, Rect(0 ,0, liBitmapWidth, liBitmapHeight), aBitmap, cmSrcCopy);

  {create a mask bmp}
  lMaskBmp := TBitmap.Create;
  lMaskBmp.Assign(aBitmap);
  lMaskBmp.Mask(aBitmap.TransparentColor);
  lMaskCanvas := TppDeviceCompatibleCanvas.Create(aCanvas.Handle, liBitmapWidth,
                                                                  liBitmapHeight,
                                                                  aBitmap.Palette);

   {draw the mask bmp to the mask mem canvas}
   ppDrawDIBitmap(lMaskCanvas, Rect(0, 0, liBitmapWidth, liBitmapHeight), lMaskBmp, cmSrcCopy);


   aCanvas.Brush.Style := bsClear;

   {use mem canvas and mask canvas to draw to the device canvas}
   ppTransparentStretchBlt(aCanvas.Handle, aRect.Left, aRect.Top,
                                         liDrawWidth, liDrawHeight,
                                         lMemCanvas.Handle, 0, 0, liBitmapWidth, liBitmapHeight,
                                         lMaskCanvas.Handle, 0, 0);

  lMaskBmp.Free;                                       
  lMaskCanvas.Free;
  lMemCanvas.Free;

end; {procedure, ppDrawTransparentDIBitmapUsingStretchBlt}



{------------------------------------------------------------------------------}
{ ppDrawTransparentDIBitmap }

procedure ppDrawTransparentDIBitmap(aCanvas: TCanvas; const aRect: TRect; aBitmap: TBitmap; aCopyMode: TCopyMode);
var
  liRasterCaps: Integer;
  lbStretchBlt: Boolean;
  {liDeviceBPP: Integer;}

begin

  {check whether device supports StretchBlt}
  liRasterCaps := GetDeviceCaps(aCanvas.Handle, RASTERCAPS);

  lbStretchBlt := (liRasterCaps and RC_STRETCHBLT) > 0;

  {get device bitmap bits per pixel}
 { liDeviceBPP := GetDeviceCaps(aCanvas.Handle, BITSPIXEL) * GetDeviceCaps(aCanvas.Handle, PLANES);
  }

  if (lbStretchBlt) then
    ppDrawTransparentDIBitmapUsingStretchBlt(aCanvas, aRect, aBitmap, aCopyMode)

 { else if liDeviceBPP > 1 then
    ppDrawTransparentDIBitmapWithoutStretchBlt(aCanvas, aRect, aBitmap, aCopyMode)}

  else
    ppDrawDIBitmap(aCanvas, aRect, aBitmap, aCopyMode);


end; {procedure, ppDrawTransparentDIBitmap}

{------------------------------------------------------------------------------}
{ ppDrawDIBitmap }

procedure ppDrawDIBitmap(aCanvas: TCanvas; const aRect: TRect; aBitmap: TBitmap; aCopyMode: TCopyMode);
var
  lpBitMapInfo: PBitmapInfo;
  lpImage: Pointer;
  liInfoSize: Integer;
  lSavePalette: HPalette;
  lbRestorePalette: Boolean;
  liImageSize: DWord;
  lbHalftone: Boolean;
  lPoint: TPoint;
  lBitmapDescription: Windows.TBitmap;
  lbMonochrome: Boolean;
  liBitmapBPP, liDeviceBPP: Integer;
  lHBitmap: HBITMAP;
  lbFreeBitmap: Boolean;
  lhBitmapInfo: THandle;
  lhImage: THandle;

begin

  // modified from RB 7.02 as suggested by a customer.
  // calling ppGetHBitmap uses the video resolution
  // which can degrade the image
  if (aCopyMode = cmSrcAnd) then
    begin
      lHBitmap := ppGetHBitmap(aBitmap);
      lbFreeBitmap := true;
    end
  else
    begin
      lHBitmap := aBitmap.Handle;  // does not work for transparent images
      lbFreeBitmap := false;
    end;

  lSavePalette := 0;
  lbRestorePalette := False;

  if aBitmap.Palette <> 0 then
    begin
      lSavePalette := SelectPalette(aCanvas.Handle, aBitmap.Palette, False);
      RealizePalette(aCanvas.Handle);
      lbRestorePalette := True;
    end
  else
    begin
      SelectPalette(aCanvas.Handle, SystemPalette16, False);
      RealizePalette(aCanvas.Handle);

    end;

  {get bitmap description (i.e. organization)}
  GetObject(lHBitmap, SizeOf(lBitmapDescription), @lBitmapDescription);

  {determine the number of bits required to describe each pixel }
  liBitmapBPP := (lBitmapDescription.bmBitsPixel * lBitmapDescription.bmPlanes);

  {determine the devices color cababilities }
  liDeviceBPP := GetDeviceCaps(aCanvas.Handle, BITSPIXEL) * GetDeviceCaps(aCanvas.Handle, PLANES);

  lbHalftone := (liDeviceBPP <= 8) and (liDeviceBPP < liBitmapBPP);

  lbMonochrome := (liBitmapBPP = 1);

  {set the stretch blit mode}
  if lbHalftone then
    begin
      GetBrushOrgEx(aCanvas.Handle, lPoint);
      SetStretchBltMode(aCanvas.Handle, HALFTONE);

      SetBrushOrgEx(aCanvas.Handle, lPoint.x, lPoint.y, @lPoint);
    end

  else if not lbMonochrome then
    SetStretchBltMode(aCanvas.Handle, STRETCH_DELETESCANS);

  {initialize }
  liInfoSize   := 0;
  liImageSize  := 0;

  {get info needed to convert bitmap to DIB}
  ppGetDIBSizes(lHBitmap, liInfoSize, liImageSize);

  lhBitmapInfo := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE, liInfoSize);
  lpBitMapInfo  := PBitmapInfo(GlobalLock(lhBitmapInfo));

//  lpBitMapInfo  := AllocMem(liInfoSize);
//  lpImage       := AllocMem(liImageSize);

  try
    lhImage := GlobalAlloc(GMEM_MOVEABLE or GMEM_SHARE, liImageSize);
    lpImage := Pointer(GlobalLock(lhImage));

    try

      {convert bitmap to Device Independent Bitmap}
      ppGetDIB(lHBitmap, aBitmap.Palette, lpBitMapInfo^, lpImage^);

      {draw bitmap to printer canvas }
      StretchDIBits(aCanvas.Handle,
                    aRect.Left, aRect.Top, aRect.Right - aRect.Left, aRect.Bottom - aRect.Top,
                    0, 0, lpBitMapInfo^.bmiHeader.biWidth, lpBitMapInfo^.bmiHeader.biHeight,
                    lpImage, lpBitMapInfo^, DIB_RGB_COLORS, aCopyMode);

    finally
      GlobalUnlock(lhImage);
      GlobalFree(lhImage);
    end;

  finally
    GlobalUnlock(lhBitmapInfo);
    GlobalFree(lhBitmapInfo);
  end;

//  FreeMem(lpBitmapInfo, liInfoSize);
//  FreeMem(lpImage, liImageSize);


  if lbRestorePalette then
    SelectPalette(aCanvas.Handle, lSavePalette, False);

  if lbFreeBitmap then
    DeleteObject(lHBitmap);

end; {procedure, DrawDIBitmap}

{------------------------------------------------------------------------------}
{ ppCopyPalette }

function ppCopyPalette(aPalette: HPalette): HPalette;
begin
   Result := CopyPalette(aPalette);
end;

{------------------------------------------------------------------------------}
{ ppGetSystemDefaultLanguage }

function ppGetSystemDefaultLanguage: TppLanguageType;
var
  lwLang1: Word;
  lwLang2: Word;
begin

  lwLang1 := Lo(GetSystemDefaultLangId);
  lwLang2 := Hi(GetSystemDefaultLangId);

  case lwLang1 of
    LANG_DANISH:      Result := lgDanish;
    LANG_DUTCH:       Result := lgDutch;
    LANG_FRENCH:      Result := lgFrench;
    LANG_GERMAN:      Result := lgGerman;
    LANG_ITALIAN:     Result := lgItalian;
    LANG_NORWEGIAN:   Result := lgNorwegian;
    LANG_SWEDISH:     Result := lgSwedish;

    LANG_SPANISH:
      begin
        if (lwLang2 = SUBLANG_SPANISH) then
          Result := lgSpanish
        else
          Result := lgSpanishMexico;
      end;

    LANG_PORTUGUESE:
      begin
        if (lwLang2 = SUBLANG_PORTUGUESE_BRAZILIAN) then
          Result := lgPortugueseBrazil
        else
          Result := lgPortuguese;
      end;

    else
      Result := lgEnglish;

  end;

end; {function, ppGetSystemDefaultLanguage}

{------------------------------------------------------------------------------}
{ ppInMainThread }

function ppInMainThread: Boolean;
begin

  if (uOutlinePreviewing = 0) and (uBackgroundPrinting = 0) then
    Result := GetCurrentThreadID = MainThreadID
  else
    Result := True;

end; {function, ppInMainThread}

{------------------------------------------------------------------------------}
{ TppDebugLog.WriteMessage }

procedure TppDebugLog.WriteMessage(aMessage: String);
begin
  Add(aMessage);
  SaveToFile('c:\temp\debug.txt');
end;

{------------------------------------------------------------------------------}
{ ppResourceManager }

function ppResourceManager: TppResourceManager;
begin

  if  ((uResourceManager = nil) and not(uFinalized)) then
    uResourceManager := uResourceManagerClass.Create;

  Result := uResourceManager;

end;

{------------------------------------------------------------------------------}
{ ppDebugLog }

function ppDebugLog: TppDebugLog;
begin
  if uDebugLog = nil then
    begin
      uDebugLog := TppDebugLog.Create;
      {clear it out}
      uDebugLog.SaveToFile('c:\temp\debug.txt');
    end;
  Result := uDebugLog;
end;

{------------------------------------------------------------------------------}
{ ppCapitalize }

function ppCapitalize(const aString: String): String;
var
  liPos: Integer;
  liLength: Integer;
  lsWord: String;
begin

  Result := aString;

  liLength := Length(Result);

  if (liLength = 0) then Exit;

  Result := LowerCase(Result);

  Result[1] := UpperCase(Result[1])[1];

  lsWord := Result;

  liPos := Pos(#32, lsWord);

  while (liPos <> 0) and (liPos < liLength) do
    begin
      lsWord[liPos + 1] := UpperCase(lsWord[liPos + 1])[1];

      lsWord := Copy(lsWord, liPos + 1, Length(lsWord));

      Result := Copy(Result, 1, Length(Result) - Length(lsWord)) + lsWord;

      liPos := Pos(#32, lsWord);
    end;

  liPos := Pos('_', lsWord);

  while (liPos <> 0) and (liPos < liLength) do
    begin
      lsWord[liPos + 1] := UpperCase(lsWord[liPos + 1])[1];

      lsWord := Copy(lsWord, liPos + 1, Length(lsWord));

      Result := Copy(Result, 1, Length(Result) - Length(lsWord)) + lsWord;

      liPos := Pos('_', lsWord);
    end;

end; {function, ppCapitalize}

{------------------------------------------------------------------------------}
{ ppStripUnderscores }

function ppStripUnderscores(const aString: String): String;
var
  liPos: Integer;
  liLength: Integer;
  lsWord: String;
begin

  Result := aString;

  liLength := Length(Result);

  lsWord := Result;

  liPos := Pos('_', lsWord);

  while (liPos <> 0) and (liPos < liLength) do
    begin
      lsWord[liPos] := #32;

      lsWord[liPos + 1] := UpperCase(lsWord[liPos + 1])[1];

      lsWord := Copy(lsWord, liPos, Length(lsWord));

      Result := Copy(Result, 1, Length(Result) - Length(lsWord)) + lsWord;

      liPos := Pos('_', lsWord);
    end;

end; {function, ppStripUnderscores}

{------------------------------------------------------------------------------}
{ ppStrToDateTime }

function ppStrToDateTime(aValue: String): TDateTime;
begin

{$IFDEF Delphi5}
    Result := StrToDateTime(aValue);
{$ELSE}

  {use existing century window value}
  if TwoDigitYearCenturyWindow <> 0 then
    Result := StrToDateTime(aValue)

  else
    try

      {handle pre-Delphi Y2K issues by temp setting CenturyWindow to 50}
      TwoDigitYearCenturyWindow := 50;

      Result := StrToDateTime(aValue);
    finally
      TwoDigitYearCenturyWindow  := 0;
    end;

{$ENDIF}

end;  {function, ppStrToDateTime}

{@ppBeginOutlinePreviewing }

procedure ppBeginOutlinePreviewing;
begin
  Inc(uOutlinePreviewing);
end;

{@ppEndOutlinePreviewing }

procedure ppEndOutlinePreviewing;
begin

  if (uOutlinePreviewing > 0) then
    Dec(uOutlinePreviewing);
    
end;

{@ppBeginBackgroundPrinting }

procedure ppBeginBackgroundPrinting;
begin
  Inc(uBackgroundPrinting);
end;

{@ppEndBackgroundPrinting }

procedure ppEndBackgroundPrinting;
begin

  if (uBackgroundPrinting > 0) then
    Dec(uBackgroundPrinting);

end;

{------------------------------------------------------------------------------}
{ ppFromMMThousandths }

function ppFromMMThousandths(Value: Longint; aUnits: TppUnitType; aPixelsPerInch: Integer): Single;
begin

  case aUnits of

    utScreenPixels:
      Result := Round(((Value / 1000) * InchPerMM) * aPixelsPerInch);

    utInches:
      Result := Round( ( ( (Value / 1000) * InchPerMM) * 10000) ) / 10000;

    utMillimeters:
      Result := Value / 1000;

    utPrinterPixels:
        Result := Round( ((Value / 1000) * InchPerMM) * aPixelsPerInch);

    utMMThousandths:
      Result := Value;

  else
    Result := 0;

  end; {case, unit type}

end; {procedure, ppFromMMThousandths}

{------------------------------------------------------------------------------}
{ ppToMMThousandths }

function ppToMMThousandths(Value: Single; aUnits: TppUnitType; aPixelsPerInch: Integer): Longint;
begin

  case aUnits of

    utScreenPixels:
      Result := Round( ((Value / aPixelsPerInch) / InchPerMM) * 1000);

    utInches:
      Result := Round( (Value / InchPerMM) * 1000);

    utMillimeters:
      Result := Round(Value * 1000);

    utPrinterPixels:
        Result := Round( ((Value / aPixelsPerInch) / InchPerMM) * 1000);

    utMMThousandths:
      Result := Trunc(Value);

  else
    Result := 0;

  end; {case, unit type}

end; {procedure, ppToMMThousandths}

function ppGetHelpFilePath: String;
var
  lsDelphiPath: String;
begin
  lsDelphiPath := ppGetDelphiPath;

  if lsDelphiPath <> '' then
    Result := ppGetDelphiPath + '\RBuilder\Help\'
  else
    Result := '';

end;

{$IFNDEF Delphi9}

function GradientFill; external msimg32 name 'GradientFill';

{------------------------------------------------------------------------------}
{ ppGradientFillCanvas }

procedure ppGradientFillCanvas(const ACanvas: TCanvas; const AStartColor, AEndColor: TColor; const ARect: TRect; const Direction: TppGradientDirection);
const
  cGradientDirections: array[TppGradientDirection] of Cardinal = (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
var
  lStartColor: Cardinal;
  lEndColor: Cardinal;
  lVertexes: array[0..1] of TTriVertex;
  lGradientRect: TGradientRect;
begin

  lStartColor := ColorToRGB(AStartColor);
  lEndColor := ColorToRGB(AEndColor);

  lVertexes[0].x := ARect.Left;
  lVertexes[0].y := ARect.Top;
  lVertexes[0].Red := GetRValue(lStartColor) shl 8;
  lVertexes[0].Blue := GetBValue(lStartColor) shl 8;
  lVertexes[0].Green := GetGValue(lStartColor) shl 8;
  lVertexes[0].Alpha := 0;

  lVertexes[1].x := ARect.Right;
  lVertexes[1].y := ARect.Bottom;
  lVertexes[1].Red := GetRValue(lEndColor) shl 8;
  lVertexes[1].Blue := GetBValue(lEndColor) shl 8;
  lVertexes[1].Green := GetGValue(lEndColor) shl 8;
  lVertexes[1].Alpha := 0;

  lGradientRect.UpperLeft := 0;
  lGradientRect.LowerRight := 1;

  GradientFill(ACanvas.Handle, @lVertexes[0], 2, @lGradientRect, 1, cGradientDirections[Direction]);
end;
{$ENDIF}


function ppCreateGuidString: String;
var
  lGuid: TGUID;
begin

  if CoCreateGuid(lGuid) = S_OK then
    Result := GUIDToString(lGuid);

  Result := StringReplace(Result, '{', '', []);
  Result := StringReplace(Result, '}', '', []);


end;


{ TMetafileCanvas }

constructor TppMetaFileCanvas.CreateCanvas(AMetafile: TMetafile; ReferenceDevice: HDC);
begin

  FPixelsPerInch.X := GetDeviceCaps(ReferenceDevice, LOGPIXELSX);
  FPixelsPerInch.Y := GetDeviceCaps(ReferenceDevice, LOGPIXELSY);

  CreateWithComment(AMetafile, ReferenceDevice, AMetafile.CreatedBy, AMetafile.Description);

end;

{------------------------------------------------------------------------------}
{ TppMetaFileCanvas.Changing }

procedure TppMetaFileCanvas.Changing;
begin
  inherited Changing;


  UpdateDeviceContext;

end; {procedure, Changing}

{------------------------------------------------------------------------------}
{ TppMetaFileCanvas.CreateHandle }

procedure TppMetaFileCanvas.CreateHandle;
begin
  UpdateDeviceContext;



end; {procedure, CreateHandle}

{------------------------------------------------------------------------------}
{ TppMetaFileCanvas.UpdateDeviceContext }

procedure TppMetaFileCanvas.UpdateDeviceContext;
var
  liFontSize: Integer;
begin

  if (FPixelsPerInch.Y <> Font.PixelsPerInch) then
    begin
      liFontSize := Font.Size;
      Font.PixelsPerInch := FPixelsPerInch.Y;
      Font.Size := liFontSize;
    end;

end; {procedure, UpdateDeviceContext}


class function TppFont.Clone(aFont: TFont): TFont;
begin
  Result := TFont.Create;
  Result.Assign(aFont);
end;

class function TppFont.Compare(aFont1, aFont2: TFont): Boolean;
begin
  Result := (aFont1.Name = aFont2.Name) and
            (aFont1.Height = aFont2.Height) and
            (aFont1.Color = aFont2.Color) and
            (aFont1.Charset = aFont2.Charset) and
            (aFont1.Style = aFont2.Style) and
            (aFont1.Pitch = aFont2.Pitch)
            {$IFDEF Delphi10}
            and (aFont1.Orientation = aFont2.Orientation)
            {$ENDIF};
end;

function TppFont.EqualTo(aFont: TFont): Boolean;
begin
  Result := Compare(Self, aFont);
end;



{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}



initialization
  RegisterClass(TppFont);

  uIsWinXP := (Win32Platform = VER_PLATFORM_WIN32_NT) and
              (((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)) or (Win32MajorVersion > 5));

//  uIsWinXP := False;  {use for testing}

finalization
  UnregisterClass(TppFont);

  uResourceManager.Free;
  uResourceManager := nil;

  uDebugLog.Free;
  uDebugLog := nil;

  uFinalized := True;

end.


