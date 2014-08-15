{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchError;

interface

uses
  ppTypes;

type

  {@ESearchError}

  ESearchError = class(EReportBuilderError);

  {@ESearchPreviewError}

  ESearchPreviewError = class(ESearchError);

  {@ESearchEngineError}

  ESearchEngineError = class(ESearchError);

  {@ESearchHighlightError}

  ESearchHighlightError = class(ESearchError);

  {@ERichTextHighlightError}

  ERichTextHighlightError = class(ESearchError);

  {@ESearchAbort}

  ESearchAbort = class(ESearchError);

implementation

end.
 
