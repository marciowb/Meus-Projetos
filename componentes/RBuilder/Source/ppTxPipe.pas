{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }                          

unit ppTxPipe;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6}Variants,{$ENDIF}
  Windows,
  Classes,
  SysUtils,
  Graphics,
  Math,

  ppTypes,
  ppCharacter,
  ppCollectionBase,
  ppDB,
  ppUtils;


const
  {note: only these datatypes are supported by the TextPipeline}
  cValidTextDataType: TppDataTypeSet = [dtString, dtInteger, dtLongint, dtDouble, dtBoolean,
                                        dtDateTime, dtDate, dtTime];

type

  TppTextPipeline = class;

  {TppBookmarkCollection }
  TppBookmarkCollection = class(TppIndexedCollectionBase)
  private
    FItemIndex: Integer;

    function GetItem(aIndex: Integer): Integer;
    function GetCurrent: Integer;
    function GetPrior: Integer;
    function GetNext: Integer;
    procedure SetCurrent(aBookmark: Integer);

  protected
    function GetKey(aObject: TObject): String; override;

  public
    function Add(aBookmark: Integer): Integer;
    function Contains(aBookmark: Integer): Boolean;

    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property Current: Integer read GetCurrent write SetCurrent;
    property Next: Integer read GetNext;
    property Prior: Integer read GetPrior;

  end;

  {TppFileDataStream }
  TppFileDataStream = class(TObject)
    private
      FActive: Boolean;
      FCurrentRecordSize: Longint;
      FFieldBuf: PChar;
      FFieldDelimiter: Char;
      FFieldStrings: TStringList;
      FFileStream: TFileStream;
      FStreamSize: Longint;
      FMaxCharsPerRecord: Longint;
      FRecordBuf: PChar;
      FTextPipeline: TppTextPipeline;
      FBOF: Boolean;
      FEOF: Boolean;
      FQuoteChar: Char;
      FRemoveSurroundingQuotes: Boolean;
      FStreamEncoding: TEncoding;
      FEolSize: Integer;
      FBOMLength: Integer;
      FMaxRecBufSize: Integer;
{$IFDEF UNICODE}
      FBookmarks: TppBookmarkCollection;
{$ENDIF}

      function  CalcMaxCharsPerRecord: Integer;
      function CheckEndOfDelimitedField(aPStartStr, aPCurrentStr, aPEndBuffer: PChar): Boolean;
      function FetchNext: Boolean;
      function FetchPrior: Boolean;
      procedure GetFieldData;
      function GetFieldStringIndex(aFieldName: String): Integer;
      procedure LoadFieldBufferDelimited;
      procedure LoadFieldBufferFixed;
      procedure SeekPrior;
{$IFDEF UNICODE}
      function ReadChars(var aChars: TCharArray; aCharCount: Integer): Integer;
      function ReadCharBytes(var aChars: TCharArray; aByteCount: Integer): Integer;
{$ENDIF}
      function GetBOF: Boolean;
      function GetEOF: Boolean;

    public
      constructor Create(aTextPipeline: TppTextPipeline);
      destructor Destroy; override;

      procedure Open;
      procedure Close;

      function  GetBookmark: Longint;
      procedure GoToBookmark(aBookmark: Longint);
      procedure FreeBookmark(aBookmark: Longint);

      procedure First;
      procedure Last;
      function  MoveBy(aIncrement: Longint): Integer;

      function  GetFieldAsString(aFieldName: String): String;
      function  GetFieldAsInteger(const aFieldName: String): Longint;
      function  GetFieldAsFloat(const aFieldName: String): Double;
      function  GetFieldAsGuid(const aFieldName: String): TGuid;
      function  GetFieldAsBoolean(const aFieldName: String): Boolean;

      property Active: Boolean read FActive;
      property BOF: Boolean read GetBOF;
      property EOF: Boolean read GetEOF;

      property QuoteChar: Char read FQuoteChar write FQuoteChar;
      property RemoveSurroundingQuotes: Boolean read FRemoveSurroundingQuotes write FRemoveSurroundingQuotes;

  end; {class, TppFileDataStream}


  {@TppTextPipeline

    Assign a TppTextPipeline component to the DataPipeline property of any
    data-aware report component in order for that component to access data from
    an ASCII text file. Use the FileName property to specify the file from which
    data is to be retrieved.  Use the FileType property to specify the format of
    he data.

    When the DataPipeline is assigned to a Report or to a DetailBand, several
    additional properties can be used to describe how the data should be
    traversed. The RangeBegin property describes the record on which traversal
    should start. The RangeEnd property describes the record on which traversal
    should stop. The AddBookmark method can be used to traverse a list of
    records.

    Note: See the NoData demos such as dm0131 for an example of how to use a
    text pipeline.}

  {@TppTextPipeline.BooleanFalse

    String to be used when evaluating whether a boolean field is false.}

  {@TppTextPipeline.BooleanTrue

    String to be used when evaluating whether a boolean field is true.}

  {@TppTextPipeline.CustomDelimiter

    String to be used when parsing the text file data of a ftCustom file 
    type.}

  {@TppTextPipeline.FileName

    Full path and file name of the file from which the ASCII data will be 
    read.}

  {@TppTextPipeline.FileType

    Specifies the format of the file. These are the possible values:

    <Table>
    Value	          Meaning
    ------------    -----------
    ftComma	        Comma delimited file
    ftTab	          Tab delimited file.
    ftFixedLength	  Fixed-length records, each field is of a fixed length.
    ftCustom	      Parses the fields of each record based on the delimiter
                    specified in CustomDelimiter.
    </Table>}


  {@TppTextPipeline.QuoteChar

    Defaults to the double quote character ("). When the RemoveSurroundingQuotes
    property is set to true, the text pipeline will remove any surrounding
    quote characters from string data values. }

  {@TppTextPipeline.RemoveSurroundingQuotes

    Defaults to True. When set to true, the text pipeline will remove any
    surrounding quote characters from string data values. The QuoteChar
    property can be used to customize the value of the quote character.}

  TppTextPipeline = class(TppCustomDataPipeline)
    private
      FBooleanTrue: String;
      FBooleanFalse: String;
      FCustomDelimiter: Char;
      FFileName: String;
      FFileType: TppFileType;
      FFileStream: TppFileDataStream;
      FQuoteChar: Char;
      FRemoveSurroundingQuotes: Boolean;
{$IFDEF UNICODE}
      FEncoding: TEncoding;
{$ENDIF}
      procedure SetFileName(const aFileName: String);
      procedure SetFileType(aFileType: TppFileType);
      procedure SetBooleanTrue(aValue: String);
      procedure SetBooleanFalse(aValue: String);
      procedure SetCustomDelimiter(aDelimeter: Char);

    protected
 
      {overriden from TppDataPipeline}
      procedure CloseDataSet; override;
      function  GetActive: Boolean; override;
      function  CheckBOF: Boolean; override;
      function  CheckEOF: Boolean; override;
      procedure GotoFirstRecord; override;
      procedure GotoLastRecord; override;
      procedure OpenDataSet; override;
      function TraverseBy(aIncrement: Integer): Integer; override;

      {field support}
      property AutoCreateFields default False;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      {overriden from TppDataPipeline}
      procedure FreeBookmark(aBookmark: Longint); override;
      function  GetBookmark: Longint; override;
      function  GetDataSetName: String; override;
      function  GetFieldAlignment(aFieldName: String): TAlignment; override;
      function  GetFieldAsDouble(aFieldName: String): Double; override;
      function  GetFieldAsGuid(aFieldName: String): TGuid; override;
      function  GetFieldAsPicture(aFieldName: String): TPicture; override;
      function  GetFieldAsString(aFieldName: String): String; override;
      function  GetFieldDataType(aFieldName: String): TppDataType; override;
      function  GetFieldDisplayWidth(aFieldName: String): Integer; override;
      function  GetFieldIsCalculated(aFieldName: String): Boolean; override;
      function  GetFieldIsNull(aFieldName: String): Boolean; override;
      function  GetFieldSize(aFieldName: string): Integer; override;
      function  GetFieldValue(aFieldName: string): Variant; override;

      procedure GotoBookmark(aBookmark: Longint); override;

      function  IsValidDataType(aDataType: TppDataType): Boolean; override;

      property QuoteChar: Char read FQuoteChar write FQuoteChar;
      property RemoveSurroundingQuotes: Boolean read FRemoveSurroundingQuotes write FRemoveSurroundingQuotes;

{$IFDEF UNICODE}
      property Encoding: TEncoding read FEncoding write FEncoding;
{$ENDIF}

    published
      property BooleanTrue: String read FBooleanTrue write SetBooleanTrue;
      property BooleanFalse: String read FBooleanFalse write SetBooleanFalse;
      property CustomDelimiter: Char read FCustomDelimiter write SetCustomDelimiter default ',';
      property FileName: String read FFileName write SetFileName;
      property FileType: TppFileType read FFileType write SetFileType default ftComma;

      {TppDataPipeline properties}
      property MasterDataPipeline;
      property MoveBy;
      property RangeEnd;
      property RangeEndCount;
      property RangeBegin;
      property SkipWhenNoRecords;
      property UserName;
      property Visible;

      {TppDataPipeline events}
      property AfterClose;
      property AfterOpen;
      property BeforeClose;
      property BeforeOpen;
      property OnDataChange;
      property OnFirst;
      property OnGotoBookmark;
      property OnLast;
      property OnMasterRecordPositionChange;
      property OnNext;
      property OnPrior;
      property OnRecordPositionChange;
      property OnTraversal;

  end; {class, TppTextPipeline}


 {@TppChildTextPipeline }
  TppChildTextPipeline = class(TppTextPipeline)
    protected
      function GetChildOwner: TComponent; override;

    public
      function HasParent: Boolean; override;

    end; {class, TppChildTextPipeline}



implementation


{******************************************************************************
 *
 ** C H I L D   T E X T  P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppChildTextPipeline.GetChildOwner }

function TppChildTextPipeline.GetChildOwner: TComponent;
begin
  Result := Self;
end; {function, GetChildOwner}

{------------------------------------------------------------------------------}
{ TppChildTextPipeline.HasParent }

function TppChildTextPipeline.HasParent: Boolean;
begin
  Result := True;
end; {function, HasParent}

{******************************************************************************
 *
 ** F I L E   D A T A   I N D E X
 *
{******************************************************************************}

function TppBookmarkCollection.GetItem(aIndex: Integer): Integer;
begin
  Result := Integer(InnerList[aIndex]);
end;

procedure TppBookmarkCollection.SetCurrent(aBookmark: Integer);
begin
  FItemIndex := IndexOfKey(IntToStr(aBookmark));
  if (FItemIndex < 0) then
    Add(aBookmark);
end;

function TppBookmarkCollection.GetCurrent: Integer;
begin
  Result := Integer(InnerList[FItemIndex]);
end;

function TppBookmarkCollection.GetNext: Integer;
begin

  if (FItemIndex < Count-1) then
    Result := GetItem(FItemIndex+1)
  else
    Result := -1;

end;

function TppBookmarkCollection.GetPrior: Integer;
begin
  if (FItemIndex > 0) then
    Result := GetItem(FItemIndex-1)
  else
    Result := -1;
end;

function TppBookmarkCollection.GetKey(aObject: TObject): String;
begin
  Result := IntToStr(Integer(aObject));
end;

function TppBookmarkCollection.Add(aBookmark: Integer): Integer;
begin
  FItemIndex := InternalAdd(TObject(aBookmark));
  Result := FItemIndex;
end;

function TppBookmarkCollection.Contains(aBookmark: Integer): Boolean;
begin
  Result := IndexOfKey(IntToStr(aBookmark)) >= 0;
end;


{******************************************************************************
 *
 ** F I L E  D A T A  S T R E A M
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFileDataStream.Create }

constructor TppFileDataStream.Create(aTextPipeline: TppTextPipeline);
begin

  inherited Create;

  FTextPipeline := aTextPipeline;

  FActive       := False;
  FFieldStrings := nil;
  FFileStream   := nil;
  FBOF := True;
  FEOF := True;

end; {constructor, Create}


{------------------------------------------------------------------------------}
{ TppFileDataStream.Destroy }

destructor TppFileDataStream.Destroy;
begin
  if FActive then
    Close;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppFileDataStream.Open }

procedure TppFileDataStream.Open;
begin

  if FActive then Exit;

  case FTextPipeline.FileType of

    ftTab:    FFieldDelimiter := #9;

    ftComma:  FFieldDelimiter := ',';

    ftCustom: FFieldDelimiter := FTextPipeline.CustomDelimiter;

  else {fixed length, not used}
    FFieldDelimiter := ',';
  end;

  FQuoteChar := FTextPipeline.QuoteChar;
  FRemoveSurroundingQuotes := FTextPipeline.RemoveSurroundingQuotes;

  FFileStream   := TFileStream.Create(FTextPipeline.FileName, fmOpenRead or fmShareDenyWrite);
  FFieldStrings := TStringList.Create;

{$IFDEF UNICODE}
  FBookmarks := TppBookmarkCollection.Create;

  // either use an assigned encoding, or auto detect one
  if (FTextPipeline.Encoding <> nil) then
    FStreamEncoding := FTextPipeline.Encoding
  else
{$ENDIF}
    FStreamEncoding := TppEncodingUtils.GetStreamEncoding(FFileStream);


  FBOMLength := TppEncodingUtils.GetBOMLength(FStreamEncoding);

  FActive     := True;
  FStreamSize := FFileStream.Size;

  FEolSize := FStreamEncoding.GetByteCount(#13#10);

  FCurrentRecordSize  := 0;
  FMaxCharsPerRecord  := CalcMaxCharsPerRecord;
  FMaxRecBufSize      := ppByteLength(FMaxCharsPerRecord + 2);

  FRecordBuf := AllocMem(ppByteLength(FMaxRecBufSize));
  FFieldBuf  := AllocMem(ppByteLength(FMaxRecBufSize));

  FEOF := False;

  {load the field buffer with data from the first record}
  First;
  SeekPrior;


end; {procedure, Open}

{------------------------------------------------------------------------------}
{ TppFileDataStream.Close }

procedure TppFileDataStream.Close;
begin

  if not FActive then Exit;

  FreeMem(FRecordBuf, ppByteLength(FMaxRecBufSize));
  FreeMem(FFieldBuf,  ppByteLength(FMaxRecBufSize));

  FFileStream.Free;
  FFileStream := nil;

  FFieldStrings.Free;
  FFieldStrings := nil;

  FRecordBuf := nil;
  FFieldBuf  := nil;

{$IFDEF UNICODE}
  FBookmarks.Free;
  FBookmarks := nil;
{$EnDIF}

  FBOF := True;
  FEOF := True;

  FActive := False;

end; {procedure, Close}


{------------------------------------------------------------------------------}
{ TppFileDataStream.CalcMaxCharsPerRecord }

function TppFileDataStream.CalcMaxCharsPerRecord: Integer;
var
  liField: Integer;
begin

  Result := 0;

  {calc sum of all field lengths}
  for liField := 0 to FTextPipeline.FieldCount-1 do
    Result := Result + FTextPipeline.Fields[liField].FieldLength;

  {add one for field delimiter}
  Result := Result + ((FTextPipeline.FieldCount-1) * Length(FFieldDelimiter));

  {each record will have an end of line marker (i.e. #13#10 pair) }
  Result := Result + 2;

  if Odd(Result) then
    Result := Result + 1;

end;

{------------------------------------------------------------------------------}
{ TppFileDataStream.GetBOF }

function TppFileDataStream.GetBOF: Boolean;
begin
  Result := (FFileStream = nil) or (FFileStream.Size = 0) or FBOF;

end; {function, GetBOF}


{------------------------------------------------------------------------------}
{ TppFileDataStream.GetEOF }

function TppFileDataStream.GetEOF: Boolean;
begin
  Result := (FFileStream = nil) or (FFileStream.Size = 0) or FEOF;


end; {function, GetEOF}

{------------------------------------------------------------------------------}
{ TppFileDataStream.GetBookmark }

function TppFileDataStream.GetBookmark: Longint;
begin

  Result := -1;

  if not FActive then Exit;

{$IFDEF UNICODE}
  Result := FBookmarks.Prior;
{$ELSE}
  if FFileStream.Position = 0 then
    Result := 0
  else
    Result := FFileStream.Position - FCurrentRecordSize;
{$ENDIF}

end; {function, GetBookmark}

{------------------------------------------------------------------------------}
{ TppFileDataStream.FreeBookmark }

procedure TppFileDataStream.FreeBookmark(aBookmark: Longint);
begin

end; {procedure, FreeBookmark}

{------------------------------------------------------------------------------}
{ TppFileDataStream.GotoBookmark }

procedure TppFileDataStream.GotoBookmark(aBookmark: Longint);
begin
  if not FActive then Exit;

  FFileStream.Position := aBookmark;

{$IFDEF UNICODE}
  FBookmarks.Current := aBookmark;
{$ENDIF}

  FetchNext;

  GetFieldData;

end; {procedure, GotoBookmark}

{------------------------------------------------------------------------------}
{ TppFileDataStream.First }

procedure TppFileDataStream.First;
begin

  if not FActive then Exit;

  FFileStream.Position := FBOMLength;

{$IFDEF UNICODE}
  if FBookmarks.Count > 0 then
    FBookmarks.ItemIndex := 0;

  FBookmarks.Current := FFileStream.Position;
{$ENDIF}

  FetchNext;
  
  GetFieldData;

  FBOF := True;

end; {procedure, First}

{------------------------------------------------------------------------------}
{ TppFileDataStream.Last }

procedure TppFileDataStream.Last;
begin

  if not FActive then Exit;


{$IFDEF UNICODE}
  // position to last bookmark
  FBookmarks.ItemIndex := FBookmarks.Count-1;
  FFileStream.Position := FBookmarks.Current;

  // fetchnext until end of stream
  while (FBookmarks.Current < FFileStream.Size) do
    FetchNext;

{$ELSE}
  FFileStream.Position := FFileStream.Size;

{$ENDIF}

  SeekPrior;

  {update BOF here}
  FBOF := FFileStream.Position = FBOMLength;

  FetchNext;

  GetFieldData;

end; {procedure, Last}

{------------------------------------------------------------------------------}
{ TppFileDataStream.MoveBy }

function TppFileDataStream.MoveBy(aIncrement: Longint): Integer;
begin

  Result := 0;

  if not FActive then Exit;

  if aIncrement > 0 then
    while (Result < aIncrement) and not EOF do
      begin
        if FetchNext then
          Inc(Result);
      end
  else
    while (Result < Abs(aIncrement)) and not BOF do
      begin
        if FetchPrior then
          Inc(Result);
      end;

  GetFieldData;

end; {procedure, MoveBy}

{$IFDEF UNICODE}

{------------------------------------------------------------------------------}
{ TppFileDataStream.ReadCharBytes }

function TppFileDataStream.ReadCharBytes(var aChars: TCharArray; aByteCount: Integer): Integer;
var
  lBytes: TBytes;
  liBytesRead: Integer;
begin

  // initialize
  SetLength(lBytes, aByteCount);
  SetLength(aChars, 0);

  // read bytes from stream
  liBytesRead := FFileStream.Read(lBytes[0], aByteCount);

  // decode bytes to chars
  if liBytesRead > 0 then
    begin
      aChars := FStreamEncoding.GetChars(lBytes, 0, liBytesRead);

      Result := Length(aChars);
    end
  else
    Result := 0;

end;

{------------------------------------------------------------------------------}
{ TppFileDataStream.ReadChars }

function TppFileDataStream.ReadChars(var aChars: TCharArray; aCharCount: Integer): Integer;
var
  lBytes: TBytes;
  lTempChars: TCharArray;
  liTempChars: Integer;
  liCharsRead: Integer;
  liStreamPos: Integer;
begin

  liCharsRead := 0;

  // initialize buffers
  SetLength(aChars, aCharCount);
  SetLength(lBytes, aCharCount);

  liStreamPos := FFileStream.Position;

  // try to read the requested number of chars
  while (liStreamPos <= (FFileStream.Size-FEolSize)) and (liCharsRead < aCharCount) do
    begin

      FFileStream.Position := liStreamPos;

      // read some chars
      liTempChars := ReadCharBytes(lTempChars, aCharCount);

      if liTempChars = 0 then Break;

      liTempChars := Math.Min(liTempChars, aCharCount-liCharsRead);

      SetLength(lTempChars, liTempChars);

      // copy TempChars to aChars
      Move(lTempChars[0], aChars[liCharsRead], ppByteLength(liTempChars));

      // increment chars read
      liCharsRead := liCharsRead + liTempChars;

      // increment the stream position by the number of valid bytes read
      liStreamPos := liStreamPos + FStreamEncoding.GetByteCount(lTempChars);

    end;

  SetLength(aChars, liCharsRead);

  Result := liCharsRead;

end;


{------------------------------------------------------------------------------}
{ TppFileDataStream.FetchNext }

function TppFileDataStream.FetchNext: Boolean;
var
  llStreamPosition: Longint;
  lpEndOfLine: PChar;
  lChars: TCharArray;
  lsEndOfLineMarker: String;
  liCharsRead: Integer;
begin

  Result := False;

  FEOF := (FFileStream.Position >= FFileStream.Size);

  if (FEOF) then
    FBOF := (FFileStream.Position = FBOMLength)
  else if (FBookmarks.Next > 0)  then
    begin

      // read chars from stream into reocord buf
      FCurrentRecordSize := FBookmarks.Next - FBookmarks.Current;
      liCharsRead := ReadCharBytes(lChars, FCurrentRecordSize);
      Move(lChars[0], FRecordBuf^, ppByteLength(liCharsRead));

      if FRecordBuf[FCurrentRecordSize-2] = #13 then
        FRecordBuf[FCurrentRecordSize-2] := #0
      else
        FRecordBuf[FCurrentRecordSize-1] := #0;

      {increment stream position }
      FBookmarks.ItemIndex := FBookmarks.ItemIndex + 1;

      FBOF := False;

      Result := True;

    end
  else
    begin

      {save current position in stream}
      llStreamPosition := FFileStream.Position;

      liCharsRead := ReadChars(lChars, FMaxCharsPerRecord);

      // copy chars to record buf
      if liCharsRead > 0 then
        Move(lChars[0], FRecordBuf^, ppByteLength(liCharsRead));

      // append a null terminator to the end
      FRecordBuf[liCharsRead] := #0;

      lsEndOfLineMarker := '';

      {find end of line - either a #13#10 or #10}
      lpEndOfLine := StrPos(FRecordBuf, #13#10);

      if (lpEndOfLine = nil) then
        lpEndOfLine := StrPos(FRecordBuf, #10);

      if (lpEndOfLine <> nil) then
        begin
          if lpEndOfLine[0] = #13 then
            lsEndOfLineMarker := #13#10
          else
            lsEndOfLineMarker := #10;

          lpEndOfLine^ := #0;

        end;

      SetLength(lChars, StrLen(FRecordBuf));

      FCurrentRecordSize := FStreamEncoding.GetByteCount(lChars) + FStreamEncoding.GetByteCount(lsEndOfLineMarker);

      {increment stream position }
      FFileStream.Position := llStreamPosition + FCurrentRecordSize;

      FBookmarks.Current := FFileStream.Position;

      FBOF := False;

      Result := True;
    end;

end; {function, FetchNext}

{$ELSE}

function TppFileDataStream.FetchNext: Boolean;
var
  llBytesRead: Longint;
  llStreamPosition: Longint;
  lpEndOfLine: PChar;
  liEndOfLineMarker: Cardinal;
begin

  Result := False;

  FEOF := (FFileStream.Position >= FFileStream.Size);

  if not(FEOF) then
    begin

      {save current position in stream}
      llStreamPosition := FFileStream.Position;

      {read data from stream into record buffer}
      llBytesRead := FFileStream.Read(FRecordBuf^, FMaxCharsPerRecord+1);

      FRecordBuf[llBytesRead] := #0;

      liEndOfLineMarker := 0;

      {find end of line - either a #13#10 or #10}
      lpEndOfLine := StrPos(FRecordBuf, #13#10);

      if (lpEndOfLine = nil) then
        lpEndOfLine := StrPos(FRecordBuf, #10);

      if (lpEndOfLine <> nil) then
        begin
          if lpEndOfLine[0] = #13 then
            liEndOfLineMarker := 2
          else
            liEndOfLineMarker := 1;

          lpEndOfLine^ := #0;

        end;

      FCurrentRecordSize := StrLen(FRecordBuf) + liEndOfLineMarker;

      {increment stream position }
      FFileStream.Position := llStreamPosition + FCurrentRecordSize;

      FBOF := False;

      Result := True;
    end

  else
    FBOF := (FFileStream.Position = FBOMLength);

end; {function, FetchNext}


{$ENDIF}


{------------------------------------------------------------------------------}
{ TppFileDataStream.FetchPrior }

function TppFileDataStream.FetchPrior: Boolean;
var
  llCurrentRecStart: Longint;

begin

  Result := False;

  if GetBOF then Exit;

  {move to start of current record}
  llCurrentRecStart := FFileStream.Position - (FCurrentRecordSize+ FEolSize);

  if llCurrentRecStart >= 0 then
    begin
    {$IFDEF UNICODE}
      // start of current record
      FBookmarks.ItemIndex := FBookmarks.ItemIndex-1;
      FFileStream.Position := FBookmarks.Current;
    {$ELSE}
      FFileStream.Position := llCurrentRecStart;
    {$ENDIF}
    end
  else
    First;

  {need to check BOF again here}
  if GetBOF then Exit;

  {find start of prior record}
  SeekPrior;

  {read the record}
  FetchNext;

  Result := True;


end; {function, FetchPrior}

{$IFDEF UNICODE}

{------------------------------------------------------------------------------}
{ TppFileDataStream.SeekPrior }

procedure TppFileDataStream.SeekPrior;
begin

  if not GetBOF then
    begin
      // position to prior record
      FBookmarks.Current := FBookmarks.Prior;
      FFileStream.Position := FBookmarks.Current;
    end;

end; {seek prior}

{$ELSE}

{------------------------------------------------------------------------------}
{ TppFileDataStream.SeekPrior }

procedure TppFileDataStream.SeekPrior;
var
  llBytesRead: Longint;
  llSavePosition: Longint;
  lpStartOfLine: PChar;
  llReadSize: Longint;
  lRecordBuf: PChar;

begin


  if GetBOF then Exit;

  {save current position in stream}
  llSavePosition := FFileStream.Position;

  {go backwards (max record size + #13#10) }
  if FFileStream.Position > (FMaxCharsPerRecord+FEolSize) then
    begin
      FFileStream.Position := FFileStream.Position - (FMaxCharsPerRecord+FEolSize);
      llReadSize := FMaxCharsPerRecord;
    end
  else
    begin
      FFileStream.Position := FBOMLength;
      llReadSize := llSavePosition-FEolSize;
    end;

  {read data from stream into record buffer}
  llBytesRead := FFileStream.Read(FRecordBuf^, llReadSize);

  lRecordBuf := PChar(FRecordBuf);

  lRecordBuf[llBytesRead] := #0;

  {find start of rec}
  lpStartOfLine := lRecordBuf + StrLen(lRecordBuf);

  while not ppCharInSet(lpStartOfLine^, [#13,#10]) and (lpStartOfLine >= lRecordBuf) do
    Dec(lpStartOfLine);

  Inc(lpStartOfLine);

  StrCopy(lRecordBuf, lpStartOfLine);

  {decrement stream position }
  FFileStream.Position := llSavePosition - (Integer(StrLen(lRecordBuf)) + FEolSize);


end; {seek prior}

{$ENDIF}

{------------------------------------------------------------------------------}
{ TppFileDataStream.GetFieldData }

procedure TppFileDataStream.GetFieldData;
begin

  {load field buffer }
  if FTextPipeline.FileType = ftFixedLength then
    LoadFieldBufferFixed
  else
    LoadFieldBufferDelimited;

end;  {procedure, GetFieldData}


{------------------------------------------------------------------------------}
{ TppFileDataStream.CheckEndOfDelimitedField }

function TppFileDataStream.CheckEndOfDelimitedField(aPStartStr, aPCurrentStr, aPEndBuffer: PChar): Boolean;
var
  lpPriorChar: PChar;
begin

  Result := False;
  
  if (aPCurrentStr^ = '#0') then // null terminator
    Result := True
  else if (aPCurrentStr > aPEndBuffer) then // end of buffer
    Result := True
  else if (aPCurrentStr^ = FFieldDelimiter) then // field delimiter
    begin

      if (aPStartStr^ <> QuoteChar) then  // not a quoted string
         Result := True
      else // check prior character for the presence of the end quote (i.e. 'Hello, world',)
        begin
          lpPriorChar := aPCurrentStr-1;
          if (lpPriorChar <> aPStartStr) and (lpPriorChar^ = QuoteChar) then
            Result := True;
        end;

    end;

end;

{------------------------------------------------------------------------------}
{ TppFileDataStream.LoadFieldBufferDelimited }

procedure TppFileDataStream.LoadFieldBufferDelimited;
var
  lpStartStr, lpEndStr: PChar;
  lpEndBuffer: PChar;
  lbEndString: Boolean;
  llBufSize: Longint;

begin

  {copy record bugger to field buffer}
  StrCopy(FFieldBuf, FRecordBuf);

  {parse the field buffer}
  llBufSize   := StrLen(FFieldBuf);
  lpStartStr  := FFieldBuf;
  lpEndBuffer := lpStartStr + llBufSize;
  lbEndString := False;

  FFieldStrings.Clear;

  while not lbEndString do
    begin

      {remove leading spaces}
   {   while (lpStartStr^ = ' ') and (lpStartStr <= lpEndBuffer) do
        Inc(lpStartStr);}

      {search for end of string}
    lpEndStr := lpStartStr;

     while not CheckEndOfDelimitedField(lpStartStr, lpEndStr, lpEndBuffer) do
       Inc(lpEndStr);

      if (lpEndStr^ = FFieldDelimiter) then
        lpEndStr^ := #0;
        
      {add parsed string to result list}
      FFieldStrings.Add(lpStartStr);


      {increment pointer to start of next string}
      if not lbEndString then
        lpStartStr := lpEndStr + Length(FFieldDelimiter);

      {check for ending condition}
       if lpStartStr > lpEndBuffer then
        lbEndString := True;

    end;


end; {procedure, LoadFieldBufferDelimited }

{------------------------------------------------------------------------------}
{ TppFileDataStream.LoadFieldBufferFixed }

procedure TppFileDataStream.LoadFieldBufferFixed;
var
  lpField: PChar;
  liField: Integer;
  liFieldLength: Integer;
  lcSaveChar: Char;

begin

  FFieldStrings.Clear;

  {initialize}
  FFieldBuf^ := #0;
  lpField    := FRecordBuf;

  for liField := 0 to FTextPipeline.FieldCount-1 do
    begin

      {temporarily convert field to a null terminated string}
      liFieldLength := FTextPipeline.Fields[liField].FieldLength;
      lcSaveChar := lpField[liFieldLength];
      lpField[liFieldLength] := #0;

      {add to field strings}
      FFieldStrings.Add(lpField);

      {restore the orginal char to the record buf}
      lpField[liFieldLength] := lcSaveChar;

      {advance the field pointer}
      lpField  := lpField + liFieldLength;

    end; {for each field}


end; {procedure, LoadFieldBufferFixed }

{------------------------------------------------------------------------------}
{ function TppFileDataStream.GetFieldStringIndex }

function TppFileDataStream.GetFieldStringIndex(aFieldName: String): Integer;
var
  liIndex: Integer;
begin

  liIndex := FTextPipeline.IndexOfFieldName(aFieldName);

  if (liIndex < FFieldStrings.Count) then
    Result := liIndex
  else
    Result := -1;

end; {function, GetFieldStringIndex;

{------------------------------------------------------------------------------}
{function TppFileDataStream.GetFieldAsString}

function TppFileDataStream.GetFieldAsString(aFieldName: String): String;
var
  liIndex: Integer;
  liResultLength: Integer;
begin

  liIndex := GetFieldStringIndex(aFieldName);

  if (liIndex >= 0) then
    Result := FFieldStrings[liIndex]
  else
    Result := '';


  if FRemoveSurroundingQuotes then
    begin
    
      liResultLength := Length(Result);

      if (liResultLength > 1)  then
        begin
          if (Result[1] = FQuoteChar) and (Result[liResultLength] = FQuoteChar) then
            Result := Copy(Result, 2, liResultLength-2);

        end;
        
    end;


end; {function, GetFieldAsString}

{------------------------------------------------------------------------------}
{function TppFileDataStream.GetFieldAsGuid}

function TppFileDataStream.GetFieldAsGuid(const aFieldName: String): TGuid;
var
  liIndex: Integer;
  lsValue: String;

begin

  liIndex := GetFieldStringIndex(aFieldName);

  if liIndex >= 0 then
    begin
      lsValue := FFieldStrings[liIndex];

      if (lsValue <> '') then
        Result := StringToGuid(lsValue)

      else
        Result := cNullGuid;
    end

  else
    Result := cNullGuid;

end; {function, GetFieldAsInteger}



{------------------------------------------------------------------------------}
{function TppFileDataStream.GetFieldAsInteger}

function TppFileDataStream.GetFieldAsInteger(const aFieldName: String): Longint;
var
  liIndex: Integer;
  lsValue: String;

begin

  liIndex := GetFieldStringIndex(aFieldName);

  if liIndex >= 0 then
    begin
      lsValue := FFieldStrings[liIndex];

      if (lsValue <> '') then
        Result := StrToInt(lsValue)

      else
        Result := 0;
    end

  else
    Result := 0;

end; {function, GetFieldAsInteger}

{------------------------------------------------------------------------------}
{function TppFileDataStream.GetFieldAsFloat}

function TppFileDataStream.GetFieldAsFloat(const aFieldName: String): Double;
var
  liIndex: Integer;
  lsValue: String;

begin

  liIndex := GetFieldStringIndex(aFieldName);

  if liIndex >= 0 then
    begin
      lsValue := FFieldStrings[liIndex];


      if (lsValue <> '') then
        Result := StrToFloat(lsValue)

      else
        Result := 0.0;
    end

  else
    Result := 0.0;

end; {function, GetFieldAsFloat}


{------------------------------------------------------------------------------}
{function TppFileDataStream.GetFieldAsBoolean}

function TppFileDataStream.GetFieldAsBoolean(const aFieldName: String): Boolean;
var
  liIndex: Integer;

begin

  liIndex := GetFieldStringIndex(aFieldName);

  if liIndex >= 0 then
    Result := (FFieldStrings[liIndex] = FTextPipeline.BooleanTrue)
  else
    Result := False;

end; {function, GetFieldAsBoolean}



{******************************************************************************
 *
 ** T E X T   P I P E L I N E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTextPipeline.Create }

constructor TppTextPipeline.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  AutoCreateFields := False;

  FCustomDelimiter := ',';
  FFileName   := '';
  FFileStream := TppFileDataStream.Create(Self);
  FFileType   := ftComma;

  FQuoteChar := '"';
  FRemoveSurroundingQuotes := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTextPipeline.Destroy }

destructor TppTextPipeline.Destroy;
begin

  Close;

  FFileStream.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppTextPipeline.SetFileName }

procedure TppTextPipeline.SetFileName(const aFileName: String);
begin
  FFileName := aFileName;

  DoOnDataChange;
  PropertyChange;
end; {procedure, SetFileName}

{------------------------------------------------------------------------------}
{ TppTextPipeline.SetFileType }

procedure TppTextPipeline.SetFileType(aFileType: TppFileType);
begin
  FFileType := aFileType;

  DoOnDataChange;

end; {procedure, SetFileType}

{------------------------------------------------------------------------------}
{ TppTextPipeline.SetBooleanTrue }

procedure TppTextPipeline.SetBooleanTrue(aValue: String);
begin
  FBooleanTrue := aValue;

  DoOnDataChange;

end; {procedure, SetBooleanTrue}

{------------------------------------------------------------------------------}
{ TppTextPipeline.SetBooleanFalse }

procedure TppTextPipeline.SetBooleanFalse(aValue: String);
begin
  FBooleanFalse := aValue;

  DoOnDataChange;

end; {procedure, SetBooleanFalse}

{------------------------------------------------------------------------------}
{ TppTextPipeline.SetFileType }

procedure TppTextPipeline.SetCustomDelimiter(aDelimeter: Char);
begin
  FCustomDelimiter := aDelimeter;

  DoOnDataChange;

end; {procedure, SetCustomDelimiter}


{------------------------------------------------------------------------------}
{ TppTextPipeline.GetActive }

function TppTextPipeline.GetActive: Boolean;
begin
  Result := FFileStream.Active;
end; {procedure, GetActive}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetDataSetName }

function TppTextPipeline.GetDataSetName: String;
begin
  Result := FFileName;
end; {function, GetDataSetName}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldAlignment }

function TppTextPipeline.GetFieldAlignment(aFieldName: String): TAlignment;
begin

  if SetFieldName(aFieldName) then
    Result := CurrentField.Alignment
  else
    Result := taLeftJustify;

end; {function, GetFieldAlignment}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldAsGuid}

function TppTextPipeline.GetFieldAsGuid(aFieldName: String): TGuid;
begin

  try
    if (ppdaNoRecords in State) then
      Result := cNullGuid
    else
      Result := FFileStream.GetFieldAsGuid(aFieldName);
  except
    {note: the report component will likely trap the exception and return '' or 0}
    raise EDataError.Create(ppLoadStr(1024)); {'Invalid Value'}
  end;

end; {function, GetFieldAsGuid}


{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldAsDouble }

function TppTextPipeline.GetFieldAsDouble(aFieldName: String): Double;
begin

  try
    if (ppdaNoRecords in State) then
      Result := 0
    else
      Result := FFileStream.GetFieldAsFloat(aFieldName);
  except
    {note: the report component will likely trap the exception and return '' or 0}
    raise EDataError.Create(ppLoadStr(1024)); {'Invalid Value'}
  end;

end; {function, GetFieldAsDouble}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldAsPicture }

function TppTextPipeline.GetFieldAsPicture(aFieldName: String): TPicture;
begin
  Result := nil;
end; {function, GetFieldAsPicture}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldAsString }

function TppTextPipeline.GetFieldAsString(aFieldName: String): String;
begin

  try
    if (ppdaNoRecords in State) then
      Result := ''
    else
      Result := FFileStream.GetFieldAsString(aFieldName);
  except
    {note: the report component will likely trap the exception and return '' or 0}
    raise EDataError.Create(ppLoadStr(1024)); {'Invalid Value'}
  end;


end; {function, GetFieldAsString}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldDataType }

function TppTextPipeline.GetFieldDataType(aFieldName: String): TppDataType;
begin
  Result := dtNotknown;

  if SetFieldName(aFieldName) then
    Result := CurrentField.DataType;

end; {function, GetFieldDataType}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldDisplayWidth }

function TppTextPipeline.GetFieldDisplayWidth(aFieldName: String): Integer;
begin
  if SetFieldName(aFieldName) then
    Result := CurrentField.DisplayWidth
  else
    Result := 0;

end; {function, GetFieldDisplayWidth}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldIsNull }

function TppTextPipeline.GetFieldIsNull(aFieldName: String): Boolean;
begin
  Result := (GetFieldAsString(aFieldName) = '');
end; {function, GetFieldIsNull}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldIsCalculated }

function TppTextPipeline.GetFieldIsCalculated(aFieldName: String): Boolean;
begin
  Result := False;
end; {function, GetFieldIsCalculated}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldSize }

function TppTextPipeline.GetFieldSize(aFieldName: string): Integer;
begin

  if SetFieldName(aFieldName) then
    Result := CurrentField.FieldLength
  else
    Result := 0;

end; {function, GetFieldSize}


{------------------------------------------------------------------------------}
{ TppTextPipeline.GetFieldValue }

function TppTextPipeline.GetFieldValue(aFieldName: string): Variant;
var
  ldResult: Double;
begin

  if not Active then
    Open;

  Result := Null;

  if (ppdaNoRecords in State) then Exit;

  if not SetFieldName(aFieldName) then Exit;

  try

    case CurrentField.DataType of

      dtString:
        Result := FFileStream.GetFieldAsString(aFieldName);

      dtDateTime:
        Result := TDateTime(FFileStream.GetFieldAsFloat(aFieldName));

      dtDate:
        begin
         ldResult := Int(FFileStream.GetFieldAsFloat(aFieldName));
         Result := TDateTime(ldResult);
        end;

      dtTime:
        begin
         ldResult := Frac(FFileStream.GetFieldAsFloat(aFieldName));
         Result := TDateTime(ldResult);
        end;

      dtInteger, dtLongint:
        Result := FFileStream.GetFieldAsInteger(aFieldName);

      dtDouble:
        Result := FFileStream.GetFieldAsFloat(aFieldName);

      dtBoolean:
        Result := FFileStream.GetFieldAsBoolean(aFieldName);

      end; {case, datatype}

    except
      {note: the report component will likely trap the exception and return '' or 0}
      raise EDataError.Create(ppLoadStr(1024)); {'Invalid Value'}
    end;


end; {function, GetFieldValue}

{------------------------------------------------------------------------------}
{ TppTextPipeline.IsValidDataType }

function TppTextPipeline.IsValidDataType(aDataType: TppDataType): Boolean;
begin
  Result := aDataType in cValidTextDataType;
  
end; {function, IsValidDataType}


{------------------------------------------------------------------------------}
{ TppTextPipeline.FreeBookmark }

procedure TppTextPipeline.FreeBookmark(aBookmark: Longint);
begin
  FFileStream.FreeBookmark(aBookmark);
end; {procedure, FreeBookmark}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GetBookmark }

function  TppTextPipeline.GetBookmark: Longint;
begin
  Result := FFileStream.GetBookmark;
end; {procedure, GetBookmark}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GotoBookmark }

procedure TppTextPipeline.GotoBookmark(aBookmark: Longint);
begin

  FFileStream.GotoBookmark(aBookmark);

  inherited GotoBookmark(aBookmark);

end; {procedure, GotoBookmark}

{------------------------------------------------------------------------------}
{ TppTextPipeline.CheckBOF }

function TppTextPipeline.CheckBOF: Boolean;
begin
  Result := FFileStream.BOF;

end; {procedure, CheckBOF}

{------------------------------------------------------------------------------}
{ TppTextPipeline.CheckEOF }

function TppTextPipeline.CheckEOF: Boolean;
begin
  Result := FFileStream.EOF;

end; {procedure, CheckEOF}

{------------------------------------------------------------------------------}
{ TppTextPipeline.OpenDataSet }

procedure TppTextPipeline.OpenDataSet;
begin
  FFileStream.Open;
end; {procedure, OpenDataSet}

{------------------------------------------------------------------------------}
{ TppTextPipeline.CloseDataSet }

procedure TppTextPipeline.CloseDataSet;
begin
  FFileStream.Close;

end; {procedure, CloseDataSet}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GotoFirstRecord }

procedure TppTextPipeline.GotoFirstRecord;
begin
  FFileStream.First;

  inherited GotoFirstRecord;

end; {procedure, GotoFirstRecord}

{------------------------------------------------------------------------------}
{ TppTextPipeline.TraverseBy }

function TppTextPipeline.TraverseBy(aIncrement: Integer): Integer;
begin
  Result := FFileStream.MoveBy(aIncrement);

end; {procedure, MoveBy}

{------------------------------------------------------------------------------}
{ TppTextPipeline.GotoLastRecord }

procedure TppTextPipeline.GotoLastRecord;
begin
  FFileStream.Last;

  inherited GotoLastRecord;

end; {procedure, GotoLastRecord}


{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  RegisterClasses([TppTextPipeline, TppChildTextPipeline]);

finalization

  UnRegisterClasses([TppTextPipeline, TppChildTextPipeline]);

end.
