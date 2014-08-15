{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFRenderer;

interface

uses
  Classes,
  ppDevice,
  ppFormatStyles,
  ppRTFObject,
  ppRTFSettings;

type

  TppRTFRendererClass = class of TppRTFRenderer;

  {@TppRTFRenderer

    This is an abstract base class.  When a draw command is received by the
    RTF device, the renderer object for the closest ancestor with an associated
    renderer in the class hierarchy is chosen for processing the draw command.

    The WriteLine and WriteMem procedures can be used to easily write instructions
    to the Richtext document stream.}

  TppRTFRenderer = class(TObject)
  private
    FRTFObject: TppRTFObject;
    FDocStream: TStream;
    FColorTable: TppColorTable;
    FFontTable: TppFontTable;
    FRTFSettings: TppRTFSettings;
    FID: Integer;
    procedure SetRTFSettings(const Value: TppRTFSettings);

  protected
    function  ExtToStr(aValue: Extended): String;
    procedure SetRTFObject(const Value: TppRTFObject); virtual;
    procedure SetDocStream(const Value: TStream); virtual;
    procedure WriteLine(aLine: String);
    procedure WriteMem(aBuffer: String);

  public
    constructor Create; virtual;
    destructor Destroy; override;

    class function DrawCommandClass: TppDrawCommandClass; virtual; abstract;

    procedure RenderToRTF; virtual; abstract;

    property RTFObject: TppRTFObject read FRTFObject write SetRTFObject;
    property DocStream: TStream read FDocStream write SetDocStream;
    property ColorTable: TppColorTable read FColorTable write FColorTable;
    property FontTable: TppFontTable read FFontTable write FFontTable;
    property ID: Integer read FID write FID;
    property RTFSettings: TppRTFSettings read FRTFSettings write SetRTFSettings;

  end;

implementation

uses
  ppFilDev,
  ppCharacter,
  SysUtils;

constructor TppRTFRenderer.Create;
begin
  inherited;

  FRTFObject := nil;
  FDocStream := nil;

  FID := -1;

end;

destructor TppRTFRenderer.Destroy;
begin

  inherited;
end;

function TppRTFRenderer.ExtToStr(aValue: Extended): String;
begin
  Result := FormatFloat('0.0####', aValue);
  Result := StringReplace(Result, DecimalSeparator, '.', []);
end;

procedure TppRTFRenderer.SetRTFObject(const Value: TppRTFObject);
begin
  if FRTFObject <> Value then
    FRTFObject := Value;

end;

procedure TppRTFRenderer.SetDocStream(const Value: TStream);
begin
  if FDocStream <> Value then
    FDocStream := Value;

end;

procedure TppRTFRenderer.SetRTFSettings(const Value: TppRTFSettings);
begin
  if FRTFSettings <> Value then
    FRTFSettings := Value;

end;

{$WARNINGS OFF}

procedure TppRTFRenderer.WriteLine(aLine: String);
begin
  TppFileDeviceUtils.WriteLine(FDocStream, aLine);

end;

procedure TppRTFRenderer.WriteMem(aBuffer: String);
begin
  TppFileDeviceUtils.WriteMem(FDocStream, aBuffer);

end;
{$WARNINGS ON}

end.
