{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchRegistration;

interface

implementation

uses
  ppPreview,
  ppTextSearchPreview,
  ppDrwCmd,
  ppRichTxDrwCmd,
  ppTextSearchEngineRegistry,
  ppTextSearchSelectionHighlighter,
  ppTextSearchRichTextHighlighter,
  ppTextSearchDrawCommandHighlightRegistry,
  ppTextSearchRichTextEngine,
  ppTextSearchToolbox;

initialization

  {creates the search visual controls}
  TppPreviewPlugin.RegisterSearchClass(TppTextSearchPreview);

  {need an engine to search the TppDrawText objects}
  TppTextSearchEngineRegistry.Register(TppTextSearchRichTextEngine);

  {highlighter to highlight TppDrawText and TppDrawRichText objects}
  TppTextSearchDrawCommandHighlightRegistry.Register(TppDrawText, TppTextSearchSelectionHighlighter);
  TppTextSearchDrawCommandHighlightRegistry.Register(TppDrawRichText, TppTextSearchRichTextHighlighter);

  {class functions that are used by the search engine and highlighter}
  TppTextSearchToolboxRegistry.Register(TppTextSearchToolbox);

finalization
  TppPreviewPlugin.UnRegisterSearchClass(TppTextSearchPreview);

  TppTextSearchEngineRegistry.UnRegister(TppTextSearchRichTextEngine);

  TppTextSearchDrawCommandHighlightRegistry.UnRegister(TppDrawText, TppTextSearchSelectionHighlighter);
  TppTextSearchDrawCommandHighlightRegistry.UnRegister(TppDrawRichText, TppTextSearchRichTextHighlighter);

  TppTextSearchToolboxRegistry.UnRegister(TppTextSearchToolbox);

end.
 
