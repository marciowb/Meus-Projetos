{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB }

unit ppXLSSettings;

interface

uses
  Classes,
  Graphics,
  ppTypes;

type

  {@TppXLSSettings

    Contains settings used to control the creation of XLS documents.

    Use the ExportCommands property to control which report components get
    exported to the XLS document. Note: applies to XLSReport not XLSData format.}

  {@TppXLSSettings.CacheToFile

    Defaults to false. Determines whether memory or file streams are used
    internally to store intermediate results.

    Note: Applies to XLSReport output; not applicable to XLSData}

  {@TppXLSSettings.ExportRTFAsBitmap

    Defaults to False. Run-time only. Indicates whether rich text is exported
    as a bitmap rather than parsed and merged directly into the XLS document. Use
    this setting when rich text oontains images or other complex formatting.

    Note: Applies to XLSReport output; not applicable to XLSData}


  {@TppXLSSettings.ExportComponents

    Determines which report components are to be exported to the XLS document.

    Note: Applies to XLSReport output; not applicable to XLSData}

  {@TppXLSSettings.OpenXLSFile

    Default to False. When true, automatically opens the output file when
    generation is completed.}

  {@TppXLSSettings.ScaleToPageWidth

    Defaults to False. Determines whether horizontal scale is 90% of actual size,
    so that printed output fits on the physical page width. It is odd, but Excel
    cannot fit an 8 inch wide layout on letter size paper. For example if you
    use Excel to draw a line 8 inches wide, the printed output will not fit
    on a letter size paper. When True only the drawing positions and width
    are scaled, the font is not scaled, thus auto-sized and word wrapped content
    may not fit within cell width.

    Note: Applies to XLSReport output; not applicable to XLSData}


  TppXLSSettings = class(TPersistent)
  private
    FCacheToFile: Boolean;
    FExportComponents: TppExportComponents;
    FExportRTFAsBitmap: Boolean;
    FOpenXLSFile: Boolean;
    FScaleToPageWidth: Boolean;

    procedure SetExportComponents(aExportComponents: TppExportComponents);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property ExportRTFAsBitmap: Boolean read FExportRTFAsBitmap write FExportRTFAsBitmap default False;

  published
    property CacheToFile: Boolean read FCacheToFile write FCacheToFile default False;
    property ExportComponents: TppExportComponents read FExportComponents write SetExportComponents default cAllExportComponents;
    property OpenXLSFile: Boolean read FOpenXLSFile write FOpenXLSFile default False;
    property ScaleToPageWidth: Boolean read FScaleToPageWidth write FScaleToPageWidth default False;
  end;


implementation

constructor TppXLSSettings.Create;
begin
  inherited;

  FCacheToFile := False;
  FExportComponents := cAllExportComponents;
  FOpenXLSFile := False;
  FExportRTFAsBitmap := False;
  FScaleToPageWidth := False;

end;

destructor TppXLSSettings.Destroy;
begin

  inherited;
end;

{@TppXLSSettings.Assign

  Assigns all published properties to a TppXLSSettings object.}

procedure TppXLSSettings.Assign(Source: TPersistent);
var
  lSettings: TppXLSSettings;
begin

  lSettings := TppXLSSettings(Source);

  FCacheToFile := lSettings.CacheToFile;
  FExportComponents := lSettings.ExportComponents;
  FOpenXLSFile := lSettings.OpenXLSFile;
  FExportRTFAsBitmap := lSettings.ExportRTFAsBitmap;
  FScaleToPageWidth := lSettings.ScaleToPageWidth;

end;

procedure TppXLSSettings.SetExportComponents(aExportComponents: TppExportComponents);
begin
  FExportComponents := aExportComponents;

end;

initialization

  RegisterClass(TppXLSSettings);

finalization

  UnregisterClass(TppXLSSettings);

end.
