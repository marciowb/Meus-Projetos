{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchRichTextHighlighter;

interface

uses
  Graphics,
  Classes,
  ComCtrls,
  
  ppDrwCmd,
  ppRichTxDrwCmd,
  ppDevice,
  ppTextSearchDrawCommandHighlighter,
  ppTextSearchOccurrence;

type

  {@TppTextSearchRichTextHighlighter

    Finds the search text in the draw command and creates a draw command on top
    to it to effectively show the highlighted text in place.

    Use this class to search a TppDrawRichText object.

    In order to control the highlight draw command which is created for the actual
    hihglight on the page, create a descendent of this class and override the
    CreateDrawCommand method to create the highlight draw command of your
    choice.}


  TppTextSearchRichTextHighlighter = class(TppTextSearchDrawCommandHighlighter)
    private
      FRichBackgroundColor: Integer;
      FRichTextColor: Integer;

      procedure ChangeSelectedTextColor(aRichEdit: TCustomRichEdit; aDrawRichText: TppDrawRichText; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aNewTextColor, aNewBackgroundColor: TColor);

    public
      constructor Create; override;
      destructor Destroy; override;

      function CreateHighlight(aDrawCommand: TppDrawCommand; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas): TppDrawCommand; override;
      procedure EraseHighlight(aDrawCommand: TppDrawCommand; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas); override;
    end;


  {@TppTextSearchRichTextHighlighterClass }

  TppTextSearchRichTextHighlighterClass = class of TppTextSearchRichTextHighlighter;

implementation

uses
  {$IFDEF Delphi6} Types, {$ENDIF}

  ExtCtrls, SysUtils, Windows, Forms, RichEdit, Controls,
  ppTypes, ppUtils, ppTextSearchError, ppPlainText,
  ppTextSearchToolbox, ppRTTI;

{@TppTextSearchRichTextHighlighter.Create }

constructor TppTextSearchRichTextHighlighter.Create;
begin

  inherited Create;

  FRichTextColor := 15793151; {cream}
  FRichBackgroundColor := 6956042; {navy}

end;

{@TppTextSearchRichTextHighlighter.Destroy }

destructor TppTextSearchRichTextHighlighter.Destroy;
begin

  inherited Destroy;

end;

{@TppTextSearchRichTextHighlighter.CreateHighlight

  Creates a highlight draw command which is added to the current TppPage
  in order to highlight the text in the proper position. The highlight
  draw command is in the correct position as a result of this routine.}

function TppTextSearchRichTextHighlighter.CreateHighlight(aDrawCommand: TppDrawCommand; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas): TppDrawCommand;
var
  lRichEdit: TCustomRichEdit;
begin

  if not(aDrawCommand is TppDrawRichText) then
    raise ESearchHighlightError.Create('TppTextSearchRichTextHighlighter.CreateHighlight: Must pass a TppDrawRichText object to highlight, not a ' + aDrawCommand.ClassName);

  lRichEdit := nil;

  try
    lRichEdit := ppCreateRichEditOffScreen(nil);

    ChangeSelectedTextColor(lRichEdit, TppDrawRichText(aDrawCommand), aTextSearchOccurrence, aSearchText, FRichTextColor, FRichBackgroundColor);

  finally
    lRichEdit.Free;

  end;

  Result := nil;

end;
       
{@TppTextSearchRichTextHighlighter.EraseHighlight }

procedure TppTextSearchRichTextHighlighter.EraseHighlight(aDrawCommand: TppDrawCommand; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aCanvas: TCanvas);
var
  lRichEdit: TCustomRichEdit;
begin

  inherited EraseHighlight(aDrawCommand, aTextSearchOccurrence, aSearchText, aCanvas);

  lRichEdit := nil;

  try
    lRichEdit := ppCreateRichEditOffScreen(nil);

    ChangeSelectedTextColor(lRichEdit, TppDrawRichText(aDrawCommand), aTextSearchOccurrence, aSearchText, aTextSearchOccurrence.OriginalTextColor, aTextSearchOccurrence.OriginalBackgroundColor);
    
  finally
    lRichEdit.Free;

  end;

end;
       
{@TppTextSearchRichTextHighlighter.ChangeSelectedTextColor }

procedure TppTextSearchRichTextHighlighter.ChangeSelectedTextColor(aRichEdit: TCustomRichEdit; aDrawRichText: TppDrawRichText; aTextSearchOccurrence: TppTextSearchOccurrence; aSearchText: String; aNewTextColor, aNewBackgroundColor: TColor);
var
  lbUseResultColor: Boolean;
  lLines: TStrings;
  lColor: TColor;
  lPropRec: TraPropRec;
begin

  if TraRTTI.GetPropRec(aDrawRichText.ClassType, 'Color', lPropRec) then
     begin
       TraRTTI.GetPropValue(aDrawRichText, 'Color', lColor);

       if TraRTTI.GetPropRec(aRichEdit.ClassType, 'Color', lPropRec) then
         TraRTTI.SetPropValue(aRichEdit, 'Color', lColor);
     end;

  if TraRTTI.GetPropRec(aRichEdit.ClassType, 'Lines', lPropRec) then
    TraRTTI.GetPropValue(aRichEdit, 'Lines', lLines);

  aDrawRichText.RichTextStream.Position := 0;

  lLines.LoadFromStream(aDrawRichText.RichTextStream);

  aRichEdit.SelStart := aTextSearchOccurrence.StartCharPosition;
  aRichEdit.SelLength := Length(aSearchText);

  aTextSearchOccurrence.OriginalTextColor := aRichEdit.SelAttributes.Color;

  aRichEdit.SelStart := aTextSearchOccurrence.StartCharPosition;
  aRichEdit.SelLength := Length(aSearchText);
  aRichEdit.SelAttributes.Color := aNewTextColor;

  aTextSearchOccurrence.OriginalBackgroundColor := TppRTFEngine.ChangeBackgroundColor(aRichEdit, aNewBackgroundColor, lbUseResultColor);

  aDrawRichText.RichTextStream.Position := 0;

  lLines.SaveToStream(aDrawRichText.RichTextStream);

end;

end.
