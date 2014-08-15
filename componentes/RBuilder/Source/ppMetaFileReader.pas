{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB                                                     
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppMetaFileReader;

interface

{$I ppIfDef.pas}

uses
  dialogs,
//  Forms,
//  ppFileUtils,

  Windows,
  SysUtils,
  Classes,
  Graphics,

  ppUtils,
  ppTypes,
  ppCharacter,
  ppMetaGraphics;

type

  TppMetaGDIObject = class;

  {TppMetaFileReader}
  TppMetaFileReader = class
  private
    FCommandLog: TStringList;
    FCount: Integer;
    FEnhMetaHeader: TEnhMetaHeader;
    FErrorLog: TStrings;
    FGDIObjects: array of TppMetaGDIObject;
    FMetafile: TMetaFile;
    FMetaGraphics: IppMetaGraphics;
    FRect: TRect;
    FUniqueCommandsOnly: Boolean;
    
    procedure FreeGDIObjects;
    function GetMetaFileRecordDescription(aRecordType: Integer): String;
    procedure LogCommand(aRecordType: Integer);
    procedure LogError(aRecordType: Integer);
    function ProcessMetaRecord(aPMetaRecord: Pointer): Boolean;

  public
    constructor Create; virtual;
    destructor Destroy; override;
    
    procedure Execute(aMetaGraphics: IppMetaGraphics; aRect: TRect);
    procedure BuildCommandLog; overload;
    procedure BuildCommandLog(aUniqueCommandOnly: Boolean); overload;

    property CommandLog: TStringList read FCommandLog;
    property ErrorLog: TStrings read FErrorLog;
    property Metafile: TMetaFile read FMetafile write FMetafile;

  end;


  TppGDIObjectType = (gdiBrush, gdiFont, gdiPen);

  {TppGDIObjectType}
  TppMetaGDIObject = class
  private
    FBrush: TBrush;
    FFont: TFont;
    FFontAngle: Integer;
    FHandle: THandle;
    FGDIObjectType: TppGDIObjectType;
    FPen: TPen;
  public
    constructor Create(aHandle: THandle; aGDIObjecType: TppGDIObjectType);
    destructor Destroy; override;
    property Brush: TBrush read FBrush;
    property Font: TFont read FFont;
    property FontAngle: Integer read FFontAngle write FFontAngle;
    property Handle: THandle read FHandle;
    property GDIObjectType: TppGDIObjectType read FGDIObjectType;
    property Pen: TPen read FPen;

  end;

  TPointArray = array of TPoint;
  TRectArray = array of TRect;
  PPointArray = ^TPointArray;
  TIntegerArray = array of Integer;

  TSmallPointArray = array[0..0] of TSmallPoint;
  PSmallPointArray = ^TSmallPointArray;
  TCountArray = array[0..0] of DWord;
  PCountArray = ^TCountArray;

  {TppEmrUtils}
  TppEmrUtils = class
  private

  public
    class procedure InitializeCountarray(const aSource: array of DWord; aCount: Integer; var aCountArray: TIntegerArray); overload;
    class procedure InitializePointArray(const aSource: array of TPoint; aCount: Integer; var aPointArray: TPointArray); overload;
    class procedure InitializePointArray16(const aSource: array of TSmallPoint; aCount: Integer; var aPointArray: TPointArray); overload;
    class procedure InitializeBrushData(aBrush: TBrush; aHBrush: HBrush);
    class procedure InitializeIntegerArray(const aSource: array of Integer; aCount: Integer; var aIntegerArray: TIntegerArray); overload;
    class procedure InitializePenData(aPen: TPen; aHPen: HPen);
  end;


implementation


function cbReadMetaFunc(aDC: HDC; apHTable: PHANDLETABLE; apEMFR: PENHMETARECORD; aObjCount: Integer; aMetaFileReader: TppMetaFileReader): Integer; stdcall;
begin

  // process meta record, add to error log if not implemented
  if not aMetaFileReader.ProcessMetarecord(apEMFR) then
    aMetaFileReader.LogError(apEMFR^.iType);

  Result := 1;

end;

function cbReadMetaFuncForLog(aDC: HDC; apHTable: PHANDLETABLE; apEMFR: PENHMETARECORD; aObjCount: Integer; aMetaFileReader: TppMetaFileReader): Integer; stdcall;
begin

  aMetaFileReader.LogCommand(apEMFR^.iType);

  Result := 1;

end;

constructor TppMetaFileReader.Create;
begin

  inherited;

  FErrorLog := TStringList.Create;
  FCommandLog := TStringList.Create;

end;
                                                                                                    
destructor TppMetaFileReader.Destroy;
begin


  FreeGDIObjects;
  
  FGDIObjects := nil;

  FErrorLog.Free;
  FCommandLog.Free;

  inherited;


end;


procedure TppMetaFileReader.FreeGDIObjects;
var
  liIndex: Integer;
begin

  if (FGDIObjects = nil) then Exit;

  for liIndex := 0 to Length(FGDIObjects) - 1 do
    FGDIObjects[liIndex].Free;

  FGDIObjects := nil;

end;

procedure TppMetaFileReader.Execute(aMetaGraphics: IppMetaGraphics; aRect: TRect);
begin

  FCount := 0;
  FMetaGraphics := aMetaGraphics;
  FErrorLog.Clear;
  FRect := aRect;

  EnumEnhMetaFile(0, FMetaFile.Handle, @cbReadMetaFunc, self, aRect);

  FMetaGraphics := nil;

  FreeGDIObjects;

end;

procedure TppMetaFileReader.BuildCommandLog;
begin

  BuildCommandLog(False);

end;

procedure TppMetaFileReader.BuildCommandLog(aUniqueCommandOnly: Boolean);
begin

  FCommandLog.Clear;

  FUniqueCommandsOnly := aUniqueCommandOnly;

  EnumEnhMetaFile(0, FMetaFile.Handle, @cbReadMetaFuncForLog, self, Rect(0,0,0,0));

end;


function TppMetaFileReader.GetMetaFileRecordDescription(aRecordType: Integer): String;
begin

  case aRecordType of

    EMR_HEADER: // 1
      Result := 'EMR_HEADER';

    EMR_POLYBEZIER: // 2
      Result := 'EMR_POLYBEZIER';

    EMR_POLYGON: // 3
      Result := 'EMR_POLYGON';

    EMR_POLYLINE: // 4
      Result := 'EMR_POLYLINE';

    EMR_POLYBEZIERTO: // 5
      Result := 'EMR_POLYBEZIERTO';

    EMR_POLYLINETO: // 6
      Result := 'EMR_POLYLINETO';

    EMR_POLYPOLYLINE: // 7
      Result := 'EMR_POLYPOLYLINE';

    EMR_POLYPOLYGON: // 8
      Result := 'EMR_POLYPOLYGON';

    EMR_SETWINDOWEXTEX: // 9
      Result := 'EMR_SETWINDOWEXTEX';

    EMR_SETWINDOWORGEX: // 10
      Result := 'EMR_SETWINDOWORGEX';

    EMR_SETVIEWPORTEXTEX: // 11
      Result := 'EMR_SETVIEWPORTEXTEX';

    EMR_SETVIEWPORTORGEX: // 12
      Result := 'EMR_SETVIEWPORTORGEX';

    EMR_SETBRUSHORGEX: // 13
      Result := 'EMR_SETBRUSHORGEX';

    EMR_EOF: // 14
       Result := 'EMR_EOF';

    EMR_SETPIXELV: // 15
      Result := 'EMR_SETPIXELV';

    EMR_SETMAPPERFLAGS: // 16
      Result := 'EMR_SETMAPPERFLAGS';
    
    EMR_SETMAPMODE: // 17
      Result := 'EMR_SETMAPMODE';

    EMR_SETBKMODE: // 18
      Result := 'EMR_SETBKMODE';

    EMR_SETPOLYFILLMODE: // 19
      Result := 'EMR_SETPOLYFILLMODE';

    EMR_SETROP2: // 20
        Result := 'EMR_SETROP2';

    EMR_SETSTRETCHBLTMODE: // 21
        Result := 'EMR_SETSTRETCHBLTMODE';

    EMR_SETTEXTALIGN: // 22
        Result := 'EMR_SETTEXTALIGN';

    EMR_SETCOLORADJUSTMENT: // 23
        Result := 'EMR_SETCOLORADJUSTMENT';

    EMR_SETTEXTCOLOR: // 24
        Result := 'EMR_SETTEXTCOLOR';

    EMR_SETBKCOLOR: // 25
        Result := 'EMR_SETBKCOLOR';

    EMR_OFFSETCLIPRGN: // 26
        Result := 'EMR_OFFSETCLIPRGN';

    EMR_MOVETOEX: // 27
        Result := 'EMR_MOVETOEX';

    EMR_SETMETARGN: // 28
         Result := 'EMR_SETMETARGN';

    EMR_EXCLUDECLIPRECT: // 29
         Result := 'EMR_EXCLUDECLIPRECT';

    EMR_INTERSECTCLIPRECT: // 30
         Result := 'EMR_INTERSECTCLIPRECT';

    EMR_SCALEVIEWPORTEXTEX: // 31
         Result := 'EMR_SCALEVIEWPORTEXTEX';

    EMR_SCALEWINDOWEXTEX: // 32
         Result := 'EMR_SCALEWINDOWEXTEX';

    EMR_SAVEDC: // 33
         Result := 'EMR_SAVEDC';

    EMR_RESTOREDC: // 34
         Result := 'EMR_RESTOREDC';

    EMR_SETWORLDTRANSFORM: // 35
         Result := 'EMR_SETWORLDTRANSFORM';

    EMR_MODIFYWORLDTRANSFORM: // 36
         Result := 'EMR_MODIFYWORLDTRANSFORM';

    EMR_SELECTOBJECT: // 37
         Result := 'EMR_SELECTOBJECT';

    EMR_CREATEPEN: // 38
         Result := 'EMR_CREATEPEN';

    EMR_CREATEBRUSHINDIRECT: // 39
          Result := 'EMR_CREATEBRUSHINDIRECT';

    EMR_DELETEOBJECT: // 40
          Result := 'EMR_DELETEOBJECT';

    EMR_ANGLEARC: // 41
         Result := 'EMR_ANGLEARC';

    EMR_ELLIPSE: // 42
         Result := 'EMR_ELLIPSE';

    EMR_RECTANGLE: // 43
         Result := 'EMR_RECTANGLE';

    EMR_ROUNDRECT: // 44
         Result := 'EMR_ROUNDRECT';

    EMR_ARC: // 45
         Result := 'EMR_ARC';

    EMR_CHORD: // 46
         Result := 'EMR_CHORD';

    EMR_PIE: // 47
         Result := 'EMR_PIE';

    EMR_SELECTPALETTE: // 48
         Result := 'EMR_SELECTPALETTE';

    EMR_CREATEPALETTE: // 49
         Result := 'EMR_CREATEPALETTE';

    EMR_SETPALETTEENTRIES: // 50
         Result := 'EMR_SETPALETTEENTRIES';

    EMR_RESIZEPALETTE: // 51
          Result := 'EMR_RESIZEPALETTE';

    EMR_REALIZEPALETTE: // 52
         Result := 'EMR_REALIZEPALETTE';

    EMR_EXTFLOODFILL: // 53
         Result := 'EMR_EXTFLOODFILL';

    EMR_LINETO: // 54
        Result := 'EMR_LINETO';

    EMR_ARCTO: // 55
        Result := 'EMR_ARCTO';

    EMR_POLYDRAW: // 56
        Result := 'EMR_POLYDRAW';

    EMR_SETARCDIRECTION: // 57
        Result := 'EMR_SETARCDIRECTION';

    EMR_SETMITERLIMIT: // 58
        Result := 'EMR_SETMITERLIMIT';

    EMR_BEGINPATH: // 59
        Result := 'EMR_BEGINPATH';

    EMR_ENDPATH: // 60
        Result := 'EMR_ENDPATH';

    EMR_CLOSEFIGURE: // 61
        Result := 'EMR_CLOSEFIGURE';

    EMR_FILLPATH: // 62
        Result := 'EMR_FILLPATH';

    EMR_STROKEANDFILLPATH: // 63
        Result := 'EMR_STROKEANDFILLPATH';

    EMR_STROKEPATH: // 64   
        Result := 'EMR_STROKEPATH';

    EMR_FLATTENPATH: // 65
        Result := 'EMR_FLATTENPATH';

    EMR_WIDENPATH: // 66
        Result := 'EMR_WIDENPATH';

    EMR_SELECTCLIPPATH: // 67
        Result := 'EMR_SELECTCLIPPATH';

    EMR_ABORTPATH: // 68
        Result := 'EMR_ABORTPATH';

    EMR_GDICOMMENT: // 70
        Result := 'EMR_GDICOMMENT';

    EMR_FILLRGN: // 71
        Result := 'EMR_FILLRGN';

    EMR_FRAMERGN: // 72
        Result := 'EMR_FRAMERGN';

    EMR_INVERTRGN: // 73
        Result := 'EMR_INVERTRGN';

    EMR_PAINTRGN: // 74
        Result := 'EMR_PAINTRGN';

    EMR_EXTSELECTCLIPRGN: // 75
        Result := 'EMR_EXTSELECTCLIPRGN';

    EMR_BITBLT: // 76
        Result := 'EMR_BITBLT';

    EMR_STRETCHBLT: // 77
        Result := 'EMR_STRETCHBLT';

    EMR_MASKBLT: // 78
        Result := 'EMR_MASKBLT';

    EMR_PLGBLT: // 79
        Result := 'EMR_PLGBLT';

    EMR_SETDIBITSTODEVICE: // 80
        Result := 'EMR_SETDIBITSTODEVICE';

    EMR_STRETCHDIBITS: // 81
        Result := 'EMR_STRETCHDIBITS';

    EMR_EXTCREATEFONTINDIRECTW: // 82
        Result := 'EMR_EXTCREATEFONTINDIRECTW';

    EMR_EXTTEXTOUTA: // 83
        Result := 'EMR_EXTTEXTOUTA';

    EMR_EXTTEXTOUTW: // 84
        Result := 'EMR_EXTTEXTOUTW';

    EMR_POLYBEZIER16: // 85
        Result := 'EMR_POLYBEZIER16';

    EMR_POLYGON16: // 86
        Result := 'EMR_POLYGON16';

    EMR_POLYLINE16: // 87
        Result := 'EMR_POLYLINE16';

    EMR_POLYBEZIERTO16: // 88
        Result := 'EMR_POLYBEZIERTO16';

    EMR_POLYLINETO16: // 89
        Result := 'EMR_POLYLINETO16';

    EMR_POLYPOLYLINE16: // 90
        Result := 'EMR_POLYPOLYLINE16';

    EMR_POLYPOLYGON16: // 91
        Result := 'EMR_POLYPOLYGON16';

    EMR_POLYDRAW16: // 92
        Result := 'EMR_POLYDRAW16';

    EMR_CREATEMONOBRUSH: // 93
        Result := 'EMR_CREATEMONOBRUSH';

    EMR_CREATEDIBPATTERNBRUSHPT: // 94
        Result := 'EMR_CREATEDIBPATTERNBRUSHPT';

    EMR_EXTCREATEPEN: // 95
        Result := 'EMR_EXTCREATEPEN';

    EMR_POLYTEXTOUTA: // 96
        Result := 'EMR_POLYTEXTOUTA';

    EMR_POLYTEXTOUTW: // 97
        Result := 'EMR_POLYTEXTOUTW';

    EMR_SETICMMODE: // 98
        Result := 'EMR_SETICMMODE';

    EMR_CREATECOLORSPACE: // 99;
        Result := 'EMR_CREATECOLORSPACE';

    EMR_SETCOLORSPACE: // 100;
        Result := 'EMR_SETCOLORSPACE';

    EMR_DELETECOLORSPACE: // 101;
        Result := 'EMR_DELETECOLORSPACE';

    EMR_GLSRECORD: // 102
        Result := 'EMR_GLSRECORD';

    EMR_GLSBOUNDEDRECORD: // 103
        Result := 'EMR_GLSBOUNDEDRECORD';

    EMR_PIXELFORMAT: // 104
        Result := 'EMR_PIXELFORMAT';

    EMR_DRAWESCAPE: // 105
        Result := 'EMR_DRAWESCAPE';

    EMR_EXTESCAPE: // 106
        Result := 'EMR_EXTESCAPE';

    EMR_STARTDOC: // 107
        Result := 'EMR_STARTDOC';

    EMR_SMALLTEXTOUT: // 108
        Result := 'EMR_SMALLTEXTOUT';

    EMR_FORCEUFIMAPPING: // 109
        Result := 'EMR_FORCEUFIMAPPING';

    EMR_NAMEDESCAPE: // 110
        Result := 'EMR_NAMEDESCAPE';

    EMR_COLORCORRECTPALETTE: // 111
        Result := 'EMR_COLORCORRECTPALETTE';

    EMR_SETICMPROFILEA: // 112
        Result := 'EMR_SETICMPROFILEA';

    EMR_SETICMPROFILEW: // 113
        Result := 'EMR_SETICMPROFILEW';

    EMR_ALPHABLEND: // 114
        Result := 'EMR_ALPHABLEND';

    EMR_ALPHADIBBLEND: // 115
        Result := 'EMR_ALPHADIBBLEND';

    EMR_TRANSPARENTBLT: // 116
        Result := 'EMR_TRANSPARENTBLT';

    EMR_TRANSPARENTDIB: // 117
        Result := 'EMR_TRANSPARENTDIB';

    EMR_GRADIENTFILL: // 118
        Result := 'EMR_GRADIENTFILL';

    EMR_SETLINKEDUFIS: // 119
        Result := 'EMR_SETLINKEDUFIS';

    EMR_SETTEXTJUSTIFICATION: // 120
        Result := 'EMR_SETTEXTJUSTIFICATION';

    else
      Result := 'Dunno';

  end;


end;

procedure TppMetaFileReader.LogCommand(aRecordType: Integer);
var
  lsCommand: String;
begin

  lsCommand := GetMetaFileRecordDescription(aRecordType);

  if (FUniqueCommandsOnly) and (FCommandLog.IndexOf(lsCommand) >= 0) then
    // nothing
  else
    FCommandLog.Add(lsCommand);
    
end;

procedure TppMetaFileReader.LogError(aRecordType: Integer);
var
  lsCommand: String;
begin

  lsCommand := GetMetaFileRecordDescription(aRecordType);

//  if (FUniqueCommandsOnly) and (FCommandLog.IndexOf(lsCommand) >= 0) then
    // nothing
//  else
    FErrorLog.Add(lsCommand);
    
end;

function TppMetaFileReader.ProcessMetaRecord(aPMetaRecord: Pointer): Boolean;
const
  ROP2Codes: array[1..16] of TPenMode =
    (pmBlack, pmNotMerge, pmNotMask, pmNotCopy,
     pmMaskPenNot, pmNop, pmXor, pmNotMask,
     pmMask, pmNotXor, pmNop,  pmMergeNotPen,
     pmCopy, pmMergePenNot, pmMerge, pmWhite);
var
  liEMRType: Integer;
  lEmrLineTo: TEMRLINETO;
  lEmrSetTextColor: TEMRSETTEXTCOLOR;
  lEmrSetMode: TEMRSELECTCLIPPATH;
  lEmrCreatePen: TEMRCREATEPEN;
  lEmrExtCreatePen: TEMRExtCreatePen;
  lEmrCreateBrush: TEMRCREATEBRUSHINDIRECT;
  lEmrCreateFont: TEMREXTCREATEFONTINDIRECT;
  lEmrTextOut: TEMREXTTEXTOUT;
//  lEmrPolyLine: TEMRPOLYLINE;
  lEmrPolyPolyLine: TEMRPOLYPOLYLINE;
  lEmrSetViewPortEx: TEMRSETVIEWPORTEXTEX;
  lEmrSetViewPortOrgEx: TEMRSETVIEWPORTORGEX;
  lEmrSetPixelV: TEMRSETPIXELV;
  lEmrText: TEMRTEXT;
  lEmrAngleArc: TEMRANGLEARC;
  lEmrArc: TEMRARC;
  lEmrFloodFill: TEMREXTFLOODFILL;
  lEmrExtSelectClipRgn: TEMREXTSELECTCLIPRGN;
  lEMRExcludeClipRect: TEMRExcludeClipRect;
  lPWChar: PWChar;
  lPByte: PByte;
  lPAnsiChar: PAnsiChar;
  lsText: String;
  liIndex: Integer;
  lLogBrush: TLogBrush;
  lEmrBitBlt: TEMRBITBLT;
  lpRgnData: PRgnData;
  lHRgn: HRGN;
  lEmrSelectObject: TEMRSELECTOBJECT;
  lhHandle: THandle;
  lObjectType: DWord;
  lBitmap: TBitmap;
  lpBitmapInfo: PBitmapInfo;
  lHBitmap: HBITMAP;
  lpBitmapData: PChar;
  lEmrStretchBlt: TEMRStretchBlt;
  lRect: TRect;
  lPoint: TPoint;
  lPointArray: TPointArray;
  lpPointArray: PPointArray;
  lRectArray: TRectArray;
  lpSmallPointArray: PSmallPointArray;
  lIntegerArray: TIntegerArray;
  lpCountArray: PCountArray;
  lpInteger: PInteger;
  lEmrGradientFill: TEMGradientFill;
  lVertexArray: array of TTriVertex;
  lStartColor: TColor;
  lEndColor: TColor;


  lMetaPPM_X: Double;
  lMetaPPM_Y: Double;
  lScale_X: Single;
  lScale_Y: Single;

  lEmrPolyPolyLine16: TEMRPolyPolyline16;
  lEmrTransparentBlt: TEMRTRANSPARENTBLT;
  lEmrMaskBlt: TEMRMASKBLT;
  lEmrStretchDIBits: TEMRSTRETCHDIBITS;


begin

  Result := True;

  Inc(FCount);


  liEMRType := PENHMETARECORD(aPMetaRecord)^.iType;

  case liEMRType of

    EMR_HEADER:
      begin
        FEnhMetaHeader := PENHMETAHEADER(aPMetaRecord)^;

        // initialize handle table
        SetLength(FGDIObjects, FEnhMetaHeader.nHandles);

        // calc reference device resolution pixels per mm
        lMetaPPM_X := FEnhMetaHeader.szlDevice.cx / FEnhMetaHeader.szlMillimeters.cx;
        lMetaPPM_Y := FEnhMetaHeader.szlDevice.cy / FEnhMetaHeader.szlMillimeters.cy;

        // scale = (pix /  mm) / (pix/mm)
        lScale_X :=  (FRect.Right - FRect.Left) * 100.0 /
                    (FEnhMetaHeader.rclFrame.Right - FEnhMetaHeader.rclFrame.Left) / lMetaPPM_X;

        // scale = (pix /  mm) / (pix/mm)
        lScale_Y :=  (FRect.Bottom - FRect.Top) * 100.0 /
                    (FEnhMetaHeader.rclFrame.Bottom - FEnhMetaHeader.rclFrame.Top) / lMetaPPM_Y;

        // initialize view
        FMetaGraphics.InitializeView(FEnhMetaHeader.rclBounds, lScale_X, lScale_Y);

      end;

    EMR_POLYBEZIER: // 2
      begin
        TppEmrUtils.InitializePointArray(PEMRPOLYLINE(aPMetaRecord)^.aptl, PEMRPOLYLINE(aPMetaRecord)^.cptl, lPointArray);

        //FMetaGraphics.PolyBezier(lEmrPolyLine.aptl);
        FMetaGraphics.PolyBezier(lPointArray);

      end;

    EMR_POLYGON: // 3
      begin
        TppEmrUtils.InitializePointArray(PEMRPOLYLINE(aPMetaRecord)^.aptl, PEMRPOLYLINE(aPMetaRecord)^.cptl, lPointArray);

        //FMetaGraphics.Polygon(lEmrPolyLine.aptl);
        FMetaGraphics.Polygon(lPointArray);

      end;

    EMR_POLYLINE: // 4
      begin
        TppEmrUtils.InitializePointArray(PEMRPOLYLINE(aPMetaRecord)^.aptl, PEMRPOLYLINE(aPMetaRecord)^.cptl, lPointArray);

        //FMetaGraphics.PolyLine(lEmrPolyLine.aptl);
        FMetaGraphics.PolyLine(lPointArray);

      end;
    EMR_POLYBEZIERTO: // 5
      begin
        TppEmrUtils.InitializePointArray(PEMRPOLYLINE(aPMetaRecord)^.aptl, PEMRPOLYLINE(aPMetaRecord)^.cptl, lPointArray);

        //FMetaGraphics.PolyBezierTo(lEmrPolyLine.aptl);
        FMetaGraphics.PolyBezierTo(lPointArray);

      end;

    EMR_POLYLINETO: // 6
      begin
        TppEmrUtils.InitializePointArray(PEMRPOLYLINE(aPMetaRecord)^.aptl, PEMRPOLYLINE(aPMetaRecord)^.cptl, lPointArray);

        //FMetaGraphics.PolyLineTo(lEmrPolyLine.aptl);
        FMetaGraphics.PolyLineTo(lPointArray);

        // moveto last point
//        lPoint :=  lPointArray[High(lPointArray)];
        
//        FMetaGraphics.MoveTo(lPoint.X, lPoint.Y);

      end;

    EMR_POLYPOLYLINE : // 7
      begin
        lEmrPolyPolyLine := PEMRPOLYPOLYLINE(aPMetaRecord)^;

        // pointer to array of point counts for each poly
        lpInteger := @PEMRPOLYPOLYLINE(aPMetaRecord)^.aPolyCounts[0];

        // pointer to array of small points
        lpPointArray := @PEMRPOLYPOLYLINE(aPMetaRecord)^.aptl;

        // adjust paointer for number of elements in the aPolyCounts array.
        Inc(PByte(lpPointArray), SizeOf(lEmrPolyPolyLine.aPolyCounts[0]) * (lEmrPolyPolyLine.nPolys-1));

        // for each poly
        for liIndex := 0 to lEmrPolyPolyLine.nPolys-1 do
          begin

            // load array
            TppEmrUtils.InitializePointArray(lpPointArray^, lpInteger^, lPointArray);

            // draw polyline
            FMetaGraphics.PolyLine(lPointArray);

            // increment array pointer
            Inc(PByte(lpPointArray), SizeOf(lEmrPolyPolyLine.aptl[0]) * lpInteger^);

            // increment integer pointer
            Inc(PByte(lpInteger), SizeOf(lEmrPolyPolyLine.aPolyCounts[0]));

         end;

      end;

    EMR_POLYPOLYGON: // 8
      begin
      
        lEmrPolyPolyLine := PEMRPOLYPOLYLINE(aPMetaRecord)^;

        // pointer to array of points
        lpPointArray := @PEMRPOLYPOLYLINE(aPMetaRecord)^.aptl;

        // adjust pointer for length of aPolyCounts array.
        Inc(PByte(lpPointArray), SizeOf(lEmrPolyPolyLine.aPolyCounts[0]) * (lEmrPolyPolyLine.nPolys-1));

        // pointer to aPolyCounts array
        lpCountArray := @PEMRPOLYPOLYLINE16(aPMetaRecord)^.aPolyCounts;

        // initialize point array
        TppEmrUtils.InitializePointArray(lpPointArray^, lEmrPolyPolyLine.cptl, lPointArray);

        // initialize poly counts array
        TppEmrUtils.InitializeCountArray(lpCountArray^, lEmrPolyPolyLine.nPolys, lIntegerArray);

        // call metagraphics
        FMetaGraphics.PolyPolygon(lPointArray, lIntegerArray);

      end;

    EMR_SETWINDOWEXTEX: // 9
      begin
        lEmrSetViewPortEx := PEMRSETVIEWPORTEXTEX(aPMetaRecord)^;

        FMetaGraphics.SetWindowExt(lEmrSetViewPortEx.szlExtent);

      end;

    EMR_SETWINDOWORGEX: // 10
      begin
        lEmrSetViewPortOrgEx := PEMRSETVIEWPORTORGEX(aPMetaRecord)^;

        FMetaGraphics.SetWindowOrg(lEmrSetViewPortOrgEx.ptlOrigin);

      end;

    EMR_SETVIEWPORTEXTEX: // 11
      begin
        lEmrSetViewPortEx := PEMRSETVIEWPORTEXTEX(aPMetaRecord)^;

        FMetaGraphics.SetViewPortExt(lEmrSetViewPortEx.szlExtent);

      end;

    EMR_SETVIEWPORTORGEX: // 12
      begin
        lEmrSetViewPortOrgEx := PEMRSETVIEWPORTORGEX(aPMetaRecord)^;

        FMetaGraphics.SetViewportOrg(lEmrSetViewPortOrgEx.ptlOrigin);

      end;

    EMR_SETBRUSHORGEX: // 13
      begin
        lEmrSetViewPortOrgEx := PEMRSETVIEWPORTORGEX(aPMetaRecord)^;

        FMetaGraphics.SetBrushOrg(lEmrSetViewPortOrgEx.ptlOrigin);

      end;

    EMR_EOF: // 14
       ; // do nothing

    EMR_SETPIXELV: // 15
      begin
        lEmrSetPixelV := PEMRSETPIXELV(aPMetaRecord)^;

        FMetaGraphics.SetPixelColor(lEmrSetPixelV.ptlPixel, lEmrSetPixelV.crColor);

      end;

    EMR_SETMAPPERFLAGS: // 16
      begin
        FMetaGraphics.FontMapperFlags := PEMRSETMAPPERFLAGS(aPMetaRecord)^.dwFlags;
      end;

    EMR_SETMAPMODE: // 17
      begin
        FMetaGraphics.MapMode := PEMRSETMAPMODE(aPMetaRecord)^.iMode;
      end;


    EMR_SETBKMODE: // 18
      begin
        lEmrSetMode := PEMRSETBKMODE(aPMetaRecord)^;

        // Delphi handles BkMode as Brush.Style
        if (lEmrSetMode.iMode = OPAQUE) and (FMetaGraphics.Brush.Style = bsClear) then
          FMetaGraphics.Brush.Style := bsSolid
        else if (lEmrSetMode.iMode = TRANSPARENT) and (FMetaGraphics.Brush.Style =  bsSolid) then
          FMetaGraphics.Brush.Style := bsClear;  // TRANSPARENT

      end;

    EMR_SETPOLYFILLMODE: // 19
      begin
        FMetaGraphics.PolyFillMode := PEMRSETPOLYFILLMODE(aPMetaRecord)^.iMode;
      end;

    EMR_SETROP2: // 20   // Pen.Mode
      begin

        lEmrSetMode := PEMRSETROP2(aPMetaRecord)^;
        FMetaGraphics.Pen.Mode := ROP2Codes[lEmrSetMode.iMode];

      end;

    EMR_SETSTRETCHBLTMODE: // 21
      begin
        // Delphi is handling this automatically
       // FMetaGraphics.StretchBltMode := PEMRSETSTRETCHBLTMODE(aPMetaRecord)^.iMode;
      end;


    EMR_SETTEXTALIGN: // 22   Windows.SetTextAlign
      begin
        lEmrSetMode := PEMRSETTEXTALIGN(aPMetaRecord)^;

        FMetaGraphics.TextAlignmentFlags := lEmrSetMode.iMode;

      end;
    EMR_SETCOLORADJUSTMENT: // 23
      begin
        Result := False; // not implemented
      end;

    EMR_SETTEXTCOLOR: // 24    Font.Color
      begin
        lEmrSetTextColor := PEMRSETTEXTCOLOR(aPMetaRecord)^;
        FMetaGraphics.TextColor := TColor(lEmrSetTextColor.crColor);

      end;

    EMR_SETBKCOLOR: // 25    Brush.Color
      begin
        lEmrSetTextColor := PEMRSETBKCOLOR(aPMetaRecord)^;
        FMetaGraphics.SetBKColor(TColor(lEmrSetTextColor.crColor));

      end;

    EMR_OFFSETCLIPRGN: // 26
      begin
        lPoint := PEMROFFSETCLIPRGN(aPMetaRecord)^.ptlOffset;
        FMetaGraphics.OffsetClipRegion(lPoint.X, lPoint.Y);
      end;

    EMR_MOVETOEX: // 27
      begin
         lEmrLineTo := PEMRLINETO(aPMetaRecord)^;
         FMetaGraphics.MoveTo(lEmrLineTo.ptl.X, lEmrLineTo.ptl.Y);
      end;

    EMR_SETMETARGN: // 28
      begin
        FMetagraphics.SetMetaRgn();
      end;

    EMR_EXCLUDECLIPRECT: // 29
      begin
        Result := False;  // not implemented
      end;

    EMR_INTERSECTCLIPRECT: // 30
      begin
        lEMRExcludeClipRect := PEMRExcludeClipRect(aPMetaRecord)^;
        FMetaGraphics.IntersectClipRect(lEmrExcludeClipRect.rclClip);
      end;

    EMR_SCALEVIEWPORTEXTEX: // 31
      begin
        Result := False;  // not implemented
      end;

    EMR_SCALEWINDOWEXTEX: // 32
      begin
        Result := False;  // not implemented
      end;

    EMR_SAVEDC: // 33
      begin
        FMetagraphics.SaveDC();
      end;

    EMR_RESTOREDC: // 34
      begin
        FMetagraphics.RestoreDC();
      end;

    EMR_SETWORLDTRANSFORM: // 35
      begin
        FMetaGraphics.SetWorldTransform(PEMRSETWORLDTRANSFORM(aPMetaRecord)^.xform);
      end;

    EMR_MODIFYWORLDTRANSFORM: // 36
      begin
        FMetaGraphics.ModifyWorldTransform(PEMRMODIFYWORLDTRANSFORM(aPMetaRecord)^.xform, PEMRMODIFYWORLDTRANSFORM(aPMetaRecord)^.iMode);
      end;

    EMR_SELECTOBJECT: // 37
      begin
        lEmrSelectObject := PEMRSELECTOBJECT(aPMetaRecord)^;

        // check for stock object
        if (lEmrSelectObject.ihObject and ENHMETA_STOCK_OBJECT) > 0 then
          begin
            liIndex := lEmrSelectObject.ihObject and MAXLONG;
            lhHandle := Windows.GetStockObject(liIndex);

            lObjectType := Windows.GetObjectType(lhHandle);

             if (lObjectType = OBJ_PEN) or (lObjectType = OBJ_EXTPEN) then
                TppEmrUtils.InitializePenData(FMetaGraphics.Pen, lhHandle)
             else if lObjectType = OBJ_BRUSH then
               begin
                 TppEmrUtils.InitializeBrushData(FMetaGraphics.Brush, lhHandle);

                 // stock null brush, initialize to white and clear
                 if (FMetaGraphics.Brush.Style = bsClear) then
                  begin
                    FMetaGraphics.Brush.Color := clWhite;
                    FMetaGraphics.Brush.Style := bsClear;
                  end;

               end
             else if lObjectType = OBJ_FONT then
               begin
                 FMetaGraphics.Font.Handle := lhHandle;
                 FMetaGraphics.FontAngle := 0;
               end;

          end
        else
          begin
            liIndex := lEmrSelectObject.ihObject;

            case FGDIObjects[liIndex].GDIObjectType of

              gdiPen:
                TppEmrUtils.InitializePenData(FMetaGraphics.Pen, FGDIObjects[liIndex].Handle);
              gdiBrush:
                TppEmrUtils.InitializeBrushData(FMetaGraphics.Brush, FGDIObjects[liIndex].Handle);
              gdiFont:
                begin
                  FMetaGraphics.Font := FGDIObjects[liIndex].Font;
                  FMetaGraphics.FontAngle := FGDIObjects[liIndex].FontAngle;
                end;

            end;
          end;

      end;

    EMR_CREATEPEN: // 38          CreatePen
      begin
         lEmrCreatePen := PEMRCREATEPEN(aPMetaRecord)^;

         lhHandle := CreatePenIndirect(lEmrCreatePen.lopn); // auto-convert to TPen

         FGDIObjects[lEmrCreatePen.ihPen] := TppMetaGDIObject.Create(lhHandle, gdiPen);

      end;

    EMR_CREATEBRUSHINDIRECT: // 39      CreateBrush
      begin
         lEmrCreateBrush := PEMRCREATEBRUSHINDIRECT(aPMetaRecord)^;

         lhHandle := CreateBrushIndirect(lEmrCreateBrush.lb);  // auto-convert to TBrush

         FGDIObjects[lEmrCreateBrush.ihBrush] := TppMetaGDIObject.Create(lhHandle, gdiBrush);

      end;
    EMR_DELETEOBJECT: // 40
      begin
        liIndex := PEMRDELETEOBJECT(aPMetaRecord)^.ihObject;

        FGDIObjects[liIndex].Free;
        FGDIObjects[liIndex] := nil;

      end;

    EMR_ANGLEARC: // 41
      begin
        lEmrAngleArc := PEMRANGLEARC(aPMetaRecord)^;
        FMetaGraphics.AngleArc(lEmrAngleArc.ptlCenter, lEmrAngleArc.nRadius, lEmrAngleArc.eStartAngle, lEmrAngleArc.eSweepAngle);

      end;
    EMR_ELLIPSE: // 42
      begin
        FMetaGraphics.Ellipse(PEMRELLIPSE(aPMetaRecord)^.rclBox);

      end;
    EMR_RECTANGLE: // 43
      begin
        FMetaGraphics.Rectangle(PEMRRECTANGLE(aPMetaRecord)^.rclBox);
      end;

    EMR_ROUNDRECT: // 44
      begin
        FMetaGraphics.RoundRect(PEMRROUNDRECT(aPMetaRecord)^.rclBox, PEMRROUNDRECT(aPMetaRecord)^.szlCorner);
      end;

    EMR_ARC: // 45
      begin
        lEmrArc :=  PEMRARC(aPMetaRecord)^;
        FMetaGraphics.Arc(lEmrArc.rclBox, lEmrArc.ptlStart, lEmrArc.ptlEnd);
      end;

    EMR_CHORD: // 46
      begin
        lEmrArc :=  PEMRARC(aPMetaRecord)^;
        FMetaGraphics.Chord(lEmrArc.rclBox, lEmrArc.ptlStart, lEmrArc.ptlEnd);
      end;
    EMR_PIE: // 47
      begin
        lEmrArc := PEMRARC(aPMetaRecord)^;
        FMetaGraphics.Pie(lEmrArc.rclBox, lEmrArc.ptlStart, lEmrArc.ptlEnd);
      end;

    EMR_SELECTPALETTE: // 48
      begin
        Result := False;  // not implemented
      end;

    EMR_CREATEPALETTE: // 49
      begin
        Result := False;  // not implemented
      end;

    EMR_SETPALETTEENTRIES: // 50
      begin
        Result := False;  // not implemented
      end;

    EMR_RESIZEPALETTE: // 51
      begin
        Result := False;  // not implemented
      end;

    EMR_REALIZEPALETTE: // 52
      begin
        Result := False;  // not implemented
      end;

    EMR_EXTFLOODFILL: // 53
      begin
        lEmrFloodFill := PEMREXTFLOODFILL(aPMetaRecord)^;
        FMetaGraphics.FloodFill(lEmrFloodFill.ptlStart, lEmrFloodFill.crColor, lEmrFloodFill.iMode);
      end;

    EMR_LINETO: // 54             LineTo
      begin
        lEmrLineTo := PEMRLINETO(aPMetaRecord)^;
        FMetaGraphics.LineTo(lEmrLineTo.ptl.X, lEmrLineTo.ptl.Y);
      end;

    EMR_ARCTO: // 55
      begin
        lEmrArc :=  PEMRARC(aPMetaRecord)^;
        FMetaGraphics.LineTo(lEmrArc.ptlStart.X, lEmrArc.ptlStart.Y);
        FMetaGraphics.Arc(lEmrArc.rclBox, lEmrArc.ptlStart, lEmrArc.ptlEnd);
        FMetaGraphics.MoveTo(lEmrArc.ptlEnd.X, lEmrArc.ptlEnd.Y);
      end;

    EMR_SETARCDIRECTION: // 57
      begin
        FMetaGraphics.ArcDirection :=  PEMRSETARCDIRECTION(aPMetaRecord)^.iArcDirection;
      end;

    EMR_SETMITERLIMIT: // 58
      begin
        Result := False;  // not implemented
      end;

    EMR_BEGINPATH: // 59
      begin
        FMetaGraphics.BeginPath;
      end;

    EMR_ENDPATH: // 60
      begin
        FMetaGraphics.EndPath;
      end;

    EMR_CLOSEFIGURE: // 61
      begin
        FMetaGraphics.CloseFigure;
      end;

    EMR_FILLPATH: // 62
      begin
        FMetaGraphics.FillPath;
      end;

    EMR_STROKEANDFILLPATH: // 63
      begin
        Result := False;  // not implemented
      end;

    EMR_STROKEPATH: // 64
      begin
        Result := False;  // not implemented
      end;

    EMR_FLATTENPATH: // 65
      begin
        Result := False;  // not implemented
      end;

    EMR_WIDENPATH: // 66
      begin
        Result := False;  // not implemented
      end;

    EMR_SELECTCLIPPATH: // 67
      begin
        lEmrSetMode := PEMRSELECTCLIPPATH(aPMetaRecord)^;
        FMetaGraphics.SelectClipPath(lEmrSetMode.iMode);
      end;

    EMR_ABORTPATH: // 68
      begin
        Result := False;  // not implemented
      end;

    EMR_GDICOMMENT: // 70
        ; // ignore

    EMR_FILLRGN: // 71
      begin
        Result := False;  // not implemented
      end;

    EMR_FRAMERGN: // 72
      begin
        Result := False;  // not implemented
      end;

    EMR_INVERTRGN: // 73
      begin
        Result := False;  // not implemented
      end;

    EMR_PAINTRGN: // 74
      begin
        Result := False;  // not implemented
      end;

    EMR_EXTSELECTCLIPRGN: // 75
       begin

         lEmrExtSelectClipRgn := PEMREXTSELECTCLIPRGN(aPMetaRecord)^;

         lpRgnData := @PEMREXTSELECTCLIPRGN(aPMetaRecord)^.RgnData;

         lRectArray := nil;
         lHRgn := 0;

         if (lEmrExtSelectClipRgn.cbRgnData > 0) then
           begin

             lHRgn := ExtCreateRegion(nil, lEmrExtSelectClipRgn.cbRgnData, lpRgnData^);

             lPByte := @lpRgnData.Buffer;

             SetLength(lRectArray, lpRgnData.rdh.nCount);

             for liIndex := 0 to lpRgnData.rdh.nCount - 1 do
               begin
                 lRectArray[liIndex].Left := PRect(lPByte)^.Left;
                 lRectArray[liIndex].Top := PRect(lPByte)^.Top;
                 lRectArray[liIndex].Right := PRect(lPByte)^.Right;
                 lRectArray[liIndex].Bottom := PRect(lPByte)^.Bottom;

                 Inc(lPByte, SizeOf(TRect));

               end;

           end;

         FMetaGraphics.ExtSelectClipRgn(lHRgn, lpRgnData, lEmrExtSelectClipRgn.iMode, lRectArray);

         DeleteObject(lHRgn);

       end;

    EMR_BITBLT: // 76
      begin

        lEmrBitBlt := PEMRBITBLT(aPMetaRecord)^;

        if lEmrBitBlt.cbBitsSrc = 0 then
          begin
            lRect := Rect(lEmrBitBlt.xDest, lEmrBitBlt.yDest, lEmrBitBlt.xDest + lEmrBitBlt.cxDest, lEmrBitBlt.yDest + lEmrBitBlt.cyDest);

            FMetaGraphics.PatBlt(lRect, lEmrBitBlt.dwRop);
          end
        else
          begin
            // initialize TBitmap
            lBitmap := TBitmap.Create;
            lBitmap.Width := lEmrBitBlt.cxDest;
            lBitmap.Height := lEmrBitBlt.cyDest;

            // initialize lpBitmapInfo
            lPByte := aPMetaRecord;
            Inc(lPByte, lEmrBitBlt.offBmiSrc); // pointer to start of bitmap info header
            lpBitmapInfo := PBitmapInfo(lPByte);

            // initialize lpBitmapData
            lPByte := aPMetaRecord;
            Inc(lPByte, lEmrBitBlt.offBitsSrc); // pointer to start of bitmap bits
            lpBitmapData := PChar(lpByte);

            // create DIB
            lHBitmap := Windows.CreateDIBitmap(lBitmap.Canvas.Handle,
                                               lpBitmapInfo^.bmiHeader,
                                               CBM_INIT,
                                               lpBitmapData,
                                               lpBitmapInfo^,
                                               lEmrBitBlt.iUsageSrc);

            // assign handle to TBitmap
            lBitmap.Handle := lHBitmap;

            // TODO: set world transform
            //lEmrBitBlt.xformSrc

            // render to meta graphics
            FMetaGraphics.CopyMode := lEmrBitBlt.dwRop;
    //        FMetaGraphics.Brush.Color :=
            FMetaGraphics.Draw(lEmrBitBlt.xDest, lEmrBitBlt.yDest, lBitmap);

            // free resources
            lBitmap.Free;
            Windows.DeleteObject(lHBitmap);

          end;


      end;

    EMR_STRETCHBLT: // 77
      begin

        lEmrStretchBlt := PEMRSTRETCHBLT(aPMetaRecord)^;

        lRect := Rect(lEmrStretchBlt.xDest, lEmrStretchBlt.yDest, lEmrStretchBlt.xDest + lEmrStretchBlt.cxDest, lEmrStretchBlt.yDest + lEmrStretchBlt.cyDest);

        // initialize TBitmap
        lBitmap := TBitmap.Create;
        lBitmap.Width := lEmrStretchBlt.cxSrc;
        lBitmap.Height := lEmrStretchBlt.cySrc;
 
        // initialize lpBitmapInfo
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrStretchBlt.offBmiSrc); // pointer to start of bitmap info header
        lpBitmapInfo := PBitmapInfo(lPByte);

        // initialize lpBitmapData
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrStretchBlt.offBitsSrc); // pointer to start of bitmap bits
        lpBitmapData := PChar(lpByte);

        // create DIB
        lHBitmap := Windows.CreateDIBitmap(lBitmap.Canvas.Handle,
                                           lpBitmapInfo^.bmiHeader,
                                           CBM_INIT,
                                           lpBitmapData,
                                           lpBitmapInfo^,
                                           lEmrStretchBlt.iUsageSrc);

        // assign handle to TBitmap
        lBitmap.Handle := lHBitmap;

//        lBitmap.SaveToFile(TppFileUtils.GetApplicationFilePath + '\test.bmp');

        // render to meta graphics
        FMetaGraphics.CopyMode := lEmrStretchBlt.dwRop;
        FMetaGraphics.StretchDraw(lRect, lBitmap);

        // free resources
        lBitmap.Free;
        Windows.DeleteObject(lHBitmap);


      end;
    EMR_MASKBLT: // 78
      begin
        lEmrMaskBlt := PEMRMASKBLT(aPMetaRecord)^;
        
        // initialize TBitmap
        lBitmap := TBitmap.Create;
        lBitmap.Width := lEmrMaskBlt.cxDest;
        lBitmap.Height := lEmrMaskBlt.cyDest;
        lBitmap.Transparent := True;
        lBitmap.TransparentColor := TColor(lEmrMaskBlt.crBkColorSrc);

        // initialize lpBitmapInfo
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrMaskBlt.offBmiSrc); // pointer to start of bitmap info header
        lpBitmapInfo := PBitmapInfo(lPByte);

        // initialize lpBitmapData
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrMaskBlt.offBitsSrc); // pointer to start of bitmap bits
        lpBitmapData := PChar(lpByte);

        // create DIB
        lHBitmap := Windows.CreateDIBitmap(lBitmap.Canvas.Handle,
                                           lpBitmapInfo^.bmiHeader,
                                           CBM_INIT,
                                           lpBitmapData,
                                           lpBitmapInfo^,
                                           lEmrMaskBlt.iUsageSrc);

        // assign handle to TBitmap
        lBitmap.Handle := lHBitmap;

        // TODO: set world transform
        //lEmrMaskBlt.xformSrc

        // render to meta graphics
        FMetaGraphics.CopyMode := lEmrMaskBlt.dwRop;
//        FMetaGraphics.Brush.Color :=
        FMetaGraphics.Draw(lEmrMaskBlt.xDest, lEmrMaskBlt.yDest, lBitmap);

        // free resources
        lBitmap.Free;
        Windows.DeleteObject(lHBitmap);

      end;
    EMR_PLGBLT: // 79
      begin
        Result := False;  // not implemented
      end;

    EMR_SETDIBITSTODEVICE: // 80
      begin
        Result := False;  // not implemented
      end;

    EMR_STRETCHDIBITS: // 81
      begin
        lEmrStretchDIBits := PEMRSTRETCHDIBITS(aPMetaRecord)^;

        lRect := Rect(lEmrStretchDIBits.xDest, lEmrStretchDIBits.yDest, lEmrStretchDIBits.xDest + lEmrStretchDIBits.cxDest, lEmrStretchDIBits.yDest + lEmrStretchDIBits.cyDest);

        // initialize TBitmap
        lBitmap := TBitmap.Create;
        lBitmap.Width := lEmrStretchDIBits.cxSrc;
        lBitmap.Height := lEmrStretchDIBits.cySrc;
 
        // initialize lpBitmapInfo
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrStretchDIBits.offBmiSrc); // pointer to start of bitmap info header
        lpBitmapInfo := PBitmapInfo(lPByte);

        // initialize lpBitmapData
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrStretchDIBits.offBitsSrc); // pointer to start of bitmap bits
        lpBitmapData := PChar(lpByte);

        // create DIB
        lHBitmap := Windows.CreateDIBitmap(lBitmap.Canvas.Handle,
                                           lpBitmapInfo^.bmiHeader,
                                           CBM_INIT,
                                           lpBitmapData,
                                           lpBitmapInfo^,
                                           lEmrStretchDIBits.iUsageSrc);

        // assign handle to TBitmap
        lBitmap.Handle := lHBitmap;

//        lBitmap.SaveToFile(TppFileUtils.GetApplicationFilePath + '\test.bmp');

        // render to meta graphics
        FMetaGraphics.CopyMode := lEmrStretchDIBits.dwRop;
        FMetaGraphics.StretchDraw(lRect, lBitmap);

        // free resources
        lBitmap.Free;
        Windows.DeleteObject(lHBitmap);


      end;

    EMR_EXTCREATEFONTINDIRECTW: // 82     CreateFont
      begin
        lEmrCreateFont := PEMREXTCREATEFONTINDIRECT(aPMetaRecord)^;

        lEmrCreateFont.elfw.elfLogFont.lfOrientation := lEmrCreateFont.elfw.elfLogFont.lfEscapement;

        lhHandle := CreateFontIndirectW(lEmrCreateFont.elfw.elfLogFont); // auto convert to TFont

        FGDIObjects[lEmrCreateFont.ihFont] := TppMetaGDIObject.Create(lhHandle, gdiFont);
        FGDIObjects[lEmrCreateFont.ihFont].FontAngle := lEmrCreateFont.elfw.elfLogFont.lfEscapement;

      end;

    EMR_EXTTEXTOUTA: // 83
      begin
        lEmrTextOut := PEMREXTTEXTOUT(aPMetaRecord)^;
        lEmrText := lEmrTextOut.emrtext;

        // initialize pointer to string
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrText.offString); // pointer to start of ansi string buffer
        lPAnsiChar := PAnsiChar(lPByte);

        lsText := String(AnsiString(lPAnsiChar));

        // iniitialize pointer to intercharacter spacing array
        if (lEmrText.offDx > 0) then
           begin
             lPByte := aPMetaRecord;
             Inc(lPByte, lEmrText.offDx); // pointer to start of optional intercharacter spacing aray
             lPInteger := PInteger(lPByte);
             TppEmrUtils.InitializeIntegerArray(lPInteger^, lEmrText.nChars, lIntegerArray);
           end
         else
           SetLength(lIntegerArray, 0);


         FMetaGraphics.TextFlags := lEmrText.fOptions;

         if (FMetaGraphics.TextFlags and ETO_OPAQUE) > 0 then
           FMetaGraphics.Brush.Style := bsSolid;

         FMetaGraphics.TextRect(lEmrText.rcl, lEmrText.ptlReference.X, lEmrText.ptlReference.Y, lsText, lIntegerArray);

      end;

    EMR_EXTTEXTOUTW: // 84
      begin
        lEmrTextOut := PEMREXTTEXTOUT(aPMetaRecord)^;
        lEmrText := lEmrTextOut.emrtext;

        // initialize pointer to string
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrText.offString); // pointer to start of widestring buffer

        lpWChar := PWChar(lPByte);
{$IFNDEF UNICODE}
        if FMetagraphics.Font.Charset = 2 then
          lsText := ppUnicodeSymbolsToAnsi(lpWChar, lEmrText.nChars)
        else
{$ENDIF}
          lsText := WideCharLenToString(lpWChar, lEmrText.nChars);

        // iniitialize pointer to intercharacter spacing array
         if (lEmrText.offDx > 0) then
           begin
             lPByte := aPMetaRecord;
             Inc(lPByte, lEmrText.offDx); // pointer to start of optional intercharacter spacing aray

             lPInteger := PInteger(lPByte);
             TppEmrUtils.InitializeIntegerArray(lPInteger^, lEmrText.nChars, lIntegerArray);
           end
         else
           SetLength(lIntegerArray, 0);

         FMetaGraphics.TextFlags := lEmrText.fOptions;

         if (FMetaGraphics.TextFlags and ETO_OPAQUE) > 0 then
           FMetaGraphics.Brush.Style := bsSolid;

         FMetaGraphics.TextRect(lEmrTextOut.rclBounds, lEmrText.ptlReference.X, lEmrText.ptlReference.Y, lsText, lIntegerArray);

      end;
    EMR_POLYBEZIER16: // 85
      begin
        TppEmrUtils.InitializePointArray16(PEMRPolyline16(aPMetaRecord)^.apts, PEMRPolyline16(aPMetaRecord)^.cpts, lPointArray);

        FMetaGraphics.PolyBezier(lPointArray);

      end;

    EMR_POLYGON16: // 86
      begin
        TppEmrUtils.InitializePointArray16(PEMRPolyline16(aPMetaRecord)^.apts, PEMRPolyline16(aPMetaRecord)^.cpts, lPointArray);

        FMetaGraphics.Polygon(lPointArray);

      end;

   EMR_POLYLINE16: // 87
      begin

        TppEmrUtils.InitializePointArray16(PEMRPolyline16(aPMetaRecord)^.apts, PEMRPolyline16(aPMetaRecord)^.cpts, lPointArray);

        FMetaGraphics.PolyLine(lPointArray);

      end;
    EMR_POLYBEZIERTO16: // 88
      begin
        TppEmrUtils.InitializePointArray16(PEMRPolyline16(aPMetaRecord)^.apts, PEMRPolyline16(aPMetaRecord)^.cpts, lPointArray);

        FMetaGraphics.PolyBezierTo(lPointArray);

//        lPoint := lPointArray[High(lPointArray)];
//        FMetaGraphics.MoveTo(lPoint.X, lPoint.Y);

      end;
    EMR_POLYLINETO16: // 89
      begin
        TppEmrUtils.InitializePointArray16(PEMRPolyline16(aPMetaRecord)^.apts, PEMRPolyline16(aPMetaRecord)^.cpts, lPointArray);

        FMetaGraphics.PolyLineTo(lPointArray);

//        lPoint := lPointArray[High(lPointArray)];
//        FMetaGraphics.MoveTo(lPoint.X, lPoint.Y);

      end;

    EMR_POLYPOLYLINE16: // 90
      begin

        lEmrPolyPolyLine16 := PEMRPOLYPOLYLINE16(aPMetaRecord)^;

        // pointer to array of point counts for each poly
        lpInteger := @PEMRPOLYPOLYLINE16(aPMetaRecord)^.aPolyCounts[0];

        // pointer to array of small points
        lpSmallPointArray := @PEMRPOLYPOLYLINE16(aPMetaRecord)^.apts;

        // adjust pointer for number of elements in the aPolyCounts array.
        Inc(PByte(lpSmallPointArray), SizeOf(lEmrPolyPolyLine16.aPolyCounts[0]) * (lEmrPolyPolyLine16.nPolys-1));


        // for each poly
        for liIndex := 0 to lEmrPolyPolyLine16.nPolys-1 do
          begin

            // load array
            TppEmrUtils.InitializePointArray16(lpSmallPointArray^, lpInteger^, lPointArray);

            // draw polyline
            FMetaGraphics.PolyLine(lPointArray);

            // increment array pointer
            Inc(PByte(lpSmallPointArray), SizeOf(lEmrPolyPolyLine16.apts[0]) * lpInteger^);

            // increment integer pointer
            Inc(PByte(lpInteger), SizeOf(lEmrPolyPolyLine16.aPolyCounts[0]));

         end;


      end;

    EMR_POLYPOLYGON16: // 91
      begin

        lEmrPolyPolyLine16 := PEMRPOLYPOLYLINE16(aPMetaRecord)^;

        // pointer to array of small points
        lpSmallPointArray := @PEMRPOLYPOLYLINE16(aPMetaRecord)^.apts;

        // adjust pointer for number of elements in the aPolyCounts array.
        Inc(PByte(lpSmallPointArray), SizeOf(lEmrPolyPolyLine16.aPolyCounts[0]) * (lEmrPolyPolyLine16.nPolys-1));

        // pointer to aPolyCounts array
        lpCountArray := @PEMRPOLYPOLYLINE16(aPMetaRecord)^.aPolyCounts;

        // copy points to lPointArray
        TppEmrUtils.InitializePointArray16(lpSmallPointArray^, lEmrPolyPolyLine16.cpts, lPointArray);

        // copy counts to lIntegerArray
        TppEmrUtils.InitializeCountArray(lpCountArray^, lEmrPolyPolyLine16.nPolys, lIntegerArray);

        // call meta graphics
        FMetaGraphics.PolyPolygon(lPointArray, lIntegerArray);

      end;
    EMR_POLYDRAW16: // 92
      begin
        Result := False;  // not implemented
      end;

    EMR_CREATEMONOBRUSH: // 93
      begin
        Result := False;  // not implemented
      end;

    EMR_CREATEDIBPATTERNBRUSHPT: // 94
      begin
        Result := False;  // not implemented
      end;

    EMR_EXTCREATEPEN: // 95
      begin

         lEmrExtCreatePen := PEMRExtCreatePen(aPMetaRecord)^;

         lLogBrush.lbStyle := lEmrExtCreatePen.elp.elpBrushStyle;
         lLogBrush.lbColor := TColor(lEmrExtCreatePen.elp.elpColor);
         lLogBrush.lbHatch := lEmrExtCreatePen.elp.elpHatch;

         //FMetaGraphics.Brush.Handle := CreateBrushIndirect(lLogBrush);
         lhHandle := Windows.ExtCreatePen(lEmrExtCreatePen.elp.elpPenStyle,
                                                  lEmrExtCreatePen.elp.elpWidth,
                                                  lLogBrush,
                                                  lEmrExtCreatePen.elp.elpNumEntries,
                                                  Pointer(PEMRExtCreatePen(aPMetaRecord)^.elp.elpStyleEntry));

         FGDIObjects[lEmrExtCreatePen.ihPen] := TppMetaGDIObject.Create(lhHandle, gdiPen);

      end;
    EMR_POLYTEXTOUTA: // 96
      begin
        Result := False;  // not implemented
      end;

    EMR_POLYTEXTOUTW: // 97
      begin
        Result := False;  // not implemented
      end;

    EMR_SETICMMODE: // 98
      begin
        Result := False;  // not implemented
      end;

    EMR_CREATECOLORSPACE: // 99;
      begin
        Result := False;  // not implemented
      end;

    EMR_SETCOLORSPACE: // 100;
      begin
        Result := False;  // not implemented
      end;

    EMR_DELETECOLORSPACE: // 101;
      begin
        Result := False;  // not implemented
      end;

    EMR_GLSRECORD: // 102
      begin
        Result := False;  // not implemented
      end;

    EMR_GLSBOUNDEDRECORD: // 103
      begin
        Result := False;  // not implemented
      end;

    EMR_PIXELFORMAT: // 104
      begin
        Result := False;  // not implemented
      end;

    EMR_DRAWESCAPE: // 105
      begin
        Result := False;  // not implemented
      end;

    EMR_EXTESCAPE: // 106
      begin
        Result := False;  // not implemented
      end;

    EMR_STARTDOC: // 107
      begin
        Result := False;  // not implemented
      end;

    EMR_SMALLTEXTOUT: // 108
      begin
        Result := False; // not implemented
      end;

    EMR_FORCEUFIMAPPING: // 109
      begin
        Result := False;  // not implemented
      end;

    EMR_NAMEDESCAPE: // 110
      begin
        Result := False; // not implemented
      end;

    EMR_COLORCORRECTPALETTE: // 111
      begin
        Result := False;  // not implemented
      end;

    EMR_SETICMPROFILEA: // 112
      begin
        Result := False;  // not implemented
      end;

    EMR_SETICMPROFILEW: // 113
      begin
        Result := False;  // not implemented
      end;

    EMR_ALPHABLEND: // 114
      begin
        Result := False;  // not implemented
      end;

    EMR_ALPHADIBBLEND: // 115
      begin
        Result := False;  // not implemented
      end;

    EMR_TRANSPARENTBLT: // 116
      begin
        lEmrTransparentBlt := PEMRTRANSPARENTBLT(aPMetaRecord)^;

        // initialize TBitmap
        lBitmap := TBitmap.Create;
        lBitmap.Width := lEmrTransparentBlt.cxDest;
        lBitmap.Height := lEmrTransparentBlt.cyDest;
        lBitmap.Transparent := True;
        lBitmap.TransparentColor := TColor(lEmrTransparentBlt.dwRop);

        // initialize lpBitmapInfo
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrTransparentBlt.offBmiSrc); // pointer to start of bitmap info header
        lpBitmapInfo := PBitmapInfo(lPByte);

        // initialize lpBitmapData
        lPByte := aPMetaRecord;
        Inc(lPByte, lEmrTransparentBlt.offBitsSrc); // pointer to start of bitmap bits
        lpBitmapData := PChar(lpByte);

        // create DIB
        lHBitmap := Windows.CreateDIBitmap(lBitmap.Canvas.Handle,
                                           lpBitmapInfo^.bmiHeader,
                                           CBM_INIT,
                                           lpBitmapData,
                                           lpBitmapInfo^,
                                           lEmrTransparentBlt.iUsageSrc);

        // assign handle to TBitmap
        lBitmap.Handle := lHBitmap;

        // TODO: set world transform
        //lEmrBitBlt.xformSrc

        // render to meta graphics
        FMetaGraphics.CopyMode := cmSrcAnd;
//        FMetaGraphics.Brush.Color :=
        FMetaGraphics.Draw(lEmrTransparentBlt.xDest, lEmrTransparentBlt.yDest, lBitmap);

        // free resources
        lBitmap.Free;
        Windows.DeleteObject(lHBitmap);

      end;
    EMR_TRANSPARENTDIB: // 117
      begin
        Result := False;  // not implemented
      end;

    EMR_GRADIENTFILL: // 118
      begin
        lEmrGradientFill := PEMGradientFill(aPMetaRecord)^;

        if (lEmrGradientFill.nVer > 2) or (lEmrGradientFill.nTri > 2) then
          begin
            Result := False;
            exit;
          end;

        SetLength(lVertexArray, lEmrGradientFill.nVer);
        lpByte := @PEMGradientFill(aPMetaRecord)^.Ver;

        for liIndex := 0 to lEmrGradientFill.nVer - 1 do
          begin
            lVertexArray[liIndex].x := PTriVertex(lpByte)^.x;
            lVertexArray[liIndex].y := PTriVertex(lpByte)^.y;
            lVertexArray[liIndex].Red := PTriVertex(lpByte)^.Red;
            lVertexArray[liIndex].Green := PTriVertex(lpByte)^.Green;
            lVertexArray[liIndex].Blue := PTriVertex(lpByte)^.Blue;
            lVertexArray[liIndex].Alpha := PTriVertex(lpByte)^.Alpha;

            Inc(lPByte, SizeOf(TTriVertex));
          end;

        lStartColor := TColor( RGB(lVertexArray[0].Red shr 8, lVertexArray[0].Green shr 8, lVertexArray[0].Blue shr 8));
        lEndColor := TColor( RGB(lVertexArray[1].Red shr 8, lVertexArray[1].Green shr 8, lVertexArray[1].Blue shr 8));

        lRect := lEmrGradientFill.rclBounds;

        FMetaGraphics.GradientFill(lRect, lStartColor, lEndColor, lEmrGradientFill.ulMode);

      end;

    EMR_SETLINKEDUFIS: // 119
      begin
        Result := False;  // not implemented
      end;

    EMR_SETTEXTJUSTIFICATION: // 120
      begin
        Result := False;  // not implemented
      end;
    else
      FErrorLog.Add(IntToStr(liEMRType));


  end;


end;

constructor TppMetaGDIObject.Create(aHandle: THandle; aGDIObjecType: TppGDIObjectType);
begin

  inherited Create;

  FHandle := aHandle;

  FGDIObjectType := aGDIObjecType;

  case aGDIObjecType of
    gdiFont:
      begin
        FFont := TFont.Create;
        FFont.Handle := FHandle;
      end;
    gdiBrush:
      begin
        FBrush := TBrush.Create;
        FBrush.Handle := FHandle;
      end;
    gdiPen:
      begin
        FPen := TPen.Create;
        FPen.Handle := FHandle;
      end;

  end;
  
end;

destructor TppMetaGDIObject.Destroy;
begin
  inherited;
  FBrush.Free;
  FPen.Free;
  Font.Free;
end;

{$IFDEF Delphi9}
class procedure TppEmrUtils.InitializeBrushData(aBrush: TBrush; aHBrush: HBrush);
begin
  aBrush.Handle := aHBrush;

end;

{$ELSE}

class procedure TppEmrUtils.InitializeBrushData(aBrush: TBrush; aHBrush: HBrush);
var
  lLogBrush: TLogBrush;
begin

  Windows.GetObject(aHBrush, SizeOf(TLogBrush), @lLogBrush);

  aBrush.Color := TColor(lLogBrush.lbColor);

  case lLogBrush.lbStyle of
    BS_SOLID:
      aBrush.Style := bsSolid;
    BS_HOLLOW:
      aBrush.Style := bsClear;
    BS_PATTERN:
      begin
        if not Assigned(aBrush.Bitmap) then
          aBrush.Bitmap := TBitmap.Create;
        aBrush.Bitmap.Handle := lLogBrush.lbHatch
      end;
    else
      aBrush.Style := TBrushStyle(lLogBrush.lbHatch + Ord(bsHorizontal));
    end;


end;

{$ENDIF}

{$IFDEF Delphi9}
class procedure TppEmrUtils.InitializePenData(aPen: TPen; aHPen: HPen);
begin
  aPen.Handle := aHPen;

end;

{$ELSE}


class procedure TppEmrUtils.InitializePenData(aPen: TPen; aHPen: HPen);
const
  LogPenStyles: array[0..6] of TPenStyle = (psSolid, psDash, psDot, psDashDot,
                                            psDashDotDot, psClear, psInsideFrame);
var
  lLogPen: TLogPen;
  liSize: Integer;
  lPExtLogPen: ^TExtLogPen;
begin

  liSize := GetObject(aHPen, 0, nil); // get size

  if liSize = SizeOf(TLogPen) then // std pen
    begin
      GetObject(aHPen, SizeOf(TLogPen), @lLogPen);
      aPen.Color := TColor(lLogPen.lopnColor);
      aPen.Style := LogPenStyles[lLogPen.lopnStyle];
      aPen.Width := lLogPen.lopnWidth.X;
    end
  else if liSize >= SizeOf(TExtLogPen) then // ext pen
    begin
      GetMem(lPExtLogPen, liSize);
      try
        GetObject(aHPen, liSize, lPExtLogPen);
        aPen.Color := TColor(lPExtLogPen^.elpColor);
        aPen.Style := LogPenStyles[lPExtLogPen^.elpPenStyle and PS_STYLE_MASK];
        aPen.Width := lPExtLogPen^.elpWidth;
      finally
        FreeMem(lPExtLogPen);
      end;
    end;


end;

{$ENDIF}

class procedure TppEmrUtils.InitializePointArray(const aSource: array of TPoint; aCount: Integer; var aPointArray: TPointArray);
var
  lPByte: PByte;
  liIndex: Integer;
begin

  lPByte := @aSource;

  SetLength(aPointArray, aCount);

  for liIndex := 0 to aCount-1 do
    begin
      aPointArray[liIndex].X := PPoint(lPByte)^.X;
      aPointArray[liIndex].Y := PPoint(lPByte)^.Y;

      Inc(lPByte, SizeOf(TPoint));

    end;

end;

class procedure TppEmrUtils.InitializeCountarray(const aSource: array of DWord; aCount: Integer; var aCountArray: TIntegerArray);
var
  lPByte: PByte;
  liIndex: Integer;
begin

  lPByte := @aSource;

  SetLength(aCountArray, aCount);

  for liIndex := 0 to aCount-1 do
    begin
      aCountArray[liIndex] := PInteger(lPByte)^;

      Inc(lPByte, SizeOf(DWord));

    end;

end;

class procedure TppEmrUtils.InitializeIntegerArray(const aSource: array of Integer; aCount: Integer; var aIntegerArray: TIntegerArray);
var
  lPByte: PByte;
  liIndex: Integer;
begin

  lPByte := @aSource;

  SetLength(aIntegerArray, aCount);

  for liIndex := 0 to aCount-1 do
    begin
      aIntegerArray[liIndex] := PInteger(lPByte)^;

      Inc(lPByte, SizeOf(Integer));

    end;

end;


class procedure TppEmrUtils.InitializePointArray16(const aSource: array of TSmallPoint; aCount: Integer; var aPointArray: TPointArray);
var
  lPByte: PByte;
  liIndex: Integer;
begin

  lPByte := @aSource;

  SetLength(aPointArray, aCount);

  for liIndex := 0 to aCount-1 do
    begin
      aPointArray[liIndex].X := PSmallPoint(lPByte)^.X;
      aPointArray[liIndex].Y := PSmallPoint(lPByte)^.Y;

      Inc(lPByte, SizeOf(TSmallPoint));

    end;
end;

end.
