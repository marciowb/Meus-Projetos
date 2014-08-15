{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2010                    BBBBB   }

unit ppRTFSettings;

interface

uses
  Classes,
  Graphics,
  ppTypes;

type

  {@TppRTFSettings

    Contains settings used to control the creation of RTF/DOC documents.

    Use the ExportCommands property to control which report components get
    exported to the RichText document.}

  {@TppRTFSettings.CacheToFile

    Writes each page to a temporary file during generation rather than to
    memory.

    By default, each page received by the report is written to memory before
    being added to the file stream.  If memory usage is an issue, setting this
    property to True will write this information to a temporary file saving
    memory during the export process.}

  {@TppRTFSettings.DefaultFont

    The default font used for the RichText document.

    This font (and font size) is used for all blank lines in the RichText
    document.  Try to assign this value to the most commonly used font in the
    report.  The default for this property is Arial 10.}

  {@TppRTFSettings.ExportComponents

    Determines which report components are to be exported to the RTF document.

    Note that graphical (lines, shapes, etc.) and images are not supported in
    simple RTF readers such as WordPad. }

  {@TppRTFSettings.MergeRichText

    Attempt to merge any report Richtext components into the exported Richtext
    document.

    By default this property is set to True.  Setting this to false will export
    any Richtext components on the report as a metafile and display them inside
    the document as an image.  This can be useful when using highly advanced
    Richtexts inside the report. }

  {@TppRTFSettings.OpenRTFFile

    Default to False. When true, automatically opens the output file when
    generation is completed.}

  {@TppRTFSettings.ShiftThreshold

    Vertical line spacing error threshold in twips.

    Use this property to fine tune an RTF document that may contain lines of
    text that gradually shift up or down.  When a page is generated with the
    UsePrecisionLines property set to True, each precision line is accurate to
    the truncated point value.  The remainder however is saved and added with
    previous line height remainders.  Once this value equals or exceeds the
    ShiftThreshold, the RTF device attempts to shift all remaining lines up to
    increase accuracy.  By default this value is set to 20 twips (1 point).

    If report lines are shifting downward, decrease the ShiftThreshold value.

    If report lines are shifting upward, increase the ShiftThreshold value. }

  {@TppRTFSettings.UsePrecisionLines

    Attempts to add small empty "precision" lines of text to increase the
    vertical accuracy of text objects in the exported RTF document.

    This property is set to True by default.  Setting this property to False
    will round off any extra vertical space between components causing the
    document to loose a small amount of accuracy however it may be necessary in
    some cases when the document is to be edited in a text editor or if you are
    having issues fitting a report on a single page. }

  TppRTFSettings = class(TPersistent)
  private
    FCacheToFile: Boolean;
    FMergeRichText: Boolean;
    FExportComponents: TppExportComponents;
    FDefaultFont: TFont;
    FUsePrecisionLines: Boolean;
    FOpenRTFFile: Boolean;
    FShiftThreshold: Integer;

    procedure SetExportComponents(aExportComponents: TppExportComponents);
    procedure SetDefaultFont(aFont: TFont);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property ShiftThreshold: Integer read FShiftThreshold write FShiftThreshold;

  published
    property CacheToFile: Boolean read FCacheToFile write FCacheToFile default False;
    property DefaultFont: TFont read FDefaultFont write SetDefaultFont;
    property ExportComponents: TppExportComponents read FExportComponents write SetExportComponents default cAllExportComponents;
    property MergeRichText: Boolean read FMergeRichText write FMergeRichText default True;
    property OpenRTFFile: Boolean read FOpenRTFFile write FOpenRTFFile default False;
    property UsePrecisionLines: Boolean read FUsePrecisionLines write FUsePrecisionLines default True;

  end;

implementation

constructor TppRTFSettings.Create;
begin
  inherited;

  FDefaultFont := TFont.Create;
  FDefaultFont.Name := 'Arial';
  FDefaultFont.Size := 10;

  FCacheToFile := False;
  FMergeRichText := True;
  FExportComponents := cAllExportComponents;
  FUsePrecisionLines := True;
  FOpenRTFFile := False;
  FShiftThreshold := 20;  // one point (twips)

end;

destructor TppRTFSettings.Destroy;
begin

  FDefaultFont.Free;
  FDefaultFont := nil;

  inherited;
end;

{@TppRTFSettings.Assign

  Assigns all published properties to a TppRTFSettings object. }

procedure TppRTFSettings.Assign(Source: TPersistent);
var
  lSettings: TppRTFSettings;
begin

  lSettings := TppRTFSettings(Source);

  FCacheToFile := lSettings.CacheToFile;
  FMergeRichText := lSettings.MergeRichText;
  FExportComponents := lSettings.ExportComponents;
  FDefaultFont.Assign(lSettings.DefaultFont);
  FUsePrecisionLines := lSettings.UsePrecisionLines;
  FOpenRTFFile := lSettings.OpenRTFFile;
  FShiftThreshold := lSettings.ShiftThreshold;

end;

procedure TppRTFSettings.SetDefaultFont(aFont: TFont);
begin
  FDefaultFont.Assign(aFont);

end;

procedure TppRTFSettings.SetExportComponents(aExportComponents: TppExportComponents);
begin
  FExportComponents := aExportComponents;

end;

initialization
  RegisterClass(TppRTFSettings);

finalization
  UnregisterClass(TppRTFSettings);

end.
