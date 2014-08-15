{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchSelectionHighlighter;

interface

uses
  ppDevice,
  ppTextSearchHighlighter;

type

{@TppTextSearchSelectionHighlighter

  Text is highlighted with a the user's default highlight color behind the text. The text font is
  colored with the users default selected text highlight color. You can change this color by setting
  the Color and TextColor properties.}

  TppTextSearchSelectionHighlighter = class(TppTextSearchHighlighter)
    public
      constructor Create; override;

    end;

implementation

uses
  Graphics;

constructor TppTextSearchSelectionHighlighter.Create;
begin

  inherited Create;

  Color := clHighlight;
  TextColor := clHighlightText;

end;

end.
