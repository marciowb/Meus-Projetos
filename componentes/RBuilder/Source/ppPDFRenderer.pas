{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFRenderer;


interface

uses
  Classes,
  ppDevice,
  ppPDFXRef,
  ppPDFSettings,
  ppPDFCanvas,
  ppPrintr;

type

  TppPDFRendererClass = class of TppPDFRenderer;

  {TppPDFRenderer

    This is an abstract base class.  When a draw command is received by the
    PDF device, the renderer object for the closest ancestor with an associated
    renderer in the class hierarchy is chosen for processing the draw command.

    Use the ExtToStr function when converting floating point numbers to strings
    to ensure the decimal separator is a period (necessary for PDF)

    The WriteLine and WriteMem procedures can be used to easily write instructions
    to the PDF content stream.}

  TppPDFRenderer = class
  private
    FDrawCommand: TppDrawCommand;
    FPDFSettings: TppPDFSettings;
    FPDFXRef: TppPDFXRef;
    FMemoryStream: TMemoryStream;
    FPageHeight: Double;
    FPrinter: TppPrinter;
    FPDFCanvas: TppPDFCanvas;

    procedure SetFPDFXRef(const Value: TppPDFXRef);
    procedure SetMemoryStream(const Value: TMemoryStream);
    procedure SetPageHeight(const Value: Double);
    procedure SetPDFSettings(const Value: TppPDFSettings);
    procedure SetPrinter(const Value: TppPrinter);

  protected
    function  ExtToStr(aValue: Extended): String;

    procedure SetDrawCommand(const Value: TppDrawCommand); virtual;
    procedure WriteLine(aLine: String);
    procedure WriteMem(aBuffer: String);

  public
    constructor Create; virtual;
    destructor Destroy; override;
    class function DrawCommandClass: TppDrawCommandClass; virtual; abstract;
    procedure RenderToPDF; virtual; abstract;

    property PDFCanvas: TppPDFCanvas read FPDFCanvas write FPDFCanvas;
    property DrawCommand: TppDrawCommand read FDrawCommand write SetDrawCommand;
    property PDFXRef: TppPDFXRef read FPDFXRef write SetFPDFXRef;
    property MemoryStream: TMemoryStream read FMemoryStream write SetMemoryStream;
    property PageHeight: Double read FPageHeight write SetPageHeight;
    property PDFSettings: TppPDFSettings read FPDFSettings write SetPDFSettings;
    property Printer: TppPrinter read FPrinter write SetPrinter;

  end;

implementation

uses
  ppPDFUtils,
  ppCharacter,
  SysUtils;

constructor TppPDFRenderer.Create;
begin
  inherited;

  FPDFCanvas := TppPDFCanvas.Create;

  FDrawCommand := nil;
  FPDFSettings := nil;
  FPDFXRef := nil;
  FMemoryStream := nil;
  FPageHeight := 0;

end;

destructor TppPDFRenderer.Destroy;
begin
  FPDFCanvas.Free;
  FPDFCanvas := nil;

  inherited;
end;

function TppPDFRenderer.ExtToStr(aValue: Extended): String;
begin
  Result := FormatFloat('0.0####', aValue);
  Result := StringReplace(Result, DecimalSeparator, '.', []);
end;

procedure TppPDFRenderer.SetDrawCommand(const Value: TppDrawCommand);
begin
  if FDrawCommand <> Value then
    FDrawCommand := Value;

end;

procedure TppPDFRenderer.SetFPDFXRef(const Value: TppPDFXRef);
begin
  if FPDFXRef <> Value then
    FPDFXRef := Value;

  FPDFCanvas.PDFXRef := FPDFXRef;
    
end;

procedure TppPDFRenderer.SetMemoryStream(const Value: TMemoryStream);
begin
  if FMemoryStream <> Value then
    FMemoryStream := Value;

  FPDFCanvas.ContentStream := FMemoryStream;

end;

procedure TppPDFRenderer.SetPageHeight(const Value: Double);
begin
  if FPageHeight <> Value then
    FPageHeight := Value;

  FPDFCanvas.PageHeight := FPageHeight;

end;

procedure TppPDFRenderer.SetPDFSettings(const Value: TppPDFSettings);
begin
  if FPDFSettings <> Value then
    FPDFSettings := Value;

  FPDFCanvas.PDFSettings := FPDFSettings;

end;

procedure TppPDFRenderer.SetPrinter(const Value: TppPrinter);
begin
  FPrinter := Value;

  FPDFCanvas.Printer := FPrinter;

end;

{TppPDFRenderer.WriteLine

  Writes a line of text to the main Device Stream including the Carrage
  Return and Line Feed characters. }
{$WARNINGS OFF}
procedure TppPDFRenderer.WriteLine(aLine: String);
begin
  TppPDFUtils.WriteLine(FMemoryStream, aLine);

end;

{TppPDFRenderer.WriteMem

  Writes a line of text ot the main Device Stream without the CRLF
  characters. }

procedure TppPDFRenderer.WriteMem(aBuffer: String);
begin
  TppPDFUtils.WriteMem(FMemoryStream, aBuffer);

end;
{$WARNINGS ON}

end.
