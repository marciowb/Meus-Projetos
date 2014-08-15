{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }

unit ppFilDev;

interface

{$I ppIfDef.pas}

uses
  {$IFDEF Delphi6} RTLConsts, {$ENDIF}
  Windows,
  Classes,
  Consts,
  Graphics,
  ExtCtrls,
  SysUtils,
  Forms,
  Controls,
  ShellAPI,
  ppZLib,

  ppDevice,
  ppTypes,
  ppUtils,
  ppForms,
  ppDrwCmd,
  ppSMTPCustom,
  ppEmailSettings,
  ppCharacter;


type

  {@TppStreamDevice

     This class is an abstract ancestor for stream based report output
     formats. TppStreamDevice descends from TppDevice and adds
     functionality required to manage an output stream.

     Assign the value of the OutputStream property to redirect output to a
     custom stream that is created and destroyed outisde of this class.

     TppFileDevice extends TppStreamDevice to add functionality required to
     manage a file stream.}

  {@TppStreamDevice.Encoding

    Use to specify a string encoding.

    For Delphi 2007 and prior, this property does nothing.}

  {@TppStreamDevice.IncludeBOM

    Indicates whether a Byte Order Mark should be prepended at the beginning.

    Only applicable when an Encoding is specified, and the Encoding has a BOM.

    For Delphi 2007 and prior, this property does nothing.}

  {@TppStreamDevice.OutputStream

    Provides access to the output stream. Set this property to redirect output
    to a custom stream that is created and destroyed outside of this class.}

  TppStreamDevice = class(TppDevice)
    private
      FOutputStream: TStream;
      FFreeingStream: Boolean;
      FEncoding: TEncoding;
      FIncludeBOM: Boolean;

      procedure InternalFreeOutputStream;

    protected
      function CreateOutputStream: TStream; virtual; abstract;
      procedure FreeOutputStream; virtual; abstract;

      procedure SetOutputStream(Value: TStream); virtual;
      procedure WriteToOutputStream(const Buffer; Count: Longint); overload; virtual;
      procedure WriteToOutputStream(const aText: String); overload; virtual;
      procedure WriteBOMToOutputStream; virtual;


    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure EndJob; override;
      procedure StartJob; override;
      procedure CancelJob; override;

      property Encoding: TEncoding read FEncoding write FEncoding;
      property IncludeBOM: Boolean read FIncludeBOM write FIncludeBOM;
      property OutputStream: TStream read FOutputStream write SetOutputStream;

  end;


  {@TppFileDevice

     This class is an abstract ancestor class for report output formats that are
     printed to a file. Registered FileDevices appear in the PrintDialog under
     the filetypes drop down list. TppFileDevice descends from TppStreamDevice
     and adds functionality that supports writing to filestream.

     This class supports the two types of stream based output:

      - Set FileName to specify the name of the output file. The FileDevice will
        internally create a FileStream and assign it to the OutputStream property.
      - Set the OutputStream property to redirect output to a custom stream
        that is created and destroyed externally.}

  {@TppFileDevice.FileName

    Set FileName to specify the name of the output file.}

  {@TppFileDevice.FileStream

    Retained for backward compatibility. Use the OutputStream property to access
    the output stream.}

  {@TppFileDevice.EndPrintJob

    Defaults to True. Use this property in conjunction with StartPrintJob to
    print multiple reports to the same file.

    <CODE>

      uses
        ppPDF, ppFileUtils;

      var
        lPDFDevice: TppPDFDevice;
      begin

        // create PDF device and configure
        lPDFDevice := TppPDFDevice.Create(nil);
        lPDFDevice.FileName := TppFileUtils.GetApplicationFilePath + 'myReport.PDF';

        //  print first report to PDF file
        lPDFDevice.EndPrintJob := False;
        lPDFDevice.Publisher := ppReport1.Publisher;

        ppReport1.PrintToDevices;

        // print second report to PDF file
        lPDFDevice.Reset;
        lPDFDevice.Publisher := ppReport2.Publisher;
        lPDFDevice.StartPrintJob := False;
        lPDFDevice.EndPrintJob := True;

        ppReport2.PrintToDevices;

        lPDFDevice.Free

      end;

    </CODE>}

  {@TppFileDevice.StartPrintJob


    Defaults to True. Use this property in conjunction with EndPrintJob to
    print multiple reports to the same file.

    <CODE>

      uses
        ppPDF, ppFileUtils;

      var
        lPDFDevice: TppPDFDevice;
      begin

        // create PDF device and configure
        lPDFDevice := TppPDFDevice.Create(nil);
        lPDFDevice.FileName := TppFileUtils.GetApplicationFilePath + 'myReport.PDF';

        //  print first report to PDF file
        lPDFDevice.EndPrintJob := False;
        lPDFDevice.Publisher := ppReport1.Publisher;

        ppReport1.PrintToDevices;

        // print second report to PDF file
        lPDFDevice.Reset;
        lPDFDevice.Publisher := ppReport2.Publisher;
        lPDFDevice.StartPrintJob := False;
        lPDFDevice.EndPrintJob := True;

        ppReport2.PrintToDevices;

        lPDFDevice.Free

      end;

    </CODE>}

  TppFileDevice = class(TppStreamDevice)
    private
      FAllowEmail: Boolean;
      FAutoOpen: Boolean;
      FDefaultBands: TppBandTypes;
      FEndPrintJob: Boolean;
      FCurrentFileName: String;
      FFileName: String;
      FFirstFileName: String;
      FOriginalFileName: String;
      FFileStream: TFileStream;
      FEmailSettings: TppEmailSettings;
      FFirstEmailSettings: TppEmailSettings;
      FCurrentEmailSettings: TppEmailSettings;
      FStartPrintJob: Boolean;
      FRenameFileOnEndJob: Boolean;
      FSMTPCustom: TppSMTPCustom;

      function GetFileName(aPage: TppPage): String;
      function AddFileSuffix(aFileName, aSuffix: String): String;
      procedure SendEmail(aEmailSettings: TppEmailSettings);

    protected
      function  CreateOutputStream: TStream; override;
      procedure FreeOutputStream; override;
      function  CreateFileStream: TStream; virtual;
      procedure DisplayMessage(aPage: TppPage); virtual;
      procedure GetDrawTextCommandsForDataExport(aPage: TppPage; var aList: TStringList); virtual;
      procedure GetDrawTextCommandsForReportExport(aPage: TppPage; var aList: TStringList); virtual;
      procedure SavePageToFile(aPage: TppPage); virtual;
      procedure SetFileName(aFileName: String); virtual;
      procedure SetAutoOpen(aValue: Boolean); virtual;
      procedure SpawnNewJob(aPage: TppPage); virtual;

      procedure WriteToFileStream(const Buffer; Count: Longint); virtual;

      property DefaultBands: TppBandTypes read FDefaultBands write FDefaultBands;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function DefaultExt: String; virtual;  {abstract;  removed to support CBuilder}
      class function DefaultExtFilter: String; virtual;  {abstract;  removed to support CBuilder}
      class function DeviceDescription(aLanguageIndex: Longint): String; virtual;  {abstract;  removed to support CBuilder}

      procedure EndJob; override;
      procedure ReceivePage(aPage: TppPage); override;
      procedure StartJob; override;

      property AllowEmail: Boolean read FAllowEmail write FAllowEmail;
      property EndPrintJob: Boolean read FEndPrintJob write FEndPrintJob;
      property FileName: String read FFileName write SetFileName;
      property FileStream: TFileStream read FFileStream;
      property StartPrintJob: Boolean read FStartPrintJob write FStartPrintJob;

  end; {class TppFileDevice}


  {@TppTextFileDevice

    This component receives the pages generated by the report engine and saves
    the textual portions to a file. To access this component, typecast the
    Sender parameter of any textual component OnSave event. Use the StartingLine
    and EndingLine properties to add custom formatting to each line. Use the
    StartingPage and EndingPage properties to add custom formatting to each
    page. Use the FirstLine and LastLine properties to add formatting to the
    beginning or ending of the file.  The text file is opened when the Publisher
    calls the StartJob method. Text file is closed when the Publisher calls the
    EndJob method. If the Publisher calls the CancelJob method the file is
    closed and deleted.

    An example of an event handler utilizing these properties has been
    provided.}

  {@TppTextFileDevice.DefaultBands

    Defaults to [btDetail]. Specifies the default band types to export for the
    case in which the report elements have not been explicitly configured via
    the Print to File dialog or the Band and Component Save, SaveNo properties.}


  {@TppTextFileDevice.EndingLine

    Run-time only. Indicates that the last item of the line is being written to
    the file.}

  {@TppTextFileDevice.EndingPage

    Run-time only. Indicates that the last item of the page is being written to
    the file.}

  {@TppTextFileDevice.FirstLine

    Run-time only. Indicates that the first line is being written to the file.}

  {@TppTextFileDevice.LastLine

    Run-time and read-only. Indicates that the last line is being written to the
    file.}

  {@TppTextFileDevice.LineItemNo

    Run-time and read-only. This property maintains a count as each item is
    added to the line.}

  {@TppTextFileDevice.LineNo

    Run-time and read-only. This item maintains a count as each line is written
    to the file.}

  {@TppTextFileDevice.QuoteAll

    Tells the TextFileDevice to ignore the normal quoting standards and place
    quotes (represented by the QuoteChar property) around all exported values.}

  {@TppTextFileDevice.QuoteChar

    Defines the character or characters to be used to quote values that contain
    commas or spaces (or all values if the QuoteAll property is set to True).

    Setting this property to an empty string will effectively quote none of the
    field values.

    The default quote character is a double quote (").}

  {@TppTextFileDevice.StartingLine

    Run-time and read-only. Indicates that the first item of the line is being
    written to the file.}

  {@TppTextFileDevice.StartingPage

    Run-time and read-only. Indicates that the last item of the line is being
    written to the file.}

  {@TppTextFileDevice.TextFileType

    The TextFileType property determines format of the file when printing to a
    text file.

    <Table>
    Value              Meaning
    --------------     ---------
    ftComma	           Comma delimited file
    ftTab	             Tab delimited file.
    ftFixedLength      Fixed Length records, each textual component is saved
                       with the length specified in the SaveLength property.
    ftCustom	         No delimiters or carriage return line-feeds are provided.
                       The textual components are streamed together unless you
                       use the OnSave event to add formatting.
    </Table>}

  TppTextFileDevice = class(TppFileDevice)
    private
      FEndingLine: Boolean;
      FEndingPage: Boolean;
      FFirstLine: Boolean;
      FLineItemNo: Longint;
      FLineNo: Longint;
      FLastLine: Boolean;
      FOnSave: TppTextDeviceSaveEvent;
      FQuoteChar: String;
      FQuoteAll: Boolean;
      FStartingLine: Boolean;
      FStartingPage: Boolean;
      FTextFileType: TppFileType;

      procedure SetTextFileType(aFileType: TppFileType);

    public
      constructor Create(aOwner: TComponent); override;

      class function DeviceName: String; override;
      class function DefaultExt: String; override;
      class function DefaultExtFilter: String; override;
      class function DeviceDescription(aLanguageIndex: Longint): String; override;

      procedure StartJob; override;
      procedure ReceivePage(aPage: TppPage); override;
      procedure SavePageToFile(aPage: TppPage); override;
      procedure EndJob; override;

      property DefaultBands;
      property EndingLine: Boolean read FEndingLine;
      property EndingPage: Boolean read FEndingPage;
      property FirstLine: Boolean read FFirstLine;
      property LineItemNo: Longint read FLineItemNo;
      property LineNo: Longint read FLineNo;
      property LastLine: Boolean read FLastLine;
      property OnSave: TppTextDeviceSaveEvent read FOnSave write FOnSave;
      property QuoteChar: String read FQuoteChar write FQuoteChar;
      property QuoteAll: Boolean read FQuoteAll write FQuoteAll;
      property StartingLine: Boolean read FStartingLine;
      property StartingPage: Boolean read FStartingPage;
      property TextFileType: TppFileType read FTextFileType write SetTextFileType default ftComma;
{$IFDEF UNICODE}
     property Encoding;
     property IncludeBOM;
{$ENDIF}

  end; {class TppTextFileDevice}


  {@TppReportTextFileDevice

    This device saves all of the text from the report to the text file specified
    in the TextFileName property. The positions of the textual components are
    converted to a character grid before being placed into the file (much like the
    Generic/TextOnly driver).  In order to get good looking text files using this
    device, modifications to the report layout are usually required.  This is due
    to the factthat the precise positions of the text on the page do not always
    convert well to the crudecharacter grid positions required by a text file.  An
    example of a report layout that has been modified for printing to file is
    provided in demo 107.

    Note: The difference between this device and the TextFileDevice is that the
    TextFileDevice is best at generating structured text files (with column headers
    and 'fields') that can be easily imported into spreadsheets or other
    applications designed to handle tabular data.  The purpose of
    ReportTextFileDevice is to emulate the format of the report in the text.}

  {@TppReportTextFileDevice.AutoCalcGrid

    When set to True this property forces the device to automatically calculate
    the character grid based on the font of the first textual component rendered
    for the page. Typical character grid values include 120 characters wide by
    66 lines and 80 characters wide by 66 lines.}

  {@TppReportTextFileDevice.CharsPerLine

    Run-time and read-only. This property returns the characters per line of the
    character grid.}

  {@TppReportTextFileDevice.LinesPerPage

    Run-time and read-only. This property returns the lines per page of the
    character grid.}

  TppReportTextFileDevice = class(TppFileDevice)
    private
      FAutoCalcGrid: Boolean;
      FCalculateOutputFontSize: Boolean;
      FCharsPerLine: Integer;
      FLinesPerPage: Integer;
      FOutputFontSize: Integer;

      procedure SetOutputFontSize(Value: Integer);
    protected

    public
      constructor Create(aOwner: TComponent); override;

      {override from TppFileDevice}
      class function DeviceName: String; override;
      class function DefaultExt: String; override;
      class function DefaultExtFilter: String; override;
      class function DeviceDescription(aLanguageIndex: Longint): String; override;

      {override from TppDevice}
      procedure ReceivePage(aPage: TppPage); override;
      procedure SavePageToFile(aPage: TppPage); override;

      procedure CharacterGrid(aCharsPerLine, aLinesPerPage: Integer);

      property AutoCalcGrid: Boolean read FAutoCalcGrid write FAutoCalcGrid;
      property CalculateOutputFontSize: Boolean read FCalculateOutputFontSize write FCalculateOutputFontSize default True;
      property CharsPerLine: Integer read FCharsPerLine;
      property LinesPerPage: Integer read FLinesPerPage;
      property OutputFontSize: Integer read FOutputFontSize write SetOutputFontSize;
{$IFDEF UNICODE}
     property Encoding;
     property IncludeBOM;
{$ENDIF}
  end; {class TppReportTextFileDevice}

  {@TppArchiveDevice
  
   This component receives the pages generated by the report engine and saves
   them to a file.}

  TppArchiveDevice = class(TppFileDevice)
    private
      FPageStream: TFileStream;
      FTempFile: String;

      FSaveCompleteOutlineOnly: Boolean;

      procedure FreeOutlineDrawCommand(aPage: TppPage);

    public
      constructor Create(aOwner: TComponent); override;

      class function DeviceName: String; override;
      class function DefaultExt: String; override;
      class function DefaultExtFilter: String; override;
      class function DeviceDescription(aLanguageIndex: Longint): String; override;

      procedure StartJob; override;
      procedure ReceivePage(aPage: TppPage); override;
      procedure SavePageToFile(aPage: TppPage); override;
      procedure EndJob; override;

      property SaveCompleteOutlineOnly: Boolean read FSaveCompleteOutlineOnly write FSaveCompleteOutlineOnly;

  end; {class TppArchiveDevice}


  TppFileDeviceClass = class of TppFileDevice;

  TppFileDeviceUtils = class
    public
    class procedure CompressStream(aDataStream: TStream; aCompressionLevel: TppCompressionLevel = clDefault);
    class function  DrawCommandToBitmap(aDrawCommand: TppDrawCommand; aScalePercentage: Integer; aBackgroundColor: TColor): TBitmap;
    class procedure GetFileDeviceClasses(aFileDeviceClasses: TStrings);
    class function  GetFileDeviceClassForName(aDeviceName: String): TppFileDeviceClass;
    class procedure WriteLine(aOutputStream: TStream; aLine: AnsiString);
    class procedure WriteMem(aOutputStream: TStream; aBuffer: AnsiString);

    class function  ShellExec(const aPathStr, aCmdStr, aDirStr: string; aShow: Word): Boolean; overload;
    class function  ShellExec(aFileName: String): Boolean; overload;

    // unit conversion
    class function InchPerMicron: Double;
    class function MicronsToTwips(aMicrons: Integer): Integer;
    class function PixelsToPoints(aPixels, aPixelsPerInch: Integer): Double;
    class function PixelsToTwips(aPixels, aPixelsPerInch: Integer): Integer;
    class function TwipsToPixels(aTwips, aPixelsPerInch: Integer): Integer;
    class function TwipsPerInch: Integer;

  end;

implementation

uses
  ppViewr,
  ppEmailMessage,
  ppFileUtils;

{x$DEFINE TESTING}

{$IFDEF TESTING}
{------------------------------------------------------------------------------}
{ BinaryStreamToTextStream}

function BinaryStreamToTextStream(aBinaryStream: TStream): TMemoryStream;
var
  lDecimalSeparator: Char;
begin

  lDecimalSeparator := DecimalSeparator;

  Result := TMemoryStream.Create;

  try

    try
      {convert & copy binary BinaryStream content to TextStream }
      aBinaryStream.Seek(0, soFromBeginning);

      DecimalSeparator  := '.';

      ObjectBinaryToText(aBinaryStream, Result);

    except

      Result.Free;

      raise

    end;

  finally
    DecimalSeparator := lDecimalSeparator;
  end;

end;

{$ENDIF}


{******************************************************************************
 *
 ** S T R E A M   D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppStreamDevice.Create }

constructor TppStreamDevice.Create(aOwner: TComponent);

begin
  inherited Create(aOwner);

  FOutputStream := nil;

{$IFDEF UNICODE}
  FEncoding := TEncoding.Default;
{$ENDIF}

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.Destroy }

destructor TppStreamDevice.Destroy;
begin

  {EndJob, if needed}
  if Busy then
    EndJob;

  inherited Destroy;

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.InternalFreeOutputStream }

procedure TppStreamDevice.InternalFreeOutputStream;
begin

  if not(FFreeingStream) then
    begin
      FFreeingStream := True;
      try
        FreeOutputStream;
      finally
        FFreeingStream := False;
      end;
    end;

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.SetOutputStream }

procedure TppStreamDevice.SetOutputStream(Value: TStream);
begin
  // free the existing stream
  if (FOutputStream <> nil) then
    InternalFreeOutputStream;

  FOutputStream := Value;

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.StartJob }

procedure TppStreamDevice.StartJob;
begin
  inherited StartJob;

  if (FOutputStream = nil) then
    FOutputStream := CreateOutputStream;

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.EndJob }

procedure TppStreamDevice.EndJob;
begin
  inherited EndJob;

//  if (FOutputStream <> nil) then
    InternalFreeOutputStream;

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.CancelJob }

procedure TppStreamDevice.CancelJob;
begin
  inherited CancelJob;

//  if (FOutputStream <> nil) then
    InternalFreeOutputStream;

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.WriteBOMToOutputStream }

procedure TppStreamDevice.WriteBOMToOutputStream;
var
  lPreamble: TBytes;
  liCount: Integer;
begin

  if not(FIncludeBOM) then Exit;
  
  if (FEncoding = nil) or (FOutputStream = nil) then Exit;

  // for encoding, write preamble at the front of the output stream
  if (FOutputStream.Size = 0) then
    begin
      SetLength(lPreamble, 0);
      lPreamble := FEncoding.GetPreamble;
      liCount := Length(lPreamble);

      if (liCount > 0) and (FOutputStream.Write(lPreamble[0], liCount) <> liCount) then
        raise EWriteError.CreateRes(PResStringRec(@SWriteError));

    end;

end;

{------------------------------------------------------------------------------}
{ TppStreamDevice.WriteToOutputStream }

procedure TppStreamDevice.WriteToOutputStream(const Buffer; Count: Longint);
begin

  if (Count = 0) or (FOutputStream = nil) then Exit;

  // for encoding, write preamble at the front of the output stream
  if (FEncoding <> nil) and (FOutputStream.Size = 0) then
    WriteBOMToOutputStream;

  if (FOutputStream.Write(Buffer, Count) <> Count) then
{$IFDEF Delphi5}
    raise EWriteError.CreateRes(PResStringRec(@SWriteError));
{$ELSE}
    raise EWriteError.Create(SWriteError);
{$ENDIF}

end;

procedure TppStreamDevice.WriteToOutputStream(const aText: String);
var
  lBytes: TBytes;
begin

  if Length(aText) = 0 then Exit;


  if (FEncoding <> nil) then
    begin
      SetLength(lBytes, 0);
      lBytes := FEncoding.GetBytes(aText);
      WriteToOutputStream(lBytes[0], Length(lBytes));
    end
  else
    WriteToOutputStream(aText[1], ppByteLength(aText));

end;


{******************************************************************************
 *
 ** F I L E   D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppFileDevice.Create }

constructor TppFileDevice.Create(aOwner: TComponent);

begin
  inherited Create(aOwner);

  FAllowEmail := True;
  FAutoOpen := True;
  FCurrentFileName := '';
  FFileName   := '';
  FFirstFileName := '';
  FFileStream := nil;
  FEndPrintJob := True;
  FStartPrintJob := True;
  FDefaultBands := [btDetail];

  FEmailSettings := nil;
  FFirstEmailSettings := TppEmailSettings.Create;
  FCurrentEmailSettings := TppEmailSettings.Create;
  FSMTPCustom := TppSMTPPlugIn.CreateInstance;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppFileDevice.Destroy }

destructor TppFileDevice.Destroy;
begin

  FFirstEmailSettings.Free;
  FFirstEmailSettings := nil;
  FCurrentEmailSettings.Free;
  FCurrentEmailSettings := nil;

  FSMTPCustom.Free;
  FSMTPCustom := nil;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppFileDevice.DefaultExt }

class function TppFileDevice.DefaultExt: String;
begin
  {treat as abstract - descendants should override}
  Result := '';

end; {class function, DefaultExt}

{------------------------------------------------------------------------------}
{ TppFileDevice.DefaultExtFilter }

class function TppFileDevice.DefaultExtFilter: String;
begin
  {treat as abstract - descendants should override}
  Result := '';

end; {class function, DefaultExtFilter}

{------------------------------------------------------------------------------}
{ TppFileDevice.DeviceDescription }

class function TppFileDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  {treat as abstract - descendants should override}
  Result := '';

end; {class function, DeviceDescription}


{------------------------------------------------------------------------------}
{ TppFileDevice.SetFileName }

procedure TppFileDevice.SetFileName(aFileName: String);
begin

  if not(Busy) then
    FFileName := aFileName;

  FOriginalFileName := FFileName;

end; {procedure, SetTextFileName}


{------------------------------------------------------------------------------}
{ TppFileDevice.CreateOutputStream }

function TppFileDevice.CreateOutputStream: TStream;
begin

  Result := CreateFileStream;

end;

{------------------------------------------------------------------------------}
{ TppFileDevice.FreeOutputStream }

procedure TppFileDevice.FreeOutputStream;
begin

  // only free the streams that we create
  if (FFileStream <> nil) then
    begin
      if OutputStream = FFileStream then
        OutputStream := nil;

      FFileStream.Free;
      FFileStream := nil;
    end;

end;

{------------------------------------------------------------------------------}
{ TppFileDevice.ProcessFile }

function TppFileDevice.GetFileName(aPage: TppPage): string;
begin
  Result := AddFileSuffix(FOriginalFileName, aPage.FileSuffix);

end;

{------------------------------------------------------------------------------}
{ TppFileDevice.AddFileSuffix }

function TppFileDevice.AddFileSuffix(aFileName, aSuffix: String): String;
var
  lsFileName: String;
  lsSpacer: String;
  liExtPos: Integer;
begin

  lsFileName := aFileName;

  //If the user would like to take complete control over the name of each file
  //exported, the original file name should be "_".  This way the suffix assigned
  //will be the entire file name.
  if TppFileUtils.RemoveFileExtension(lsFileName) = '_' then
  begin
    lsSpacer := '';
    lsFileName := '';
  end
  else
    lsSpacer := '_';

  //Find the file extension separator
  liExtPos := Pos('.', lsFileName);

  if liExtPos > 0 then
    //Insert breakvalue in before the file extension
    Insert(lsSpacer + aSuffix, lsFileName, liExtPos)
  else
    lsFileName := lsFileName + lsSpacer + aSuffix + '.' + DefaultExt;

  Result := lsFileName;

end;

{------------------------------------------------------------------------------}
{ TppFileDevice.FreeOutputStream }

procedure TppFileDevice.ReceivePage(aPage: TppPage);
begin
  inherited;

  if (IsRequestedPage) then
    begin
      DisplayMessage(aPage);

      if not(IsMessagePage) then
        begin
          if aPage.NewJob then
            SpawnNewJob(aPage);

          SavePageToFile(aPage);
        end;
    end;
end;

{------------------------------------------------------------------------------}
{ TppFileDevice.CreateFileStream }

function TppFileDevice.CreateFileStream: TStream;
var
  lMode: Word;
  lsMessage: String;
begin

  if (FAutoOpen) then
    begin

      lMode := fmOpenReadWrite or fmShareExclusive or fmCreate;

      {put exception handling here in case file can't be opened}
      try
        FFileStream := TFileStream.Create(FFileName, lMode);
      except
        lsMessage := ppLoadStr(67); {Unable to open file: <filename>.}
        lsMessage := ppSetMessageParameters(lsMessage);
        lsMessage := Format(lsMessage, [FFileName]);

        raise EPrintError.Create(lsMessage);
      end; {try, except}

    end; {if FAutoOpen}

  Result := FFileStream;

end;

{------------------------------------------------------------------------------}
{ TppFileDevice.StartJob }

procedure TppFileDevice.StartJob;
begin
  if StartPrintJob then
    begin
      inherited StartJob;  // ancestor will call create stream

      FCurrentFileName := FFileName;
      if FEmailSettings <> nil then
        FCurrentEmailSettings.Assign(FEmailSettings);

      DisplayMessage(nil);

    end;

end;

{procedure, StartJob}

{------------------------------------------------------------------------------}
{ TppFileDevice.EndJob }

procedure TppFileDevice.EndJob;
begin
  if not EndPrintJob then exit;

  if EndPrintJob then
    inherited EndJob;   // anscestor will call free stream

  if FRenameFileOnEndJob then
    begin
      //RenameFile fails if the file already exists.
      if FileExists(FFirstFileName) then
        DeleteFile(FFirstFileName);
      
      RenameFile(FOriginalFileName, FFirstFileName);
      if FEmailSettings <> nil then
        SendEmail(FFirstEmailSettings);
      FRenameFileOnEndJob := False;
    end
  else if FEmailSettings <> nil then
    SendEmail(FCurrentEmailSettings);

end; {procedure, EndJob}

{------------------------------------------------------------------------------}
{ TppFileDevice.DisplayMessage }

procedure TppFileDevice.DisplayMessage(aPage: TppPage);
var
  lsMessage: String;
begin

  if (aPage = nil) then
    begin
      {message: Accessing data...}
      lsMessage := ppLoadStr(2);
    end

  else if IsMessagePage and ((Publisher <> nil) and not Publisher.ReportCompleted) then
    begin

      if (CancelDialog <> nil) then
        lsMessage := CancelDialog.PrintProgress
      else
        lsMessage := '';

    end
  else if (PageRequest.PageSetting = psAll) and (aPage.PassSetting = psTwoPass) then
    begin
      {message: Printing Page 1 of 15 for <reportname> on <printername>}
      lsMessage := ppLoadStr(28);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), IntToStr(aPage.AbsolutePageCount),
                          aPage.DocumentName, FileName]);

    end

  else
    begin
      {message: Printing Page 1 for <reportname> on <printername>}
      lsMessage := ppLoadStr(27);
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), aPage.DocumentName,
                                      FileName]);
    end;

  if (CancelDialog <> nil) and (CancelDialog.PrintProgress <> lsMessage) then
    begin
      CancelDialog.PrintProgress := lsMessage;
      Application.ProcessMessages;
    end;

end; {procedure, DisplayMessage}

{------------------------------------------------------------------------------}
{ TppFileDevice.GetDrawTextCommandsForDataExport }

procedure TppFileDevice.GetDrawTextCommandsForDataExport(aPage: TppPage; var aList: TStringList);
var
  liCommand: Integer;
  liCommands: Integer;
  lCommand: TppDrawCommand;
  lDrawText: TppDrawText;
  lDetailList: TStringList;
  lSaveList: TStringList;
begin

  lSaveList := TStringList.Create;

  lDetailList := TStringList.Create;

  {retrieve draw text commands which need to be saved to file}
  liCommands := aPage.DrawCommandCount;

  for liCommand := 0 to liCommands-1 do
    begin

      lCommand := aPage.DrawCommands[liCommand];

      if (lCommand is TppDrawText) then
        begin
          lDrawText := TppDrawText(lCommand);

          // add item to save list
          if lDrawText.BandSave and lDrawText.ComponentSave then
            lSaveList.AddObject(lDrawText.Order, lDrawText);

          // add item to detail list
          if (lDrawText.Component <> nil) and (lDrawText.BandType in FDefaultBands) then
            begin
              lDrawText.BandSave := True;
              lDrawText.ComponentSave := True;
              lDrawText.ComponentSaveNo := liCommand;
              lSaveList.AddObject(lDrawText.Order, lDrawText);
            end;

        end;

    end;

  // if SaveList is empty, use DetailList
  if lSaveList.Count > 0 then
    aList := lSaveList
  else if lDetailList.Count > 0 then
    aList := lDetailList
  else
    aList := nil;

  // free unused lists
  if (lSaveList <> aList) then
    lSaveList.Free;

  if (lDetailList <> aList) then
    lDetailList.Free;


end;

{------------------------------------------------------------------------------}
{ TppFileDevice.GetDrawTextCommandsForReportExport }

procedure TppFileDevice.GetDrawTextCommandsForReportExport(aPage: TppPage; var aList: TStringList);
var
  liCommand: Integer;
  liCommands: Integer;
  lCommand: TppDrawCommand;
  lDrawText: TppDrawText;
  lsOrder: String;
  lBitmap: TBitmap;
  liIndex: Integer;
  liTop: Integer;
  liTextHeight: Integer;
  lMemo: TppDrawText;
begin

  lBitmap := nil;

  aList := TStringList.Create;

  try

    {retrieve draw text commands which need to be saved to file}
    liCommands := aPage.DrawCommandCount;

    for liCommand := 0 to liCommands - 1 do
      begin

        lCommand := aPage.DrawCommands[liCommand];

        if (lCommand is TppDrawText) then
          begin
            if (TppDrawText(lCommand).WrappedText.Count > 0) then
              begin
                lMemo := TppDrawText(lCommand);

                if (lBitmap = nil) then
                  lBitmap := TBitmap.Create;

                lBitmap.Canvas.Font := lMemo.Font;
                liTextHeight := lBitmap.Canvas.TextHeight('0');
                liTextHeight := Round(ppFromScreenPixels(liTextHeight, utMMThousandths, pprtVertical, nil));
                liTop := lMemo.Top;

                for liIndex := 0 to lMemo.WrappedText.Count - 1 do
                  begin
                    lDrawText := TppDrawText.Create(Self);
                    lDrawText.Text := lMemo.WrappedText[liIndex];
                    lDrawText.Font := lMemo.Font;
                    lDrawText.Color := lMemo.Color;
                    lDrawText.Height := liTextHeight;
                    lDrawText.Left := lMemo.Left;
                    lDrawText.Top := liTop;
                    lDrawText.Width := lMemo.Width;
                    lDrawText.Alignment := lMemo.Alignment;
                    lDrawText.WordWrap := True;
                    lDrawText.DataType := lMemo.DataType;
                    lsOrder := Format('%8d',[lDrawText.Top]) + Format('%8d',[lDrawText.Left]);
                    aList.AddObject(lsOrder, lDrawText);
                    liTop := liTop + liTextHeight + 1;
                  end;
              end
            else
              begin
                lDrawText := TppDrawText(lCommand);
                lsOrder := Format('%8d',[lDrawText.Top]) + Format('%8d',[lDrawText.Left]);
                aList.AddObject(lsOrder, lDrawText);
              end;
          end;

      end;

  finally
    lBitmap.Free;
  end;

  if (aList.Count = 0) then
    begin
      aList.Free;
      aList := nil;
    end;

end; {procedure, GetDrawTextCommands}

{------------------------------------------------------------------------------}
{ TppFileDevice.SetAutoOpen }

procedure TppFileDevice.SetAutoOpen(aValue: Boolean);
begin

  if (FAutoOpen <> aValue) then
    FAutoOpen := aValue;

end; {procedure, SetAutoOpen}

{------------------------------------------------------------------------------}
{ TppFileDevice.SavePageToFile }

procedure TppFileDevice.SavePageToFile(aPage: TppPage);
begin
  //Implemented in descendent classes
end;

procedure TppFileDevice.SendEmail(aEmailSettings: TppEmailSettings);
var
  lEmailMessage: TppEmailMessage;
  lFileName: string;
begin

  if not(AllowEmail) then exit;

  lEmailMessage := TppEmailMessage.Create;

  try
    if FRenameFileOnEndJob then
      lFileName := FFirstFileName
    else
      lFileName := FCurrentFileName;

    if aEmailSettings.Recipients.Count > 0 then
      begin
        lEmailMessage.AssignSettingsToMessage(aEmailSettings);

        lEmailMessage.Attachments.Add(lFileName);

        FSMTPCustom.Host := aEmailSettings.HostAddress;
        FSMTPCustom.UserID := aEmailSettings.UserName;
        FSMTPCustom.Password := aEmailSettings.Password;
        FSMTPCustom.PreviewEmail := False;  //Setting to True causes MAPI to lock up

        FSMTPCustom.SendMail(lEmailMessage);
      end;

  finally
    if aEmailSettings.DeleteFile then
      DeleteFile(lFileName);

    lEmailMessage.Free;
  end;

end;

procedure TppFileDevice.SpawnNewJob(aPage: TppPage);
begin

  FFileName := GetFileName(aPage);
  FEmailSettings := aPage.EmailSettings;

  if (aPage.AbsolutePageNo = 1) then
    begin
      FFirstFileName := FFileName;
      FFirstEmailSettings.Assign(FEmailSettings);
      FRenameFileOnEndJob := True;
    end
  else
    begin
      EndJob;
      StartJob;
    end;

end;

{------------------------------------------------------------------------------}
{ TppFileDevice.WriteToFileStream
  - retained for backward compatibility}

procedure TppFileDevice.WriteToFileStream(const Buffer; Count: Longint);
begin

  WriteToOutputStream(Buffer, Count);

end; {procedure, WriteToFileStream}


{******************************************************************************
 *
 ** T E X T   F I L E   D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.Create }

constructor TppTextFileDevice.Create(aOwner: TComponent);

begin
  inherited Create(aOwner);

  FEndingLine := False;
  FFirstLine := False;
  FLineItemNo := 0;
  FLineNo := 0;
  FLastLine := False;
  FOnSave := nil;
  FStartingLine := False;
  FTextFileType := ftComma;
  FQuoteChar := '"';
  FQuoteAll := False;

{$IFDEF UNICODE}
  Encoding := TEncoding.UTF8;
{$ENDIF}

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.DeviceName }

class function TppTextFileDevice.DeviceName: String;
begin
  Result := 'TextFile';
end; {class function, DeviceName}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.DefaultExt }

class function TppTextFileDevice.DefaultExt: String;
begin
  Result := 'txt';
end; {class function, DefaultExt}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.DefaultExtFilter }

class function TppTextFileDevice.DefaultExtFilter: String;
begin
  Result := 'Text files|*.TXT|All files|*.*';
end; {class function, DefaultExtFilter}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.DeviceDescription }

class function TppTextFileDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := ppLoadStr(37);
end; {class function, DeviceDescription}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.SetTextFileType }

procedure TppTextFileDevice.SetTextFileType(aFileType: TppFileType);
begin

  if not(Busy) then
    FTextFileType := aFileType;

end; {procedure, SetTextFileType}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.StartJob }

procedure TppTextFileDevice.StartJob;
begin
  if not(StartPrintJob) then Exit;

  inherited StartJob;

  FEndingLine := False;
  FEndingPage := False;
  FFirstLine := False;
  FLineItemNo := 0;
  FLineNo := 0;
  FLastLine := False;
  FStartingLine := False;
  FStartingPage := False;

end; {procedure, StartJob}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.EndJob }

procedure TppTextFileDevice.EndJob;
begin
  if not(EndPrintJob) then Exit;

  FEndingLine := False;
  FEndingPage := False;
  FFirstLine := False;
  FLineItemNo := 0;
  FLineNo := 0;
  FLastLine := False;
  FStartingLine := False;
  FStartingPage := False;

  inherited EndJob;

end; {procedure, EndJob}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.ReceivePage }

procedure TppTextFileDevice.ReceivePage(aPage: TppPage);
begin

  inherited ReceivePage(aPage);

end; {procedure, ReceivePage}

{------------------------------------------------------------------------------}
{ TppTextFileDevice.SavePageToFile }

procedure TppTextFileDevice.SavePageToFile(aPage: TppPage);
var
  liCommand      : Integer;
  liCommands     : Integer;
  lDrawCommands  : TStringList;
  lDrawText      : TppDrawText;
  lsLine         : String;
  lsText         : String;
  liBandNo       : Longint;
  liRowNo        : Longint;
  liReportNo     : Longint;
  liSaveBandNo   : Longint;
  liSaveRowNo    : Longint;
  liSaveReportNo : Longint;
  liLastBandNo   : Longint;
  lsDelimiter    : String;
  lsCRLF         : String;
  lsSaveLine     : String;

  procedure EndLine;
    begin
      lsSaveLine := lsLine;

      {write line to stream}
      if (Length(lsSaveLine) > 0) then
          begin
            WriteToOutputStream(lsSaveLine);

            {if not end of file, add carriage return to end of line}
            if not((aPage.LastPage) and FEndingPage) and
               not(FTextFileType = ftCustom) then
              WriteToOutputStream(lsCRLF);
          end;

    end; {procedure, EndLine}

begin


  lsCRLF := #13#10;

  {get the draw text commands from the page}
  GetDrawTextCommandsForDataExport(aPage, lDrawCommands);

  if (lDrawCommands = nil) then Exit;

  {sort the commands into proper order}
  lDrawCommands.Sort;

  {get delimiter}
  case FTextFileType of
    ftComma:
      lsDelimiter := ',';

    ftTab:
      lsDelimiter := #9;

    else
      lsDelimiter := '';
  end;

  {init looping vars}
  liCommand := 0;
  liCommands := lDrawCommands.Count;

  FStartingPage := True;
  FEndingPage := False;

  FFirstLine := (aPage.AbsolutePageNo = 1);
  liLastBandNo := TppDrawText(lDrawCommands.Objects[liCommands - 1]).BandSaveNo;

  {loop through canvas commands, saving values to text file}
  while (liCommand < liCommands) do
    begin

      FLineItemNo := 0;

      FStartingLine := True;
      FEndingLine := False;

      lsLine := '';

      lDrawText := TppDrawText(lDrawCommands.Objects[liCommand]);

      //Keep track of subreports
      liReportNo := lDrawText.ReportSaveNo;
      liSaveReportNo := liReportNo;

      liBandNo := lDrawText.BandSaveNo;
      liSaveBandNo := liBandNo;

      //Keep track of crosstab rows
      liRowNo := lDrawText.RowSaveNo;
      liSaveRowNo := liRowNo;

      FLastLine := (aPage.LastPage) and (liBandNo = liLastBandNo);

      while (liReportNo = liSaveReportNo) and (liBandNo = liSaveBandNo) and (liRowNo = liSaveRowNo) do
        begin

          {set ending line, ending page indicators}
          if (liCommand = (liCommands - 1)) then
            begin
              FEndingLine := True;
              FEndingPage := True;
            end

          else if (liBandNo <> TppDrawText(lDrawCommands.Objects[liCommand + 1]).BandSaveNo) then
            FEndingLine := True;

          {get the text value}
          if lDrawText.WordWrap then
            //Remove all CRLF characters
            lsText := StringReplace(lDrawText.WrappedText.Text, lsCRLF, '', [rfReplaceAll])
          else
            lsText := lDrawText.Text;

          {if fixed length, truncate or pad text as necessary}
          if (FTextFileType = ftFixedLength) then
            lsText := ppFixText(lsText, lDrawText.SaveLength, lDrawText.Alignment);

          if (FTextFileType = ftComma) and ((Pos(',', lsText) <> 0) or (Pos(#32, lsText) <> 0)) or (FQuoteAll) then
            begin
              {escape the quote char if it already exists in the exported string.}
              lsText := StringReplace(lsText, QuoteChar, QuoteChar + QuoteChar, [rfReplaceAll]);
              {add quotes around the entire string.}
              lsText := FQuoteChar + lsText + FQuoteChar;
            end;

          {fire the OnSave event}
          if Assigned(FOnSave) then FOnSave(Self, lDrawText.Component, lsText);

          if FStartingPage then
            FStartingPage := False;

          {add delimiter to text value}
          if FStartingLine then
            FStartingLine := False
          else
            lsText := lsDelimiter + lsText;

          lsLine := lsLine + lsText;

          Inc(FLineItemNo);

          Inc(liCommand);

          if (liCommand >= liCommands) then
            liBandNo := -1

          else
            begin
              lDrawText := TppDrawText(lDrawCommands.Objects[liCommand]);

              liReportNo := lDrawText.ReportSaveNo;
              liBandNo := lDrawText.BandSaveNo;
              liRowNo := lDrawText.RowSaveNo;
            end;

      end; {while, line not complete}

      {save completed line to file}
      EndLine;

      if FFirstLine then
        FFirstLine := False;

      Inc(FLineNo);

    end; {while, each command}


    lDrawCommands.Free;

end; {procedure, SavePageToFile}

{******************************************************************************
 *
 ** A R C H I V E   D E V I C E
 *
{******************************************************************************}


{------------------------------------------------------------------------------}
{ TppArchiveDevice.Create }

constructor TppArchiveDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FPageStream := nil;

  { for deployment purposes this should be true. for QA this should be false
    in order to test the incremental outline generation }
  FSaveCompleteOutlineOnly := True;

end; {constructor, Create}

{------------------------------------------------------------------------------}
{ TppArchiveDevice.DeviceName }

class function TppArchiveDevice.DeviceName: String;
begin
  Result := 'ArchiveFile';
end; {class function, DeviceName}


{@TppArchiveDevice.DefaultExt
 The DefaultExt property controls the default extension used when this device
 creates a file.

 Note: When the user is printing to file, a 'File' button is displayed on the
 Print dialog. This button allows the user to access a standard Delphi
 TSaveDialog. This dialog allows the user to specify the file to which the
 report should be printed. The DefaultExt and DefaultExtFilter functions are
 assigned to this dialog before it is displayed.}

class function TppArchiveDevice.DefaultExt: String;
begin
  Result := 'raf';
end; {class function, DefaultExt}


{@TppArchiveDevice.DefaultExtFilter
 The DefaultExtFilter property controls the files that will be listed in the
 current directory. For example, the filter: 'Text files|*.TXT' would display
 all files with the extension 'txt' in the current directory.

 Note: When the user is printing to file, a 'File' button is displayed on the
 Print dialog. This button allows the user to access a standard Delphi
 TSaveDialog. This dialog allows the user to specify the file to which the
 report should be printed. The DefaultExt and DefaultExtFilter functions are
 assigned to this dialog before it is displayed.}

class function TppArchiveDevice.DefaultExtFilter: String;
begin
  Result := 'Archive files|*.RAF|All files|*.*';
end; {class function, DefaultExtFilter}


{@TppArchiveDevice.DeviceDescription
 This function is used to populate the drop-down list of devices on the File tab
 of the Print dialog, and should return a more user-friendly description of the
 device than the DeviceName function. For example, the new ReportTextFileDevice
 class returns 'Report Emulation Text File' as the DeviceDescription and
 'ReportTextFile' as the DeviceName.}

class function TppArchiveDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := ppLoadStr(34); {'Archive File'}
end; {class function, DeviceDescription}

{------------------------------------------------------------------------------}
{ TppArchiveDevice.StartJob }

procedure TppArchiveDevice.StartJob;
var
  lMode: Word;
  lsMessage: String;
begin

  if not(StartPrintJob) then Exit;

  inherited StartJob;

  lMode := fmCreate or fmShareExclusive;

  FTempFile := ppGetTempFileName(ppGetTempPath, 'arc');

  {put exception handling here in case file can't be opened}
  try
    FPageStream := TFileStream.Create(FTempFile, lMode);

  except
    lsMessage := ppLoadStr(67); {Unable to open file: <filename>.}
    lsMessage := ppSetMessageParameters(lsMessage);
    lsMessage := Format(lsMessage, [FTempFile]);

    raise EPrintError.Create(lsMessage);
  end; {try, except}


  {save a space in the front of the stream to write the page directory size}
  OutputStream.Position := SizeOf(Longint);

end; {procedure, StartJob}

{------------------------------------------------------------------------------}
{ TppArchiveDevice.EndJob }

procedure TppArchiveDevice.EndJob;
var
  llPageDirectorySize: Longint;
begin

  if not(EndPrintJob) then Exit;

  if OutputStream = nil then Exit;

  llPageDirectorySize := OutputStream.Position;

  {copy pagestream to output stream,
    note: pass 0 as second paramter to copy entire stream}
  OutputStream.CopyFrom(FPageStream, 0);

  {write the page directory size}
  OutputStream.Position := 0;
  WriteToOutputStream(llPageDirectorySize, SizeOf(llPageDirectorySize));

  FPageStream.Free;
  FPageStream := nil;

  {delete the temp file}
  DeleteFile(FTempFile);

  inherited EndJob;

end; {procedure, EndJob}


{------------------------------------------------------------------------------}
{ TppArchiveDevice.ReceivePage }

procedure TppArchiveDevice.ReceivePage(aPage: TppPage);
begin

  inherited ReceivePage(aPage);

end; {procedure, ReceivePage}

{------------------------------------------------------------------------------}
{ TppArchiveDevice.SavePageToFile }

procedure TppArchiveDevice.SavePageToFile(aPage: TppPage);
var
  lPageEntry: TppPageEntryRec;
begin

  if (not(aPage.LastPage) and FSaveCompleteOutlineOnly) then
    FreeOutlineDrawCommand(aPage);

  lPageEntry.Position       := FPageStream.Position;
  lPageEntry.AbsolutePageNo := aPage.AbsolutePageNo;

  try

    {write the page directory}
    WriteToOutputStream(lPageEntry, SizeOf(lPageEntry));

    {write the page }
    FPageStream.WriteComponent(aPage);

  except on E: EWriteError do
    begin
      FreeOutputStream;

      FPageStream.Free;
      FPageStream := nil;

      DeleteFile(FTempFile);

      raise E;
    end;
  end;

end; {procedure, SavePageToFile}

{------------------------------------------------------------------------------}
{ TppArchiveDevice.FreeOutlineDrawCommand }

procedure TppArchiveDevice.FreeOutlineDrawCommand(aPage: TppPage);
var
  lOutlineDrawCommand: TppDrawCommand;
begin

  lOutlineDrawCommand := aPage.GetOutlineDrawCommand;

  if (lOutlineDrawCommand <> nil) then
    begin
      lOutlineDrawCommand.Page := nil;
      lOutlineDrawCommand.Free;
    end;

end; {procedure, FreeOutlineDrawCommand}

{******************************************************************************
 *
 ** R E P O R T   T E X T   F I L E   D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.Create }

constructor TppReportTextFileDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FAutoCalcGrid := True;
  FCalculateOutputFontSize := True;
  FCharsPerLine := 80;
  FLinesPerPage := 66;
  FOutputFontSize := 12;

{$IFDEF UNICODE}
  Encoding := TEncoding.UTF8;
{$ENDIF}

end; {constructor, Create}

{@TppReportTextFileDevice.CharacterGrid
 Sets the character grid used to convert the positions of the textual components
 of each report page to the character position within the text file.  The
 character grid is usually calculated automatically based on the first textual
 component rendered (when AutoCalcGrid is set to True).  Manually modifying the
 grid can sometimes improve the quality of the resulting text file; however,
 changing the report layout itself is usually the quickest way to a create a
 text file that most accurately reflects the report.}

procedure TppReportTextFileDevice.CharacterGrid(aCharsPerLine, aLinesPerPage: Integer);
begin
  FAutoCalcGrid := False;

  FCharsPerLine := aCharsPerLine;
  FLinesPerPage := aLinesPerPage;

end; {procedure, CharacterGrid}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.DeviceName }

class function TppReportTextFileDevice.DeviceName: String;
begin
  Result := 'ReportTextFile';
end; {class function, DeviceName}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.DefaultExt }

class function TppReportTextFileDevice.DefaultExt: String;
begin
  Result := 'txt';
end; {class function, DefaultExt}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.DefaultExtFilter }

class function TppReportTextFileDevice.DefaultExtFilter: String;
begin
  Result := 'Text files|*.TXT|All files|*.*';
end; {class function, DefaultExtFilter}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.DeviceDescription }

class function TppReportTextFileDevice.DeviceDescription(aLanguageIndex: Longint): String;
begin
  Result := ppLoadStr(12); {'Report Emulation Text File'}
end; {class function, DeviceDescription}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.ReceivePage }

procedure TppReportTextFileDevice.ReceivePage(aPage: TppPage);
begin

  inherited ReceivePage(aPage);

end; {procedure, ReceivePage}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.SavePageToFile }

procedure TppReportTextFileDevice.SavePageToFile(aPage: TppPage);
var
  lDrawCommands: TStringList;
  lDrawText: TppDrawText;
  liCommand: Integer;
  lsCRLF: String;
  lsLine: String;
  liCharPos: Integer;
  liLineNo: Integer;
  llTextWidth: Longint;
  llTextHeight: Longint;
  lsText: String;

  function TopToLineNo(aTop: Longint): Integer;
  begin
    Result := (aTop div llTextHeight) + 1;
  end;

  function LeftToCharPos(aLeft: Longint): Integer;
  begin
    Result := (aLeft div llTextWidth) + 1;
  end;

  function JustifyText: String;
  var
    liLength: Integer;
    liWidth: Integer;
  begin
    Result := lDrawText.Text;

    liWidth := (lDrawText.Width div llTextWidth) + 1;

    if (lDrawText.AutoSize) then
      begin
        liLength := Length(lDrawText.Text);

        if (liLength < liWidth) then
          liLength := liWidth;
      end
    else
      liLength := liWidth;

    Result := ppFixText(Result, liLength, lDrawText.Alignment);
  end;

  function BlankLine: String;
  begin
    Result := StringOfChar(' ', FCharsPerline);
  end;

  function GetNearestCourierSize(aFont: TFont): Integer;
  var
    lBitmap: TBitmap;
    liTextWidth8: Integer;
    liTextWidth10: Integer;
    liTextWidthAFont: Integer;
  begin
    {Default to Courier New 12}
    Result := 12;

    lBitmap := TBitmap.Create;
    try
      lBitmap.Canvas.Font.Name := 'Courier New';
      lBitmap.Canvas.Font.Size := 8;
      liTextWidth8 := lBitmap.Canvas.TextWidth('0');

      lBitmap.Canvas.Font.Size := 10;
      liTextWidth10 := lBitmap.Canvas.TextWidth('0');

      lBitmap.Canvas.Font := aFont;
      liTextWidthAFont := lBitmap.Canvas.TextWidth('0');

      if liTextWidthAFont <= liTextWidth8 then
        Result := 8
      else if liTextWidthAFont <= liTextWidth10 then
        Result := 10;

    finally
      lBitmap.Free;
    end;
  end;

  procedure CalcCharacterGrid;
  var
    lDrawCommand: TppDrawCommand;
    lBitmap: TBitmap;
    lDrawText: TppDrawText;
    liTextWidth: Integer;
    liTextHeight: Integer;
    liFontSize: Integer;
  begin

    lBitmap := TBitmap.Create;

    liTextWidth := 0;
    liTextHeight := 0;

    try

      lBitmap.Canvas.TryLock;

      lDrawCommand := TppDrawCommand(lDrawCommands.Objects[0]);

      if not(lDrawCommand is TppDrawText) then
        raise EReportBuilderError.Create('procedure TppReportTextFileDevice.CalcCharacterGrid: Drawcommand is not a TppDrawText but a ' + lDrawCommand.ClassName);

      lDrawText := TppDrawText(lDrawCommand);

      if CalculateOutputFontSize then
        liFontSize := GetNearestCourierSize(lDrawText.Font)
      else
        liFontSize := OutputFontSize;

      lBitmap.Canvas.Font.Name := 'Courier New';
      lBitmap.Canvas.Font.Size := liFontSize;

      liTextWidth := lBitmap.Canvas.TextWidth('0');
      liTextHeight := lBitmap.Canvas.TextHeight('0');

    finally
      lBitmap.Canvas.UnLock;

      lBitmap.Free;
    end;

    if FAutoCalcGrid then
      begin
        llTextWidth := Round(ppFromScreenPixels(liTextWidth, utMMThousandths, pprtHorizontal, nil));
        llTextHeight := Round(ppFromScreenPixels(liTextHeight, utMMThousandths, pprtVertical, nil));

        FCharsPerLine := (aPage.PageDef.mmWidth div llTextWidth);
        FLinesPerPage := (aPage.PageDef.mmHeight div llTextHeight);
      end
    else
      begin
        llTextWidth := (aPage.PageDef.mmWidth div FCharsPerLine);
        llTextHeight := (aPage.PageDef.mmHeight div FLinesPerPage);
      end;

  end;

  procedure EndLine;
  begin

    lsLine := TrimRight(lsLine);

    {write line to stream}
    if (Length(lsLine) > 0) then
      WriteToOutputStream(lsLine);

    {if not end of file, add carriage return to end of line}
    if (liLineNo = FLinesPerPage) and (aPage.LastPage) then
      {do nothing}
    else
      WriteToOutputStream(lsCRLF);

    Inc(liLineNo);

  end; {procedure, EndLine}

begin

  lsCRLF := #13#10;

  {get the draw text commands from the page}
  lDrawCommands := nil;

  GetDrawTextCommandsForReportExport(aPage, lDrawCommands);

  if (lDrawCommands = nil) then Exit;


  try
    {sort the commands into proper order}
    lDrawCommands.Sort;

    {calculate character grid}
    CalcCharacterGrid;

    {init looping vars}
    liCommand := 0;
    lsLine := BlankLine;
    liLineNo := 1;

    {loop through canvas commands, saving values to text file}
    while (liCommand < lDrawCommands.Count) and (liLineNo <= FLinesPerPage) do
      begin
        lDrawText := TppDrawText(lDrawCommands.Objects[liCommand]);

        if (TopToLineNo(lDrawText.Top) = liLineNo) then
          begin
            liCharPos := LeftToCharPos(lDrawText.Left);

            lsText := JustifyText;

            Delete(lsLine, liCharPos, Length(lsText));
            Insert(lsText, lsLine, liCharPos);

            Inc(liCommand);
          end
        else
          begin
            EndLine;

            lsLine := BlankLine;
          end;

          // free draw command, if it was created by this device (see GetDrawTextCommandsForReportExport)
          if lDrawText.Owner = Self then
            lDrawText.Free;

      end; {while, each command}

    while (liLineNo <= FLinesPerPage) do
      begin
        EndLine;

        lsLine := BlankLine;
      end;

  finally
    lDrawCommands.Free;
  end;

end; {procedure, SavePageToFile}

{------------------------------------------------------------------------------}
{ TppReportTextFileDevice.SetOutputFontSize }
procedure TppReportTextFileDevice.SetOutputFontSize(Value: Integer);
begin

  if (Value <> FOutputFontSize) then
    begin
      FOutputFontSize := Value;
      FCalculateOutputFontSize := False;
    end;

end; {procedure, SetOutputFontSize}

{@TppFileDeviceUtils.CompressStream

  Compresses a given stream at the chosen compression level.  This function
  uses the ZLib library to compress a memory stream before being written to the
  PDF file. }

class procedure TppFileDeviceUtils.CompressStream(aDataStream: TStream; aCompressionLevel: TppCompressionLevel = clDefault);
var
  lCompressionStream: TppCompressionStream;
  lInputStream: TStream;
begin

  {create a temporary input stream and copy the data stream}
  lInputStream := TStream(aDataStream.ClassType.Create);

  try
    lInputStream.CopyFrom(aDataStream, 0);

    {clear the data stream - it will be used to write the compressed output}
    aDataStream.Size := 0;

    {create a ZLib compression stream - it will write compressed data to aDataStream }
    lCompressionStream := TppCompressionStream.Create(aCompressionLevel, aDataStream);

    try
      lCompressionStream.CopyFrom(lInputStream, 0);
    finally
      lCompressionStream.Free;
    end;

  finally
    lInputStream.Free;

  end;

end;

{@TppFileDeviceUtils.DrawCommandToBitmap

  Converts a given drawcommand to an bitmap image.  This routine will copy the
  contents of any DrawCommand and draw them to the canvas of the returned
  bitmap.  Note that once this is done, much of the quality of the original
  component is lost. }

class function TppFileDeviceUtils.DrawCommandToBitmap(aDrawCommand: TppDrawCommand; aScalePercentage: Integer; aBackgroundColor: TColor): TBitmap;
var
  lBackgroundShape: TppDrawShape;
  liQuarterInch: Integer;
  lPage: TppPage;
  lScreenDevice: TppScreenDevice;
  lViewer: TppViewer;
begin

  {This is just padding to ensure the draw command has room to draw.}
  liQuarterInch := ppToMMThousandths(0.25, utInches, pprtHorizontal, nil);

  lBackgroundShape := TppDrawShape.Create(nil);
  lBackgroundShape.ShapeType := stRectangle;
  lBackgroundShape.Brush.Color := aBackgroundColor;
  lBackgroundShape.Left := 0;
  lBackgroundShape.Top := 0;
  lBackgroundShape.Width := aDrawCommand.Left + aDrawCommand.Width + liQuarterInch;
  lBackgroundShape.Height := aDrawCommand.Top + aDrawCommand.Height + liQuarterInch;

  lPage := TppPage.Create(nil);

  try

    lPage.PageDef.mmWidth := aDrawCommand.Left + aDrawCommand.Width + liQuarterInch;
    lPage.PageDef.mmHeight := aDrawCommand.Top + aDrawCommand.Height + liQuarterInch;
    lPage.AddDrawCommand(lBackgroundShape);
    lPage.AddDrawCommand(aDrawCommand);

    lViewer := TppViewer.Create(nil);
    lScreenDevice := TppScreenDevice.Create(lViewer);

    try

      lScreenDevice.Viewer.ZoomPercentage := aScalePercentage;
      lScreenDevice.PageRequest.PageSetting := psAll;
      lScreenDevice.ReceivePage(lPage);

      lScreenDevice.ScaleVertices(aDrawCommand);

      Result := TBitmap.Create;
      Result.Width := aDrawCommand.DrawRight - aDrawCommand.DrawLeft;
      Result.Height := aDrawCommand.DrawBottom - aDrawCommand.DrawTop;

      Result.Canvas.Draw(-aDrawCommand.DrawLeft, -aDrawCommand.DrawTop, lScreenDevice.PageImage);

    finally
      lScreenDevice.Free;
      lViewer.Free;
    end;

  finally

    lPage.RemoveDrawCommand(aDrawCommand);
    lPage.Free;

  end;

end;

class procedure TppFileDeviceUtils.GetFileDeviceClasses(aFileDeviceClasses: TStrings);
var
  lDeviceClasses: TStringList;
  lDeviceClass: TppDeviceClass;
  lFileDeviceClass: TppFileDeviceClass;
  liIndex: Integer;
begin

  lDeviceClasses := TStringList.Create;

  try

  // get list of registered device classes
  ppGetDeviceClasses(lDeviceClasses);

  // build list of file device class descendants
  for liIndex := lDeviceClasses.Count - 1 downto 0  do
    begin
      lDeviceClass := TppDeviceClass(lDeviceClasses.Objects[liIndex]);

      if (lDeviceClass.InheritsFrom(TppFileDevice)) then
        begin
          lFileDeviceClass := TppFileDeviceClass(lDeviceClass);
          aFileDeviceClasses.AddObject(lFileDeviceClass.DeviceDescription(0), TObject(lDeviceClass));
        end;

    end;

  finally
    lDeviceClasses.Free

  end;

end;

class function TppFileDeviceUtils.GetFileDeviceClassForName(aDeviceName: String): TppFileDeviceClass;
var
  lFileDeviceClasses: TStringList;
  lFileDeviceClass: TppFileDeviceClass;
  lbFound: Boolean;
  liIndex: Integer;
begin

  lFileDeviceClasses := TStringList.Create;
  lFileDeviceClass := nil;

  try
    // get list of registered file devices
    TppFileDeviceUtils.GetFileDeviceClasses(lFileDeviceClasses);

    liIndex := 0;
    lbFound := False;

    // find the device for the specified description
    while not(lbFound) and (liIndex < lFileDeviceClasses.Count) do
      begin
        lFileDeviceClass := TppFileDeviceClass(lFileDeviceClasses.Objects[liIndex]);

        if (lFileDeviceClass.DeviceName = aDeviceName) then
          lbFound := True
        else
          Inc(liIndex);

      end;

    if lbFound then
      Result :=  lFileDeviceClass
    else
      Result := nil;


  finally
    lFileDeviceClasses.Free;
  end;

end;

{******************************************************************************
 *
 ** TppFileDeviceUtils
 *
{******************************************************************************}

class function TppFileDeviceUtils.InchPerMicron: Double;
begin
  Result := 0.0000393701;
end;

class function TppFileDeviceUtils.MicronsToTwips(aMicrons: Integer): Integer;
begin
  Result := Trunc(aMicrons * InchPerMicron * TwipsPerInch);

end;

{@TppFileDeviceUtils.PixelsToPoints

  Given a number of pixels and screen or printer pixels per inch, this function
  will return a Double type value in points. }

class function TppFileDeviceUtils.PixelsToPoints(aPixels, aPixelsPerInch: Integer): Double;
begin
  Result := aPixels / aPixelsPerInch * 72;

end;

class function TppFileDeviceUtils.PixelsToTwips(aPixels, aPixelsPerInch: Integer): Integer;
begin
  Result := Round(aPixels / aPixelsPerInch * TwipsPerInch);

end;

class function TppFileDeviceUtils.TwipsToPixels(aTwips, aPixelsPerInch: Integer): Integer;
begin
  Result := Trunc((aTwips / TwipsPerInch) * aPixelsPerInch);

end;

class function TppFileDeviceUtils.ShellExec(const aPathStr, aCmdStr, aDirStr: string; aShow: Word): Boolean;
var
  lhInst: THandle;
  lpOperation: array[0..5] of Char;
begin

  StrPCopy(lpOperation, 'open');

  lhInst := ShellExecute(0, lpOperation, PChar(aPathStr), PChar(aCmdStr), PChar(aDirStr), aShow);

  { If 32 or less, an error occurred }
  Result := (lhInst > 32);

end;

class function TppFileDeviceUtils.ShellExec(aFileName: String): Boolean;
begin
  Result := ShellExec(aFileName, '', ExtractFilePath(aFileName), SW_SHOWNORMAL);

end;

class function TppFileDeviceUtils.TwipsPerInch: Integer;
begin
  Result := 1440;
end;

{@TppFileDeviceUtils.WriteLine }

class procedure TppFileDeviceUtils.WriteLine(aOutputStream: TStream; aLine: AnsiString);
begin
  aLine := aLine + #13 + #10;
  aOutputStream.Write(aLine[1], Length(aLine));

end;

{@TppFileDeviceUtils.WriteMem }

class procedure TppFileDeviceUtils.WriteMem(aOutputStream: TStream; aBuffer: AnsiString);
begin
  aOutputStream.Write(aBuffer[1], Length(aBuffer));

end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

initialization

  ppRegisterDevice(TppTextFileDevice);
  ppRegisterDevice(TppReportTextFileDevice);
  ppRegisterDevice(TppArchiveDevice);

finalization

  ppUnRegisterDevice(TppTextFileDevice);
  ppUnRegisterDevice(TppReportTextFileDevice);
  ppUnRegisterDevice(TppArchiveDevice);

end. 
