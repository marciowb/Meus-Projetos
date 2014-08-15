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

unit gtTIFFEng;

interface
uses
  Classes, Graphics, SysUtils,
  gtdZLib, gtFilters, gtDocConsts, gtCstGfxEng, gtDocResStrs;

type
  TgtTIFFCompressionType = (ctNone, ctPackBits, ctZip);

  TgtTIFFEngine = class(TgtCustomGraphicsEngine)
  private
    FTIFFStream: TStream;
    FImgSizes, FHeights, FWidths: TList;
    FGrayscale: Boolean;
    FMultiPage: Boolean;
    FImageCount: Integer;
    FTIFFCompressionType: TgtTIFFCompressionType;
    procedure InitTIFF;
    procedure CreateTIFF;
    procedure EndTIFF;
    procedure WriteWord(ABuf: array of word; AStream: TStream);
    procedure SetGrayscale(const Value: Boolean);
    procedure SetTIFFCompressionType(const Value: TgtTIFFCompressionType);
    procedure SetMultiPage(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  protected
  	function ShowSetupModal: Word; override;
  	procedure EndPage; override;
    procedure Start; override;
    procedure Finish; override;
  published
    property Grayscale: Boolean read FGrayscale write SetGrayscale
      default False;
    property CompressionType: TgtTIFFCompressionType read FTIFFCompressionType
      write SetTIFFCompressionType default ctZip;
    property MultiPage: Boolean read FMultiPage write SetMultiPage
      default True;
    property DocInfo;
  end;

implementation

uses gtCstDocEng, gtTIFFEngDlg, gtDocUtils;

{ TgtTIFFEngine }

procedure TgtTIFFEngine.Start;
begin
  inherited;
  if Preferences.OutputToUserStream then
    FTIFFStream := UserStream;
  if MultiPage then InitTIFF;
end;

constructor TgtTIFFEngine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FGrayscale := False;
  FTIFFCompressionType := ctZip;
  FMultiPage := True;
  FileExtension := 'tif';
  FileDescription := STIFFDescription;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 111);
{$ENDIF}
end;

procedure TgtTIFFEngine.CreateTIFF;
var
  LValStream: TMemoryStream;
  LL, LZero: Cardinal;
  LFirstIFDOffset, LIFDOffsets, LIFDSize, LValOffset, LStripOffset: Int64;
  LDirCount: Word;
  LK: Integer;
const
  LCmprValue: array[TgtTIFFCompressionType] of Word = (1, 32773, 32946);
begin
  LValStream := TMemoryStream.Create;
  try
    LZero := 0;
    // determine no. of directory entries
    LDirCount := 14;
    if (CompressionType = ctNone) then Dec(LDirCount);
    if Grayscale then Dec(LDirCount);
    if DocInfo.Author = '' then Dec(LDirCount);
    if DocInfo.Subject = '' then Dec(LDirCount);
    if DocInfo.Creator = '' then Dec(LDirCount);
    // initialise arrays and locals
    LStripOffset := 8;
    LFirstIFDOffset := FTIFFStream.Size;
    //Total Size of each ifd
    LIFDSize := CDirCountSize + (LDirCount * CDirSize) + CIFDOffsetSize;
    //value stream OffSet
    LValOffset := LFirstIFDOffset + LIFDSize * FImageCount;
    for LK:=0 to (FImageCount-1) do
    begin
      // write no. of Direrctory Entries
      FTIFFStream.Write(LDirCount, 2);
      // Directory Entries
      // Width
      WriteWord([CTagWidth, CTypeShort, 1, 0], FTIFFStream);
      LL := Cardinal(FWidths[LK]);
      FTIFFStream.Write(LL, 4);
      // Length
      WriteWord([CTagLength, CTypeShort, 1, 0], FTIFFStream);
      LL := Cardinal(FHeights[LK]);
      FTIFFStream.Write(LL, 4);
      // Bits Per Sample
      if Grayscale then
        WriteWord([CTagBitsPerSample, CTypeShort, 1, 0, CBitsPerSample, 0], FTIFFStream)
      else
      begin
        WriteWord([CTagBitsPerSample, CTypeShort, 3, 0], FTIFFStream);
        LL := LValOffset + LValStream.Size;
        FTIFFStream.Write(LL, 4);
        WriteWord([CBitsPerSample, CBitsPerSample, CBitsPerSample], LValStream);
      end;
      // Compression: default = 1 = No Compression
      if CompressionType <> ctNone then
      begin
        WriteWord([CTagCompression, CTypeShort, 1, 0], FTIFFStream);
        FTIFFStream.Write(LCmprValue[CompressionType], 4);
      end;
      // Photometric Interpretation
      WriteWord([CTagPhotometricInterpretation, CTypeShort, 1, 0, 2, 0], FTIFFStream);
      // Image Description
      if DocInfo.Subject <> '' then
      begin
        WriteWord([CTagImageDesc, CTypeAscii], FTIFFStream);
        LL := Cardinal(Length(DocInfo.Subject))+1;
        FTIFFStream.Write(LL, 4);
        DocInfo.Subject := DocInfo.Subject + #0;
        if (LL > 4) then
        begin
          LL := LValOffset + LValStream.Size;
          FTIFFStream.Write(LL, 4);
          LValStream.Write(DocInfo.Subject[1], SizeOf(DocInfo.Subject));
        end
        else
        begin
          FTIFFStream.Write(DocInfo.Subject[1], 4);
        end;
      end;
      // Strip Offsets : write and update
      WriteWord([CTagStripOffsets, CTypeLong, 1, 0], FTIFFStream);
      LL := Cardinal(LStripOffset);
      FTIFFStream.Write(LL, 4);
      LStripOffset := LStripOffset + Int64(FImgSizes[LK]);
      // Samples Per Pixel : Not present in grayscale images
      if (not Grayscale) then
        WriteWord([CTagSamplesPerPixel, CTypeShort, 1, 0, 3, 0], FTIFFStream);
      // Rows Per Strip
      WriteWord([CTagRowsPerStrip, CTypeShort, 1, 0, Word(FHeights[LK])+1, 0], FTIFFStream);
      // Strip Byte Counts
      WriteWord([CTagStripByteCounts, CTypeLong, 1, 0], FTIFFStream);
      LL := Cardinal(FImgSizes[LK]);
      FTIFFStream.Write(LL, 4);
      // X Resolution
      WriteWord([CTagXRes, CTypeRational, 1, 0], FTIFFStream);
      LL := LValOffset + LValStream.Size;
      FTIFFStream.Write(LL, 4);
      WriteWord([96, 0, 1, 0], LValStream);
      // Y Resolution
      WriteWord([CTagYRes, CTypeRational, 1, 0], FTIFFStream);
      LL := LValOffset + LValStream.Size;
      FTIFFStream.Write(LL, 4);
      WriteWord([96, 0, 1, 0], LValStream);
      // Software
      if DocInfo.Creator <> '' then
      begin
        WriteWord([CTagSoftware, CTypeAscii], FTIFFStream);
        LL := Length(DocInfo.Creator) + 1;
        FTIFFStream.Write(LL, 4);
        DocInfo.Creator := DocInfo.Creator + #0;
        if (LL > 4) then
        begin
          LL := LValOffset + LValStream.Size;
          FTIFFStream.Write(LL, 4);
          LValStream.Write(DocInfo.Creator[1], Length(DocInfo.Creator));
        end
        else
        begin
          FTIFFStream.Write(DocInfo.Creator[1], 4);
        end;
      end;
      // Artist
      if DocInfo.Author <> '' then
      begin
        WriteWord([CTagArtist, CTypeAscii], FTIFFStream);
        LL := Length(DocInfo.Author) + 1;
        FTIFFStream.Write(LL, 4);
        DocInfo.Author := DocInfo.Author + #0;
        if (LL > 4) then
        begin
          LL := LValOffset + LValStream.Size;
          FTIFFStream.Write(LL, 4);
          LValStream.Write(DocInfo.Author[1], Length(DocInfo.Author));
        end
        else
        begin
          FTIFFStream.Write(DocInfo.Author[1], 4);
        end;
      end;

      // End of IFD's
      if LK = (FImageCount - 1) then // Last IFD
        FTIFFStream.Write(LZero, 4)
      else
      begin // Next IFD offset
        LIFDOffsets := FTIFFStream.Size + CIFDOffsetSize;
        FTIFFStream.Write(LIFDOffsets, 4);
      end;
    end;
    FTIFFStream.CopyFrom(LValStream, 0);
    // Write to the stream
    FTIFFStream.Position := 4;
    FTIFFStream.Write(LFirstIFDOffset, 4);
  finally
  	LValStream.Free;
  end;
end;

destructor TgtTIFFEngine.Destroy;
begin

  inherited;
end;

procedure TgtTIFFEngine.Finish;
begin
  inherited;
  if MultiPage then
  begin
    CreateTIFF;
    EndTIFF;
  end;
end;

procedure TgtTIFFEngine.EndPage;
var
  LFlateFilter: TgtFlateFilter;
  LRLEFilter: TgtRLEFilter;
  LI, LJ: Integer;
  LL: Cardinal;
  LB: Byte;
  LBitmap: TBitmap;
  LTmp1, LTmp2, LTmp3: TMemoryStream;
begin
  inherited EndPage;

  LBitmap := TBitmap.Create;
  LTmp3 := TMemoryStream.Create;
  try
    LBitmap.Width := Round(FMetafile.Width * ScaleX);
    LBitmap.Height := Round(FMetafile.Height * ScaleY);

    with LBitmap do
      Canvas.StretchDraw(Rect(0, 0, Width, Height), FMetafile);

    if (not MultiPage) then InitTIFF;
    Inc(FImageCount);
    FHeights.Add(TObject(LBitmap.Height));
    FWidths.Add(TObject(LBitmap.Width));
    for LI := 0 to (LBitmap.Height - 1) do
    begin
      LTmp2 := TMemoryStream.Create;
      for LJ := 0 to (LBitmap.Width - 1) do
      begin
        LL := ColorToRGB(LBitmap.Canvas.Pixels[LJ, LI]);
        if Grayscale then
        begin
          // convert to gray scale and write one byte
          LB := Byte(((LL shr 16) + ((LL shl 16) shr 24) + ((LL shl 24) shr 24)) div 3);
          LTmp2.Write(LB, 1);
        end
        else LTmp2.Write(LL, 3);
      end;
      if CompressionType = ctPackBits then
      begin
        LRLEFilter := TgtRLEFilter.Create;
        LTmp1 := LRLEFilter.Encode(LTmp2);
        LTmp2.Clear;
        LTmp1.Position := 0;
        LTmp2.CopyFrom(LTmp1, 0);
        LTmp1.Free;
        LRLEFilter.Free;
      end;
      LTmp3.CopyFrom(LTmp2, 0);
      LTmp2.Free;
    end;
    if CompressionType = ctZip then
    begin
      LFlateFilter := TgtFlateFilter.Create;
      LTmp1 := LFlateFilter.Encode(LTmp3, clMax);
      LTmp1.Position := 0;
      LTmp3.Clear;
      LTmp3.CopyFrom(LTmp1, 0);
      LTmp1.Free;
      LFlateFilter.Free;
    end;
    FTIFFStream.CopyFrom(LTmp3, 0);
    FImgSizes.Add(TObject(LTmp3.Size));
    if (not MultiPage) then
    begin
      CreateTIFF;
      EndTIFF;
    end;
  finally
    LTmp3.Free;
    LBitmap.Free;
  end;
end;

procedure TgtTIFFEngine.EndTIFF;
begin
  if (not Preferences.OutputToUserStream) then
    FTIFFStream.Free;
  FHeights.Free;
  FWidths.Free;
  FImgSizes.Free;
end;

procedure TgtTIFFEngine.InitTIFF;
var
  LZero : Cardinal;
  LFileName: String;
begin
  LZero := 0;
  if (not Preferences.OutputToUserStream) then
  begin
    if MultiPage then
    begin
    	LFileName := FileName;
      if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      FTIFFStream := CreateFile(LFileName + '.' + FileExtension)
    end
    else
    begin
    	LFileName := FileName + IntToStr(CurrentPage);
      if Assigned(OnNeedFileName) then
      	OnNeedFileName(Self, LFileName, CurrentPage);
      FTIFFStream := CreateFile(LFileName + '.' + FileExtension)
    end;
  end;
  WriteWord([CByteOrder, CTIFFId], FTIFFStream);
  FTIFFStream.Write(LZero, 4);
  FHeights := TList.Create;
  FWidths := TList.Create;
  FImgSizes := TList.Create;
  FImageCount := 0;
  EngineFileNames.Add(LFileName + '.' + FileExtension);
end;

procedure TgtTIFFEngine.SetGrayscale(const Value: Boolean);
begin
  FGrayscale := Value;
end;

procedure TgtTIFFEngine.SetMultiPage(const Value: Boolean);
begin
  FMultiPage := Value;
end;

procedure TgtTIFFEngine.SetTIFFCompressionType(
  const Value: TgtTIFFCompressionType);
begin
  FTIFFCompressionType := Value;
end;

procedure TgtTIFFEngine.WriteWord(ABuf: array of word; AStream: TStream);
begin
	AStream.Write(ABuf, Sizeof(ABuf));
end;

function TgtTIFFEngine.ShowSetupModal: Word;
begin
  with TgtTIFFEngineDlg.Create(nil) do
  try
    Engine := Self;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
