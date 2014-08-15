{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppTextSearchRichTextEngine;

interface

uses
  Classes,
  Graphics,
  ComCtrls,
  
  ppTextSearchEngine,
  ppDrwCmd,
  ppRichTxDrwCmd,
  ppDevice,
  ppTextSearchOccurrence,
  ppTextSearchDrawCommandHighlighter;

type

  {@TppTextSearchRichTextEngine

    Extends the plain text searching capability of its ancestor in order to
    support searching inside of TppDrawRichText objects.}

  TppTextSearchRichTextEngine = class(TppTextSearchEngine)
    private
      FLockSuccess: Boolean;
      FRichEdit: TCustomRichEdit;

      procedure BuildRichTextSearchOccurrenceList(aDrawRichText: TppDrawRichText; aDrawCommandIndex: Integer; const aSearchText: String; aSearchOccurrenceList: Classes.TList);
      function CreateRichEdit: TCustomRichEdit;
      procedure EraseCurrentRichTextHighlight;

    protected
      procedure BeforeTraverseBackward; override;
      procedure BeforeTraverseForward; override;
      procedure BuildSearchOccurrenceList(aDrawCommand: TppDrawCommand; aDrawCommandIndex: Integer; const aSearchText: String; aSearchOccurrenceList: Classes.TList); override;

      procedure EraseHighlight(aDrawRichText: TppDrawRichText; aSearchOccurrence: TppTextSearchOccurrence);
      function GetRichText(aDrawRichText: TppDrawRichText): String;
      procedure OrganizeOccurrences(aSearchOccurrenceList: TList; aDrawRichTextTop, aDrawRichTextHeight: Integer); virtual;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      procedure EraseHighlights; override;

      class function Description: String; override;

    end;

implementation

uses
  Forms, Windows, SysUtils, 
  ppTextSearchToolbox, ppTextSearchError, ppRTTI, ppTypes, ppTextSearchDrawCommandHighlightRegistry;

{@TppTextSearchRichTextEngine.Create }

constructor TppTextSearchRichTextEngine.Create(aOwner: TComponent);
begin

  inherited Create(aOwner);

  FLockSuccess := False;
  FRichEdit := nil;

end;

{@TppTextSearchRichTextEngine.Destroy }

destructor TppTextSearchRichTextEngine.Destroy;
begin

  FRichEdit.Free;

  inherited Destroy;

end;

{@TppTextSearchRichTextEngine.Description }

class function TppTextSearchRichTextEngine.Description: String;
begin
  Result := 'Full Search';
end;

{@TppTextSearchRichTextEngine.BeforeTraverseForward

  Erase the current highlight.}

procedure TppTextSearchRichTextEngine.BeforeTraverseForward;
begin
  EraseCurrentRichTextHighlight;
end;

{@TppTextSearchRichTextEngine.BeforeTraverseBackward

  Erase the current highlight.}

procedure TppTextSearchRichTextEngine.BeforeTraverseBackward;
begin
  EraseCurrentRichTextHighlight;
end;

{@TppTextSearchRichTextEngine.BuildSearchOccurrenceList }

procedure TppTextSearchRichTextEngine.BuildSearchOccurrenceList(aDrawCommand: TppDrawCommand; aDrawCommandIndex: Integer; const aSearchText: String; aSearchOccurrenceList: Classes.TList);
begin

  {this is bad to check class type but we're testing}
  if (aDrawCommand is TppDrawText) then
    inherited BuildSearchOccurrenceList(aDrawCommand, aDrawCommandIndex, aSearchText, aSearchOccurrenceList)

  else if (aDrawCommand is TppDrawRichText) then
    BuildRichTextSearchOccurrenceList(TppDrawRichText(aDrawCommand), aDrawCommandIndex, aSearchText, aSearchOccurrenceList);

end;

{@TppTextSearchRichTextEngine.BuildRichTextSearchOccurrenceList

  This is where the rich text search engine searches the rich text draw command.
  The screen device doesn't actually draw all of the rich text stream on the
  current space given by the draw command.}

procedure TppTextSearchRichTextEngine.BuildRichTextSearchOccurrenceList(aDrawRichText: TppDrawRichText; aDrawCommandIndex: Integer; const aSearchText: String; aSearchOccurrenceList: Classes.TList);
var
  lsText: String;
  liLength: Integer;
  liStartPos: Integer;
  liIndex: Integer;
  liFoundPos: Integer;
  lSearchOccurrence: TppTextSearchOccurrence;
  lRichEdit: TCustomRichEdit;
  lSearchTypes: TSearchTypes;
  lTextSearchToolbox: TppTextSearchToolboxClass;
begin

  if ((aDrawRichText.EndCharPos - aDrawRichText.StartCharPos) > 1) then
    begin
      lRichEdit := CreateRichEdit;

      try
        lsText := GetRichText(aDrawRichText);

        lRichEdit.Lines.Text := lsText;
      except
        on E: EInvalidOperation do
          raise ESearchEngineError('TppTextSearchRichTextEngine.BuildRichTextSearchOccurrenceList ' + #13#10 + E.Message);
      end;

      lSearchTypes := [];

      if WholeWord then
        lSearchTypes := [stWholeWord];

      if CaseSensitive then
        lSearchTypes := lSearchTypes + [stMatchCase];

      liStartPos :=  aDrawRichText.StartCharPos;
      liLength := aDrawRichText.EndCharPos - aDrawRichText.StartCharPos;

      lTextSearchToolbox := TppTextSearchToolboxRegistry.GetToolboxPlugin;

      liFoundPos := lTextSearchToolbox.SearchRichText(lRichEdit, aSearchText, liStartPos, liLength, lSearchTypes);

      if (liFoundPos <> -1) then
        lSearchOccurrence := TppTextSearchOccurrence.Create(nil)
      else
        lSearchOccurrence := nil;

      liIndex := 0;

      while (lSearchOccurrence <> nil) and not(Cancelled)do
        begin
          lSearchOccurrence.LineNumber := 0;
          lSearchOccurrence.OccurrenceIndex := liIndex;
          lSearchOccurrence.StartCharPosition := liFoundPos;
          lSearchOccurrence.DrawCommandIndex := aDrawCommandIndex;

          Inc(liIndex);

          {just assign top here because we'll calculate a better guess below}
          lSearchOccurrence.Top := aDrawRichText.Top;

          {left is calculated based on occurrence and not actually the position
          in the page, because this isn't known until it is rendered.}
          lSearchOccurrence.Left := aDrawRichText.Left + liIndex;

          aSearchOccurrenceList.Add(lSearchOccurrence);

          liStartPos := liFoundPos + Length(aSearchText);
          liLength := aDrawRichText.EndCharPos - liStartPos;

          liFoundPos := lTextSearchToolbox.SearchRichText(lRichEdit, aSearchText, liStartPos, liLength, lSearchTypes);

          if (liFoundPos <> -1) then
            lSearchOccurrence := TppTextSearchOccurrence.Create(nil)
          else
            lSearchOccurrence := nil;

          {notify preview form to update search statistics}
          SendEventNotify(Self, ciNewSearchOccurrence, nil);

          {check for cancel}
          Application.HandleMessage;
        end;

      {notify preview form to update search statistics}
      SendEventNotify(Self, ciNewSearchOccurrence, nil);

      OrganizeOccurrences(aSearchOccurrenceList, aDrawRichText.Top, aDrawRichText.Height);

    end;

end;

{@TppTextSearchRichTextEngine.OrganizeOccurrences

  Estimate the top and left position to enable sorting of the highlights for
  navigation order from top left to bottom right as the list is traversed by
  user.

  The top and left calculations approximate a best guess to provide a way
  to sort the highlight order when navigating through them on the page. The
  reason is that each line of rich text may have a different height, so this
  estimation is a fast best guess to solve this problem.  Override and register
  a descendent engine class in order to provide customized organization
  capability.}

procedure TppTextSearchRichTextEngine.OrganizeOccurrences(aSearchOccurrenceList: TList; aDrawRichTextTop, aDrawRichTextHeight: Integer);
var
  liTopIncrement: Integer;
  liIndex: Integer;
  lSearchOccurrence: TppTextSearchOccurrence;
begin

  if (aSearchOccurrenceList.Count > 1) and not(Cancelled) then
    begin
      liTopIncrement := aDrawRichTextHeight div aSearchOccurrenceList.Count;

      liIndex := 0;

      while (liIndex < aSearchOccurrenceList.Count) and not(Cancelled) do
        begin
          lSearchOccurrence := TppTextSearchOccurrence(aSearchOccurrenceList[liIndex]);

          lSearchOccurrence.Top := aDrawRichTextTop + (liTopIncrement * liIndex);

          Inc(liIndex);
        end;

    end;

end;

{@TppTextSearchRichTextEngine.EraseHighlights }

procedure TppTextSearchRichTextEngine.EraseHighlights;
var
  liIndex: Integer;
  lDrawCommandsCleared: TList;
  lDrawCommand: TppDrawCommand;
  lDrawRichText: TppDrawRichText;
  lSearchOccurrence: TppTextSearchOccurrence;
begin

  inherited EraseHighlights;

  if (Viewer <> nil) and (CurrentPageSearch <> nil) and (CurrentPageSearch.PageNo = Viewer.CurrentPage.AbsolutePageNo) and
     (Viewer.CurrentPage.DrawCommandCount > 0) then
    begin

      if (ShowAll) then
        begin
          lDrawCommandsCleared := nil;

          try
            lDrawCommandsCleared := TList.Create;

            if (CurrentPageSearch <> nil) then
              begin

                try

                  liIndex := 0;

                  while (liIndex < CurrentPageSearch.OccurrenceCount) do
                    begin

                      lSearchOccurrence := CurrentPageSearch[liIndex];

                      lDrawCommand := Viewer.CurrentPage.DrawCommands[lSearchOccurrence.DrawCommandIndex];

                      if (lDrawCommand is TppDrawRichText) and (lSearchOccurrence.OriginalBackgroundColor <> -1) then
                        begin
                          lDrawCommandsCleared.Add(lDrawCommand);

                          lDrawRichText := TppDrawRichText(lDrawCommand);

                          EraseHighlight(lDrawRichText, lSearchOccurrence);
                        end;

                      Inc(liIndex);

                    end;

                except
                  on E: ERichTextHighlightError do
                    RequestCurrentPageFromPublisher;

                end;

              end;

          finally
            lDrawCommandsCleared.Free;
          end;

        end
      else
        EraseCurrentRichTextHighlight;

    end;

end;

{@TppTextSearchRichTextEngine.EraseHighlight }

procedure TppTextSearchRichTextEngine.EraseHighlight(aDrawRichText: TppDrawRichText; aSearchOccurrence: TppTextSearchOccurrence);
var
  lHighlighter: TppTextSearchDrawCommandHighlighter;
  lsMessage: String;
begin

  lHighlighter := TppTextSearchDrawCommandHighlightRegistry.GetHighlighterForDrawCommand(aDrawRichText);
  lHighlighter.CaseSensitive := CaseSensitive;
  lHighlighter.WholeWord := WholeWord;
  lHighlighter.ScaleX := ScaleX;
  lHighlighter.ScaleY := ScaleY;

  try
    lHighlighter.EraseHighlight(aDrawRichText, aSearchOccurrence, SearchText, Canvas);

  except
    on E: ERichTextHighlightError do
      begin
        lsMessage := 'TppCustomSearchEngine.CreateHighlightDrawCommand: Could not erase highlight draw command for ' + aDrawRichText.Classname + '.' + #13#10 + E.Message;

        raise ESearchEngineError.Create(lsMessage);
      end;

  end;

end;

{@TppTextSearchRichTextEngine.EraseCurrentRichTextHighlight }

procedure TppTextSearchRichTextEngine.EraseCurrentRichTextHighlight;
var
  lDrawCommand: TppDrawCommand;
  lDrawRichText: TppDrawRichText;
begin

  if not(ShowAll) and (CurrentSearchIndex > 0) and (Viewer <> nil) and (CurrentDrawCommandIndex < Viewer.CurrentPage.DrawCommandCount) then
    begin
      lDrawCommand := Viewer.CurrentPage.DrawCommands[CurrentDrawCommandIndex];

      if (lDrawCommand is TppDrawRichText) and (CurrentSearchOccurrence.OriginalBackgroundColor <> -1) then
        begin
          lDrawRichText := TppDrawRichText(lDrawCommand);

          try
            EraseHighlight(lDrawRichText, CurrentSearchOccurrence);

          except
            on E: ERichTextHighlightError do
              RequestCurrentPageFromPublisher;
          end;

        end;

    end;

end;

{@TppTextSearchRichTextEngine.CreateRichEdit }

function TppTextSearchRichTextEngine.CreateRichEdit: TCustomRichEdit;
begin

  if (FRichEdit = nil) then
    FRichEdit := ppCreateRichEditOffScreen(nil)
  else
    FRichEdit.Lines.Clear;

  Result := FRichEdit;

end;

{@TppTextSearchRichTextEngine.GetRichText

  Use this routine to get the rich text in order to avoid using stream's methods
  which can cause flashiness side effects in window.}

function TppTextSearchRichTextEngine.GetRichText(aDrawRichText: TppDrawRichText): String;
var
  lBuf: PChar;
  lRichTextStream: TMemoryStream;
begin

  lRichTextStream := aDrawRichText.RichTextStream;

  lRichTextStream.Position := 0;

  if (lRichTextStream.Size = 0) then
    Result := ''
  else
    begin
      lBuf := StrAlloc(aDrawRichText.RichTextStream.Size + 1);

      aDrawRichText.RichTextStream.Read(lBuf^, aDrawRichText.RichTextStream.Size);

      lBuf[aDrawRichText.RichTextStream.Size] := #0;

      Result := String(lBuf);

      StrDispose(lBuf);
    end;

end;

end.
