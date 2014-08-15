{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchOccurrence;

interface

uses
  Classes, Graphics,
  ppComm, ppDrwCmd, ppDevice, ppTypes;

type

{@TppTextSearchOccurrence

  Used by the text search engine in order to build information about the draw
  command when text in that draw command is found to match the search text.}

{@TppTextSearchOccurrence.OccurrenceIndex

  The occurrence position of the text in the single draw command. This only
  applies relative to a single draw command.}

{@TppTextSearchOccurrence.DrawCommandIndex

  The index on the page object's draw command array property in which the
  drawcommand that can be found for this draw command occurrence object.}

{@TppTextSearchOccurrence.Left

  The left position of the draw command to be highlighted on the page.}

{@TppTextSearchOccurrence.Top

  The top position of the draw command to be highlighted on the page.}

  TppTextSearchOccurrence = class(TppCommunicator)
    private
      FOccuranceIndex: Integer;
      FDrawCommandIndex: Integer;
      FLeft: Integer;
      FTop: Integer;
      FStartCharPosition: Integer;
      FLineNumber: Integer;
      FOriginalBackgroundColor: TColor;
      FOriginalTextColor: TColor;

      procedure SetOccuranceIndex(aOccuranceIndex: Integer);
      procedure SetDrawCommandIndex(aIndex: Integer);
      procedure SetOriginalBackgroundColor(aColor: TColor);

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      property StartCharPosition: Integer read FStartCharPosition write FStartCharPosition;
      property LineNumber: Integer read FLineNumber write FLineNumber;
      property OccurrenceIndex: Integer read FOccuranceIndex write SetOccuranceIndex;
      property OriginalBackgroundColor: TColor read FOriginalBackgroundColor write SetOriginalBackgroundColor;
      property OriginalTextColor: TColor read FOriginalTextColor write FOriginalTextColor;
      property DrawCommandIndex: Integer read FDrawCommandIndex write SetDrawCommandIndex;
      property Top: Integer read FTop write FTop;
      property Left: Integer read FLeft write FLeft;

    end;

implementation

uses
  ppTextSearchError;

{@TppTextSearchOccurrence.Create }

constructor TppTextSearchOccurrence.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FLineNumber := 1;
  FStartCharPosition := 0;
  FOccuranceIndex := 0;
  FOriginalBackgroundColor := -1;
  FOriginalTextColor := -1;
  FDrawCommandIndex := 0;
  FLeft := 0;
  FTop := 0;

end;
    
{@TppTextSearchOccurrence.Destroy }

destructor TppTextSearchOccurrence.Destroy;
begin

  inherited Destroy;

end;
    
{@TppTextSearchOccurrence.SetDrawCommandIndex }

procedure TppTextSearchOccurrence.SetDrawCommandIndex(aIndex: Integer);
begin
  FDrawCommandIndex := aIndex;
end;
    
{@TppTextSearchOccurrence.SetOccuranceIndex }

procedure TppTextSearchOccurrence.SetOccuranceIndex(aOccuranceIndex: Integer);
begin
  FOccuranceIndex := aOccuranceIndex;
end;
 {@TppTextSearchOccurrence.SetOriginalBackgroundColor }

procedure TppTextSearchOccurrence.SetOriginalBackgroundColor(aColor: TColor);
begin
  if (aColor = -2147483643) then
    FOriginalBackgroundColor := clWhite
  else
    FOriginalBackgroundColor := aColor;
end;

end.
