{ *************************************************************************** }
{                                                                             }
{  Gnostice Shared Visual Component Library                                   }
{                                                                             }
{  Copyright © 2002-2008 Gnostice Information Technologies Private Limited    }
{  http://www.gnostice.com                                                    }
{                                                                             }
{ *************************************************************************** }

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

unit gtPDFFont;

interface
uses
  Windows, Classes, Graphics, SysUtils, gtClasses, Math;

  function GetACPCharset: TFontCharset;
  
type

{------------------------------------------------------------------------------}
                             {TgtPDFFontInfo}
{------------------------------------------------------------------------------}

	TgtFontType = (ftTrueType, ftType1, ftStdType1);

(* Holds font metrics while exporting to PDF. *)
	TgtPDFFontInfo = class(TObject)
  public
		FfiFontObjRef: Integer;
    FfiWidths: array[32..255] of Integer; (* Required only for ANSI fonts. *)
		FfiFlags: Integer;
		FfiFontBBox: TRect;
		FfiAscent: Double;
		FfiDescent: Double;
		FfiCapHeight: Double;
		FfiAvgWidth: Integer;
		FfiMaxWidth: Integer;
		FfiStemV: Integer;
		FfiItalicAngle: Integer;
		FfiStrikeoutSize: Double;
		FfiStrikeoutPosition: Double;
		FfiUnderscoreSize: Double;
		FfiUnderscorePosition: Double;
    FfiType: TgtFontType; (* Indicates whether the font is TT or Type1 *)
    FfiIsFixedPitch: Boolean;

    constructor Create(AFont: TFont);

	end;

{------------------------------------------------------------------------------}
                             {TgtPDFFont}
{------------------------------------------------------------------------------}
  (*
    Holds information about fonts that are used in the created PDF file.
    Contains information required for Type1,
      TrueType (Without Font Embedding) fonts.
  *)
  TgtPDFFont = class(TObject)
  private
    FBaseFont: String;

    FPDFCMap: String;
    FSubset: Boolean;
    (*
      Required for Font Subsetting.
      Holds Character codes of included characters ONLY.
    *)
    FRequiredTables: array[0..9] of String;
    FIncludedCharCode: TList;
    FOutFont : TgtExtMemStream;
    FTableData : TgtExtMemStream;
    FGlyfOut : TgtExtMemStream;
    FLocaOut : TgtExtMemStream;
    FTableOutCount: Integer;
    FTableOffset, FTableLength, FTableChecksum : array of Cardinal;    
    FLocaOffset, FGlyfOffset: Cardinal;
    FNumGlyphs : Word;
    FLocaIsLong : Boolean;

    procedure FillFontMetrics(ASubset: Boolean = False; ACharset: Boolean = True);
    function IsTrueType(ACharset: Boolean = True): Boolean;
    function SetBaseFont: String;

    (* Check for DEFAULT_CHARSET and ANSI CodePage *)
    function IsAnsiCharset: Boolean;
    (*
      Get Codepage of Charset.
      Used in StringToUnicodeString.
    *)
    function GetCodePage(AFontCharset: TFontCharset): Integer;
    (* Get Unicode Value of given String. *)
		function StringToUnicodeString(AStr: AnsiString;
      AFontCharset: TFontCharset): WideString;

    (* Methods to extract CMap information. *)
    procedure GetFontCMapDetails;

    (* Methods to extract glyph width information. *)
    procedure ReadGlyphWidths;
    procedure SetSubset(const Value: Boolean);

    (* Required for Font Subsetting. *)
    (*
      This method grabs infomration about Table Dictionaries in the font.
    *)
    procedure ReadTable(AStream: TgtExtMemStream);
    function GetCheckSum(AStream : TgtExtMemStream) : Integer;
    (* Function to check whether the current glyph needs to be embedded. *)
    function HasChar(ACharCode : Word) : Boolean;
    function IsTableNeeded(AString: String): Boolean;
    procedure SubsetInitialize;
    procedure SubsetFinalize;
    function WriteLocaAndGlyf(AStream: TgtExtMemStream): Boolean;
    procedure WriteTable;

  protected
    FFont: TFont;
    FFontInfo: TgtPDFFontInfo;

  public
    (*
      For Subset problem occurs if /Widths is not included.
      In Base Font processor, font subsetting is not supported. Hence
        ASubset = False by default.
      For ExtFont, which supports subset, pass ASubset = True if font is being
        subsetted such that /Widths will be calculated.
    *)
    FCID: TList; (* Required only for CID (Non-ANSI) fonts. *)
    FCharCode: TList; (* Required only for CID (Non-ANSI) fonts. *)
    FWidths: TStringList; (* Required only for CID (Non-ANSI) fonts. *)

    constructor Create(AFont: TFont; AFontObjRef: Integer;
      ASubset: Boolean = False; ACharset: Boolean = True);
    destructor Destroy; override;

    procedure AddString(AString: String);
    procedure AddCharCodes(ACharCode: String);

    (* Get Subset Font Data. *)
    procedure GetFontFile2Subset(var AStream: TgtExtMemStream);

    function GetCIDFontDictionary(AFontDescriptorRef: String): String;

    (* Get CMap Stream (Identity-H). *)
    procedure GetCMap(AMemStream: TMemoryStream);

    function GetFontDescriptor(AFontFile2Obj: String): String;
    function GetGlyphIndiciesA(AStr: WideString;
       ACharset: TFontCharset): String;
    function GetGlyphIndiciesW(AStr: WideString;
      ACharset: TFontCharset): String;
    function GetGlyphIndiciesForNonANSI(AStr: WideString;
      ACharset: TFontCharset): String;

    function GetType0FontDictionary(AFontNo: Integer; AUnicodeObjRef,
      ADesFontObjRef: String): String;

    property Widths: TStringList read FWidths;

    (* Get Font Data. *)
    procedure GetFontFile2(var AStream: TMemoryStream);
    (*
      Method to check if the current font exists in the list.
        Condition to be checked -
          ACurrentFont.Name = AFont.Name
                    AND
          ACurrentFont.Charset = AFont.Charset
                    AND
          ACurrentFont.Style = AFont.Style
    *)
    function IsEqual(AFont: TFont): Boolean;
    property FontInfo: TgtPDFFontInfo read FFontInfo;
    property BaseFont: String read FBaseFont;
    property Font: TFont read FFont;
//  published
    property Subset: Boolean read FSubset write SetSubset;
  end;

implementation
uses
  gtConsts, gtUtils;

var
  (*
    Contains the current CodePage default charset.
    Required for checking whether font is TT.
  *)
  ACPCharset: TFontCharset;

function GetACPCharset: TFontCharset;
begin
  Result := 0;
  case GetACP of
    1252:
      Result := ANSI_CHARSET;
    932:
      Result := SHIFTJIS_CHARSET;
    949:
      Result := HANGEUL_CHARSET;
    1361:
      Result := JOHAB_CHARSET;
    936:
      Result := GB2312_CHARSET;
    950:
      Result := CHINESEBIG5_CHARSET;
    1253:
      Result := GREEK_CHARSET;
    1254:
      Result := TURKISH_CHARSET;
    1258:
      Result := VIETNAMESE_CHARSET;
    1255:
      Result := HEBREW_CHARSET;
    1256:
      Result := ARABIC_CHARSET;
    1257:
      Result := BALTIC_CHARSET;
    874:
      Result := THAI_CHARSET;
    1250:
      Result := EASTEUROPE_CHARSET;
    1251:
      Result := RUSSIAN_CHARSET;
  end;
end;

{ TgtPDFFont }

procedure TgtPDFFont.FillFontMetrics(ASubset: Boolean; ACharset: Boolean);
var
  LFont: TFont;
	LDC: HDC;
	LSaveFont: HFont;
	LTM: TTextMetric;
	LOTM: TOutlineTextmetric;
	LSaveMM: Integer;
  LogF: Cardinal;

	procedure FillCharWidths;
	var
		LI: Integer;
		LSize: TSize;
		LC: String;
	begin
		LSize.cx := 0;
		LSize.cy := 0;
 	  with FFontInfo do
      (*

      *)
      if FfiIsFixedPitch and (not ASubset) then
      begin
        LC := Char(Low(FfiWidths));
        GetTextExtentPoint32(LDC, PChar(LC), 1, LSize);
        FfiMaxWidth := Round(PixelsToPoints(LSize.cx));
      end
      else
        for LI := Low(FfiWidths) to High(FfiWidths) do
        begin
          LC := Chr(LI);
          GetTextExtentPoint32(LDC, PChar(LC), 1, LSize);
          FfiWidths[LI] := Round(PixelsToPoints(LSize.cx));
        end;
	end;

  (* Get Pitch & Family of Font *)
	function GetPDFFontFlags: Integer;
	begin
    Result := 0;
		with LTM do
		begin
      (*
        Check Font Pitch.
        If bit TMPF_FIXED_PITCH is set the font is NOT fixed-pitch,
				  the values are reversed. Refer Win API help on TextMetric for details.
      *)
      if ((tmPitchAndFamily and TMPF_FIXED_PITCH) = 0) then
        Result := Result + 1;
      (* Check Font Family. *)
      if ((tmPitchAndFamily and FF_ROMAN) <> 0) then
        Result := Result + 2;
      if (tmCharSet = SYMBOL_CHARSET) then
        Result := Result + 4;
      if ((tmPitchAndFamily and FF_SCRIPT) <> 0) then
        Result := Result + 8;
      if (tmCharSet <> SYMBOL_CHARSET) then
        Result := Result + 32;
      if (tmItalic <> 0) then
        Result := Result + 64;
		end;
	end;

begin
	LFont := TFont.Create;
	with FFontInfo do
    try
			with LFont do
			begin
				Charset := FFont.Charset;
				Name :=  FFont.Name;
				Size := 1000;
				Pitch := FFont.Pitch;
				Style := FFont.Style;
			end;
			LDC := GetDC(0);
			LSaveMM := GetMapMode(LDC);
			SetMapMode(LDC, MM_TEXT);
			//LSaveFont := SelectObject(LDC, LFont.Handle);
      if FFont.Name = 'Symbol' then
      begin
        LogF := CreateFont(LFont.Height, TextSize('W', LFont).cx, 0, 0, FW_REGULAR,
          0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS,
          DEFAULT_QUALITY, FF_DONTCARE, PChar('Symbol'));
        LSaveFont := SelectObject(LDC, LogF);
      end
      else
        LSaveFont := SelectObject(LDC, LFont.Handle);
			GetTextMetrics(LDC, LTM);
			with LTM do
			begin
        if (tmPitchAndFamily and TMPF_TRUETYPE <> 0) and IsTrueType(ACharset) then
          FfiType := ftTrueType
        else if ((tmPitchAndFamily and TMPF_FIXED_PITCH <> 0) and
          (tmPitchAndFamily and TMPF_VECTOR <> 0) and
          (tmPitchAndFamily and TMPF_DEVICE <> 0)) then
          FfiType := ftType1;
          
        if ((tmPitchAndFamily and TMPF_FIXED_PITCH) = 0) then
          FfiIsFixedPitch := True;
        (*
          If it is fixed-pitch font, no need to calculate widths for
          each character.
          Just set any one character width to FfiMaxWidth.
        *)
        FillCharWidths;
        
				FfiFlags := GetPDFFontFlags;
				FfiAscent := (tmAscent / CPixelsPerInch) * CInchesToPoints;
				FfiDescent := -(Abs(tmDescent) / CPixelsPerInch) * CInchesToPoints;
				FfiCapHeight := (tmAscent / CPixelsPerInch) * CInchesToPoints;
				FfiAvgWidth := tmAveCharWidth div CPixelsPerInch * CInchesToPoints;
        if not FfiIsFixedPitch then
				  FfiMaxWidth := tmMaxCharWidth div CPixelsPerInch * CInchesToPoints;
				FfiFontBBox := Rect(
					FfiFontBBox.Left,
					Round(FfiAscent),
					FfiMaxWidth,
					Round(FfiDescent));
        (*
          Checking
            (tmPitchAndFamily and TMPF_TRUETYPE) <> 0
          does not indicate properly whether the font is TrueType.
          To test try setting the font to Courier (COURE.FON).
        *)
        if FfiType = ftTrueType then
				begin
					GetOutlineTextMetrics(LDC, SizeOf(LOTM),  @LOTM);
					with LOTM do
					begin
						// Required in degrees but function returns in tenths of a degree.
						FfiItalicAngle := otmItalicAngle div 10;
						FfiStemV := 78;
						FfiStrikeoutSize := (((otmsStrikeoutSize / CPixelsPerInch)
							 * CInchesToPoints) * FFont.Size / 1000);
						FfiStrikeoutPosition := (((otmsStrikeoutPosition /
							CPixelsPerInch) * CInchesToPoints) * FFont.Size / 1000);
						FfiUnderscoreSize := (((otmsUnderscoreSize / CPixelsPerInch)
							 * CInchesToPoints) * FFont.Size / 1000);
						FfiUnderscorePosition := (((otmsUnderscorePosition /
							CPixelsPerInch) * CInchesToPoints) * FFont.Size / 1000);
					end;
				end;
				SetMapMode(LDC, LSaveMM);
				SelectObject(LDC, LSaveFont);
				ReleaseDC(0, LDC);
			end;
		finally
			FreeAndNil(LFont);
		end;
end;

function TgtPDFFont.SetBaseFont: String;
const
(* Required for mapping to Adobe Standard 14 fonts. *)
  Std14Fonts : array[0..13] of String = (
    'Times-Roman', 'Times-Bold', 'Times-Italic', 'Times-BoldItalic',
    'Helvetica', 'Helvetica-Bold', 'Helvetica-Oblique', 'Helvetica-BoldOblique',
    'Courier', 'Courier-Bold', 'Courier-Oblique', 'Courier-BoldOblique',
    'Symbol', 'ZapfDingbats');
var
(* Required for mapping to Adobe Standard 14 fonts. *)
  LDC : HDC;
  LTextMetric : TTextMetric;
  LI : Integer;
begin
  FBaseFont := '';
  if (FFontInfo.FfiType = ftTrueType) or (FFontInfo.FfiType = ftType1) then
  begin
	  FBaseFont := ReplaceString(FFont.Name, ' ', '');
    if FFont.Name <> 'Symbol' then
    begin
      if (fsBold in FFont.Style) or (fsItalic in FFont.Style) then
        FBaseFont := FBaseFont + ',';
      if (fsBold in FFont.Style) then
        FBaseFont := FBaseFont + 'Bold';
      if (fsItalic in FFont.Style) then
        FBaseFont := FBaseFont + 'Italic';
    end;
  end
  else
  (* Return Mapped Adobe Standard 14 Type1 Font Name. *)
  begin
    with FFont do
    begin
      for LI := Low(Std14Fonts) to High(Std14Fonts) do
      begin
        if FFont.Name = Std14Fonts[LI] then
        begin
          FBaseFont := Std14Fonts[LI];
          Exit;
        end;
      end;
      if (FFont.Charset = SYMBOL_CHARSET) then
      begin
        FBaseFont := Std14Fonts[13];
        Exit;
      end;
      if (FFont.Charset <> ANSI_CHARSET) and
        ((FFont.Charset <> DEFAULT_CHARSET) and (GetACP <> CANSIWinCode)) then
      begin
        FBaseFont := Std14Fonts[12];
        Exit;
      end;
      LDC := GetDC(0);
      SelectObject(LDC, FFont.Handle);
      GetTextMetrics(LDC, LTextMetric);
      ReleaseDC(0, LDC);
      LI := -1;
      with LTextMetric do
      begin
        (* Courier New. *)
        if ((tmPitchAndFamily and TMPF_FIXED_PITCH = 0) or
          (tmPitchAndFamily and FF_MODERN = FF_MODERN)) then
          LI := 11;

        (* Times. *)
        if (tmPitchAndFamily and FF_ROMAN = FF_ROMAN) then
          LI := 3;

        (* MS Sans Serif. *)
        if (tmPitchAndFamily and FF_SWISS = FF_SWISS) then
          LI := 7;

        if tmItalic = 0  then
          LI := LI - 2;
        if tmWeight < FW_BOLD then
          LI := LI - 1;

        if LI < 0 then
          FBaseFont := FFont.Name
        else
          FBaseFont := Std14Fonts[LI];
      end; (* End with LTextMetric *)
    end; (* End with FFont. *)
  end;
end;

procedure TgtPDFFont.GetFontFile2(var AStream: TMemoryStream);
var
  LDC: HDC;
  LFontStream, LogF: Cardinal;
begin
  if FFontInfo.FfiType <> ftTrueType then
    Exit;
  LDC := GetDC(0);
  if (FFont.Name = 'Symbol') or (FFont.Name = 'Wingdings') or
    (FFont.Name = 'Wingdings 2') or (FFont.Name = 'Wingdings 3') or
    (FFont.Name = 'Webdings') or (FFont.Name = 'Marlett') then
  begin
    LogF := CreateFont(FFont.Height, TextSize('W', FFont).cx, 0, 0, FW_REGULAR,
      0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS,
      DEFAULT_QUALITY, FF_DONTCARE, PChar(FFont.Name));
    SelectObject(LDC, LogF);
  end
  else
    SelectObject(LDC, FFont.Handle);
  LFontStream := GetFontData(LDC, 0, 0, nil, 0);
  if LFontStream <> GDI_ERROR then
  begin
    AStream.SetSize(LFontStream);
    GetFontData(LDC, 0, 0, AStream.Memory, LFontStream);
  end;
  ReleaseDC(0, LDC);
end;

function TgtPDFFont.IsTrueType(ACharset: Boolean): Boolean;
var
  LDC: HDC;
// LI, LJ: Integer;
  LI :LongWord;
  LJ :TFontCharset;
  LList: TList;
  LogF: Cardinal;
begin
  Result := False;
  LDC := GetDC(0);
//  SelectObject(LDC, FFont.Handle);
  if (FFont.Name = 'Symbol') or (FFont.Name = 'Wingdings') or
    (FFont.Name = 'Wingdings 2') or (FFont.Name = 'Wingdings 3') or
    (FFont.Name = 'Webdings') or (FFont.Name = 'Marlett') then
  begin
    LogF := CreateFont(FFont.Height, TextSize('W', FFont).cx, 0, 0, FW_REGULAR,
      0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS,
      DEFAULT_QUALITY, FF_DONTCARE, PChar(FFont.Name));
    SelectObject(LDC, LogF);
  end
  else
    SelectObject(LDC, FFont.Handle);
  //ToDo: Consider TTC also...
  LI := GetFontData(LDC, 0, 0, nil, 0);
  if (LI <> GDI_ERROR) then
  //if ((Cardinal(LI) <> GDI_ERROR) and (LI <> -1)) then
  begin
    Result := True;
    if (ACharset) then
    begin
      LJ := FFont.Charset;
      if (LJ = DEFAULT_CHARSET) then
        LJ := ACPCharset;
      LList := TList.Create;
      try
        GetSupportedCharSets(FFont.Name, LList);
        // Charset is Default, Font supports ONE charset only
        if ((FFont.Charset = DEFAULT_CHARSET) and (LList.Count = 1)) then
        begin
          FFont.Charset := Integer(LList.Items[0]);
          Result := True;
        end
        else
          Result := (LList.IndexOf(TObject(LJ)) <> -1);
      finally
        LList.Free;
      end;
    end;
  end;
  ReleaseDC(0, LDC);
end;

function TgtPDFFont.IsEqual(AFont: TFont): Boolean;
begin
  Result := False;
  with FFont do
  begin
    if (Name = AFont.Name) and
       (((Charset = ANSI_CHARSET) and  (AFont.Charset = ANSI_CHARSET)) or
       ((Charset <> ANSI_CHARSET) and  (AFont.Charset <> ANSI_CHARSET))) and
      (((fsBold in Style) and (fsBold in AFont.Style)) or
        (not (fsBold in Style) and not (fsBold in AFont.Style))) and
      (((fsItalic in Style) and (fsItalic in AFont.Style)) or
        (not (fsItalic in Style) and not (fsItalic in AFont.Style))) then
      Result := True;
  end;
end;

procedure TgtPDFFont.AddCharCodes(ACharCode: String);
begin
  if not FSubset then
    Exit;
end;

procedure TgtPDFFont.AddString(AString: String);
begin
  if not FSubset then
    Exit;
end;

constructor TgtPDFFont.Create(AFont: TFont; AFontObjRef: Integer;
  ASubset: Boolean; ACharset: Boolean);
begin
  FFont := TFont.Create;
  FFont.Assign(AFont);
  FFontInfo := TgtPDFFontInfo.Create(FFont);
  FFontInfo.FfiFontObjRef := AFontObjRef;
  FillFontMetrics(ASubset, ACharset);
  SetBaseFont;  
  (*
    If TrueType Font.
      If Charset isnot ANSI_CHARSET and Font Subsetting is false,
      Read CMap & Widths.
  *)
  FSubset := ASubset;
  if (FFontInfo.FfiType = ftTrueType) and (not IsAnsiCharset or FSubset) then
  begin
    FCID := TList.Create;
    FCharCode := TList.Create;
    FWidths := TStringList.Create;
    GetFontCMapDetails;
    ReadGlyphWidths;
  end
  else
  begin
    FCID := nil;
    FCharCode := nil;
    FWidths := nil;
  end;
  
  if (FFontInfo.FfiType = ftTrueType) and (FSubset) then
    FIncludedCharCode := TList.Create
  else
    FIncludedCharCode := nil;

  (* Subsetting. *)
  FOutFont := nil;
  FTableData := nil;
  FGlyfOut := nil;
  FLocaOut := nil;
end;

destructor TgtPDFFont.Destroy;
begin
  if FCID <> nil then
    FreeAndNil(FCID);

  if FCharCode <> nil then
    FreeAndNil(FCharCode);

  if FIncludedCharCode <> nil then
    FreeAndNil(FIncludedCharCode);

  if FWidths <> nil then
    FreeAndNil(FWidths);

  FreeAndNil(FFont);
  FreeAndNil(FFontInfo);
  inherited;
end;

function TgtPDFFont.GetCheckSum(AStream: TgtExtMemStream): Integer;
var
  I : Integer;
  V : array[0..3] of Byte;
begin
  AStream.Position := 0;
  V[0] := 0; V[1] := 0; V[2] := 0; V[3] := 0;
  for I := 0 to (AStream.Size div 4) do begin
    v[3] := v[3] + (AStream.ReadByte and $FF);
    v[2] := v[2] + (AStream.ReadByte and $FF);
    v[1] := v[1] + (AStream.ReadByte and $FF);
    v[0] := v[0] + (AStream.ReadByte and $FF);
  end;
  Result := V[0] + (V[1] shl 8) + (v[2] shl 16) + (v[3] shl 24);
end;

function TgtPDFFont.GetCIDFontDictionary(
  AFontDescriptorRef: String): String;
var
  LI, LJ: Integer;
  LLastIndex, LPrevWidth, LFirstIndex, LFirstWidth, LLastWidth: Integer;
  LFoundEqualWidth: Boolean;
  LWidths: String;
begin
  LWidths := '';

  LLastIndex := 1;
  LPrevWidth := 1000;
  LI := 1;
  while LI <= FWidths.Count - 1 do
  begin
    LFirstIndex := LI;
    LFirstWidth := Integer(FWidths.Objects[LI]);
    LFoundEqualWidth := False;
    for LJ := LI + 1 to FWidths.Count - 1 do
    begin
      LLastIndex := LJ;
      LLastWidth := Integer(FWidths.Objects[LJ]);
      if LFirstWidth <> LLastWidth then Break
      else
      begin
        LFoundEqualWidth := True;
        LPrevWidth := LLastWidth;
      end;
    end;
    if not LFoundEqualWidth then
    begin
      LWidths := LWidths + FWidths.Strings[LFirstIndex] + ' ' +
        FWidths.Strings[LFirstIndex] + ' ' + IntToStr(LFirstWidth) + ' ';
      Inc(LI);
    end
    else
    begin
      LWidths := LWidths + FWidths.Strings[LFirstIndex] + ' ' +
        FWidths.Strings[LLastIndex - 1] + ' ' + IntToStr(LPrevWidth) + ' ';
      LI := LLastIndex;
    end;
  end;
  Result :=
    '/Type/Font' +
    '/Subtype/CIDFontType2';
  if FSubset then
    Result := Result +
      '/BaseFont/WYOIAS+' + BaseFont
  else
    Result := Result +
      '/BaseFont/' + BaseFont;
  Result := Result +
    '/FontDescriptor ' + AFontDescriptorRef +
    '/CIDSystemInfo' + CRLF + '<<' + CRLF +
    '/Registry(Adobe)'+
    '/Ordering(Identity)' +
    '/Supplement 0' + CRLF + '>>' + CRLF;
  if not FFontInfo.FfiIsFixedPitch then
    Result := Result +
      '/W [' + LWidths + ']';
  Result := Result +
    '/DW ' + IntToStr(FFontInfo.FfiMaxWidth) +
    '/CIDToGIDMap/Identity';
end;

procedure TgtPDFFont.GetCMap(AMemStream: TMemoryStream);
var
  LI: Integer;
  LATemp : AnsiString;
begin
  if FCID.Count = 0 then Exit;
  FPDFCMap :=
    '%!PS-Adobe-3.0 Resource-CMap' + CRLF +
    '%%DocumentNeededResources: ProcSet (CIDInit)' + CRLF +
    '%%IncludeResource: ProcSet (CIDInit)' + CRLF +
    '%%BeginResource: CMap (Identity-H)' + CRLF +
    '%%Title: (Identity-H Adobe Identity 0)' + CRLF +
    '%%Version: 10.001' + CRLF +
    '%%Copyright: -----------------------------------------------------------';
  FPDFCMap := FPDFCMap + CRLF +
    '%%Copyright: Copyright 1990-2000 Adobe Systems Incorporated.' + CRLF +
    '%%Copyright: All Rights Reserved.' + CRLF +
    '%%Copyright:' + CRLF +
    '%%Copyright: Patents Pending' + CRLF +
    '%%Copyright:' + CRLF +
    '%%Copyright: NOTICE: All information contained herein is the property'
      + CRLF +
    '%%Copyright: of Adobe Systems Incorporated.' + CRLF +
    '%%Copyright:' + CRLF +
    '%%Copyright: PostScript and Display PostScript are trademarks of' + CRLF +
    '%%Copyright: Adobe Systems Incorporated which may be registered in'
      + CRLF +
    '%%Copyright: certain jurisdictions.' + CRLF +
    '%%Copyright: -----------------------------------------------------------'
      + CRLF +
    '%%EndComments' + CRLF +
    CRLF +
    '/CIDInit /ProcSet findresource begin' + CRLF +
    CRLF +
    '12 dict begin' + CRLF +
    CRLF +
    'begincmap' + CRLF +
    CRLF +
    '/CIDSystemInfo 3 dict dup begin' + CRLF +
      '/Registry (Adobe) def' + CRLF +
      '/Ordering (Identity) def' + CRLF +
      '/Supplement 0 def' + CRLF +
    'end def' + CRLF +
    CRLF +
    '/CMapName /Identity-H def' + CRLF +
    '/CMapVersion 10.001 def' + CRLF +
    '/CMapType 1 def' + CRLF +
    CRLF +
    '/XUID [1 10 25404 9999] def' + CRLF +
    CRLF +
    '/WMode 0 def' + CRLF +
    CRLF +
    '1 begincodespacerange' + CRLF +
    '<' + IntToHex(Integer(FCID.Items[0]), 4) +
    '> <' + IntToHex(Integer(FCID.Items[FCID.Count - 1]), 4) + '>' + CRLF +
    'endcodespacerange' + CRLF +
    CRLF +
    IntToStr(FCID.Count) + ' begincidrange' + CRLF;
    for LI := 0 to FCID.Count - 1 do
    begin
      FPDFCMap := FPDFCMap +  '<' + IntToHex(Integer(FCID.Items[LI]), 4) +
        '> <' + IntToHex(Integer(FCID.Items[LI]), 4) + '> ' +
        IntToStr(Integer(FCharCode.Items[LI])) + CRLF ;
    end;
  FPDFCMap := FPDFCMap +
    'endcidrange' + CRLF +
    'endcmap' + CRLF +
    'CMapName currentdict /CMap defineresource pop' + CRLF +
    'end' + CRLF +
    'end' + CRLF +
    CRLF +
    '%%EndResource' + CRLF +
    '%%EOF';
  LATemp := AnsiString(FPDFCMap);
  AMemStream.Write(LATemp[1], Length(FPDFCMap));
end;

function TgtPDFFont.GetCodePage(AFontCharset: TFontCharset): Integer;
const
	CANSICodePageIDs: array[0..14] of record
		FontCharset: TFontCharset;
		WinCode: Integer;
	end = (
		(FontCharset: ANSI_CHARSET; WinCode: 1252),
		(FontCharset: SHIFTJIS_CHARSET; WinCode: 932),
		(FontCharset: HANGEUL_CHARSET; WinCode: 949),
		(FontCharset: JOHAB_CHARSET; WinCode: 1361),
		(FontCharset: GB2312_CHARSET; WinCode: 936),
		(FontCharset: CHINESEBIG5_CHARSET; WinCode: 950),
		(FontCharset: GREEK_CHARSET; WinCode: 1253),
		(FontCharset: TURKISH_CHARSET; WinCode: 1254),
		(FontCharset: VIETNAMESE_CHARSET; WinCode: 1258),
		(FontCharset: HEBREW_CHARSET; WinCode: 1255),
		(FontCharset: ARABIC_CHARSET; WinCode: 1256),
		(FontCharset: BALTIC_CHARSET; WinCode: 1257),
		(FontCharset: THAI_CHARSET; WinCode: 874),
		(FontCharset: EASTEUROPE_CHARSET; WinCode: 1250),
    (FontCharset: RUSSIAN_CHARSET; WinCode: 1251)
		);
var
	LI: Integer;
begin
	Result := GetACP;
	for LI := Low(CANSICodePageIDs) to High(CANSICodePageIDs) do
	begin
		if CANSICodePageIDs[LI].FontCharset = AFontCharset then
		begin
			Result := CANSICodePageIDs[LI].WinCode;
			Break;
		end;
	end;
end;

procedure TgtPDFFont.GetFontCMapDetails;
var
	LStream, LCMapStream: TgtExtMemStream;
	LI, LJ, LCharCode, LNoOfTables, LGlyphIDSize, idROIndex: Integer;
  LOffset, LTableLength: Int64;
  LPlatId, LPlatSpecId, LSegCount, GlyphIndex: Word; // UShort
	EndCount, StartCount, idDelta, idRangeOffset, GlyphID: array of Word;

  LTable: AnsiString;
begin
  LCMapStream := nil;

	LStream := TgtExtMemStream.Create;
	try
    GetFontFile2(TMemoryStream(LStream));
    (* Read CMap. *)
    SetLength(LTable, 4);
    (* Skip Version.*)
    LStream.SkipBytes(4);
    (* Read No. of Tables Directories. *)
    LNoOfTables := LStream.ReadUShort;
    (* Move to start of Table Directory entries. *)
    LStream.Position := 12;
    LI := -1;

    (*
      Loop to get cmap Offset & Length.
      Finally Obtain CMap stream.
    *)
    repeat
      LTable := LStream.ReadString(4);

      if (LTable = 'cmap') then
      begin
        (* Skip Checksum *)
        LStream.SkipBytes(4);
        (* Get CMap table Offset, Length. *)
        LOffset := LStream.ReadULong;
        LTableLength := LStream.ReadULong;
        (* Move to cmap table content. *)
        LStream.Position := LOffset;

        (* Copy CMap Content. *)
        LCMapStream := TgtExtMemStream.Create;
        LCMapStream.CopyFrom(LStream, LTableLength);
        Break;
      end;
      (* Did not find cmap. Skip Checksum, Offset & Length *)
      LStream.SkipBytes(12);
      Inc(LI);
    until (LI = LNoOfTables);
	finally
		FreeAndNil(LStream);
	end;

  (* If CMap table found. *)
  if (LCMapStream <> nil) then
  begin
    try
      (* Skip Table version no. (0) *)
      LCMapStream.Position := 2;
      (* Read No. of encoding tables. *)
      LNoOfTables := LCMapStream.ReadUShort;
      LOffset := -1;
      (* Loop through encoding table to find CMap31. *)
      for LI := 0 to LNoOfTables do
      begin
        LPlatId := LCMapStream.ReadUShort;
        LPlatSpecId := LCMapStream.ReadUShort;
        if (((LPlatId = 3) and (LPlatSpecId = 1))) then
        begin
          (* Get Format 4 Offset. *)
          LOffset := LCMapStream.ReadULong;
          Break;
        end
        else if (((LPlatId = 3) and (LPlatSpecId = 0))) then
        begin
          (* Get Format 4 Offset. *)
          LOffset := LCMapStream.ReadULong;
          Break;
        end
        else
          LCMapStream.SkipBytes(4); //Skip Offset
      end;
      if (LOffset <> -1) then
      begin
        //(* Get Format 4 Offset. *)
        //LOffset := LCMapStream.ReadULong;
          (* Move to Format 4 Subtable. *)
          LCMapStream.Position := LOffset;
          (* Skip Format no. (4) *)
          LCMapStream.SkipBytes(2);

          (* Read Format 4 Subtable Length. *)
          LTableLength := LCMapStream.ReadUShort;
          (* Skip Version. *)
          LCMapStream.SkipBytes(2);

          (* Read Segment Count. *)
          LSegCount := LCMapStream.ReadUShort div 2;
          (* Skip searchRange, entrySelector & rangeShift. *)
          LCMapStream.SkipBytes(6);

          (* Read endCount. *)
          SetLength(EndCount, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            EndCount[LJ] := LCMapStream.ReadUShort;

          (* Skip reservedPad. *)
          LCMapStream.SkipBytes(2);

          (* Read startCount. *)
          SetLength(StartCount, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            StartCount[LJ] := LCMapStream.ReadUShort;

          (* Read idDelta. *)
          SetLength(idDelta, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            idDelta[LJ] := LCMapStream.ReadUShort;

          (* Read idRangeOffset. *)
          SetLength(idRangeOffset, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            idRangeOffset[LJ] := LCMapStream.ReadUShort;

          (*
            LTableLength div 2 - Table length in Words.
            SegCount * 4 - No. of Words occupied by ||ll arrays
            8 - No. of Words occupied by other entries.

            GlyphIDSize - No. of Word entries in GlyphID array.
          *)
          LGlyphIDSize := LTableLength div 2 - 8 - LSegCount * 4;
          SetLength(GlyphID, LGlyphIDSize);
          for LJ := 0 to LGlyphIDSize - 1 do
            GlyphID[LJ] := LCMapStream.ReadUShort;

          (* Obtain Character Code -> Glyph Index (CMap) list. *)
          (* Loop through the different segments. *)
          for LJ := 0 to LSegCount - 1 do
          begin
            (* Loop through start -> end character codes in current segment. *)
            for LCharCode := StartCount[LJ] to EndCount[LJ] do
            begin
              (* If finaly Character Code exit. *)
              if LCharCode = $FFFF then
                Break;
              if (idRangeOffset[LJ] = 0) then
                GlyphIndex := (LCharCode + idDelta[LJ]) and $FFFF
              else
			        begin
                idROIndex := LJ + idRangeOffset[LJ] div 2 - LSegCount +
                  LCharCode - StartCount[LJ];
				        GlyphIndex := (GlyphID[idROIndex] + idDelta[LJ]) mod $FFFF;
			        end;
              FCID.Add(TObject(GlyphIndex));
              FCharCode.Add(TObject(LCharCode));
            end;
          end;
        //Break;
      end;
        //else
          //LCMapStream.SkipBytes(4); //Skip Offset
      //end;
    finally
      FreeAndNil(LCMapStream);
    end;
  end;
end;

function TgtPDFFont.GetFontDescriptor(AFontFile2Obj: String): String;
begin
  with FFontInfo do
  begin
    Result :=
      '/Type/FontDescriptor';
    if FSubset then
      Result := Result +
        '/FontName/WYOIAS+' + BaseFont
    else
      Result := Result +
        '/FontName/' + BaseFont;
    Result := Result +
      '/Flags ' + IntToStr(FfiFlags) +
      Format('/FontBBox [%d %d %d %d]', [FfiFontBBox.Left, FfiFontBBox.Bottom,
        FfiFontBBox.Right, FfiFontBBox.Top]) +
      '/Ascent ' + FloatToStrLocale(FfiAscent) +
      '/Descent ' + FloatToStrLocale(FfiDescent) +
      '/CapHeight ' + FloatToStrLocale(FfiCapHeight) +
      '/AvgWidth ' + IntToStr(FfiAvgWidth) +
      '/MaxWidth ' + IntToStr(FfiMaxWidth) +
      '/MissingWidth ' + IntToStr(FfiMaxWidth) +
      '/StemV ' + IntToStr(FfiStemV) +
      '/ItalicAngle ' + IntToStr(FfiItalicAngle);
    if AFontFile2Obj <> '' then
      Result := Result +
      '/FontFile2 ' + AFontFile2Obj;
    Result := Result + CRLF;
  end;
end;

procedure TgtPDFFont.GetFontFile2Subset(var AStream: TgtExtMemStream);
begin
  (* Get Original Font Stream. *)
  GetFontFile2(TMemoryStream(AStream));

  SubsetInitialize;
  ReadTable(AStream);
  if (WriteLocaAndGlyf(AStream)) then
    WriteTable;
  (*
    Subset successful: Copy subset font stream.
    Subset UnSuccessful: Copy whole font stream.
  *)
  if (FOutFont.Size > 0) and (FOutFont.Size < AStream.Size) then
  begin
    AStream.Clear;
    FOutFont.Position := 0;
    AStream.CopyFrom(FOutFont, 0);
  end;
  SubsetFinalize;
end;

function TgtPDFFont.GetGlyphIndiciesA(AStr: WideString;
  ACharset: TFontCharset): String;
var
	I, K: Integer;
	P: PWideChar;
	GlyphIndex: Integer;
  Q: Integer;
begin
  if AStr <> '' then
    if not IsDBCSLeadByte(Byte(AStr[1])) then
    begin
      Result := '';
      K := 1;
      while (K <= Length(AStr)) do
      begin
        P := @AStr[K];
        Q := Ord(P^);
        if (ACharset = SYMBOL_CHARSET) then
          Q := ((Q + $F000) and $F0FF);
        K := K + 1;
        (* Character Code Index. *)
        I := FCharCode.IndexOf(TObject(Q));
        if I <> -1  then
        begin
          if FSubset and (P^ <> ' ') and
            (FIncludedCharCode.IndexOf(TObject(Q)) = -1) then
            FIncludedCharCode.Add(TObject(Q));

          (* CID value. *)
          GlyphIndex := Integer(FCID.Items[I]);
          Result := Result + IntToHex(GlyphIndex, 4);
        end;
      end;
    end
    else
      begin
      Result := '';
      AStr := Trim(AStr);
      K := 1;
      while (K <= Length(Trim(AStr))) do
      begin
        P := PWideChar(AStr[K]);
        if ((Length(P) = 0) and (AStr[K] <> '')) and
          IsDBCSLeadByte(Ord(AStr[K])) then
        begin
    //      P := PWideChar(Trim(System.Copy(AStr, K, 2)));

        end
        else
          K := K + 1;
        (* Character Code Index. *)
        Q := Ord(AStr[K]);
        K := K + 1;
        if (ACharset = SYMBOL_CHARSET) then
          Q := ((Q + $F000) and $F0FF);
        I := FCharCode.IndexOf(TObject(Q));
        if I <> -1  then
        begin
          if FSubset and (AStr[K] <> ' ') and
            (FIncludedCharCode.IndexOf(TObject(Q)) = -1) then
            FIncludedCharCode.Add(TObject(Q));

          (* CID value. *)
          GlyphIndex := Integer(FCID.Items[I]);
          Result := Result + IntToHex(GlyphIndex, 4);
        end;
      end;
    end;

end;

function TgtPDFFont.GetGlyphIndiciesW(AStr: WideString;
  ACharset: TFontCharset): String;
var
	I, K: Integer;
	GlyphIndex: Integer;
  Q: Integer;
begin
  if AStr <> '' then
      begin
      Result := '';
      AStr := Trim(AStr);
      K := 1;
      while (K <= Length(Trim(AStr))) do
      begin
        (* Character Code Index. *)
        Q := Ord(AStr[K]);
        K := K + 1;
        if (ACharset = SYMBOL_CHARSET) then
          Q := ((Q + $F000) and $F0FF);
        I := FCharCode.IndexOf(TObject(Q));
        if I <> -1  then
        begin
          if FSubset and (AStr[K] <> ' ') and
            (FIncludedCharCode.IndexOf(TObject(Q)) = -1) then
            FIncludedCharCode.Add(TObject(Q));

          (* CID value. *)
          GlyphIndex := Integer(FCID.Items[I]);
          Result := Result + IntToHex(GlyphIndex, 4);
        end;
      end;
    end;

end;
function TgtPDFFont.GetGlyphIndiciesForNonANSI(AStr: WideString;
  ACharset: TFontCharset): String;
var
	I, K: Integer;
	P: PWideChar;
	GlyphIndex: Integer;

begin
  if AStr <> '' then
    if not IsDBCSLeadByte(Byte(AStr[1])) then
    begin
      Result := '';
      K := 1;
      while (K <= Length(AStr)) do
      begin
        P := @AStr[K];
        K := K + 1;
        (* Character Code Index. *)
        I := FCharCode.IndexOf(TObject(Ord(P^)));
        if I <> -1  then
        begin
          if FSubset and (P^ <> ' ') and
            (FIncludedCharCode.IndexOf(TObject(Ord(P^))) = -1) then
            FIncludedCharCode.Add(TObject(Ord(P^)));

          (* CID value. *)
          GlyphIndex := Integer(FCID.Items[I]);
          Result := Result +  '<'+ IntToHex(GlyphIndex, 4)+ '>';
        end;
      end;
    end
    else
    begin
      Result := '';
      AStr := Trim(AStr);
      K := 1;
      while (K <= Length(Trim(AStr))) do
      begin
        P := PWideChar(StringToUnicodeString(AnsiString(AStr[K]), ACharset));
        if ((Length(P) = 0) and (AStr[K] <> '') and
          IsDBCSLeadByte(Ord(AStr[K]))) then
        begin
          P := PWideChar(Trim(StringToUnicodeString(AnsiString(System.Copy(AStr, K, 2)),
            ACharset)));
          K := K + 2;
        end
        else
          K := K + 1;
        (* Character Code Index. *)
        I := FCharCode.IndexOf(TObject(Ord(P^)));
        if I <> -1  then
        begin
          if FSubset and (P^ <> ' ') and
            (FIncludedCharCode.IndexOf(TObject(Ord(P^))) = -1) then
            FIncludedCharCode.Add(TObject(Ord(P^)));

          (* CID value. *)
          GlyphIndex := Integer(FCID.Items[I]);
          Result := Result + '<'+ IntToHex(GlyphIndex, 4)+'>';
        end;
      end;
    end;

end;

function TgtPDFFont.GetType0FontDictionary(AFontNo: Integer;
  AUnicodeObjRef, ADesFontObjRef: String): String;
begin
  Result :=
    '/Type/Font' +
    '/Subtype/Type0' +
    '/Name/F' + IntToStr(AFontNo);
    if FSubset then
      Result := Result +
        '/BaseFont/WYOIAS+' + BaseFont
    else
      Result := Result +
        '/BaseFont/' + BaseFont;
    Result := Result +
    '/Encoding/Identity-H' +
    '/ToUnicode ' + AUnicodeObjRef +
    '/DescendantFonts [' + ADesFontObjRef + ']' + CRLF;
end;

function TgtPDFFont.HasChar(ACharCode: Word): Boolean;
var
  LIndex: Integer;
begin
  Result := False;
  LIndex := FIncludedCharCode.IndexOf(TObject(ACharCode));
  (* If required character, return true and remove the character. *)
  if LIndex <> -1 then
  begin
    Result := True;
    FIncludedCharCode.Delete(LIndex);
  end;
end;

function TgtPDFFont.IsAnsiCharset: Boolean;
begin
  Result := False;
  if (FFont.Charset = ANSI_CHARSET) or
    ((FFont.Charset = DEFAULT_CHARSET) and (GetACP = CANSIWinCode)) then
    Result := True;
end;

function TgtPDFFont.IsTableNeeded(AString: String): Boolean;
var
  I : Integer;
begin
  (*
    For Non-ANSI_CHARSET fonts, cmap will be written seperately.
    Hence cmap is not required in subsetted font.
  *)
  for I := 0 to High(FRequiredTables) do begin
    Result := (AString = FRequiredTables[I]);
    if Result then
      Break;
  end;
end;

procedure TgtPDFFont.ReadGlyphWidths;
var
	LStream: TgtExtMemStream;
	LI, LJ, LNoOfTables, LPosition, GlyphWidth: Integer;
  LOffset: Int64;
  (*
    No. of Horizontal Metics from Horizontal Header (hhea) table.
    UnitsPerEm from Font Header (head) table.
  *)
  LNumberOfHMetrics, LUnitsPerEm: Word;
  LTable: AnsiString;

begin
	LStream := TgtExtMemStream.Create;
	try
    GetFontFile2(TMemoryStream(LStream));
    SetLength(LTable, 4);
    (* Skip Version.*)
    LStream.SkipBytes(4);
    (* Read No. of Tables Directories. *)
    LNoOfTables := LStream.ReadUShort;
    (* Move to start of Table Directory entries. *)
    LStream.Position := 12;
    LI := -1;
    LUnitsPerEm := 0;
    LNumberOfHMetrics := 0;

    (*
      Loop to get head/hhea Offset & Length.
      Finally Obtain
        UnitsPerEm from head table.
        NumberOfHMetrics from hhea table.
    *)
    repeat
      LTable := LStream.ReadString(4);
      if ((LTable = 'head') or (LTable = 'hhea') or (LTable = 'hmtx')) then
      begin
        (* Copy current position to continue search for hhea *)
        LPosition := LStream.Position;
        
        (* Skip Checksum *)
        LStream.SkipBytes(4);
        (* Get head/hhea/hmtx table Offset, Length. *)
        LOffset := LStream.ReadULong;
        LStream.SkipBytes(4);
        (* Move to head/hhea/hmtx table content. *)
        LStream.Position := LOffset;

        if (LTable = 'head') then
        begin
          (*
            Skip
              Table version number  (Fixed) 32Bit.
              fontRevision          (Fixed) 32Bit.
              checkSumAdjustment    (ULong) 32Bit.
              magicNumber           (ULong) 32Bit.
              flags                 (UShort) 16Bit.
          *)
          LStream.SkipBytes(18);
          LUnitsPerEm := LStream.ReadUShort;
          LStream.Position := LPosition;
        end
        else if (LTable = 'hhea') then
        begin
          (*
            Skip
              Table version number  (Fixed) 32Bit.
              Ascender              (FWord) 16Bit.
              Descender             (FWord) 16Bit.
              LineGap               (FWord) 16Bit.
              advanceWidthMax       (UFWORD) 16Bit.
              minLeftSideBearing    (FWord) 16Bit.
              minRightSideBearing   (FWord) 16Bit.
              xMaxExtent            (FWord) 16Bit.
              caretSlopeRise        (SHORT) 16Bit.
              caretSlopeRun         (SHORT) 16Bit.
              (reserved) * 5        (SHORT) 16Bit.
              metricDataFormat      (SHORT) 16Bit.
          *)
          LStream.SkipBytes(34);
          LNumberOfHMetrics := LStream.ReadUShort;
          LStream.Position := LPosition;
        end
        else if (LTable = 'hmtx') then
        begin
          for LJ := 0 to LNumberOfHMetrics do
          begin
            GlyphWidth := (LStream.ReadUShort * 1000) div LUnitsPerEm;
            (* Skip lsb *)
            LStream.SkipBytes(2);
            FWidths.AddObject(IntToStr(LJ), TObject(GlyphWidth));
          end;
          Break;
        end;
      end;
      (* Did not find head/hhea/hmtx. Skip Checksum, Offset & Length *)
      LStream.SkipBytes(12);
      Inc(LI);
    until (LI = LNoOfTables);

    LStream.Position := 0;
  finally
    FreeAndNil(LStream);
  end;
end;

procedure TgtPDFFont.ReadTable(AStream: TgtExtMemStream);
var
  LInt: Integer;
  LI, LJ: Word;
  LTableCount: Integer;
  LTable: String;
begin
  AStream.Position := 0;
  LTable := '';

  (* Skip TT signature *)
  AStream.SkipBytes(4);

  LTableCount := AStream.ReadUShort;


  SetLength(FTableOffset, FTableOutCount);
  SetLength(FTableLength, FTableOutCount);
  SetLength(FTableChecksum, FTableOutCount);

  (*
    Skip - searchRange, entrySelector & rangeShift.
  *)
  AStream.SkipBytes(6);

  LI := 0;
  for LJ := 0 to LTableCount - 1 do begin
    LTable := String(AStream.ReadString(4));
    if IsTableNeeded(LTable) then
    begin
      FTableChecksum[LI] := AStream.ReadULong;
      FTableOffset[LI] := AStream.ReadULong;
      FTableLength[LI] := AStream.ReadULong;

      LInt := AStream.Position;

      if (LTable = 'glyf') then
        FGlyfOffset := FTableOffset[LI]
      else if (LTable = 'loca') then
        FLocaOffset := FTableOffset[LI]
      else if (LTable = 'head') then begin
        AStream.Position := FTableOffset[LI];
        FTableData.CopyFrom(AStream, 8);
        FTableData.WriteULong(0); (* for checksum adjustment *)
        AStream.SkipBytes(4);
        FTableData.CopyFrom(AStream, (FTableLength[LI] - 12));
        FTableData.PadTo4Bytes;

        (* Check if Local table offset is Long/Short. *)
        (* Position to read indexToLocFormat field of head. *)
        AStream.Position := FTableOffset[LI] + FTableLength[LI] - 4;
        (*
          indexToLocFormat =  0 : Short Offset Loca Table.
                              1 : Long Offset Loca Table.
        *)
        FLocaIsLong := (AStream.ReadUShort = 1);
      end
      else if (LTable = 'maxp') then
      begin
        (* Get no. of glyphs in font. *)

        AStream.Position := FTableOffset[LI];
        (* Skip Version. *)
        AStream.SkipBytes(4);
        FNumGlyphs := AStream.ReadUShort;

        AStream.Position := FTableOffset[LI];
        FTableData.CopyFrom(AStream, FTableLength[LI]);
        FTableData.PadTo4Bytes;
      end
      else begin
        AStream.Position := FTableOffset[LI];
        FTableData.CopyFrom(AStream, FTableLength[LI]);
        FTableData.PadTo4Bytes;
      end;

      AStream.Position := LInt;
      Inc(LI);
    end
    else
      AStream.SkipBytes(12);
  end;
end;

procedure TgtPDFFont.SetSubset(const Value: Boolean);
begin
  FSubset := Value;
end;

function TgtPDFFont.StringToUnicodeString(AStr: AnsiString;
  AFontCharset: TFontCharset): WideString;
begin
	SetLength(Result, Length(AStr));
  MultiByteToWideChar(GetCodePage(AFontCharset), 0, PAnsiChar(AStr), Length(AStr),
    PWideChar(Result), Length(AStr) * 2);
end;

procedure TgtPDFFont.SubsetFinalize;
begin
  FreeAndNil(FOutFont);
  FreeAndNil(FTableData);
  FreeAndNil(FGlyfOut);
  FreeAndNil(FLocaOut);
end;

procedure TgtPDFFont.SubsetInitialize;
begin
  FOutFont := TgtExtMemStream.Create;
  FTableData := TgtExtMemStream.Create;
  FGlyfOut := TgtExtMemStream.Create;
  FLocaOut := TgtExtMemStream.Create;
  (*
    Table Directories -
    'DSIG', 'GDEF', 'GSUB', 'JSTF', 'LTSH', 'OS/2', 'PCLT', 'VDMX', 'cmap',
    'cvt ', 'fpgm', 'gasp', 'glyf', 'hdmx', 'head', 'hhea', 'hmtx', 'kern',
    'loca', 'maxp', 'name', 'post', 'prep'
  *)
  (* Table Directories required for PDF. *)
  FRequiredTables[0] := 'cmap';
  FRequiredTables[1] := 'cvt ';
  FRequiredTables[2] := 'fpgm';
  FRequiredTables[3] := 'glyf';
  FRequiredTables[4] := 'head';
  FRequiredTables[5] := 'hhea';
  FRequiredTables[6] := 'hmtx';
  FRequiredTables[7] := 'loca';
  FRequiredTables[8] := 'maxp';
  FRequiredTables[9] := 'prep';

  FTableOutCount := High(FRequiredTables) + 1;
end;

function TgtPDFFont.WriteLocaAndGlyf(AStream: TgtExtMemStream): Boolean;
var
  LI: Word;
  LCIDIndex: Integer;
  LCurLoca, LNextLoca, LGlyphLen, LGlyphPos : Cardinal;
begin
  Result := True;
  LCIDIndex := -1;
  for LI := 0 to FNumGlyphs do begin
    if FLocaIsLong then
      FLocaOut.WriteULong(FGlyfOut.Size)
    else
      FLocaOut.WriteUShort(FGlyfOut.Size div 2);
    if LI = FNumGlyphs then
      Break;

    if (FCID.Count <> -1) then
      LCIDIndex := Integer(FCID.IndexOf(TObject(LI)));

    (*
      If required character write it.
    *)
    if (FIncludedCharCode.Count > 0) and (LCIDIndex <> -1) and
      HasChar(Integer(FCharCode.Items[LCIDIndex])) then begin
      AStream.Position := FLocaOffset +
        (LI * Cardinal(gtUtils.IfThen(FLocaIsLong, 4, 2)));
      (*
        Get Starting and end position of the required glyph based on
        Long/Short loca table.
      *)
      if FLocaIsLong then begin
        LCurLoca := AStream.ReadULong;
        LNextLoca := AStream.ReadULong;
        LGlyphLen := LNextLoca - LCurLoca;
        LGlyphPos := FGlyfOffset + LCurLoca;
      end
      else begin
        LCurLoca := AStream.ReadUShort;
        LNextLoca := AStream.ReadUShort;
        LGlyphLen := (LNextLoca - LCurLoca) * 2;
        LGlyphPos := FGlyfOffset + (LCurLoca * 2);
      end;
      AStream.Position := LGlyphPos;
      (*
        Read numberOfContours from glyph table.
        numberOfContours >=    0      : Single Glyph.
                              -ve(-1) : Composite Glyph.
      *)
      if AStream.ReadShort = -1 then begin
        Result := False;
        Exit;
      end
      else begin
        AStream.Position := LGlyphPos;
        FGlyfOut.CopyFrom(AStream, LGlyphLen);
      end;
    end; (* End if (required glyph check)*)
  end; (* End for *)
end;

procedure TgtPDFFont.WriteTable;
var
  LI : Word;
  ChecksumAdj, LDataOffset, LHeadOffset: Cardinal;
begin
  LHeadOffset := 0;
  LDataOffset := 16 * FTableOutCount + 12;
  FOutFont.WriteULong($00010000);
  FOutFont.WriteUShort(FTableOutCount);
  LI := Trunc(IntPower(2, Trunc(Log2(FTableOutCount))) * 16) and $FFFF;
  FOutFont.WriteUShort(LI); // SearchRange
  LI := Trunc(Log2(IntPower(2, Trunc(Log2(FTableOutCount))))) and $FFFF;
  FOutFont.WriteUShort(LI); // EntrySelector
  LI := (FTableOutCount * 16) -
    (Trunc(IntPower(2, Trunc(Log2(FTableOutCount))) * 16) and $FFFF);
  FOutFont.WriteUShort(LI); // RangeShift
  FTableData.Position := 0;
  for LI := Low(FRequiredTables) to High(FRequiredTables) do begin
    if (FRequiredTables[LI] = 'glyf') then begin
      FOutFont.WriteString('glyf');
      FGlyfOut.Position := 0;
      FOutFont.WriteULong(GetCheckSum(FGlyfOut));
      FOutFont.WriteULong(FTableData.Size + (16 * FTableOutCount + 12));
      FGlyfOut.PadTo4Bytes;
      FOutFont.WriteULong(FGlyfOut.Size - FGlyfOut.PadSize);
    end
    else if (FRequiredTables[LI] = 'loca') then begin
      FOutFont.WriteString('loca');
      FLocaOut.Position := 0;
      FOutFont.WriteULong(GetCheckSum(FLocaOut));
      FOutFont.WriteULong(FGlyfOut.Size + FTableData.Size +
        (16 * FTableOutCount + 12));
      FLocaOut.PadTo4Bytes;
      FOutFont.WriteULong(FLocaOut.Size - FLocaOut.PadSize);
    end
    else begin
      FOutFont.WriteString(AnsiString(FRequiredTables[LI]));
      FOutFont.WriteULong(FTableChecksum[LI]);
      FOutFont.WriteULong(LDataOffSet);
      if (FRequiredTables[LI] = 'head') then
        LHeadOffset := LDataOffSet;
      LDataOffSet := LDataOffSet + FTableLength[LI] +
        gtUtils.IfThen((FTableLength[LI] mod 4) = 0, 0,
          (4 - (FTableLength[LI] mod 4)));
      FOutFont.WriteULong(FTableLength[LI]);
    end;
  end;
  FOutFont.CopyFrom(FTableData, 0);
  FOutFont.CopyFrom(FGlyfOut, 0);
  FOutFont.CopyFrom(FLocaOut, 0);
  ChecksumAdj := 0;
  FOutFont.Position := 0;
  //check sum adjustment in "head" table
  while (FOutFont.Position < FOutFont.Size) do begin
    ChecksumAdj := (ChecksumAdj + FOutFont.ReadULong) and $FFFFFFFF;
  end;
  //overwrite in "head" table
  FOutFont.Position := LHeadOffset;
  FOutFont.SkipBytes(8);
  FOutFont.WriteULong(ChecksumAdj);
end;

{ TgtPDFFontInfo }

constructor TgtPDFFontInfo.Create(AFont: TFont);
var
	LI: Integer;
begin
  FfiFlags := 0;
  FfiFontBBox := Rect(-250, -200, 1000, 900);
  FfiAscent := 800;
  FfiDescent := -200;
  FfiCapHeight := 700;
  FfiAvgWidth := 576;
  FfiMaxWidth := 576;
  FfiStemV := 0;
  FfiItalicAngle := 0;
  FfiStrikeoutSize := AFont.Size div 20;
  FfiStrikeoutPosition := Abs(AFont.Height) div 5;
  FfiUnderscoreSize := AFont.Size div 10;
  FfiUnderscorePosition := -1;
  FfiType := ftStdType1;
  FfiIsFixedPitch := False;
  for LI := Low(FfiWidths) to High(FfiWidths) do
    FfiWidths[LI] := 600;
end;

initialization
 ACPCharset := GetACPCharset;
 
end.
