{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppPDFSettings;

interface

uses
  Classes,
  ppComm,
  ppTypes,
  ppZLib;

type
  TppKeyLengthType = (kl40Bit, kl128Bit);

  TppPDFEncryptSettings = class;

  {@TppPDFSettings

    Contains settings used to control the creation of PDF documents.

    Use the Author and Title properties to embed decriptive information in the
    PDF document. This can be viewed by selecting File | from Adobe Acrobat
    Reader.

    Use OpenPDFFile to control whether Adobe Acrobate Reader is automatically
    launched when the PDF file is created by the report.}

  {@TppPDFSettings.Author

    The name of the person who created the document. }

  {@TppPDFSettings.Creator

    The name of the software that generated the document. }

  {@TppPDFSettings.CacheImages

    By default all images are written to memory before being written to the PDF
    stream.  Setting this property to False will force each image to be written
    to a temporary file before being copied to the main PDF stream.  This can be
    helpful in avoiding low memory issues when generating large reports}

  {@TppPDFSettings.CompressionLevel

    Compression Level setting for the image and content streams of the PDF file.
    The user has the option of compressing images and content instructions at
    four differen levels

    <Table>
    Value	        Meaning
    ---------     -----
    clNone	      No compression; data is merely copied to the output stream.
    clFastest	    Specifies fastest compression, resulting in a larger archive.
    clDefault	    Compromise between speed and amount of compression.
    clMax	        Maximum compression, resulting in a longer generation time.
    </Table> }

  {@TppPDFSettings.EncryptSettings

    Contains settings used to control the encryption of a PDF file.

    See the TppPDFEncryptSettings topic for more information... }

  {@TppPDFSettings.ExportRTFAsBitmap

    Run-time only.

    Exports all RichText components as bitmap images rather than drawing them
    directly to the PDF canvas.  This can be useful when trying to display text
    or objects too advanced for the PDF renderer to handle. }

  {@TppPDFSettings.Keywords

    Keywords associated with the document. }

  {@TppPDFSettings.OpenPDFFile

    Setting this property to True will automatically open and view the PDF
    file with the default PDF viewer defined by Windows (Usually Adobe Acrobat
    Reader). }

  {@TppPDFSettings.OptimizeImageExport

    Run-time only.

    In order to keep the PDF file size small, the PDF device by default uses the
    same image data for identical images.  In some cases (i.e. when drawing
    directly to the printer canvas) the image name is not unique.  Setting this
    property to false removes this optimization feature and prints each unique
    image separately in the PDF file. }

  {@TppPDFSettings.Subject

    The Subject of the document. }

  {@TppPDFSettings.EmbedFontOptions

    Use the EmbedFontOptions to enable font embedding inside the PDF file.  When
    a font file is embedded inside a PDF, there is no need for the user to have
    the particular font on their machine to view the document.  This is to
    ensure the file is always viewable/printable.  All Unicode fonts must be
    embedded if Unicode characters are to be used.

    Embedding fonts will increase the size of the PDF file.

    Options:

    AllFonts:  Embed all fonts used in the document.
    FontList:  Embed only the fonts defined in the TppPDFSettings.EmbedFontList
               property.
    UseSubset: Enable font subsetting.  Embed a smaller subset of
               the font(s) used in order to save space.  This can be useful when
               using large fonts or unicode fonts (all Unicode fonts need to be
               embedded).  Note however that the font subset will only contain
               the characters used in the original document.  If the PDF file is
               to be edited after creation, do not use font subsetting. }

  {@TppPDFSettings.FontEncoding

    Defines the document encoding for all fonts used.

    The PDF device includes support for ANSI encoding with multiple charsets and
    Unicode encoding.  If Unicode fonts/characters are used in a report, this
    property should always be set to Unicode encoding.  This will ensure that
    all Unicode text displays correctly inside the PDF document.

    ANSI encoding can be useful if no Unicode characters will ever be used in
    document.  The use of ANSI encoding can save space inside the PDF file due
    to the fact that all Unicode fonts must be embedded (see EmbedFontOptions).

    Unicode is only supported for Delphi 2009 or later.  For versions of Delphi
    earlier than 2009, this property is ignored. }

  {@TppPDFSettings.ScaleImages

    Option to scale images with a smaller control box than the actual size.
    This option reduces image quality but preserves space when
    large images need to be resized.  This device will only scale images with
    the following specifications:

     1. Image Width is smaller than its original graphic size (and/or)
        image Height is smaller than its original graphic size.
     2. Stretching has been enabled. }

  {@TppPDFSettings.Title

    The document's title. }

  TppPDFSettings = class(TPersistent)
    private
      FAuthor: String;
      FCacheImages: Boolean;
      FCompressionLevel: TppCompressionLevel;
      FCreator: string;
      FEmbedFontOptions: TppPDFEmbedFontOptions;
      FEmbedFontList: TStrings;
      FEncryptSettings: TppPDFEncryptSettings;
      FExportRTFAsBitmap: Boolean;
      FExportMetaFileAsBitmap: Boolean;
      FFontEncoding: TppFontEncoding;
      FKeywords: String;
      FOpenPDFFile: Boolean;
      FOptimizeImageExport: Boolean;
      FScaleImages: Boolean;
      FSubject: String;
      FTitle: String;

      procedure SetAuthor(const Value: String);
      procedure SetCompressionLevel(const Value: TppCompressionLevel);
      procedure SetCreator(const Value: string);
      procedure SetEmbedFontOptions(const Value: TppPDFEmbedFontOptions);
      procedure SetEmbedFontList(Value: TStrings);
      procedure SetEncryptSettings(const Value: TppPDFEncryptSettings);
      procedure SetFontEncoding(const Value: TppFontEncoding);
      procedure SetKeywords(const Value: String);
      procedure SetOpenPDFFile(const Value: Boolean);
      procedure SetSubject(const Value: String);
      procedure SetTitle(const Value: String);
      procedure SetScaleImages(const Value: Boolean);

    public
      constructor Create;
      destructor Destroy; override;

      procedure Assign(Source: TPersistent); override;

      property OptimizeImageExport: Boolean read FOptimizeImageExport write FOptimizeImageExport default True;
      property ExportRTFAsBitmap: Boolean read FExportRTFAsBitmap write FExportRTFAsBitmap default False;
      property ExportMetaFileAsBitmap: Boolean read FExportMetaFileAsBitmap write FExportMetaFileAsBitmap default False;

    published
      property Author: String read FAuthor write SetAuthor;
      property CacheImages: Boolean read FCacheImages write FCacheImages default True;
      property CompressionLevel: TppCompressionLevel read FCompressionLevel write SetCompressionLevel default clDefault;
      property Creator: string read FCreator write SetCreator;
      property EmbedFontOptions: TppPDFEmbedFontOptions read FEmbedFontOptions write SetEmbedFontOptions;
      property EmbedFontList: TStrings read FEmbedFontList write SetEmbedFontList;
      property EncryptSettings: TppPDFEncryptSettings read FEncryptSettings write SetEncryptSettings;
      property FontEncoding: TppFontEncoding read FFontEncoding write SetFontEncoding;
      property Keywords: String read FKeywords write SetKeywords;
      property OpenPDFFile: Boolean read FOpenPDFFile write SetOpenPDFFile default False;
      property ScaleImages: Boolean read FScaleImages write SetScaleImages default True;
      property Subject: String read FSubject write SetSubject;
      property Title: String read FTitle write SetTitle;

  end;

  {@TppPDFEncryptSettings

    Contains settings used to control the encryption of a PDF file.

    Enabling these settings allows the creator of a PDF document to password
    protect/encrypt the document as well as limit the user functionality such as
    printing and copying the document. }

  {@TppPDFEncryptSettings.AllowCopy

    Allow the user to copy text and graphics from the document. }

  {@TppPDFEncryptSettings.AllowInteract

    Allow the user to add or modify text annotations and interactive form
    fields. }

  {@TppPDFEncryptSettings.AllowModify

    Allow the user to modify the contents of the document (other than text
    annotations and interactive form fields). }

  {@TppPDFEncryptSettings.AllowPrint

    Allow the user to print the document. }

  {@TppPDFEncryptSettings.Enabled

    Enable password protection/encryption for the exported PDF file. }

  {@TppPDFEncryptSettings.OwnerPassword

    Password to open and remove all restrictions from the PDF file.  A value
    must be assigned to encrypt the document (even if no User Password is
    assigned). }

  {@TppPDFEncryptSettings.UserPassword

    Password to open the PDF document.  Once opened using this password, the
    restrictions defined with the AllowPrint, AllowCopy, AllowModify, and
    AllowInteract properties are still valid.

    Leaving this value blank will allow automatic opening of the PDF document
    (without a password) with the defined restrictions.}

  TppPDFEncryptSettings = class(TPersistent)
    private
      FAllowCopy: Boolean;
      FAllowInteract: Boolean;
      FAllowModify: Boolean;
      FAllowPrint: Boolean;
      FEnabled: Boolean;
      FOwnerPassword: string;
      FUserPassword: string;

    public
      constructor Create;

      procedure Assign(Source: TPersistent); override;

    published
      property AllowCopy: Boolean read FAllowCopy write FAllowCopy;
      property AllowInteract: Boolean read FAllowInteract write FAllowInteract;
      property AllowModify: Boolean read FAllowModify write FAllowModify;
      property AllowPrint: Boolean read FAllowPrint write FAllowPrint;
      property Enabled: Boolean read FEnabled write FEnabled;
      property OwnerPassword: string read FOwnerPassword write FOwnerPassword;
      property UserPassword: string read FUserPassword write FUserPassword;
  end;

implementation

uses
  SysUtils;

constructor TppPDFSettings.Create;
begin
  inherited Create;

  FScaleImages := True;
  FCompressionLevel := clDefault;
  FOpenPDFFile := False;
  FOptimizeImageExport := True;
  FEmbedFontOptions := [efUseSubset];
  FEmbedFontList := TStringList.Create;
  FExportRTFAsBitmap := False;
  FExportMetaFileAsBitmap := False;
  FFontEncoding := feAnsi;
  FCacheImages := True;

  FEncryptSettings := TppPDFEncryptSettings.Create;

end;

destructor TppPDFSettings.Destroy;
begin
  FEmbedFontList.Free;
  FEmbedFontList := nil;

  FEncryptSettings.Free;
  FEncryptSettings := nil;

  inherited Destroy;
end;

{@TppPDFSettings.Assign

  Assigns all published properties to a TppPDFSettings object. }

procedure TppPDFSettings.Assign(Source: TPersistent);
var
  lSettings: TppPDFSettings;
begin

  lSettings := TppPDFSettings(Source);

  FAuthor := lSettings.FAuthor;
  FCompressionLevel := lSettings.FCompressionLevel;
  FCreator := lSettings.Creator;
  FEmbedFontOptions := lSettings.FEmbedFontOptions;
  FEmbedFontList.Assign(lSettings.FEmbedFontList);
  FKeywords := lSettings.FKeywords;
  FOpenPDFFile := lSettings.FOpenPDFFile;
  FScaleImages := lSettings.FScaleImages;
  FSubject := lSettings.FSubject;
  FTitle := lSettings.FTitle;
  FOptimizeImageExport := lSettings.OptimizeImageExport;
  FExportRTFAsBitmap := lSettings.ExportRTFAsBitmap;
  FExportMetaFileAsBitmap := lSettings.ExportMetaFileAsBitmap;
  FFontEncoding := lSettings.FontEncoding;
  FCacheImages := lSettings.CacheImages;
  FEncryptSettings.Assign(lSettings.EncryptSettings);

end;

procedure TppPDFSettings.SetAuthor(const Value: String);
begin
  FAuthor := Value;
end;

procedure TppPDFSettings.SetCompressionLevel(const Value: TppCompressionLevel);
begin
  FCompressionLevel := Value;
end;

procedure TppPDFSettings.SetCreator(const Value: string);
begin
  FCreator := Value;
end;

procedure TppPDFSettings.SetKeywords(const Value: String);
begin
  FKeywords := Value;
end;

procedure TppPDFSettings.SetSubject(const Value: String);
begin
  FSubject := Value;
end;

procedure TppPDFSettings.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

procedure TppPDFSettings.SetOpenPDFFile(const Value: Boolean);
begin
  FOpenPDFFile := Value;
end;

procedure TppPDFSettings.SetScaleImages(const Value: Boolean);
begin
  FScaleImages := Value;
end;

procedure TppPDFSettings.SetEmbedFontOptions(const Value: TppPDFEmbedFontOptions);
begin

  if (efAllFonts in FEmbedFontOptions) and (efFontList in Value) then
    FEmbedFontOptions := FEmbedFontOptions + [efFontList] - [efAllFonts]

  else if (efFontList in FEmbedFontOptions) and (efAllFonts in Value) then
    FEmbedFontOptions := FEmbedFontOptions + [efAllFonts] - [efFontList]

  else
    FEmbedFontOptions := Value;

end;

procedure TppPDFSettings.SetEmbedFontList(Value: TStrings);
begin
  FEmbedFontList.Assign(Value);
  
end;

procedure TppPDFSettings.SetEncryptSettings(const Value: TppPDFEncryptSettings);
begin
  FEncryptSettings.Assign(Value);

end;

procedure TppPDFSettings.SetFontEncoding(const Value: TppFontEncoding);
begin
  if (Value <> FFontEncoding) then
    FFontEncoding := Value;
end;

{@TppPDFEncryptSettings.Assign

  Assigns all published properties to a TppPDFEncryptSettings object. }

procedure TppPDFEncryptSettings.Assign(Source: TPersistent);
var
  lSettings: TppPDFEncryptSettings;
begin

  lSettings := TppPDFEncryptSettings(Source);

  FAllowCopy     := lSettings.AllowCopy;
  FAllowInteract := lSettings.AllowInteract;
  FAllowModify   := lSettings.AllowModify;
  FAllowPrint    := lSettings.AllowPrint;
  FEnabled       := lSettings.Enabled;
  FOwnerPassword := lSettings.OwnerPassword;
  FUserPassword  := lSettings.UserPassword;

end;

constructor TppPDFEncryptSettings.Create;
begin
  FAllowCopy := True;
  FAllowInteract := True;
  FAllowModify := True;
  FAllowPrint := True;
  FEnabled := False;
  FOwnerPassword := '';
  FUserPassword := '';

end;

initialization
  RegisterClass(TppPDFSettings);

finalization
  UnregisterClass(TppPDFSettings);

end.
