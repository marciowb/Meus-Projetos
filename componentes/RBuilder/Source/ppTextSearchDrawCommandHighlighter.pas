{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchDrawCommandHighlighter;

interface

uses
  Graphics,
  ppDevice,
  ppTextSearchOccurrence;

type

{@TppTextSearchDrawCommandHighlighter

  Used by the print preview text search engine in order to highlight a draw
  command on the page object which matches the text that is found on the page.

  This class is the ancestor for the draw command highlihghter that should
  be used with a draw command. Each draw command can be registered with a
  specific draw command highlighter class. The highlighter classes are part of
  an abstract factory in which the text search engine asks the draw command
  highlight registry for the highlighter class in order to instantiate the
  highlighter for that draw command.}

 {TppTextSearchDrawCommandHighlighter.TextColor

     The color of the text which is used to draw the highlights on the page.
     When the search engine's ShowAll property is true, all highlights
     except the cursor highlight use this text color.}

  TppTextSearchDrawCommandHighlighter = class(TObject)
    private
      FScaleY: Double;
      FScaleX: Double;
      FColor: Integer;
      FCaseSensitive: Boolean;
      FWholeWord: Boolean;
      FTransparent: Boolean;
      FTextColor: Integer;

    public
      constructor Create; virtual;

      function CreateHighlight(aDrawCommand: TppDrawCommand; aSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas): TppDrawCommand; virtual;
      procedure EraseHighlight(aDrawCommand: TppDrawCommand; aSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas); virtual;

      property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive;
      property Color: Integer read FColor write FColor;
      property ScaleY: Double read FScaleY write FScaleY;
      property ScaleX: Double read FScaleX write FScaleX;
      property TextColor: Integer read FTextColor write FTextColor;
      property Transparent: Boolean read FTransparent write FTransparent;
      property WholeWord: Boolean read FWholeWord write FWholeWord;

    end;

  TppTextSearchDrawCommandHighlighterClass = class of TppTextSearchDrawCommandHighlighter;

implementation

uses
  ppTextSearchError;

{@TppTextSearchDrawCommandHighlighter.Create }

constructor TppTextSearchDrawCommandHighlighter.Create;
begin

  inherited Create;

  FCaseSensitive := False;
  FColor := clHighlight;
  FScaleY := 1;
  FScaleX := 1;
  FTextColor := clHighlightText;
  FTransparent := False;
  FWholeWord := False;

end;

{@TppTextSearchDrawCommandHighlighter.CreateHighlight }

function TppTextSearchDrawCommandHighlighter.CreateHighlight(aDrawCommand: TppDrawCommand; aSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas): TppDrawCommand;
begin

  if (aDrawCommand = nil) then
    raise ESearchHighlightError.Create('TppTextSearchDrawCommandHighlighter.CreateHighlight: Must pass a non nil draw command object.');

  if (aSearchOccurrence = nil) then
    raise ESearchHighlightError.Create('TppTextSearchDrawCommandHighlighter.CreateHighlight: Must pass a non nil draw command search Artifact object.');

  if (aCanvas = nil) then
    raise ESearchHighlightError.Create('TppTextSearchDrawCommandHighlighter.CreateHighlight: Must pass a non nil TCanvas object.');

  Result := nil;

end;
 
{@TppTextSearchDrawCommandHighlighter.EraseHighlight }

procedure TppTextSearchDrawCommandHighlighter.EraseHighlight(aDrawCommand: TppDrawCommand; aSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas);
begin

  if (aDrawCommand = nil) then
    raise ESearchHighlightError.Create('TppTextSearchDrawCommandHighlighter.CreateHighlight: Must pass a non nil draw command object.');

  if (aSearchOccurrence = nil) then
    raise ESearchHighlightError.Create('TppTextSearchDrawCommandHighlighter.CreateHighlight: Must pass a non nil draw command search Artifact object.');

end;

end.
